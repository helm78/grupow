package com.grupow.loading 
{
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	 * ...
	 * @author Raúl Uranga
	 */
	public class FLVCacher extends EventDispatcher
	{
		public static const PROGRESS : String = "progress";
		public static const COMPLETE : String = "complete";
		
		private var _vidConnection:NetConnection;
		private var _vidStream:NetStream;
		private var _infoClient:Object;
		private var _initializated:Boolean;
		private var _path:String;
		private var _playing:Boolean;
		private var _bufferTime:Number;
		private var _dummy:Sprite;
		private var _progress:Number;
		
		public var debugMode:Boolean = false;

		/**
		 * 
		 * @param	target path to the FLV
		 * @param	buffertime  time in ms for the buffer
		 */
		public function FLVCacher(target:String,buffertime:Number = 5) 
		{
			_infoClient = new Object();
			_infoClient.onCuePoint = onCuePoint;
			_infoClient.onMetaData = onMetaData;
			
			_path = target;
			_bufferTime = buffertime
			
			_progress = 0;
		}
		
		public function get progress():Number { return _progress / 100; }
		
		public function getStream():NetStream { return _vidStream; }
		
		public function dispose():void
		{
			_vidConnection.close();
			_vidConnection.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus_handler);
			_vidConnection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError_handler);
				
			_vidConnection = null;
			_vidStream.close();
			_vidStream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus_handler);
			_vidStream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError_handler);
			_vidStream = null;
		}
		
		public function load():void 
		{	
			_vidConnection = new NetConnection();
			_vidConnection.connect(null);
			_vidConnection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_handler, false, 0, true);
			_vidConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError_handler, false, 0, true);
			
			_vidStream = new NetStream(_vidConnection);
			_vidStream.client = _infoClient;
			_vidStream.bufferTime = _bufferTime;
			_vidStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus_handler, false, 0, true);
			_vidStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError_handler, false, 0, true);
			
			_vidStream.play(_path, 0);
            _vidStream.seek(0);
			
			_dummy = new Sprite();
            _dummy.addEventListener(Event.ENTER_FRAME, enterframe_handler, false, 0, true);
		}
		
		private function enterframe_handler(e:Event):void 
		{
			if (_vidStream.bytesLoaded == _vidStream.bytesTotal && _vidStream.bytesTotal > 8) {
				
				if (_dummy != null)
					_dummy.removeEventListener(Event.ENTER_FRAME, enterframe_handler);
				
				debug("__Event.COMPLETE__");
				
				this.dispatchEvent(new Event(Event.COMPLETE));
				
            } else {
				
				
				_progress = Math.min(Math.round(_vidStream.bufferLength / _vidStream.bufferTime * 100), 100);
				//
				debug("_progress: ", _progress);
				
				this.dispatchEvent(new Event(ProgressEvent.PROGRESS));
				//				
				if (_progress == 100) {
					
					debug("__Event.COMPLETE__");
					
					_dummy.removeEventListener(Event.ENTER_FRAME, enterframe_handler);
					_dummy = null;
					
					this.dispatchEvent(new Event(Event.COMPLETE));
				}
				
			}
		}
				
		private function debug(...rest):void
		{
			if(debugMode)
				trace("[FLVCacher] " + rest);
		}
		
		private function onAsyncError_handler(e:AsyncErrorEvent):void 
		{
			//debug("onAsyncError_handler: " + e.text);
		}
		
		private function onNetStatus_handler(e:NetStatusEvent):void 
		{
			debug("-----------------------")
			debug(">>onNetStatus_handler");
			debug(e.info.code);
			
			switch (e.info.code)
			{
				//*/
				case "NetStream.Play.Start":
					
					debug("NetStream.Play.Start");
					
					_vidStream.pause();
					
					break;
	
					
				case "NetStream.Play.StreamNotFound":
					
					debug("NetStream.Play.StreamNotFound");
					
					break;
			}

		}
		
		private function onMetaData(info:Object):void
		{
			//_metaData = info;
		}
		 
		private function onCuePoint(info:Object):void
		{
			
		}
			
	}
	
}