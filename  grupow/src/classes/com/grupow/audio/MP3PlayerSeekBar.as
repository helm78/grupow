﻿package com.grupow.audio
{
	import flash.display.MovieClip;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author David Gámez
 	 *
 	 *
 	 *
 	 *
 	 * 
	 */
	
	public class MP3PlayerSeekBar extends Sprite
	{
		private var bounds:Object;
		private var _currentX:Number;
		private var _lastX:Number;
		private var _isDragging:Boolean;
		private var offset:Number;
		private var oldx:Number;
		private var _max:Number;
		private var _min:Number;
		private var _xMax:Number;
		
		public function MP3PlayerSeekBar()
		{
		//*/
			bounds = { left:0, right:track.width };
			_currentX = slider_btn.x;
			_lastX = slider_btn.x;
			_isDragging = false;
			_min = 0;
			_max = 1;
			slider_btn.addEventListener(MouseEvent.MOUSE_DOWN, onDown_handler, false, 0, true);

			progressarBar.scaleX = 0;
			playheadTimeBar.scaleX = position / max;
		//*/
		}
		//*/
		private static function normalize(value:Number, minimum:Number, maximum:Number):Number 
		{
			return (value - minimum) / (maximum - minimum);
		}

		private static function interpolate(normValue:Number, minimum:Number, maximum:Number):Number 
		{
			return minimum + (maximum - minimum) * normValue;
		}

		private static function map(value:Number, min1:Number, max1:Number, min2:Number, max2:Number):Number 
		{
			return interpolate(normalize(value, min1, max1), min2, max2);
		}
		
		private function onDown_handler(e:MouseEvent):void
		{
			_isDragging = true;
			offset = slider_btn.mouseX;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove_handler);
			this.dispatchEvent(new SeekBarEvent(SeekBarEvent.BEGIN_SCRUB, false, false, position));
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp_handler,false,0, true);
		}

		private function onUp_handler(e:MouseEvent):void
		{
			_isDragging = false;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove_handler, false);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onUp_handler);
			this.dispatchEvent(new SeekBarEvent(SeekBarEvent.END_SCRUB, false, false, position));
			
		}

		private function onMove_handler(e:MouseEvent):void
		{
			oldx = slider_btn.x;
			slider_btn.x = mouseX - offset;
			
			if (slider_btn.x <= bounds.left)
				slider_btn.x = bounds.left;
			else if (slider_btn.x >= _xMax)
				slider_btn.x = _xMax;
			
			if (oldx != slider_btn.x) 
				this.dispatchEvent(new SeekBarEvent(SeekBarEvent.CHANGE,false,false,position));
				
				
			playheadTimeBar.scaleX = position / max;
			
			e.updateAfterEvent();
		}
		
		public function setEnabled(value:Boolean):void
		{
			slider_btn.visible = value;
		}
		
		public function dispose():void
		{
			slider_btn.removeEventListener(MouseEvent.MOUSE_DOWN, onDown_handler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onUp_handler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove_handler);
		}
		
		public function updateProgress(value:Number):void
		{			
			this.progressarBar.scaleX = value;
			
			
			_xMax = this.progressarBar.scaleX < 1 ? this.progressarBar.width - 5 : this.progressarBar.width;
			
			if (_xMax < 0) {
				_xMax = 0;
			}
		}
		
		public function get max():Number
		{ 
			return _max;
		}
		
		public function set max(value:Number):void 
		{
			_max = value;
		}
		
		public function get min():Number
		{ 
			return _min;
		}
		
		public function set min(value:Number):void 
		{
			_min = value;
		}
		
		public function set position(value:Number):void 
		{
			slider_btn.x =  map(value, min, max, bounds.left, bounds.right);
			playheadTimeBar.scaleX = position / max;
		}
		
		public function get position():Number 
		{ 
			return map(slider_btn.x, bounds.left, bounds.right, min, max);
		}
		//*/
		
	}
	
	
}