
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

package com.grupow.video {
	
	import flash.events.Event;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class FLVPlayerProgressEvent extends Event
	{
		public static const PROGRESS:String = "onProgress";
		public var bytesLoaded:uint;
		public var bytesTotal:uint;
		
		public function FLVPlayerProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,bytesLoaded:uint = 0,bytesTotal:uint = 0) {
			
			super(type, bubbles, cancelable);
			
			this.bytesLoaded = bytesLoaded;
			this.bytesTotal = bytesTotal;
		}
		
		public override function clone():Event {
            return new FLVPlayerProgressEvent(type, bubbles, cancelable,bytesLoaded,bytesTotal);
        }
		
	}
	
}