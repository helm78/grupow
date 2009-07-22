
/**
 * 
 * Grupow ImageLoader
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.utils 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class ImageLoader extends Sprite
	{
		private var _loader:Loader;
		private var _loaderInfo:LoaderInfo;
		private var _progress:Number;
		private var _bytesloaded:uint;
		private var _bytesTotal:uint;
		private var _isComplete:Boolean;
		
		public var debugMode:Boolean;
		
		public function ImageLoader() 
		{
			debug("__ImageLoader Class__");
			
			debugMode = false;
			
			_progress = 0;
			
			this.addEventListener(Event.ADDED_TO_STAGE, added_handler, false,0,true );
			this.addEventListener(Event.REMOVED_FROM_STAGE, removed_handler, false,0,true );
		}
		
		private function removed_handler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, added_handler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removed_handler);
			dispose();
		}
		
		private function added_handler(e:Event):void 
		{
			
		}
		
		private function createLoaderListeners():void
		{
			_loaderInfo.addEventListener(Event.OPEN, open_handler, false, 0, true);
			_loaderInfo.addEventListener(Event.INIT, init_handler, false, 0, true);
			_loaderInfo.addEventListener(Event.COMPLETE, complete_handler, false, 0, true);
			_loaderInfo.addEventListener(Event.UNLOAD, unload_handler, false, 0, true);
			_loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress_handler, false, 0, true);
			_loaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpstatus_handler, false, 0, true);
			_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioerror_handler, false, 0, true);
		}
		
		private function removeLoaderListeners():void
		{
			_loaderInfo.removeEventListener(Event.OPEN, open_handler);
			_loaderInfo.removeEventListener(Event.INIT, init_handler);
			_loaderInfo.removeEventListener(Event.COMPLETE, complete_handler);
			_loaderInfo.removeEventListener(Event.UNLOAD, unload_handler);
			_loaderInfo.removeEventListener(ProgressEvent.PROGRESS,progress_handler);
			_loaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpstatus_handler);
			_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioerror_handler);
		}
		
		
		private function unload_handler(e:Event):void 
		{
			debug("image unloaded");
		}
		
		private function init_handler(e:Event):void 
		{
			debug("init_handler");
		}
		
		private function open_handler(e:Event):void 
		{
			debug("open_handler");
		}
		
		private function progress_handler(e:ProgressEvent):void 
		{
			_progress = e.bytesLoaded / e.bytesTotal;
			dispatchEvent(e);
		}
		
		private function httpstatus_handler(e:HTTPStatusEvent):void 
		{
			debug("HTTP status code: ", e.status);
		}
		
		private function ioerror_handler(e:IOErrorEvent):void 
		{
			trace("ImageLoader");
			trace("A loading error ocurred:\n", e.text);
		}
		
		private function complete_handler(e:Event):void 
		{
			_isComplete = true;
			
			addChild(_loader);
			
			dispatchEvent(e);
		}
		
		private function debug(...rest):void
		{
			if(debugMode)
				trace(rest);
		}
		
		public function get progress():Number { return _progress; }
		
		public function get isComplete():Boolean { return _isComplete; }
		
		private function dispose():void
		{
			disposeLoader();
			parent.removeChild(this)		
		}
		
		private function disposeLoader():void
		{
			try {
				_loader.close();
			}catch (e) { };
			
			try {
				_loader.unload();
			}catch (e) { };
			
			
			removeLoaderListeners();
			
			//removeChild(_loader);
			//_loader = null;
		}
		
		public function get content():DisplayObject 
		{
			return _loader.content;
		}
		
		public function load(value:String):void
		{
			
			if (_loader != null) {
				disposeLoader();
			}
			
			_progress = 0;
			_isComplete = false;
			
			_loader = new Loader();
			_loaderInfo = _loader.contentLoaderInfo;
			createLoaderListeners();

			try {
				
				_loader.load(new URLRequest(value));
				
			}catch (e:Error) {
				
				debug("Unable to load content:\n", e.message);
				
			}
		
		}
		
	}
	
}