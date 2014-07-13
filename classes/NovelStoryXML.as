/**********************************************
/* NovelStoryXML処理クラス
/* XML定義・XMLノード操作
 *********************************************/
class NovelStoryXML extends NovelXML
{
	public function NovelStoryXML ()
	{
		//XMLオブジェクト作成
		this.myXML = new XML ();
		this.myXML.ignoreWhite = true;
		this.myXML.load ("data.xml");
	}
}
