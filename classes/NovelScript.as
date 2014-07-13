	/**********************************************
/* Script処理クラス
/* 
/* Script解析・解析による動作実行
 *********************************************/
class NovelScript {
	private var m_cg:NovelGraphics;
	private var cg_num:Number;
	private var m_sound:NovelSound;
	public var end_flg:Boolean;
	public function NovelScript() {
		cg_num = 0;
		m_cg = new NovelGraphics();
		//グラフィックスオブジェクト
		m_sound = new NovelSound();
		//サウンドメソッドオブジェクト
		end_flg = false;
	}
	/*******************************************
	 /* XMLスクリプト解析関数
	 *******************************************/
	public function scriptAnalysis(analysisNode:XMLNode, CompTypeText:MovieClip) {
		//以下属性読み取り部分を他関数に移植したい	by Ishii
		//属性”曲”を読み取り、曲の差し替えを実行
		trace("NovelScriptからの呼び出し");
		// CGタグ解析 （互換性維持のため残してある旧処理）
		if (analysisNode.nodeName == "cg") {
			m_cg.loadCG(
						analysisNode.attributes["name"],
						analysisNode.attributes["face"],
						analysisNode.attributes["align"],
						analysisNode.attributes["x"],
						analysisNode.attributes["y"],
						analysisNode.attributes["scale"],
						analysisNode.attributes["alpha"]
						);
		}
		// 外部CGタグ解析 
		if (analysisNode.nodeName == "cg_file") {
			m_cg.loadCGfromFile(
								//analysisNode.attributes["clip"],
								analysisNode.attributes["file"],
								analysisNode.attributes["align"],
								analysisNode.attributes["x"],
								analysisNode.attributes["y"],
								analysisNode.attributes["scale"],
								analysisNode.attributes["alpha"],
								analysisNode.attributes["effect"],
								analysisNode.attributes["width"],
								analysisNode.attributes["height"],
								cg_num
								);
			cg_num++;
		}
		// 外部swfファイル読み込み 
		if (analysisNode.nodeName == "flash") {
			if ( analysisNode.attributes["messagebox"] == "off")
			{
				// テキストを空に
				EraseCompTypeText(CompTypeText);
				// メッセージボックス表示をOFFに.
				_root.myData.TextBack._visible = false;
				_root.myData.myLoad._visible = false;
			}
			m_cg.loadSWFfromFile(
								analysisNode.attributes["file"],
								cg_num
								);
			cg_num++;
		}
		// BGM再生
		if (analysisNode.nodeName == "music" || analysisNode.nodeName == "bgm") {
			SetBGMInfo( analysisNode );
		}
		// 効果音再生
		if (analysisNode.nodeName == "se") {
			m_sound.loadSE(
						   analysisNode.attributes["file"],
						   analysisNode.attributes["volume"]
						   );
		}		
		// 描画クリアー
		if (analysisNode.nodeName == "clear") {
			RemoveCGMovieClip()
		}
		// テキスト表示
		if (analysisNode.nodeName == "text") {
			SetComTypeText(analysisNode,CompTypeText);
		}
		// スクリプト終了
		if (analysisNode.nodeName == "end") {
			SetEndFlag(analysisNode,CompTypeText);
		}
	}
	//////////////////////////////////////////////////////////////
	//Private Method( リファクタリングによる関数分割 )
	//////////////////////////////////////////////////////////////
	private function SetBGMInfo(analysisNode:XMLNode)
	{
			m_sound.stopBGM();
			if ( analysisNode.attributes["filename"] != null)
			{
				m_sound.setbgmName(analysisNode.attributes["filename"]);
				m_sound.loadBGM(
								analysisNode.attributes["filename"],
								analysisNode.attributes["volume"]
								);
			}
			else if ( analysisNode.attributes["file"] != null )
			{
				m_sound.setbgmName(analysisNode.attributes["file"]);
				m_sound.loadBGM(
								analysisNode.attributes["file"],
								analysisNode.attributes["volume"]
								);				
			}
	}
	private function SetComTypeText(analysisNode:XMLNode,CompTypeText:MovieClip)
	{
		//Font Setting
		var font_size:Number = getAttributeToNumber(analysisNode,"size");
		var font_size_x:Number = getAttributeToNumber(analysisNode,"size_x");
		var font_size_y:Number = getAttributeToNumber(analysisNode,"size_y");
		var font_type:String = getAttributeToString(analysisNode,"font");
		var font_color:Number = getAttributeToNumber(analysisNode,"color");
		
		if( font_size!=null) {
			CompTypeText.app_oldfontsize=CompTypeText.app_fontsize;
			CompTypeText.app_fontsize=font_size;
		}  else {
			CompTypeText.app_fontsize=CompTypeText.app_oldfontsize;
		}
		if( font_size_x!=null ) {
			CompTypeText.oldadd_x=CompTypeText.add_x;
			CompTypeText.add_x = font_size_x;
		} else {
			CompTypeText.add_x=CompTypeText.oldadd_x;
		}
		if( font_size_y!=null ) {
			CompTypeText.oldadd_y=CompTypeText.add_y;
			CompTypeText.add_y = font_size_y;
		} else {
			CompTypeText.add_y=CompTypeText.oldadd_y;
		}
		if( font_type!=null ) {
			CompTypeText.app_oldfontname=CompTypeText.app_fontname;
			CompTypeText.app_fontname=font_type;
		} else {
			CompTypeText.app_fontname=CompTypeText.app_oldfontname;
		}
		if ( font_color!=null ) {
			CompTypeText.app_oldfontcolor=CompTypeText.app_fontcolor;
			CompTypeText.app_fontcolor=font_color;
		} else {
			CompTypeText.app_fontcolor=CompTypeText.app_oldfontcolor;
		}
		//XMLノード型配列、宣言方法がわからんからここで定義してます。
		var elementTextNode = analysisNode.childNodes;
		var i:Number;
		EraseCompTypeText(CompTypeText);
		for (i=0; i<=3; i++) {
			if (elementTextNode[i].firstChild != null) {
				CompTypeText.text_arr[i] = elementTextNode[i].firstChild.nodeValue;
			}
		}
		elementTextNode = null;
	}
	private function SetEndFlag(analysisNode:XMLNode,CompTypeText:MovieClip)
	{
			EraseCompTypeText(CompTypeText);
			m_sound.stopBGM();
			end_flg = true;
	}
	private function RemoveCGMovieClip()
	{
		var i:Number;
		for ( i = 0; i < cg_num ; i++){
			m_cg.RemoveCGMovieClip( i );
		}
		_root.myData.TextBack._visible = true;
		_root.myData.myLoad._visible = true;
		cg_num = 0;
	}
	//////////////////////////////////////////////////////////////
	//Util Method
	//////////////////////////////////////////////////////////////
	private function EraseCompTypeText(CompTypeText:MovieClip)
	{
			var i:Number;
			//テキスト表示オブジェクトのテキスト変数の初期化
			for (i=0; i<=3; i++) {
				CompTypeText.text_arr[i] = "";
			}
	}
	private function getAttributeToNumber( analysisNode:XMLNode , attName:String ) : Number
	{
		return analysisNode.attributes[attName];
	}
	private function getAttributeToString( analysisNode:XMLNode , attName:String ) : String
	{
		return analysisNode.attributes[attName];
	}
}
