
/**
 * 
 * Grupow NullLayoutManager
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.display
{
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	
	import com.grupow.display.IResizeable;
	
	import flash.display.Sprite;
	
	public class NullLayoutManager implements ILayoutManager
	{
		
		
		public function NullLayoutManager() 
		{
			//super()
		}
		
		public function update():void
		{
			
		}
		
		public function registerItem(item:IResizeable):void
		{
			
		}
		
		public function getItem(index:Number):IResizeable
		{
			return new LayoutItem(new Sprite(), LayoutItem.CENTER);
		}
		
		public function removeItem(item:IResizeable):void
		{
	
		}
		
		public function get stageWidth():Number { return 0; }
		
		public function get stageHeight():Number { return 0; }
		
	}
	
}