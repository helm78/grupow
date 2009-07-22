
/**
 * 
 * Grupow StringUtils
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.utils 
{
	
	/**
	 * ...
	 * @author Raúl Uranga
	 */
	public class StringUtils 
	{
		
		public function StringUtils() 
		{
			
		}
		
		public static function has (str:String,c:String):Boolean
		{
			return (str.indexOf(c) != -1);
		}
		
		public static function replaceChar(str:String, busca:String, pon:String):String 
		{
			return str.split(busca).join(pon);
		}
		
		public static function replaceChars(_str:String, keys:Array, chars:Array):String
		{
			var temp:String = _str;
			for (var i = 0; i<keys.length; i++) {
				temp = StringUtils.replaceChar(temp, keys[i], chars[i]);
			}
			return temp;
		}
		
		public static function isEmail (str:String):Boolean
		{

			if (str.length < 5) { return false; }

			var iChars = "*|,\":<>[]{}`';()&$#%";
			var eLength = str.length;

			for (var i = 0; i < eLength; i++) {
				if (iChars.indexOf(str.charAt(i)) != -1) {
					return false;
				}
			}

			var atIndex = str.lastIndexOf("@");

			if (atIndex < 1 || (atIndex == eLength - 1)) {
				return false;
			}
			
			var pIndex = str.lastIndexOf(".");

			if (pIndex < 4 || (pIndex == eLength - 1)) {
				return false;
			}
			
			if (atIndex > pIndex) {
				return false;
			}
			
			return true;
		};
		
		public static function dosDigit(n:Number):String 
		{
			return String((n < 10) ? "0" + n : n);
		}
		
		public static function insertAt(str:String, val:String, pos:Number):String
		{
			return str.substring(0, pos) + val + str.substr(pos);
		}
		
		public static function cropAt(str:String, val:String, pos:Number):String
		{
			return str.substring(0, pos) + val;
		}
		
		public static function repeat(str:String,many:Number):String
		{
			var s:String = ""; 
			var t:String = str.toString();
			
			while (--many>=0) {
				s += t;
			}
			return s;
		};
		
		public static function addZero(str:String,many:Number):String
		{
			var s:String = "0"
			return (repeat(s, many) + str.toString()).substring((repeat(s, many) + str.toString()).length - many);

		};
		
		
		
		private static var TAB = 9;
		private static var LINEFEED = 10;
		private static var CARRIAGE = 13;
		private static var SPACE = 32;
	
		private static function  lTrim (str:String):String 
		{
			var s = str.toString();
			var i = 0;
			while (s.charCodeAt(i) == SPACE || s.charCodeAt(i) == CARRIAGE || s.charCodeAt(i) == LINEFEED || s.charCodeAt(i) == TAB) {
				i++;
		}
			return s.substring(i, s.length);
		};
		
		private static function  rTrim (str:String):String
		{
			var s = str.toString();
			var i = s.length-1;
			while (s.charCodeAt(i) == SPACE || s.charCodeAt(i) == CARRIAGE || s.charCodeAt(i) == LINEFEED || s.charCodeAt(i) == TAB) {
				i--;
			}
			return s.substring(0, i+1);
		};
		
		public static function trim (str:String):String
		{
			var s:String = str.toString();
			return lTrim(rTrim(s));
		};
		
	}
}