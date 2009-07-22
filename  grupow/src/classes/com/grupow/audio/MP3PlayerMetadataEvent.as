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
	public class MP3PlayerMetadataEvent  extends Event
	{
		public static const METADATA_RECEIVED:String = "onMetadata";
		public static const CUE_POINT:String = "onCuePoint";
		public var info:Object;
		
		public function MP3PlayerMetadataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,info:Object = null)
		{
			super(type, bubbles, cancelable);
			
			this.info = info;
		}
	
		
		public override function clone():Event {
            return new MP3PlayerMetadataEvent(type, bubbles, cancelable,info);
        }
	}
	
}