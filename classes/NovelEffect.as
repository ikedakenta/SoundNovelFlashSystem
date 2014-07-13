import mx.utils.Delegate;
// エフェクト処理クラス
//
class NovelEffect {
	//////////////////////////////////////////////////////
	//インターフェース定義
	public function SetFadeIn(mc:Object)
	{
		var timerid:Number=setInterval( fadeIn,10, mc)
		///////////////////////////////////////////////////
		///フェードイン
		///////////////////////////////////////////////////
		function fadeIn(mc:MovieClip):Void {
			mc._alpha += 5;
			if( mc._alpha>=100)
			{
				clearInterval(timerid);
			}
		}
	}
	public function SetFadeOut(mc:Object)
	{
		var timerOutid:Number = setInterval(fadeOut,10,mc);
		///////////////////////////////////////////////////
		///フェードアウト
		///////////////////////////////////////////////////
		function fadeOut(mc:MovieClip):Void {
			mc._alpha -= 5;
			if( mc._alpha<=0)
			{
				mc._visible = false;
				removeMovieClip(mc);
				clearInterval(timerOutid);
			}
		}
	}
}