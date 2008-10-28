
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
	import flash.events.Event;
	
	/**
	* ...
	* @author Raúl Uranga
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