
/**
 * 
 * Grupow WSimpleButton 
 * Copybottom (c) 2009 ruranga@grupow.com
 * 
 * this file is part of com.grupow.controls package
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.controls
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	/**
	* ...
	* @author Raúl Uranga
	*/
	
	public class WButton extends WAbstractControl
	{
		private var _label:String;
		
		public function WButton()
		{
			super();
			
			_label = "label";
			
			this.label_mc.output_txt.autoSize = TextFieldAutoSize.LEFT;
			this.label_mc.output_txt.wordWrap = false;
			
			this.hit_mc.visible = false;
			this.hit_mc.mouseEnabled = false;
			
			this.hitArea = this.hit_mc;
		}
		
		public function get label():String { return _label; }
		
		public function set label(value:String):void 
		{
			_label = value;
			
			this.label_mc.output_txt.text = _label;
			this.hit_mc.width = this.label_mc.output_txt.x + this.label_mc.output_txt.width;
			this.hit_mc.height = this.label_mc.output_txt.height;
		}
		
		protected override function init():void
		{	
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.CLICK, click_handler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OVER, rollOver_handler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOut_handler, false, 0, true);
		}
		
		protected override function destroy():void 
		{
			this.removeEventListener(MouseEvent.CLICK, click_handler, false);
			this.removeEventListener(MouseEvent.ROLL_OVER, rollOver_handler, false);
			this.removeEventListener(MouseEvent.ROLL_OUT, rollOut_handler, false);
		}
				
		protected function click_handler(e:MouseEvent):void
		{
			
		}
		
		protected function rollOver_handler(e:MouseEvent):void
		{
			this.gotoAndPlay("over");
		}

		protected function rollOut_handler(e:MouseEvent):void
		{
			this.gotoAndPlay("out");
		}
	}
	
}