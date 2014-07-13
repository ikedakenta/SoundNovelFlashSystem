/**********************************************
/* XML処理クラス
/* XML定義・XMLノード操作
 *********************************************/
class NovelXML
{
	public var myXML:XML;
	//
	public var rootTextNode:XMLNode;
	public var firstTextNode:XMLNode;
	public var currentTextNode:XMLNode;
	public var nextTextNode:XMLNode;
	public var totalTextNode:Number;
	public var currentIndex:Number;
	/***************************************
	/*  コンストラクタ
	/*	 XMLファイル読み込み、プロシージャーの設定
	****************************************/
	public function NovelXML ()
	{
	}
	/**************************
	/* 背景色と文字色指定
	***************************/
	public function myTextData ()
	{
		trace ("XML設定呼び出し");
		trace ("myXML" + myXML.firstChild);
		rootTextNode = myXML.firstChild;
		firstTextNode = rootTextNode.firstChild;
		currentTextNode = firstTextNode;
		//rootTextNode = myXML.cloneNode(true);
		totalTextNode = rootTextNode.childNodes.length;
		currentIndex = 1;
	}
	/********************************
	/*	ノードを次のノードへ送る
	*******************************/
	public function nextTagMove ():XMLNode
	{
		// 現在のタグカウントを1進める.
		_root.newNovelSceanSave.addSceanLine ();
		//次のテキストタグをnextTextNodeへ入力	
		nextTextNode = currentTextNode.nextSibling;
		if (nextTextNode.nextSibling == null)
		{
			//次のテキストタグがない場合は停止
			break;
		}
		else
		{
			//次のテキストタグの内容を表示
			currentTextNode++;
			currentTextNode = nextTextNode;
		}
		return nextTextNode;
	}
	/*********************************
	/* ノードを指定カウント走査し、進める
	*********************************/
	public function SearchTagMove (count_line:Number):XMLNode
	{
		var i:Number;
		// タグを最初の位置へ
		myTextData();
		
		// カウント分タグ走査
		for (i = 0; i < count_line; i++)
		{
			nextTextNode = currentTextNode.nextSibling;
			if (nextTextNode.nextSibling == null)
			{
				//次のテキストタグがない場合は停止
				break;
			}
			else
			{
				//次のテキストタグの内容を表示
				currentTextNode++;
				currentTextNode = nextTextNode;
			}
		}
		return nextTextNode;
	}
}
