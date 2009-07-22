package com.grupow.audio 
{
	
	/**
	 * ...
	 * @author David Gámez
 	 *
 	 *
	 * 
	 */
	
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLRequest;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;		
	import flash.utils.Timer;

	public class MP3Player extends Sprite
	{
		protected var sound:Sound;
		protected var soundChannel:SoundChannel;
		protected var soundTrans:SoundTransform;
		private var _playing:Boolean;
		private var _isPaused:Boolean;
		private var _autoRewind:Boolean;
		private var _currentSeekTime:Number;
		private var _playingTimer:Timer;
		private var _oTime:Number;//oldTime
		private var _cTime:Number;//currentTime
		private var _startPlayingEventFired:Boolean;
		private var _path:String;
		private var _isSeeking:Boolean;
		private var _stopped:Boolean;
		private var _isComplete:Boolean;
		private var _bytesLoaded:Number;
		private var _bytesTotal:Number;
		private var _pausePosition:Number;
		
		

		public function MP3Player():void 
		{
			initialize();
		}
		
		private function initialize():void
		{	
			_playingTimer = new Timer(0);
			_playingTimer.addEventListener(TimerEvent.TIMER, updatePlayhead_handler, false, 0, true);
		
			_isComplete = false;
			_isSeeking = false;
			_isPaused = false;
			_autoRewind = false;
			_stopped = false;	
			_startPlayingEventFired = false;
			
			_bytesLoaded = 0; 
			_bytesTotal = 0;
			
			_oTime = -1;
			_cTime = -1;	
		}
		
		private function updatePlayhead_handler(e:TimerEvent):void 
		{
			if (_oTime < 0 && _cTime < 0) {
				_oTime = _cTime = time;
			}
			
			_oTime = _cTime
			_cTime = time;
					
			if (_oTime != _cTime && (time * 10 > 1)) {
				
				dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.PLAYHEAD_UPDATE));
				
				if (!_startPlayingEventFired) {
								
					_startPlayingEventFired = true;
					
					dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.START_PLAYING));
				}
				
			}
			
			if (this.timePercent >= 0.99 ) {
				this._playingTimer.stop();
				this.soundComplete_handler();
			}
		}
		
		private function onLoadProgress(e:ProgressEvent):void 
		{
			_bytesLoaded = e.bytesLoaded; 
			_bytesTotal = e.bytesTotal;
			
			this.dispatchEvent(new MP3PlayerProgressEvent(MP3PlayerProgressEvent.PROGRESS, false, false, _bytesLoaded, _bytesTotal));			
		}
		
		private function onLoadComplete(e:Event):void 
		{
			this.dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.LOAD_COMPLETE));	
		}
		
		
		protected function soundComplete_handler():void 
		{ 
			trace("__soundComplete_handler__");
			
			_isComplete = true;
			
			this.dispatchEvent( new MP3PlayerEvent(MP3PlayerEvent.SOUND_COMPLETE));
			
			if (_autoRewind) {
				this.seek(0);
				this.pause();
				this.dispatchEvent( new MP3PlayerEvent(MP3PlayerEvent.AUTO_REWOUND));
			}
		}
		
		protected function onId3Info( e:Event ):void
		{
			dispatchEvent(new Event(Event.ID3, e.target.id3));
		}
		
		private function onSoundComplete_handler(e:Event):void 
		{
			this.dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.COMPLETE));
		}
		
		public function play(value:String = ""):void 
		{		
			if (value.length) {
				this.contentPath = value;
			}
			
			_stopped = false;
			_isPaused = false;
			_isComplete = false;
			_oTime = -1;
			_cTime = -1;
			_startPlayingEventFired = false;
			_playingTimer.stop();
			_pausePosition = 0;
			
			if ( sound ) {
				
				soundChannel.stop();
				soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete_handler);
				
				try {
					sound.removeEventListener(Event.ID3, onId3Info);
					sound.removeEventListener(Event.COMPLETE, onLoadComplete);
					sound.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
					sound.close();
				}catch (e:*) {
					
				}
			}
			
			sound = new Sound();
			
			sound.load(new URLRequest(_path));
			sound.addEventListener(Event.ID3, onId3Info);
			sound.addEventListener(Event.COMPLETE, onLoadComplete);
			sound.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);

			soundChannel = sound.play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete_handler, false, 0, true);
			
			trace("play_handler__");
			
			_playing = true;
	
			if ( soundTrans ) {
				soundChannel.soundTransform = soundTrans;
			} else {
				soundTrans = soundChannel.soundTransform;
			}
					
			dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.EVENT_PLAY));
			_playingTimer.start();
		}
		
		public function pause():void
		{
			if (!_isPaused && soundChannel) {
				
				trace("__pause_handler__");
				
				_isPaused = true; 
				_playing = false;
				
				_playingTimer.stop();
				_pausePosition = soundChannel.position;
				
				soundChannel.stop();
				soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete_handler);
				
				dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.EVENT_PAUSE));
			}
		}
		
		public function unpause():void
		{			
			if (_isPaused) {
				
				trace("__unpause__")
				
				_isPaused = false; 
				_playing = true;
				_stopped = false;
				_playingTimer.start();
				
				trace("_pausePosition: ",_pausePosition);
				
				soundChannel = sound.play(_pausePosition);
				//channel.soundTransform = (mute_mc.isMute)? new SoundTransform(0) : sndTrans;
                soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete_handler, false, 0, true);
				
				_playing = true;
				_isPaused = false;
				_playingTimer.start();
	
				dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.EVENT_UNPAUSE));
			}
		}
			
		private function stop_handler():void
		{
			trace("__stop_handler__")
			
			_pausePosition = 0;
			_stopped = true;
			_isPaused = true;
			_isSeeking = false;
			_playing = false;
			
			trace("soundChannel: ", soundChannel);
			
			if(_playingTimer != null)
				_playingTimer.stop();
			
			if(soundChannel != null) {
				soundChannel.stop();
				soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete_handler);
				soundChannel = null;
			}
			
			//this.stop();
		}
		
		public function stop():void
		{
			if (!_stopped) {
				
				stop_handler();
				this.dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.STOPPED));
			}
		}
				
		public function seek( percent:Number = 0 ):void 
		{
			soundChannel.stop();
			soundChannel = sound.play(sound.length * percent);
			_pausePosition = soundChannel.position;
		}
				
		public function get bytesLoaded():Number
		{
			return _bytesLoaded;
		}
		
		public function get bytesTotal():Number
		{
			return _bytesTotal;
		}
		
		public function get autoRewind():Boolean
		{ 
			return _autoRewind;
		}
		
		public function set autoRewind(value:Boolean):void 
		{
			_autoRewind = value;
		}
		
		
		public function get isPlaying():Boolean
		{
			return _playing;
		}
		
		public function get volume():Number
		{
			if (!soundTrans) return 0;
			return soundTrans.volume;
		}
		
		public function set volume( n:Number ):void 
		{
			if ( !soundTrans ) return;
			soundTrans.volume = n;
			soundChannel.soundTransform = soundTrans;
			dispatchEvent(new Event(MP3PlayerEvent.EVENT_VOLUME_CHANGE));
		}
		/*/
		public function get pan():Number
		{
			if (!soundTrans) return 0;
			return soundTrans.pan;
		}
		
		public function set pan( n:Number ):void 
		{
			if ( !soundTrans ) return;
			soundTrans.pan = n;
			soundChannel.soundTransform = soundTrans;
			dispatchEvent(new MP3PlayerEvent(MP3PlayerEvent.EVENT_PAN_CHANGE, false, false, true));
		}
		//*/
		public function get length():Number 
		{
			//return sound.length;
			
			var l:Number = 0;
			
			if (sound.id3.TLEN) { 
				l = sound.id3.TLEN;
			}
			
			return l;
		}
		
		public function get lengthPretty():String 
		{
			
			var l:String = "";
				
			if (sound.id3.TLEN) { 
				
				var secs:Number = sound.id3.TLEN/ 1000;
				var mins:Number = Math.floor(secs / 60);
				secs = Math.floor(secs % 60);
				l = mins + ":" + (secs < 10 ? "0" : "") + secs;
			}
			
			return l;
		}
		
		public function get time():Number 
		{
			return soundChannel.position;
		}
		
		public function get timePretty():String
		{
			var secs:Number = soundChannel.position / 1000;
			var mins:Number = Math.floor(secs / 60);
			secs = Math.floor(secs % 60);
			return mins + ":" + (secs < 10 ? "0" : "") + secs;
		}
		
		public function get timePercent():Number 
		{
			if ( !sound.id3.TLEN ) return 0;
			return soundChannel.position / sound.id3.TLEN;
		}
		
		/*
		public function get timePercent():Number 
		{
			if ( !sound.length ) return 0;
			return soundChannel.position / sound.length;
		}
		*/
		public function get contentPath():String 
		{
			return _path;
		}
		
		public function set contentPath(value:String):void 
		{
			_path = value;
		}
		
		public function get isComplete():Boolean { return _isComplete; }
					
		public function dispose():void
		{	
			this.stop();
			
			_playingTimer.stop();
			_playingTimer.removeEventListener(TimerEvent.TIMER, updatePlayhead_handler);
			_playingTimer = null;
			
			sound.removeEventListener(Event.ID3, onId3Info);
			//soundChannel.removeEventListener(MP3PlayerEvent.SOUND_COMPLETE, onSongEnd);
		}
	}
}
