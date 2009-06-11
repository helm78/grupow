package com.grupow.debug.targets
{
	
	import com.grupow.debug.WLogEvent;
	import com.grupow.debug.WLogEventLevel;
	import flash.external.ExternalInterface;
	
	/**
	 * This class serves as a custom target for Firebug's console.
	 * It works with the logging framework in Flex.
	 * 
	 * @author Danny Patterson
	 * @version 0.1.0 2008-04-08
	 */
	
	public class WFirebugTarget extends WLineFormattedTarget {
		
		public function WFirebugTarget() {
			super();
		}
	    
		
	    /**
	     * This is called by the logger and is where we delegate the message to
	     * the corresponding Firebug function based on the log level.
	     * 
	     * @see mx.logging.targets.LineFormattedTarget#logEvent
	     */ 
	    override public function logEvent(event:WLogEvent):void {
	    	super.logEvent(event);
	    	if(ExternalInterface.available) {
	    		switch(event.level) {
	    			case WLogEventLevel.DEBUG:
	    				ExternalInterface.call("console.debug", event.message);
	    				break;
	    			case WLogEventLevel.ERROR:
	    			case WLogEventLevel.FATAL:
	    				ExternalInterface.call("console.error", event.message);
	    				break;
	    			case WLogEventLevel.INFO:
	    				ExternalInterface.call("console.info", event.message);
	    				break;
	    			case WLogEventLevel.WARN:
	    				ExternalInterface.call("console.warn", event.message);
	    				break;
	    			default:
	    				ExternalInterface.call("console.log", event.message);
	    		}
			}
	    }
		
	}
}