class NovelMenu
{
	public var v_submenuArray = ["セーブ", "ロード", "バージョン"];
	var i:Number;
	public function NovelMenu ()
	{
		for (i = 1; i <= v_submenuArray.length; i++)
		{
			// メニュー項目は非表示に
			_root.myMenuGroup["mySub" + i]._visible = false;
			// メニュー項目にID番号が代入された変数を作る
			_root.myMenuGroup["mySub" + i].v_id = i;
			_root.myMenuGroup["mySub" + i].myMenuTitle.text = v_submenuArray[i - 1];
		}
	}
	public function f_showMenuSub ()
	{
		for (i = 1; i <= v_submenuArray.length; i++)
		{
			_root.myMenuGroup["mySub" + i]._visible = true;
		}
	}
	public function f_hideMenuSub ()
	{
		for (i = 1; i <= v_submenuArray.length; i++)
		{
			_root.myMenuGroup["mySub" + i]._visible = false;
		}
	}
}
