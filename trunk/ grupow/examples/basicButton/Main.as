package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	import com.grupow.display.BasicButton;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	
	public class Main extends MovieClip
	{
		public function Main() {
			
			trace("Main Class");

			basicButtonTest();
		}
		
		private function basicButtonTest():void
		{
			btn01_mc.data.index = 1;
			btn01_mc.addEventListener(MouseEvent.CLICK, onClick_handler, false, 0, true);
		}
		
		private function onClick_handler(e:MouseEvent):void 
		{
			trace("index: ",BasicButton(e.target).data.index);
		}
	}
	
}