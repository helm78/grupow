package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import mx.utils.ObjectDumper;
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
			var btn:BasicButton = new ConferencesButton();
			btn.x  = 200;
			btn.y  = 200;
			btn.label = "Hello BasicButton";
			btn.index = 1;
			btn.addEventListener(MouseEvent.CLICK, function (e:MouseEvent){trace(e.target,e.target.label,e.target.index)}, false, 0, true);
			this.addChild(btn);
			
			//Extends BasicButton
			var abtn:CategoryButton = new AwardsButton();
			abtn.x  = 200;
			abtn.y  = 220;
			abtn.label = "Hello CategoryButton";
			abtn.index = 2;
			abtn.addEventListener(MouseEvent.CLICK, function (e:MouseEvent){trace(e.target,e.target.label,e.target.index)}, false, 0, true);
			this.addChild(abtn);
		}
	}
	
}