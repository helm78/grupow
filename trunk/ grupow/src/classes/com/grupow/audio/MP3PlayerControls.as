package com.grupow.audio
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author David Gámez
 	 *
 	 *
 	 *
 	 *
 	 * 
	 */
	public class MP3PlayerControls extends MovieClip
	{
		
		private var _mp3Player:MP3Player;
		private var _seeking:Boolean;
		private var _isPlaying:Boolean;
		
		private var _firstPlay:Boolean;
		
		
		public function MP3PlayerControls(mp3Player:MP3Player = null) 
		{
			if (mp3Player != null) {
				this._mp3Player = mp3Player;
				addPlayerListeners();
			}
			
			_isPlaying = false;
			_firstPlay = true;
			
			pauseResume_mc.addEventListener(MouseEvent.CLICK, playPause_handler, false, 0, true);
			stop_btn.addEventListener(MouseEvent.CLICK, stop_handler, false, 0, true);
			
			seekBar.setEnabled(false);
			
			seekBar.addEventListener(SeekBarEvent.CHANGE, onChange, false, 0, true);
			seekBar.addEventListener(SeekBarEvent.BEGIN_SCRUB, beginScrub_handler, false, 0, true);
			seekBar.addEventListener(SeekBarEvent.END_SCRUB, endScrub_handler, false, 0, true);
			
			audio_mc.buttonMode = true;
			audio_mc.addEventListener(MouseEvent.CLICK,sound_handler,false,0,true);
		}
		
		private function sound_handler (e:Event):void
		{
			if(audio_mc.currentFrame == 1) {
				setSoundVolume(0);
				audio_mc.gotoAndStop(2);		
			}else {
				setSoundVolume(1);
				audio_mc.gotoAndStop(1);
			}
		}
		
		private function setSoundVolume(value:Number):void
		{
			this._mp3Player.volume = value;
		}
		
		private function playPause_handler (e:Event):void
		{
		
			if(pauseResume_mc.currentFrame == 2) {
				pauseAudio();
				pauseResume_mc.gotoAndStop(1);
			}else {
				resumeAudio();
				pauseResume_mc.gotoAndStop(2);
			}
		}
		
		private function resumeAudio():void
		{
			if (this._firstPlay) {
				this._mp3Player.play();
			} else {
				this._mp3Player.unpause();
			}
		}
		
		private function pauseAudio():void
		{
			this._firstPlay = false;
			this._mp3Player.pause();
		}
		
		private function stop_handler (e:Event):void 
		{
			pauseResume_mc.gotoAndStop(1);
			stopAudio();	
		}
		
		private function stopAudio():void
		{
			trace("Controls.stopAudio");
			this._mp3Player.stop();
			this._mp3Player.autoRewind = true;
		}
		
		private function addPlayerListeners():void
		{	
			_mp3Player.addEventListener(MP3PlayerEvent.EVENT_PLAY, mp3PlayerEvent_handler, false, 0, true);
			_mp3Player.addEventListener(MP3PlayerEvent.PLAYHEAD_UPDATE, mp3PlayerEvent_handler, false, 0, true);
			_mp3Player.addEventListener(MP3PlayerEvent.AUTO_REWOUND, mp3PlayerEvent_handler, false, 0, true);
			_mp3Player.addEventListener(MP3PlayerEvent.EVENT_PAUSE, mp3PlayerEvent_handler, false, 0, true);
			_mp3Player.addEventListener(MP3PlayerEvent.STOPPED, mp3PlayerEvent_handler, false, 0, true);
			_mp3Player.addEventListener(MP3PlayerEvent.EVENT_UNPAUSE, mp3PlayerEvent_handler, false, 0 , true);
			_mp3Player.addEventListener(MP3PlayerEvent.EVENT_TIME_CHANGE, mp3PlayerEvent_handler, false, 0, true);
			_mp3Player.addEventListener(MP3PlayerEvent.EVENT_VOLUME_CHANGE, mp3PlayerEvent_handler, false, 0, true);
			_mp3Player.addEventListener(MP3PlayerEvent.EVENT_PAN_CHANGE, mp3PlayerEvent_handler, false, 0, true);
			_mp3Player.addEventListener(MP3PlayerProgressEvent.PROGRESS, mp3PlayerEvent_handler, false, 0, true);
			_mp3Player.addEventListener(MP3PlayerEvent.LOAD_COMPLETE, mp3PlayerEvent_handler, false, 0, true);
		}
		
		private function mp3PlayerEvent_handler(e:Event):void 
		{
			switch(e.type)
			{
				case MP3PlayerEvent.PLAYHEAD_UPDATE :
						if(!_seeking)
							seekBar.position = _mp3Player.timePercent;
							
						time_txt.text = _mp3Player.timePretty;
						
						//totalTime_txt.visible = true;
						//
						//if (_mp3Player.lengthPretty is NaN) 
						//	totalTime_txt.visible = false;
							
						totalTime_txt.text = _mp3Player.lengthPretty;
						
						break;
						
				case MP3PlayerEvent.EVENT_PLAY:
				
						pauseResume_mc.gotoAndStop(2);
						
						this.seekBar.setEnabled(true);
						//trace("MP3_START_PLAYING");
				
						break
				case MP3PlayerEvent.EVENT_PAUSE:
						//trace("MP3_PAUSE");
				
						break;
				case MP3PlayerEvent.EVENT_UNPAUSE:
						pauseResume_mc.gotoAndStop(2);
						//trace("MP3_UNPAUSE");
						break;
				
				case MP3PlayerEvent.STOPPED:
						//trace("MP3_STOPPPED");
						
						break;
				
				case MP3PlayerEvent.START_PLAYING :
				
						//trace("START_PLAYING");
						
						break;
				
				case MP3PlayerEvent.COMPLETE :
						//trace("MP3_COMPLETE");
						pauseResume_mc.gotoAndStop(1);
				
						break;
						
				case MP3PlayerEvent.AUTO_REWOUND :
												
						if(!_seeking) {
							this.seekBar.position = this.seekBar.min;
							pauseResume_mc.gotoAndStop(1);
						}
						
						break;	
					
				case MP3PlayerEvent.LOAD_COMPLETE :
						
						//this.seekBar.setEnabled(true);
						
						break;	
						
				case MP3PlayerProgressEvent.PROGRESS :
						//trace("PROGRESS");
						this.seekBar.updateProgress(_mp3Player.bytesLoaded / _mp3Player.bytesTotal);
						break;	
			}
		}
		
		private function removePlayerListeners():void
		{
			_mp3Player.removeEventListener(MP3PlayerEvent.EVENT_PLAY, mp3PlayerEvent_handler);
			_mp3Player.removeEventListener(MP3PlayerEvent.EVENT_PAUSE, mp3PlayerEvent_handler);
			_mp3Player.removeEventListener(MP3PlayerEvent.EVENT_UNPAUSE, mp3PlayerEvent_handler);
			_mp3Player.removeEventListener(MP3PlayerEvent.STOPPED, mp3PlayerEvent_handler);
			_mp3Player.removeEventListener(MP3PlayerEvent.AUTO_REWOUND, mp3PlayerEvent_handler);
			_mp3Player.removeEventListener(MP3PlayerEvent.EVENT_TIME_CHANGE, mp3PlayerEvent_handler);
			_mp3Player.removeEventListener(MP3PlayerEvent.EVENT_VOLUME_CHANGE, mp3PlayerEvent_handler);
			_mp3Player.removeEventListener(MP3PlayerEvent.EVENT_PAN_CHANGE, mp3PlayerEvent_handler);
			_mp3Player.removeEventListener(MP3PlayerEvent.PLAYHEAD_UPDATE, mp3PlayerEvent_handler);
			_mp3Player.removeEventListener(MP3PlayerProgressEvent.PROGRESS, mp3PlayerEvent_handler);
			_mp3Player.removeEventListener(MP3PlayerEvent.LOAD_COMPLETE, mp3PlayerEvent_handler);
		}
		
		private function onChange(e:SeekBarEvent):void 
		{
			this._mp3Player.seek( e.position);
		}
		
		private function beginScrub_handler(e:SeekBarEvent):void 
		{
			_seeking = true;
			_isPlaying = this._mp3Player.isPlaying;	
		}
		
		private function endScrub_handler(e:SeekBarEvent):void 
		{
			_seeking = false;
					
			if (!_isPlaying) {
				this._mp3Player.pause();
			}
			
			if (this._mp3Player.isComplete && this._mp3Player.autoRewind) {
				
				this.seekBar.position = this.seekBar.min;
				pauseResume_mc.gotoAndStop(1);
				
			}
		}
		
		public function dispose():void
		{
			pauseResume_mc.removeEventListener(MouseEvent.CLICK,playPause_handler);
			stop_btn.removeEventListener(MouseEvent.CLICK, stop_handler);
			
			seekBar.removeEventListener(SeekBarEvent.CHANGE, onChange);
			seekBar.removeEventListener(SeekBarEvent.BEGIN_SCRUB, beginScrub_handler);
			seekBar.removeEventListener(SeekBarEvent.END_SCRUB,endScrub_handler);
			removePlayerListeners();
		}
		
		public function get mp3Player():MP3Player { 
			return _mp3Player;
		}
		
		public function set mp3Player(value:MP3Player):void 
		{
			_mp3Player = value;
			addPlayerListeners();
		}
		
		public function get seeking():Boolean { return _seeking; }
	}
	
}