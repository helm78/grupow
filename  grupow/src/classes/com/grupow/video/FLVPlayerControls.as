
/**
 * 
 * Grupow FLVPlayer 
 * Copyright (c) 2008 ruranga@grupow.com
 * 
 * this file is part of com.grupow.video package
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.video 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.SimpleButton
	import flash.events.MouseEvent;
	import flash.text.TextField;

	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class FLVPlayerControls extends MovieClip
	{
		private var _flvPlayer:FLVPlayer;
		
		private var _seeking:Boolean;
		private var _isPlaying:Boolean;
		
		//
		//
		//TODO agregar dinamicamente los controles STOP,PLAY,SEEKBAR,TIME,VOLUME
		//
		//
		public function FLVPlayerControls(flvPlayer:FLVPlayer = null) 
		{
			
			if (flvPlayer != null) {
				this._flvPlayer = flvPlayer;
				addPlayerListeners();
			}
			
			_isPlaying = false;
								
			seekBar.addEventListener(SeekBarEvent.CHANGE, onChange, false, 0, true);
			seekBar.addEventListener(SeekBarEvent.BEGIN_SCRUB, beginScrub_handler, false, 0, true);
			seekBar.addEventListener(SeekBarEvent.END_SCRUB,endScrub_handler,false,0,true);
			
			stop_btn.addEventListener(MouseEvent.CLICK,stop_handler,false,0,true);
			pauseResume_mc.addEventListener(MouseEvent.CLICK,playPause_handler,false,0,true);

			audio_mc.buttonMode = true;
			audio_mc.addEventListener(MouseEvent.CLICK,sound_handler,false,0,true);
		
		}
		
		private function stop_handler (e:Event):void 
		{
			pauseResume_mc.gotoAndStop(1);
			stopVideo();	
		}

		private function sound_handler (e:Event):void
		{
			if(audio_mc.currentFrame == 1) {
				setVideoVolume(0);
				audio_mc.gotoAndStop(2);		
			}else {
				setVideoVolume(1);
				audio_mc.gotoAndStop(1);
			}
		}

		private function playPause_handler (e:Event):void
		{
			if(pauseResume_mc.currentFrame == 2) {
				pauseVideo();
				pauseResume_mc.gotoAndStop(1);
			}else {
				resumeVideo();
				pauseResume_mc.gotoAndStop(2);
			}
		}
		
		private function endScrub_handler(e:SeekBarEvent):void 
		{
			_seeking = false;
			if (_isPlaying)
				this._flvPlayer.resume();
		}
		
		private function beginScrub_handler(e:SeekBarEvent):void 
		{
			_seeking = true;
			_isPlaying = this._flvPlayer.isPlaying;
			this._flvPlayer.pause();
		}
		
		private function onChange(e:SeekBarEvent):void 
		{
			//trace(":::onChange::: " + e.position);
			this._flvPlayer.seek(_flvPlayer.duration * e.position);

		}
		
		private function flvPlayerErrorEvent_handler(e:Event):void
		{
			trace("FLVPlayerControls.flvPlayerErrorEvent_handler: " + e.type);
		}
		
		private function flvPlayerEvent_handler(e:Event):void
		{
			switch (e.type) 
			{
				case FLVPlayerEvent.PLAYHEAD_UPDATE :
													
						if(!_seeking)
							seekBar.position = _flvPlayer.position;
							//_flvPlayer.time / _flvPlayer.duration;
					
						time_txt.text = fixTime(_flvPlayer.time);	
						
						break;
				case FLVPlayerEvent.READY :
								
						pauseResume_mc.gotoAndStop(2);
											
						break;
				case FLVPlayerEvent.STOPPED :
				
						trace("STOPPED");
						
						break;
				case FLVPlayerEvent.PAUSED :
				
						trace("PAUSED");
						
						break;
						
				case FLVPlayerEvent.START_PLAYING :
				
						trace("START_PLAYING");
						
						break;		
					
				case FLVPlayerEvent.COMPLETE :
						
						pauseResume_mc.gotoAndStop(1);
				
						break;
				case FLVPlayerEvent.BUFFERING :
				
						break;
				case FLVPlayerEvent.AUTO_REWOUND :
				
						this.seekBar.position = this.seekBar.min;
						pauseResume_mc.gotoAndStop(1);
						
						break;	
				
				case FLVPlayerProgressEvent.PROGRESS :
						
						var evt:FLVPlayerProgressEvent = e as FLVPlayerProgressEvent;
						seekBar.updateProgress(evt.bytesLoaded/evt.bytesTotal);
						
						break;
				case FLVPlayerMetadataEvent.METADATA_RECEIVED :
				
						/*/
						var evt:FLVPlayerMetadataEvent = e as FLVPlayerMetadataEvent;
						trace("-----------------------")
						trace("::onMetatada_handler::");
						//trace(ObjectUtil.toString(evt.info));
						for (var name:String in evt.info) {
							trace(name + ":" + evt.info[name]);
						}
						trace("-----------------------");
						//*/
						
						break;
				case FLVPlayerMetadataEvent.CUE_POINT :
				
						/*/
						var evt:FLVPlayerMetadataEvent = e as FLVPlayerMetadataEvent;
						trace("-----------------------")
						trace("::onCuePoint_handler::");
						//trace(ObjectUtil.toString(evt.info));
						for (var name:String in evt.info) {
							trace(name + ":" + evt.info[name]);
						}
						trace("-----------------------");
						//*/
						
						break;
			}
		}
		
		private function addPlayerListeners():void
		{
			_flvPlayer.addEventListener(FLVPlayerEvent.READY, flvPlayerEvent_handler, false, 0, true);
			_flvPlayer.addEventListener(FLVPlayerEvent.COMPLETE, flvPlayerEvent_handler , false, 0, true);
			_flvPlayer.addEventListener(FLVPlayerEvent.BUFFERING, flvPlayerEvent_handler, false, 0, true);
			_flvPlayer.addEventListener(FLVPlayerEvent.AUTO_REWOUND, flvPlayerEvent_handler, false, 0, true);
			_flvPlayer.addEventListener(FLVPlayerEvent.PLAYHEAD_UPDATE, flvPlayerEvent_handler, false, 0, true);
			
			_flvPlayer.addEventListener(FLVPlayerEvent.PAUSED, flvPlayerEvent_handler, false, 0, true);
			_flvPlayer.addEventListener(FLVPlayerEvent.START_PLAYING, flvPlayerEvent_handler , false, 0, true);
			_flvPlayer.addEventListener(FLVPlayerEvent.STOPPED, flvPlayerEvent_handler, false, 0, true);
			
			_flvPlayer.addEventListener(FLVPlayerProgressEvent.PROGRESS, flvPlayerEvent_handler , false, 0, true);
			_flvPlayer.addEventListener(FLVPlayerMetadataEvent.METADATA_RECEIVED, flvPlayerEvent_handler, false, 0, true);
			_flvPlayer.addEventListener(FLVPlayerMetadataEvent.CUE_POINT, flvPlayerEvent_handler, false, 0, true);
		}
		
		private function removePlayerListeners():void
		{
			_flvPlayer.removeEventListener(FLVPlayerEvent.READY, flvPlayerEvent_handler);
			_flvPlayer.removeEventListener(FLVPlayerEvent.COMPLETE, flvPlayerEvent_handler);
			_flvPlayer.removeEventListener(FLVPlayerEvent.BUFFERING, flvPlayerEvent_handler);
			_flvPlayer.removeEventListener(FLVPlayerEvent.AUTO_REWOUND, flvPlayerEvent_handler);
			_flvPlayer.removeEventListener(FLVPlayerEvent.PLAYHEAD_UPDATE, flvPlayerEvent_handler);
			
			_flvPlayer.removeEventListener(FLVPlayerEvent.PAUSED, flvPlayerEvent_handler);
			_flvPlayer.removeEventListener(FLVPlayerEvent.START_PLAYING, flvPlayerEvent_handler);
			_flvPlayer.removeEventListener(FLVPlayerEvent.STOPPED, flvPlayerEvent_handler);
			
			_flvPlayer.removeEventListener(FLVPlayerProgressEvent.PROGRESS, flvPlayerEvent_handler);
			_flvPlayer.removeEventListener(FLVPlayerMetadataEvent.METADATA_RECEIVED, flvPlayerEvent_handler);
			_flvPlayer.removeEventListener(FLVPlayerMetadataEvent.CUE_POINT, flvPlayerEvent_handler);
		}
		
		private function fixTime(ms:Number):String
		{
			var fixed:String = "00:00";
			if(ms > 0) {
				
				var minutes = Math.floor(ms/60);
				var seconds = Math.floor(ms%60);
			
				if (seconds<10) {
					seconds = "0"+seconds;
				}
			
				if (minutes<10) {
					minutes = "0"+minutes;
				}
				
				fixed = minutes + ":" + seconds;
			}
			
			return fixed;
		}
		
		private function stopVideo():void
		{
			this._flvPlayer.stop();
		}
		
		private function setVideoVolume(value:Number):void
		{
			this._flvPlayer.volume = value;
		}
		
		private function pauseVideo():void
		{
			this._flvPlayer.pause();
		}
		
		private function resumeVideo():void
		{
			this._flvPlayer.resume();
		}
		
		public function dispose():void
		{
			
			stop_btn.removeEventListener(MouseEvent.CLICK,stop_handler);
			pauseResume_mc.removeEventListener(MouseEvent.CLICK,playPause_handler);
			audio_mc.removeEventListener(MouseEvent.CLICK,sound_handler);
			
			seekBar.removeEventListener(SeekBarEvent.CHANGE, onChange);
			seekBar.removeEventListener(SeekBarEvent.BEGIN_SCRUB, beginScrub_handler);
			seekBar.removeEventListener(SeekBarEvent.END_SCRUB,endScrub_handler);
			removePlayerListeners();
			
			//this.parent.removeChild(this);
			//this = null;
		}
		
		public function get flvPlayer():FLVPlayer { 
			return _flvPlayer;
		}
		
		public function set flvPlayer(value:FLVPlayer):void 
		{
			_flvPlayer = value;
			addPlayerListeners();
		}
		
		
	
	}
	
}