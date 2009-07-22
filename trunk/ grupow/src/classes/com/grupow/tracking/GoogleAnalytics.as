package com.grupow.tracking {
	
	/**
	* @author Raúl Uranga
	* @version 0.1
	*/
	
	import flash.external.ExternalInterface;
	
	public class GoogleAnalytics implements iTrackable {
		
		public function GoogleAnalytics() {
			
		}
		
		public function track(action:String):void
		{
			if (ExternalInterface.available) {
				
				//Old Google Analytics Code
				//ExternalInterface.call("urchinTracker",action);
				
				//New Google Analytics Code
				ExternalInterface.call("pageTracker._trackPageview",action);
				
				trace("Google Analytics Tracking: " + action);
				
			}else {
				
				trace("External interface is not available for this container.");
				
			}
		}
		
	}
	
}