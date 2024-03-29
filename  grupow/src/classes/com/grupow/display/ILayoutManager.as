﻿
/**
 * 
 * Grupow ILayoutManager
 * Copyright (c) 2010 ruranga@grupow.com
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
	
	public interface ILayoutManager 
	{
		function update():void;
		function registerItem(item:IResizeable):void;
		function getItem(index:Number):IResizeable;
		function removeItem(item:IResizeable):void;
		function get stageWidth():Number;
		function get stageHeight():Number;
	}
	
}