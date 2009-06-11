package com.grupow.debug.targets
{
	import com.grupow.debug.targets.utils.thunderbolt.Logger;
	import com.grupow.debug.WAbstractTarget;
	import com.grupow.debug.WILogger;
	import com.grupow.debug.WLogEvent;
	import com.grupow.debug.WLogEventLevel;
	
	/**
	 * ...
	 * @author David Gamez
	 */
	public class WThunderBoltTarget extends WAbstractTarget
	{
		public var includeLevel: Boolean = true;
		public var includeCategory: Boolean = false;
		
		public function WThunderBoltTarget()
		{
			super();	
		}
		
		override public function logEvent(event:WLogEvent ):void
	    {			    	
	    	//
	    	// log level
	        var level: String;
	        if (includeLevel) 
	        	level = getLogLevel( event.level );	
			//
			// log category
	    	var message: String = "";
			if ( includeCategory ) 
				message += WILogger( event.target ).category + Logger.FIELD_SEPERATOR;
			//
			// log message
			if ( event.message.length ) 
				message += event.message;
			else 
				message += "";
	    	//
	    	// calls ThunderBolt	
	    	Logger.log ( level, message );
		}
		
		private static function getLogLevel (logLevel: int): String
		{
			var level: String;
			
			switch (logLevel) 
			{
				case WLogEventLevel.INFO:
					level = Logger.INFO;
					break;
				case WLogEventLevel.WARN:
					level = Logger.WARN;
					break;				
				case WLogEventLevel.ERROR:
					level = Logger.ERROR;
					break;
				// Firebug doesn't support a fatal level
				case WLogEventLevel.FATAL:
					level = Logger.ERROR;
					break;
				default:
					// LogLevel.DEBUG && LogLevel.ALL
					level = Logger.LOG;
			}

			return level;
		}
		
		public function set hide( value: Boolean ):void
		{
			Logger.hide = value;
		}
		
		public function set includeTime( value: Boolean ):void
		{
			Logger.includeTime = value;
		}   
			
		public function set console( value: Boolean ):void
		{
			Logger.console = value;
		}   
		
		public function set showCaller( value: Boolean ):void
		{
			Logger.showCaller = value;
		}   
		
		override public function set filters( value: Array ):void
    	{
    		super.filters = value;
    		
    		//
    		// includeCategory if we have filters
    		this.includeCategory = ( filters != null && filters.length > 0 );
    		
    	}
		/*/
		override public function internalLog(message:String):void
		{
			trace("WArthropodTarget: ", message);
		}
		//*/

	}
	
}