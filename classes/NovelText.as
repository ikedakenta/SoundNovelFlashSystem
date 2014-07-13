/**********************************************
/* SoundNovelテキスト処理クラス
/* 
/* テキスト表示設定・テキスト表示
 *********************************************/
class NovelText
{
	//サウンドノベルプログラムムービークリップデータ集合体
	private var myData:MovieClip;
	//一文字づつ表示コンポーネントムービークリップ
	private var CompTypeText:MovieClip;
	//ノベルスクリプトクラスメソッド変数
	private var mScript:NovelScript;
	//コンストラクタ
	public function NovelText (typeText:MovieClip)
	{
		CompTypeText = typeText;
		mScript = new NovelScript ();
		//スクリプト操作オブジェクト
	}
	/*********************************************
	/*	テキスト表示
	/*	TextFieldオブジェクトプロパティ設定
	**********************************************/
	public function myTextProperty (myData:MovieClip, firstElement:XMLNode)
	{
		var sChildNodes = firstElement.childNodes;
		CompTypeText.start_x = 15;
		CompTypeText.start_y = 293;
		//フォントマージン
		CompTypeText.add_x = 15;
		CompTypeText.add_y = 18;
		//フォントサイズ
		CompTypeText.app_fontsize = 15;
		CompTypeText.app_fontcolor = 0xFFFFFF;
		if( sChildNodes.length > 0 )
		{
			var i:Number;
			for( i=0;i<sChildNodes.length;i++) {
				var sChildNode:XMLNode = sChildNodes[i];
				var nodeName:String = sChildNode.nodeName;
				if(nodeName=="name") {
					CompTypeText.app_fontname=sChildNode.firstChild;
					CompTypeText.app_oldfontname=sChildNode.firstChild;
				} else if(nodeName=="size")	{
					var fontsize:Number = Number(sChildNode.firstChild.nodeValue);
					CompTypeText.app_fontsize=fontsize;
					CompTypeText.app_oldfontsize=fontsize;
				} else if(nodeName=="size_x"){
					var size_x:Number = Number(sChildNode.firstChild.nodeValue);
					CompTypeText.add_x=size_x;
					CompTypeText.oldadd_x=size_x;
				} else if(nodeName=="size_y"){
					var size_y:Number = Number(sChildNode.firstChild.nodeValue);
					CompTypeText.add_y=size_y;
					CompTypeText.oldadd_y=size_y;
				} else if(nodeName=="start_x"){
					var start_x:Number = Number(sChildNode.firstChild.nodeValue);
					CompTypeText.start_x=start_x;
					CompTypeText.oldstart_x=start_x;
				} else if(nodeName=="start_y"){
					var start_y:Number = Number(sChildNode.firstChild.nodeValue);
					CompTypeText.start_y=start_y;
					CompTypeText.oldstart_y=start_y;
				} else if(nodeName=="fontcolor"){
					var fontcolor:Number = Number(sChildNode.firstChild.nodeValue);
					CompTypeText.app_fontcolor=fontcolor;
					CompTypeText.app_oldfontcolor=fontcolor;
				}
			}
		} 
	}
	/***********************************************
	//テキストタグの表示箇所
	//
	//属性により、曲とCGの差し替えを行う
	//2004-05-02 Ishii Write
	***********************************************/
	public function updateText (newTextNode:XMLNode)
	{
		var i:Number;
		var nodeNum:Number;
		var analysisNode = newTextNode.childNodes;
		nodeNum = newTextNode.childNodes.length;
		for (i = 0; i <= nodeNum; i++)
		{
			if (analysisNode[i] != null)
			{
				mScript.scriptAnalysis (analysisNode[i], CompTypeText);
				trace (analysisNode[i]);
			}
		}
		analysisNode = null;
	}
	public function check_end_text ()
	{
		return mScript.end_flg;
	}
}
