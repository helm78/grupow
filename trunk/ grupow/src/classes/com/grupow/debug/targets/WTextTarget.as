package com.grupow.debug.targets
{
	import com.grupow.debug.WLogEvent;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author David Gamez
	 */
	public class WTextTarget extends WLineFormattedTarget
	{
		private var _holder:Sprite
		private var output_txt:TextField;
		
		public function WTextTarget() 
		{
			super();
			holder = new Sprite();
		}
		
		override public function logEvent(event:WLogEvent):void 
		{
			super.logEvent(event);  
		}
		
		override public function internalLog(message:String):void
		{
			trace(message);
		}
	}
	
}