package com.grupow.audio
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SeekBarEvent extends Event
	{
		public static const CHANGE:String = "change";
		public static const BEGIN_SCRUB:String = "begingScrub";
		public static const END_SCRUB:String = "endScrub";
		
		public var position:Number;
		
		public function SeekBarEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,position:Number = 0) {
			super(type, bubbles, cancelable);
			this.position = position;
		}
		
		public override function clone():Event {
            return new SeekBarEvent(type, bubbles, cancelable,this.position);
        }
	}
	
}