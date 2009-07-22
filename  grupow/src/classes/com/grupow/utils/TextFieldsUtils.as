
/**
 * 
 * Grupow TextFieldsUtils
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.utils
{
	import flash.text.TextField;
	import flash.utils.setTimeout;
	public class TextFieldsUtils
	{
		function TextFieldsUtils () {
		}
		
		static public function setTabIndex  (from:Number, arreglo:Array):void
		{
			var largo = arreglo.length;
			from --;
			for (var n = 0; n < largo; n ++)
			{
				arreglo [n].tabIndex = ++ from
			}
		}
		
		static public function  clearAfterTimeOut  (txt:TextField, ms:Number):Number
		{
			var scope:TextField = txt;
			var  __int:Number = setTimeout( function () {
												scope.text = "";	
											}, ms);
			return __int;
		}
	}
}
