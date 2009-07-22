
/**
 * 
 * Grupow TimeUtils
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.utils 
{
	
	/**
	 *  @author Raúl Uranga
	 */
	
	public class TimeUtils 
	{
		
		public function TimeUtils() {
		
		}
		
		//format:String = "hh:mm:ss:cc"
		public static function  formatTime(milliseconds:Number):String
		{
			// derive values (centiseconds = 100th of a second)
			//var milliseconds = Math.floor(milliseconds);
			var centiseconds = Math.floor(milliseconds/10);
			var seconds = Math.floor(centiseconds/100);
			var minutes = Math.floor(seconds / 60);
			//TODO added hours counter 
			var hours =  Math.floor(seconds/3600000);
			// make sure values dont go beyond their
			// respective ranges
			centiseconds %= 100;
			seconds %= 60;
			minutes %= 60;
			hours %= 24;
		
			// padd with 0's if values less than 2 digits (less than 10)
			if (centiseconds < 10) centiseconds = "0" + centiseconds;
			if (seconds < 10) seconds = "0" + seconds;
			if (minutes < 10) minutes = "0" + minutes;
			if (minutes < 10) hours = "0" + hours;
		
			// return values separated by :
			
			//var output:String = seconds +":" + centiseconds;
			//var output:String = minutes +":" + seconds;
					
			//if(format.split(":").length > 2)
			// +":" + centiseconds;
			
			//TODO Added hours + centiseconds to the output 
			var output:String = hours + ":" + minutes +":" + seconds + ":" + centiseconds;
			
			return output;
		}
	}
}