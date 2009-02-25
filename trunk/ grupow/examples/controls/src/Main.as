package  {
	
	
	import com.grupow.controls.WScrollTrackEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class Main extends MovieClip
	{
		//TODO to implement WComboBox,WList,WRadioButton,WCheckBox
		
		public function Main() {
			
			this.scrollPane_mc.content = contet_mc;
			
			button_mc.label = "LOREM IPSUM DOLOR SIT AMET";
			button_mc.data.id = 1;
			button_mc.addEventListener(MouseEvent.CLICK, click_handler, false, 0, true);
			
			slider_mc.min = -1;
			slider_mc.max = 1;
			slider_mc.position = 0;
			slider_mc.addEventListener(WScrollTrackEvent.CHANGE, change_handler, false, 0, true);
			
			output_txt.text = slider_mc.position.toFixed(2);
		}
		
		private function change_handler(e:WScrollTrackEvent):void 
		{
			output_txt.text = e.position.toFixed(2);
		}
		
		private function click_handler(e:MouseEvent):void 
		{
			trace(e.target.data.id);
		}
	}
	
}