package  {
	
	import com.grupow.display.LayoutItem;
	import com.grupow.display.LayoutManager;
	import flash.display.MovieClip;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	
	public class Main extends MovieClip
	{
		public function Main() {

			
			var manager:LayoutManager = LayoutManager.getInstance();
			manager.initialize(this.stage, 550, 400);
			
			var layoutItem:LayoutItem;
			
			layoutItem = new LayoutItem(s1, LayoutItem.TOP | LayoutItem.LEFT);
			layoutItem.xoffset = 10;
			layoutItem.yoffset = 10;
			manager.registerItem(layoutItem);
			
			layoutItem = new LayoutItem(s2, LayoutItem.TOP | LayoutItem.RIGHT);
			layoutItem.xoffset = -10;
			layoutItem.yoffset = 10;
			manager.registerItem(layoutItem);
			
			layoutItem = new LayoutItem(s3, LayoutItem.CENTER);
			manager.registerItem(layoutItem);
			
			layoutItem = new LayoutItem(s4, LayoutItem.BUTTOM | LayoutItem.LEFT);
			layoutItem.xoffset = 10;
			layoutItem.yoffset = -10;
			manager.registerItem(layoutItem);
			
			layoutItem = new LayoutItem(s5, LayoutItem.BUTTOM | LayoutItem.RIGHT);
			layoutItem.xoffset = -10;
			layoutItem.yoffset = -10;
			manager.registerItem(layoutItem);
			
			
			layoutItem = new LayoutItem(s7, LayoutItem.TOP | LayoutItem.HORIZONTAL_CENTER);
			layoutItem.yoffset = 10;
			manager.registerItem(layoutItem);
			
			
			layoutItem = new LayoutItem(s6, LayoutItem.BUTTOM | LayoutItem.HORIZONTAL_CENTER);
			layoutItem.yoffset = -10;
			manager.registerItem(layoutItem);
			
			layoutItem = new LayoutItem(s8, LayoutItem.LEFT | LayoutItem.PERCENT_VERTICAL_CENTER);
			layoutItem.xoffset = 10;
			layoutItem.percentVerticalCenter = 0.5;
			manager.registerItem(layoutItem);
			
			
			layoutItem = new LayoutItem(s9, LayoutItem.RIGHT | LayoutItem.PERCENT_VERTICAL_CENTER);
			layoutItem.xoffset = -10;
			layoutItem.percentVerticalCenter = 0.5;
	 	 	manager.registerItem(layoutItem);
						
			manager.update();
		}
	}
	
}