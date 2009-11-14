package  {
	
	
	import com.grupow.controls.WButton;
	import com.grupow.controls.WComboBox;
	import com.grupow.controls.WList;
	import com.grupow.controls.WScrollTrackEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
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
			
			var i:int = 0;
			for (i = 0; i < 90; i++) {
				var item:WButton = new WButton();
				item.label = "WButtonItem" + i;
				item.data.id = i;
				WList(list_mc).addItem(item);
			}
			
			//WList(list_mc).boundsRect = new Rectangle(-20, -20, 116 + 20, 16 * 5 + 20);
			WList(list_mc).borderColor = 0xff0000;
			WList(list_mc).rowCount = 14;
			//WList(list_mc).showBorder = false;
			//WList(list_mc).height = 16 * 5;
			WList(list_mc).width = 250;
			WList(list_mc).addEventListener(Event.CHANGE, onListChange);
			
			
			combo_mc.label = "Age";
			//combo_mc.rowCount = 3;
			var it:WButton;
			for (i = 0; i < 25; i++) {
				it = new ComboBoxItem();
				it.label = "Item" + i;
				it.data.id = i;
				combo_mc.addItem(it);
			}
			
			
			year_cb.label = "Age";
			year_cb.rowCount = 3;
			year_cb.listBackground = new CustomBackground();
			var st_year:uint = 2009;
			for (i = 0; i < 10; i++) {
				it = new CustomComboBoxItem();
				it.label = String(2009 - i);
				it.data.id = 2009 - i;
				year_cb.addItem(it);
			}
			
			

		}
		
		private function onListChange(e:Event):void 
		{
			trace("label: " + WList(e.target).selectedItem.label);
			trace("label: " + WList(e.target).selectedItem.data.id);
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