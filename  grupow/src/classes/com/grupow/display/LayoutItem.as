
/**
 * 
 * Grupow LayoutItem
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.display
{
	import flash.display.DisplayObject;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class LayoutItem implements IResizeable
	{
		
		public static const TOP:uint = 1 << 0;
		public static const LEFT:uint = 1 << 1;
		public static const RIGHT:uint = 1 << 2;
		public static const BUTTOM:uint = 1 << 3;
		public static const CENTER:uint = 1 << 4;
		
		public static const HORIZONTAL_CENTER:uint = 1 << 5;
		public static const VERTICAL_CENTER:uint = 1 << 6;
		
		public static const MATCH_STAGEHEIGHT:uint = 1 << 7;
		public static const MATCH_STAGEWIDTH:uint = 1 << 8;
		
		
		public static const PERCENT_HORIZONTAL_CENTER:uint = 1 << 9;
		public static const PERCENT_VERTICAL_CENTER:uint = 1 << 10;
		
		public var manager:LayoutManager;
		
		public var width:Number;
		public var height:Number;
		
		public var xoffset:Number;
		public var yoffset:Number;
		
		public var percentHorizontalCenter:Number;
		public var percentVerticalCenter:Number;
		
		private var target:DisplayObject;
		private var _flags:uint;
		
		public function LayoutItem(target:DisplayObject,flags:uint) 
		{
			this.target = target;
			
			this.width = this.target.width;
			this.height = this.target.height;
			
			xoffset = 0;
			yoffset = 0;
			
			percentHorizontalCenter = 0;
			percentVerticalCenter = 0;
			
			
			_flags = flags;
		}
		
		/* INTERFACE com.grupow.display.IResizeable */
		
		public function resizeTo(stageWidth:Number, stageHeight:Number):void
		{
			if (_flags & LayoutItem.LEFT) {
				this.target.x = this.xoffset;
			}else if (_flags & LayoutItem.RIGHT) {
				this.target.x = stageWidth - this.width + this.xoffset;
			}
			
			if (_flags & LayoutItem.TOP) {
				this.target.y = this.yoffset;
			}else if (_flags & LayoutItem.BUTTOM) {
				this.target.y = stageHeight - this.height + this.yoffset;
			}
			
			if (_flags & LayoutItem.MATCH_STAGEHEIGHT) {
				this.target.height = stageHeight;
			}
			
			if (_flags & LayoutItem.MATCH_STAGEWIDTH) {
				this.target.width = stageWidth;
			}
			
			if (_flags & LayoutItem.HORIZONTAL_CENTER) {
				this.target.x = (stageWidth * 0.5) - (this.width * 0.5) + this.xoffset;
			}
			
			if (_flags & LayoutItem.VERTICAL_CENTER) {
				this.target.y = (stageHeight * 0.5) - (this.height * 0.5) + this.yoffset;
			}
			
			if (_flags & LayoutItem.PERCENT_HORIZONTAL_CENTER) {
				this.target.x = (stageWidth * percentHorizontalCenter) - (this.width * 0.5) + this.xoffset;
			}
			
			if (_flags & LayoutItem.PERCENT_VERTICAL_CENTER) {
				this.target.y = (stageHeight * percentVerticalCenter) - (this.height * 0.5) + this.yoffset;
			}
			
			if (_flags & LayoutItem.CENTER) {
				this.target.x = (stageWidth * 0.5) - (this.width * 0.5) + this.xoffset;
				this.target.y = (stageHeight * 0.5) - (this.height * 0.5) + this.yoffset;
			}
		}
		
	}
}