
/**
 * 
 * Grupow NullView
 * Copyright (c) 2010 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.display 
{
	import flash.events.Event;

	/**
	 * ...
	 * @author Raúl Uranga
	 */
	public class NullView implements IView
	{

		public function NullView() 
		{
		}

		/* INTERFACE com.grupow.display.IView */

		public function open():void
		{
		}

		public function close():void
		{
		}

		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
		}

		public function dispatchEvent(event:Event):Boolean
		{
			return true;
		}

		public function hasEventListener(type:String):Boolean
		{
			return true;
		}

		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
		}

		public function willTrigger(type:String):Boolean
		{
			return true;
		}
	}
}