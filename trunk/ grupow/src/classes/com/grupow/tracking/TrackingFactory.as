package com.grupow.tracking {
	
	/**
	* @author Raúl Uranga
	* @version 0.1
	*/
	
	public class TrackingFactory {
		
		public static const GOOGLE_ANALYTICS:int = 1;
		//"GoogleAnalytics"
		
		public function TrackingFactory() {
			
		}
		
		public static function create(id:int):iTrackable
		{
			var temp:iTrackable;
			switch (id) {
				
				case GOOGLE_ANALYTICS:
										temp = new GoogleAnalytics();
										break;
			}
			
			return temp;
		}
		
	}
	
}