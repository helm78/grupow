
/**
* 
* Grupow SimpleTimer
* Copyright (c) 2009 ruranga@grupow.com
* 
* Released under MIT license:
* http://www.opensource.org/licenses/mit-license.php
* Timer Class usage example:
* 	
* <code>
* // format function to convert milliseconds 
* // to suitable display in display_txt
* function formatTime(milliseconds){
* 		// derive values (centiseconds = 100th of a second)
* 		//var milliseconds = Math.floor(milliseconds);
* 		var centiseconds = Math.floor(milliseconds/10);
* 		var seconds = Math.floor(centiseconds/100);
* 		var minutes = Math.floor(seconds/60);
* 		// make sure values dont go beyond their
* 		// respective ranges
*		centiseconds %= 100;
*		seconds %= 60;
*		minutes %= 60;
*	
*		// padd with 0's if values less than 2 digits (less than 10)
*		if (centiseconds < 10) centiseconds = "0" + centiseconds;
*		if (seconds < 10) seconds = "0" + seconds;
*		if (minutes < 10) minutes = "0" + minutes;
*	
*		// return values separated by :
*		return minutes +":"+ seconds +":"+ centiseconds;
*	}
* 	var timer = new Timer();
* 	timer.start();
*	function onEnterFrame  ()
*	{
*		display_txt.text = formatTime(time);
*	}
* </code>
* @author Raul Uranga
* @version 0.1
*/

package com.grupow.utils {
	
	import flash.utils.getTimer;
	
	public class SimpleTimer
	{
		private var _pauseTime:Number;
		private var _startTime:Number;
				
		public function SimpleTimer(start:Boolean = false)
		{
			_pauseTime = 0;
			_startTime = 0;
			this.reset(start);
		}
			
		public function start():void
		{
			if (this._pauseTime){
				this._startTime += getTimer() - this._pauseTime;
				this._pauseTime = 0;
			}else{
				this.reset(true);
			}
		}
		
		public function stop():void
		{
			if (!this._pauseTime) this._pauseTime = getTimer();
		}
		
		/**
		* reset the timer
		* @param	restart bool to see if you want to start again Timer
		*/
		public function reset(restart:Boolean = false):void
		{
			
			this._startTime = getTimer();
			
			if (!this._startTime) 
				this._startTime = 1;
				
			if (restart) 
				this._pauseTime = 0;
			else 
				this._pauseTime = this._startTime;
			
		}
		/**
		* gets the elapsed time in milisecons
		*/
		public function get time():Number
		{
			if (this._pauseTime) 
				return this._pauseTime - this._startTime;
			
			var gotTime = getTimer();
			
			if (!gotTime)
				gotTime = 1;
				
			return gotTime - this._startTime;
		}
		/**
		* sets the elapsed time in milisecons
		*/
		public function set time(t:Number):void
		{
			this._startTime = getTimer() - t;
		}
		
		public function get paused():Boolean
		{
			return (this._pauseTime) ? true : false;
		}
		
		public function set paused(p:Boolean):void
		{
			//if (p == Boolean(this._pauseTime)) return false;
			if (p && !Boolean(this._pauseTime)) 
				this.stop();
			else 
				this.start();
		}

	}

}
