package com.grupow.display
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	
	public dynamic class BasicButton extends MovieClip
	{
		public function BasicButton() 
		{
			try{
				this.hitArea = this.hitarea_mc;
				hitarea_mc.visible = false;
			}catch (e:*) { }
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage_handler, false, 0,true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedToStage_handler, false, 0, true);
		}
		
		private function removedToStage_handler(e:Event):void 
		{
			removeAllListeners();
		}
		
		private function addedToStage_handler(e:Event):void 
		{
			initialize();
		}
		
		protected function initialize():void
		{
			
			trace("BasicButton.initialize")
			
			this.buttonMode = true;
			this.mouseChildren = false;
			//this.addEventListener(MouseEvent.CLICK, click_handler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OVER, rollOver_handler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOut_handler, false, 0, true);
		}
		/*/
		private function click_handler(e:MouseEvent):void
		{
			trace(e.currentTarget);
		}
		//*/
		protected function rollOver_handler(e:MouseEvent):void
		{
			gotoAndPlay("over");
		}

		protected function rollOut_handler(e:MouseEvent):void
		{
			gotoAndPlay("out");
		}

		protected function removeAllListeners():void
		{
			//this.removeEventListener(MouseEvent.CLICK, click_handler, false);
			this.removeEventListener(MouseEvent.ROLL_OVER, rollOver_handler, false);
			this.removeEventListener(MouseEvent.ROLL_OUT, rollOut_handler, false);
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedToStage_handler);
		}
	}
	
}