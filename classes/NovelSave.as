/**********************************************
/* セーブ・ロード処理クラス
/* ローカルHDDへのデータセーブ・ロードを行う
 *********************************************/
class NovelSave
{
	private var mySave:SharedObject;

	public function NovelSave ()
	{
	}

	// データをローカルHDDに書き込む
	public function Save()
	{
		mySave = SharedObject.getLocal();
		mySave.flush();
	}
	
	// ローカルHDDに保存されているデータを読み込む
	public function Load()
	{
		mySave = SharedObject.getLocal();
	}	
}
