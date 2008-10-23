package com.grupow.media 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import gs.TweenLite;
	import gs.easing.Linear;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class SoundItem extends Sound
	{
		
		private var _channel:SoundChannel
		private var _soundTransform:SoundTransform;
		
		public function SoundItem(stream:URLRequest = null,conext:SoundLoaderContext = null) {
			
			super(stream,conext);
			
			_soundTransform = new SoundTransform();
			
		}
		
		public function fade(volume:Number,ms:int = 1000,handler:Function = null):void
		{
			//
			if (volume < 0)
				volume = 0;
			//
			if (volume > 1)
				volume = 1;
			//	
			TweenLite.to(this, ms/1000, {volume:volume,ease:Linear.easeNone,onComplete:handler});
		}
		
		public override function play(startTime:Number = 0,loops:int = 0,sndTransform:SoundTransform = null):SoundChannel
		{
			if(sndTransform != null)
				_soundTransform = sndTransform; 
				
			_channel = super.play(startTime, loops, _soundTransform);
			return _channel;
		}
		
		public function stop():void
		{
			try {
				_channel.stop();
			}catch (e:*) {
				//trace("SoundItem Error: SoundChannel is not defined, you need to start playing");
			}
		}
		
	
		public function get volume():Number
		{ 
			return _soundTransform.volume;
		}
		
		public function set volume(value:Number):void 
		{
			_soundTransform.volume = value;
			
			try {
				_channel.soundTransform = _soundTransform;
			}catch (e:*) {
				trace("SoundItem Error: SoundChannel is not defined, you need to start playing");
			}
		}
			
	}
}