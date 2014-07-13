/**********************************************
/* NovelInitialXML処理クラス
/* XML定義・XMLノード操作
 *********************************************/
class NovelInitialXML extends NovelXML
{
	public function NovelInitialXML ()
	{
		//XMLオブジェクト作成
		this.myXML = new XML ();
		this.myXML.ignoreWhite = true;
		this.myXML.load ("init.xml");
	}
}
