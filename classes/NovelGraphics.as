/*===========================================
/--------------------------------------------
/	描画クラス
/------------------------------------------*/
class NovelGraphics
{
	private var view:String;
	private var clip_list:Array;
	private var effect_list:Array;//FadeOutエフェクトの設定状態を保持
	private var depth:Number;
	public function NovelGraphics ()
	{
		clip_list = new Array ();
		effect_list = new Array();
		depth = 1;
	}
	/////////////////////////////////////////////////////////////////////////////////////////////////
	//画像描画関数（外部からのファイルを読み込んで使用する）
	public function loadCGfromFile (file:String, align:String, x:Number, y:Number, scale:Number, alpha:Number, effect:String, m_width:Number, m_height:Number, num:Number)
	{
		var v_name:Object;
		trace ("ムービークリップを複製します");
		_root.myData.myLoad.duplicateMovieClip ("myLoad" + num, num + 1);
		// myLoadを複製
		v_name = eval ("myData.myLoad" + num);
		// 画像の読み込み
		v_name.loadMovie (file);
		//
		if( m_width > 0 )
		{
			v_name._width = m_width;
		}
		if( m_height > 0 )
		{
			v_name._height = m_height;
		}
		v_name._x = 0;
		v_name._y = 0;
		v_name._x = x;
		v_name._y = y;
		
		if (align == "left")
		{
			//align指定があるとき
			v_name._x = 35;
		}
		else if (align == "center")
		{
			v_name._x = 150;
		}
		else if (align == "right")
		{
			v_name._x = 260;
		}
		v_name._xscale = scale;
		//倍率指定があるとき
		v_name._yscale = scale;
		v_name._alpha = alpha;
		//透明度指定があるとき		
		v_name._visible = false;
		//エフェクト指定があるとき
		if( effect!="") {
			var effectArray:Array;
			var j:Number;
			effectArray = effect.split(",");
			for(j=0;j<effectArray.length;j++) {
				SetMovieEffect(v_name,effectArray[j],num);
			}
		}
		//最後に表示状態にする
		trace ("ムービークリップを複製しました");
	}
	////////////////////////////////////////////////////////////////////////
	//外部Flash読み込み関数（外部からのファイルを読み込んで使用する）
	public function loadSWFfromFile (file:String, num:Number)
	{
		trace ("外部swfファイルを読み込みます。");
		var v_name:Object;
		_root.myData.myLoad.duplicateMovieClip ("myLoad" + num, num + 1);
		// myLoadを複製
		v_name = eval ("myData.myLoad" + num);
		var mcListener:Object = new Object ();
		var myLoader:MovieClipLoader;
		mcListener.onLoadStart = function ()
		{
			//_root.myData.TextBack._visible = false;
			//_root.myData.myLoad._visible = false;
			_root.myBar._visible = true;
			with (v_name)
			{
				trace ("背景を黒にして、額縁表示");
				beginFill (0x000000, 100);
				lineStyle (5, 0xcc8080, 100);
				moveTo (0, 0);
				lineTo (480, 0);
				lineTo (480, 360);
				lineTo (0, 360);
				endFill ();
				_visible = true;
			}
		};
		mcListener.onLoadProgress = function (mc, loadedBytes, totalBytes)
		{
			_root.myBar._xscale = (loadedBytes / totalBytes) * 100;
		};
		mcListener.onLoadComplete = function ()
		{
			_root.myBar._visible = false;
		};
		mcListener.onRelease = function ()
		{
			// 何故かこの関数が機能しません！！(><)
			trace ("外部Flash再生終わり");
			removeMovieClip (v_name);
			_root.myData.TextBack._visible = true;
			_root.myData.myLoad._visible = true;
		};
		myLoader = new MovieClipLoader ();
		myLoader.addListener (mcListener);
		myLoader.loadClip (file, v_name);
	}
	//////////////////////////////////////////////////////
	//  cgnumberのムービークリップを削除
	public function RemoveCGMovieClip( cgnumber:Number ) {
		var mc:Object;
		mc = eval("myData.myLoad"+cgnumber );
		if( effect_list[cgnumber] == "fadeout" )
		{
			trace( effect_list[cgnumber] );
			var nEffect:NovelEffect;
			nEffect = new NovelEffect();
			nEffect.SetFadeOut(mc);
		} else {
			mc._visible = false;
			trace ( mc._name);
			removeMovieClip(mc);
			trace (mc._name);
		}
	}
	//////////////////////////////////////////////////////////////////
	// エフェクト描画.
	// 画面フラッシュ.
	public function flash (num:Number)
	{
		with (_root.flash)
		{
			for (var i = 0; i < num; i++)
			{
				if (_visible == false)
				{
					_visible = true;
				}
				else
				{
					_visible = false;
				}
			}
		}
	}
	// 画面シェイク.
	public function shape (num:Number)
	{
		getURL ("JavaScript:myShaker(20)");
	}
	///////////////////////////////////////////////////////////////
	//エフェクト処理関数
	private function SetMovieEffect(v_name:Object,effect:String,num:Number) {
		var nEffect:NovelEffect;
		nEffect = new NovelEffect();
		//
		if( effect=="fadein") 	{
			v_name._alpha = 0;
			nEffect.SetFadeIn(v_name);
		} else if ( effect=="fadeout" ) {
			effect_list[num] = "fadeout";
		}
	}
	//////////////////////////////////////////////////////////////////////
	// 旧・画像描画関数で使用 （互換性維持のため一応残しておく)
	private function searchMovieClip (name:String):Boolean
	{
		var i:Number;
		trace ("Clip_LISTの中身");
		trace (clip_list);
		for (i = 0; i <= (clip_list.length + 1); i++)
		{
			if (clip_list[i].toString () != null)
			{
				if (clip_list[i].toString () == name)
				{
					return true;
				}
			}
		}
		//clip_list.push(name);
		clip_list.unshift (name);
		return false;
	}
	//旧・画像描画関数　（互換性維持のため一応残しておく）
	public function loadCG (name:String, face:String, align:String, x:Number, y:Number, scale:Number, alpha:Number)
	{
		if (name != "backcg")
		{
			if (name != "flash")
			{
				if (searchMovieClip (name) == false)
				{
					_root.myData.attachMovie (name, name, depth);
					trace ("ムービークリップが作成されました。");
					depth += 1;
				}
			}
		}
		trace (_root.myData[name]);
		with (_root.myData[name])
		{
			if (face == "clear")
			{
				_visible = false;
				//非表示に設定する
			}
			else
			{
				_x = 35;
				//何も指定なしのデフォルトは左表示
				_y = 360 - _height;
				//何も指定なしのデフォルトは左表示
				_x = x;
				//xの指定があるとき
				_y = y;
				//yの指定があるとき
				if (align == "left")
				{
					//align指定があるとき
					_x = 35;
					_y = 360 - _height;
				}
				else if (align == "center")
				{
					_x = 150;
					_y = 360 - _height;
				}
				else if (align == "right")
				{
					_x = 260;
					_y = 360 - _height;
				}
				_xscale = scale;
				//倍率指定があるとき
				_yscale = scale;
				_alpha = alpha;
				//透明度指定があるとき
				if (name == "backcg")
				{
					//背景だけはローディング方法が違う
					_x = -1;
					loadMovie (face);
				}
				else
				{
					gotoAndStop (face);
				}
				_visible = true;
				//最後に表示状態にする
			}
		}
	}
}
