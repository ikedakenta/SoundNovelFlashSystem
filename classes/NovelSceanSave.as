class NovelSceanSave extends NovelSave
{
	private var save_line:Number;
	private var now_line:Number;
	public function NovelSceanSave ()
	{
		save_line = 0;
		now_line = 0;
	}
	// シーンセーブ用の行数インクリメント
	public function addSceanLine ()
	{
		now_line++;
	}
	// セーブ用変数へのアクセサ
	public function setSaveSceanLine (line:Number)
	{
		save_line = line;
	}
	public function getSaveSceanLine ()
	{
		return save_line;
	}
	// 現在のタグカウント変数へのアクセサ
	public function setNowSceanLine (line:Number)
	{
		now_line = line;
	}
	public function getNowSceanLine ()
	{
		return now_line;
	}

	// データをローカルHDDに書き込む
	public function Save ()
	{
		mySave = SharedObject.getLocal ();
		mySave.data.save_line = now_line - 1;
		trace("セーブ：" + now_line);
		mySave.flush ();
	}
	// ローカルHDDに保存されているデータを読み込む
	public function Load ()
	{
		mySave = SharedObject.getLocal ();
		save_line = mySave.data.save_line;
		now_line = save_line;
		trace("ロード：" + save_line);
		// セーブカウントまでタグ走査を進め
		// 文字配列内容アップデート
		_root.newNovelText.updateText (_root.newNovelXML.SearchTagMove(save_line));
		//一行表示実行
		_root.CompType ();
	}
}
