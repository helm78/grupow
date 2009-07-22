
/**
 * 
 * Grupow EnterFrameCallBack
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.utils 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class EnterFrameCallBack 
	{
		private static var list:Dictionary = new Dictionary();
	
		public function EnterFrameCallBack() 
		{
			
		}
		
		public static function call(callback:Function):void
		{
			clear(callback)
			
			var t = new SpriteHelper(callback);
			
			t.start();
			
			list[callback] = t;
		}
		
		public static function clear(callback:Function):void
		{
			if (list[callback] != null) {
				list[callback].stop();
				list[callback] = null;
			};
		}
		
	}
	
}

import flash.display.Sprite;
import flash.events.Event;
import com.grupow.utils.EnterFrameCallBack

class SpriteHelper extends Sprite
{
	private var handler:Function;
	
	public function SpriteHelper(func:Function) {
		this.handler = func;
	}
	
	public function start():void {
		this.addEventListener(Event.ENTER_FRAME, enterframe_handler);
	}
	
	public function stop():void {
		this.removeEventListener(Event.ENTER_FRAME, enterframe_handler);
		this.handler = null;
	}
	
	private function enterframe_handler(e:Event):void {
		
		this.removeEventListener(Event.ENTER_FRAME, enterframe_handler);
		this.handler.call();
		
		EnterFrameCallBack.clear(handler);
		
	}
}


/*/
package com.grupow.utils 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class EnterFrameCallBack 
	{
		private static var list:Dictionary = new Dictionary();
	
		public function EnterFrameCallBack() 
		{
			
		}
		
		public static function call(callback:Function):void
		{
			var t = new SpriteHelper(callback);
			t.start();
			list[t] = "foo";
		}
		
		public static function clear(target:SpriteHelper):void
		{
			list[target] = null;
		}
		
	}
	
}

import flash.display.Sprite;
import flash.events.Event;
import com.grupow.utils.EnterFrameCallBack

class SpriteHelper extends Sprite
{
	private var handler:Function;
	
	public function SpriteHelper(func:Function) {
		this.handler = func;
	}
	
	public function start():void {
		this.addEventListener(Event.ENTER_FRAME, enterframe_handler);
	}
	
	private function enterframe_handler(e:Event):void {
		
		this.removeEventListener(Event.ENTER_FRAME, enterframe_handler);
		this.handler();
		
		EnterFrameCallBack.clear(this);
		
	}
}
//*/
