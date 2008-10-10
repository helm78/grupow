package 
{
	import com.grupow.display.BasicButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	
	public dynamic class CategoryButton extends BasicButton
	{
		private var _isActive:Boolean;
		
		public function CategoryButton() 
		{
			super();
		}
		
		protected override function initialize():void
		{
			super.initialize();
			_isActive = false;
			this.addEventListener(MouseEvent.CLICK, click_handler, false, 0, true);
		}
		
		private function click_handler(e:MouseEvent):void
		{
			if (!_isActive) {
				active();
			} else {
				deactive();
			}			
		}
		
		
		public function active():void
		{
			_isActive = true;
			this.gotoAndStop("s2");
		}

		public function deactive()
		{
			_isActive = false;
			this.gotoAndStop("s1");
		}


		protected override function rollOver_handler(e:MouseEvent):void
		{
			
			trace("::_isActive::",_isActive);
			
			if (!_isActive) {
				gotoAndPlay("over1");
			} else {
				gotoAndPlay("over2");
			}
		}

		protected override function rollOut_handler(e:MouseEvent):void
		{
			if (!_isActive) {
				gotoAndPlay("out1");
			} else {
				gotoAndPlay("out2");
			}
		}
		
		protected override function removeAllListeners():void
		{
			super.removeAllListeners();
			this.removeEventListener(MouseEvent.CLICK, click_handler, false);
		}
		
		public function get isActive():Boolean { return _isActive; }
		
	}
	
}