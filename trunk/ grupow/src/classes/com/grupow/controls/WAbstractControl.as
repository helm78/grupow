package com.grupow.controls 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class WAbstractControl extends MovieClip
	{
		public var data:Object;
		
		public function WAbstractControl() 
		{
			super();
			data = new Object();
			this.addEventListener(Event.ADDED_TO_STAGE, added_handler, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removed_handler, false, 0, true);
		}
		
		protected function added_handler(e:Event):void 
		{
			init();
		}	
		
		protected function removed_handler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, added_handler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removed_handler);
			
			this.destroy();
		}
		
		protected function init():void
		{
			
		}
		
		protected function destroy():void
		{
			
		}
	}
	
}