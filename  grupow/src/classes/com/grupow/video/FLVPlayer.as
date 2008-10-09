
package com.grupow.video {
	
	import com.grupow.video.FLVPlayerMetadataEvent;
	import com.grupow.video.FLVPlayerEvent;
	import com.grupow.video.FLVPlayerProgressEvent;
	import flash.display.Sprite;
	
	import flash.utils.Timer;
	
	import flash.display.MovieClip;
	
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	//import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	
	/**
	* ...
	* @author Raúl Uranga
	* @version 0.01
	*/
	
	/*
	 * TODO escuchar al listeneer de REMOVE_FROM_STAGE???
	 * TODO tomar las medidas de width/height del bg_mc si existe?¿
	 * TODO meter el try catch en _vidStream.play();???
	 * TODO darle bubble al NetStatusEvent.NET_STATUS y AsyncErrorEvent.ASYNC_ERROR
	 * 
	 * */
	
	public class FLVPlayer extends Sprite
	{
		
		private var _video:Video;
		private var _vidConnection:NetConnection;
		private var _vidStream:NetStream;
		private var _infoClient:Object;
		private var _initializated:Boolean;
		private var _path:String;
		private var _playing:Boolean;
		private var _bufferTime:Number;
		private var _duration:Number;
		private var _volume:Number;
		private var _soundTrans:SoundTransform;
		private var _metaData:Object;
		private var _isSeeking:Boolean;
		private var _isPaused:Boolean;
		private var _loadertimer:Timer;
		private var _autoRewind:Boolean;
		private var _debugMode:Boolean;
		private var _playingTimer:Timer;
		private var _currentSeekTime:Number;
		private var _updateSeekTimeTimer:Timer;
		private var _isComplete:Boolean;
		private var _oTime:Number;//oldTime
		private var _cTime:Number;//currentTime
		
		private var _videoWidth:Number;
		private var _videoHeight:Number;
		private var _startPlayingEventFired:Boolean;
		private var _stopped:Boolean;
		
		private var _loop:Boolean;
		
		public function FLVPlayer(width:int = 320, height:int = 240)
		{
			debug("FLVPlayer Class");
			
			_video = new Video(width, height);
			
			_videoWidth = _video.width
			_videoHeight = _video.height;
			
			try {
				
				bg_mc.visible = false;
				
			}catch(e:*){
			}
			
			addChild(_video);
			
			this.graphics.clear();
			this.graphics.clear();
			
			init();
			initConnection();
		}
		
		private function init():void
		{	
			_loadertimer = new Timer(0);
			_loadertimer.addEventListener(TimerEvent.TIMER, onLoadProgress, false, 0, true);
			
			_playingTimer = new Timer(0);
			_playingTimer.addEventListener(TimerEvent.TIMER, updatePlayhead_handler, false, 0, true);
			
			_updateSeekTimeTimer = new Timer(0);
			_updateSeekTimeTimer.addEventListener(TimerEvent.TIMER, updateSeekTime_handler, false, 0, true);
									
			//_eventDispatcher = new EventDispatcher(this);
			
			_isSeeking = false;
			_isPaused = false;
			_autoRewind = false;
			_stopped = false;
			_duration = 0;
			_startPlayingEventFired = false;
			
			_oTime = -1;
			_cTime = -1;
			
			_soundTrans = new SoundTransform();
			
			_infoClient = new Object();
			_infoClient.onCuePoint = onCuePoint;
			_infoClient.onMetaData = onMetaData;
			
			
			loop = false;
		
		}
		
		private function updateSeekTime_handler(e:TimerEvent):void 
		{
			if (_currentSeekTime != _vidStream.time)
			{
				updatePlayhead_handler(null);
				_updateSeekTimeTimer.stop();
			}
		}
		
		private function updatePlayhead_handler(e:TimerEvent):void 
		{
			if (_oTime < 0 && _cTime < 0) {
				_oTime = _cTime = time;
			}
			
			_oTime = _cTime
			_cTime = time;
			
			//debug("_oTime: " + _oTime);
			//debug("_cTime: " + _cTime);
					
			if (_oTime != _cTime && (time * 10 > 1)) {
				dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.PLAYHEAD_UPDATE, false, false, this.time));
				
				if (!_startPlayingEventFired) {
					
					trace(">>_startPlayingEventFired");
					
					_startPlayingEventFired = true;
					
					dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.START_PLAYING, false, false, this.time));
				}
				
			}
		}
		

		public function dispose():void
		{	
			//this.stop();
					
			_loadertimer.stop();
			_loadertimer.removeEventListener(TimerEvent.TIMER, onLoadProgress);
			_loadertimer = null;
			
			_playingTimer.stop();
			_playingTimer.removeEventListener(TimerEvent.TIMER, updatePlayhead_handler);
			_playingTimer = null;
			
			_updateSeekTimeTimer.stop();
			_updateSeekTimeTimer.removeEventListener(TimerEvent.TIMER, updateSeekTime_handler);
			_updateSeekTimeTimer = null;
			
			killConnection();
			
			//_timeline = null;
			
			//delete this??¿¿
		}
				
		public function killConnection():void
		{
			_video.clear();
			
			//if (_vidConnection != null)
			//{
			_vidConnection.close();
			_vidConnection.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus_handler);
			_vidConnection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError_handler);
				
			_vidConnection = null;
			//}
			
			//if (_vidStream != null)
			//{
			_vidStream.close();
			_vidStream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus_handler);
			_vidStream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError_handler);
				
			_vidStream = null;
			
			_video = null;
			//}
		}
		
		private function initConnection():void
		{
			debug("FLVPlayer.initConnection")
			
			_vidConnection = new NetConnection();
			_vidConnection.connect(null);
			_vidConnection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_handler, false, 0, true);
			_vidConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError_handler, false, 0, true);
			
			_vidStream = new NetStream(_vidConnection);
			_vidStream.client = _infoClient;
			_vidStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_handler, false, 0, true);
			_vidStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError_handler, false, 0, true);
			
			
			_video.attachNetStream(_vidStream);
			
			debug("_soundTrans.volume: " + _soundTrans.volume);
			
			_vidStream.soundTransform = _soundTrans;		
			
			debug("_vidStream.soundTransform.volume: " + _vidStream.soundTransform.volume);
		}
		
		private function onAsyncError_handler(e:AsyncErrorEvent):void 
		{
			debug("onAsyncError_handler: " + e.text);
		}
		
		/*
		* NetStream.Buffer.Empty : Data is not being received quick enough to fill the buffer.
		* NetStream.Buffer.Full: The buffer is filled and the video is "good to go".
		* NetStream.Buffer.Flush: Video is finished and the buffer will be emptied.
		* NetStream.Play.Start : Video is playing.
		* NetStream.Play.Stop : The video is finished.
		* NetStream.Play.StreamNotFound : The video plunked into the stream can't be found.
		* NetStream.Seek.InvalidTime: The user is trying to "seek" or play beyond the end of the video or beyond what has downloaded so far.
		* NetStream.Seek.Notify: The seek operation is finished.
		*/
		
		private function onNetStatus_handler(e:NetStatusEvent):void 
		{
			debug("onNetStatus_handler");
			
			try 
			{	
		
				debug("level", e.info.level, " code: ", e.info.code);
				
				switch (e.info.code)
				{
					case "NetStream.Play.Start":
						
						//_playing = true;
						debug(">>NetStream.Play.Start");
						
						_playingTimer.start();
						this.dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.READY,false,false,this.time));
						
						break;
					
					case "NetStream.Play.StreamNotFound":
					case "NetStream.Play.Stop":
					
						_playing = false;
						_playingTimer.stop();
						_updateSeekTimeTimer.stop();
						_loadertimer.stop();
						
						debug("_autoRewind: " + _autoRewind);
						
						_oTime = _cTime = 0;
											
						if (_autoRewind && e.info.code == "NetStream.Play.Stop" ) {
							
							this.stop_handler();
							
							this.dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.AUTO_REWOUND,false,false,this.time));
							
														
						} if (!loop) {
							
							_isComplete = true;
							
							this.dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.COMPLETE,false,false,this.time));
												
						}else {
							
							this.seek(0);
							
						}
						
						if (e.info.code == "NetStream.Play.StreamNotFound") {
							this.dispatchEvent(new FLVPlayerErrorEvent(FLVPlayerErrorEvent.STREAM_NOT_FOUND,false,false));
						}
						
						break;
						
					case "NetStream.Seek.InvalidTime":
					case "NetStream.Seek.Notify":
						
						debug("Seek.Notify: " + this._vidStream.time);
												
						if (_isSeeking) {
							
							_isSeeking = false;
							//if (!_isPaused)
							//	this.resume();
						}
						
						if (_isPaused) {
							_updateSeekTimeTimer.start();
						}
						
						/*/
						if (!_isPaused) {
							
							//this.resume();
							
						}else{
							_updateSeekTimeTimer.start();
						}
						//*/
						
						if (e.info.code == "NetStream.Seek.InvalidTime") {
							this.dispatchEvent(new FLVPlayerErrorEvent(FLVPlayerErrorEvent.INVALID_SEEK_TIME,false,false));
						}
						
						break;
						
					case "NetStream.Buffer.Full":
						//continue playing
						_playing = true;
						_playingTimer.start();
						break; 
						
					case "NetStream.Buffer.Empty":
						
						//buffering
						
						debug(">>NetStream.Buffer.Empty");
						
						_playing = false;
						_playingTimer.stop();
						this.dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.BUFFERING,false,false,this.time));						
						break; 
						
					case "NetStream.Buffer.Flush":
					
						break; 
				}

				
			}
			catch(error:TypeError)
			{
				//	Ignore any errors
			}
		}
		
		private function onMetaData(info:Object):void
		{
			debug("info.duration: " + info.duration);
			_duration = info.duration;
			_metaData = info;
			this.dispatchEvent(new FLVPlayerMetadataEvent(FLVPlayerMetadataEvent.METADATA_RECEIVED,false,false,_metaData));
		}
		 
		private function onCuePoint(info:Object):void
		{
			/*/
			//debug(onCuePoint:);
			debug("-----------------------");
			debug("::onCuePoint::");
			for (var name:String in info) {
				trace(name + ":" + info[name]);
			}
			debug("-----------------------");
			//*/
			
			this.dispatchEvent(new FLVPlayerMetadataEvent(FLVPlayerMetadataEvent.CUE_POINT,false,false,info));
		}
		
		private function startLoader():void
		{
			_loadertimer.stop();
			_loadertimer.start();
		}
		
		private function onLoadProgress(e:TimerEvent):void 
		{
			this.dispatchEvent(new FLVPlayerProgressEvent(FLVPlayerProgressEvent.PROGRESS, false, false, this.bytesLoaded, this.bytesTotal));
		
			if (this.bytesLoaded / this.bytesTotal == 1)
				_loadertimer.stop();
			
		}
		
		private function debug(...rest):void
		{
			if(this.debugMode)
				trace(rest);
		}
		
		public function get contentPath():String 
		{
			return _path;
		}
		
		public function set contentPath(value:String):void 
		{
			_path = value;
		}
		
		public function get bufferTime():Number 
		{ 
			return _vidStream.bufferTime; 
		}
		
		public function set bufferTime(value:Number):void
		{
			_vidStream.bufferTime = value;
		}
		
		public function get bytesLoaded():Number
		{
			return this._vidStream.bytesLoaded;
		}
		
		public function get bytesTotal():Number
		{
			return this._vidStream.bytesTotal;
		}
		
		public function getPercentLoaded():Number
		{
			return this._vidStream.bytesLoaded / this._vidStream.bytesTotal;
		}
		
		public function get position():Number
		{
			return (this.duration != 0) ? (this.time / this.duration) : 0;
		}
			
		public function get time():Number
		{
			return this._vidStream.time;
		}
		
		public function get duration():Number { return _duration; }
		
		public function get volume():Number 
		{ 
			return _soundTrans.volume;
		}
		
		public function set volume(value:Number):void 
		{
			_soundTrans.volume = value;
			if (_vidStream)
			{
				_vidStream.soundTransform = _soundTrans;
			}
		}
		
		public function get metadata():Object
		{
			return _metaData;
		}
		
		public function get isPlaying():Boolean
		{
			return _playing;
		}
		
		public function get autoRewind():Boolean
		{ 
			return _autoRewind;
		}
		
		public function set autoRewind(value:Boolean):void 
		{
			_autoRewind = value;
		}
		
		public function get debugMode():Boolean 
		{ 
			return _debugMode;
		}
		
		public function set debugMode(value:Boolean):void 
		{
			_debugMode = value;
		}
		
		public function get videoWidth():Number { return _videoWidth; }
		
		public function set videoWidth(value:Number):void 
		{
			this._video.width = _videoWidth = value;
		}
		
		public function get videoHeight():Number { return _videoHeight; }
		
		public function set videoHeight(value:Number):void 
		{
			this._video.height = _videoHeight = value;
		}
		
		public function get loop():Boolean { return _loop; }
		
		//TODO sobreescribir autoRewind?? no deben de convivir las 2 no??
		public function set loop(value:Boolean):void 
		{
			this.autoRewind = false;
			_loop = value;
		}
			
		public function play(value:String = ""):void
		{
			if (value.length) {
				this.contentPath = value;
			}
			
			//killConnection();
			//initConnection();
			
			_oTime = -1;
			_cTime = -1;
			
			_isComplete = false;
			
			_startPlayingEventFired = false;
			
			_playingTimer.stop();
			
			startLoader();
			
			_vidStream.play(contentPath);
			
			this.dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.BUFFERING,false,false,this.time));
		}
		
		public function pause():void
		{
			if (!_isPaused) {
				
				_isPaused = true; 
				//!_isPaused;
				_playing = false;
				_vidStream.pause();
				//togglePause();
				_playingTimer.stop();
				
				this.dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.PAUSED,false,false,this.time));
			}
		}
		
		public function resume():void
		{
			trace("__resume__");
			debug(">>>resume");
			
			//*/
			if (_isComplete) {
				//this.stop();
				_vidStream.seek(0);
			}
			//*/
			
			_isPaused = false;
			_stopped = false;
			_playing = true;
			
			_vidStream.resume();
			
			_playingTimer.start();
			//*/
		}
		
		public function fastForward(offset:Number = 5):void
		{
			seek(this.time + offset);
		}
		
		public function rewind(offset:Number = 5):void
		{
			seek(this.time - offset);
		}
		
		public function seek(offset:Number = 0):void
		{
			if (!_isSeeking)
			{
				var seekTime:Number = offset;
				
				
				if (seekTime < 0 )
				{
					seekTime = 0;
				}
				
				if (seekTime > this.duration)
				{
					seekTime = this.duration;
				}
				
				_isSeeking = true;
				_currentSeekTime = this.time;
				
				debug("seek currentTime", this._vidStream.time);
				debug("seek seekTime", seekTime);
				
				//this._vidStream.pause();
				
				this._playingTimer.stop();
				
				this._updateSeekTimeTimer.stop();
				
				_vidStream.seek(seekTime);
			}
		}
		
		
		
		private function stop_handler():void
		{
			_stopped = true;
			_isPaused = true;
			_isSeeking = false;
			_playing = false;
			_playingTimer.stop();
			_vidStream.pause();
			_vidStream.seek(0);
		}
		
		public function stop():void
		{
			if (!_stopped) {
				
				stop_handler();
				this.dispatchEvent(new FLVPlayerEvent(FLVPlayerEvent.STOPPED, false, false, this.time));
			}
		}
		
		public function clear():void
		{
			this._video.clear();
		}
		
		public function close():void
		{
			this._playingTimer.stop();
			this._loadertimer.stop();
			this._updateSeekTimeTimer.stop();
			
			this._vidConnection.close();
			this._vidStream.close();
		}
		
		/* INTERFACE flash.events.IEventDispatcher */
		/*/
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		public function dispatchEvent(event:Event):Boolean {
			return _eventDispatcher.dispatchEvent(event);
		}
				
		public function hasEventListener(type:String):Boolean {
			return _eventDispatcher.hasEventListener(type);
		}
				
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
				
		public function willTrigger(type:String):Boolean {
			return _eventDispatcher.willTrigger(type);
		}
		//*/
	}
		
	
}
