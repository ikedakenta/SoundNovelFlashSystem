/*===========================================
/--------------------------------------------
/	サウンドクラス
/------------------------------------------*/
class NovelSound
{
	static var BGM:Sound;
	//BGMサウンドオブジェクト作成
	static var v_play:String;
	//BGMボタンをストップ表示に切り替えておく
	static var v_volume:Number;
	//ボリューム値
	private static var bgmName:String;
	//効果音サウンドオブジェクト
	var SE:Sound;
	//サウンドリピート再生用
	public function NovelSound ()
	{
		BGM = new Sound ();
		//BGM用サウンドオブジェクト作成
		v_play = "play";
		//最初は停止状態
		bgmName = null;
		//リピート用の曲名を空に
		//サウンドバッファを０へ
		_soundbuftime = 0;
		BGM.onSoundComplete = reloadBGM;
	}
	public function getv_play ():String
	{
		return v_play;
	}
	public function changev_play ()
	{
		if (v_play == "play")
		{
			v_play = "stop";
		}
		else if (v_play == "stop")
		{
			v_play = "play";
		}
	}
	public function getvolume ():Number
	{
		return v_volume;
	}
	public function setvolume (temp:Number)
	{
		//BGMボリューム設定
		BGM.setVolume (temp);
		v_volume = temp;
	}
	public function loadSE (title:String, volume:Number)
	{
		//効果音用サウンドオブジェクト作成
		SE = new Sound ();
		//音再生 
		SE.loadSound (title, true);
		if (volume != null)
		{
			SE.setVolume (volume);
		}
	}
	public function loadBGM (title:String, volume:Number)
	{
		//BGM再生
		bgmName = title;
		v_volume = volume;
		BGM.loadSound (title, true);
		BGM.setVolume(volume);
		v_play = "play";
	}
	public function reloadBGM ()
	{
		//BGM再生
		BGM.loadSound (bgmName, true);
		BGM.setVolume(v_volume);
		v_play = "play";
	}
	public function stopBGM ()
	{
		//BGM停止
		BGM.stop ();
		v_play = "stop";
	}
	public function setbgmName (title:String)
	{
		bgmName = title;
	}
}
