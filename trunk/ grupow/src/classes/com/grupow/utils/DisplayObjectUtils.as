
/**
 * 
 * Grupow DisplayObjectUtils
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class DisplayObjectUtils 
	{
		
		private static var DEEP:int = 0;
		
		public function DisplayObjectUtils() 
		{
			
		}
		
		public static function stopAllChildrens(target:DisplayObjectContainer,recursive:Boolean = true):void 
		{
				
			for (var i = 0; i < target.numChildren ; i++) { 
				
				if (target.getChildAt(i) is MovieClip) {
					
					var child:MovieClip = MovieClip(target.getChildAt(i))
					child.stop();
					
					if (recursive) {
						
						DisplayObjectUtils.DEEP++;
						
						/*/
						if (DisplayObjectUtils.DEEP >= 200) {
							EnterFrameCallBack.call(stopAllChildrens,child,true);
						}
						//*/
												
						stopAllChildrens(child);
						
						DisplayObjectUtils.DEEP--;
						
					}
				}
			}
		}
		
		public static function playAllChildrens(target:DisplayObjectContainer,recursive:Boolean = true):void 
		{
				
			for (var i = 0; i < target.numChildren ; i++) { 
				
				if (target.getChildAt(i) is MovieClip) {
					
					var child:MovieClip = MovieClip(target.getChildAt(i))
					child.play();
					
					if (recursive) {
						
						DisplayObjectUtils.DEEP++;
						
						/*/
						if (DisplayObjectUtils.DEEP >= 200) {
							EnterFrameCallBack.call(stopAllChildrens,child,true);
						}
						//*/
												
						playAllChildrens(child);
						
						DisplayObjectUtils.DEEP--;
						
					}
				}
			}
		}
	}
}