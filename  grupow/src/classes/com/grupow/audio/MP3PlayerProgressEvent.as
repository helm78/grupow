package com.grupow.audio 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author David Gámez
 	 *
 	 *
 	 *
 	 *
 	 * 
	 */
	public class MP3PlayerProgressEvent  extends Event
	{
		public static const PROGRESS:String = "onProgress";
		public var bytesLoaded:uint;
		public var bytesTotal:uint;
		
		public function MP3PlayerProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,bytesLoaded:uint = 0,bytesTotal:uint = 0) 
		{
			super(type, bubbles, cancelable);
			
			this.bytesLoaded = bytesLoaded;
			this.bytesTotal = bytesTotal;
			
		}
		
		public override function clone():Event {
            return new MP3PlayerProgressEvent(type, bubbles, cancelable,bytesLoaded,bytesTotal);
        }
		
	}
	
}