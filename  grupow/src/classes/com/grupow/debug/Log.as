package com.grupow.debug 
{
	import com.grupow.debug.targets.WSOSTarget;
	import com.grupow.debug.targets.WTraceTarget;
	
	/**
	 * ...
	 * @author Raúl Uranga
	 */
	public class Log 
	{
		private static var _instance:Log;
		private static var _allowInstantiation:Boolean;
		
		private static const logger:WILogger = WLog.getLogger("default");
		
		public static var FIELD_SEPARATOR = " ";
		public static var INCLUDE_CATEGORY = false;
		public static var INCLUDE_TIME = false;
		public static var INCLUDE_LEVEL = true;

		
		private static var initialize:Log = Log.getInstance();
		
		public static var verbose:Boolean = true;
		
		public function Log () {
			
			if (!_allowInstantiation) {
				throw new Error("Instantiation failed: Use Log.getInstance() instead of new.");
				return;
			}
			
			var traceLogger:WTraceTarget = new WTraceTarget();
			traceLogger.addLogger(logger);		
		}
		
		public static function getInstance():Log
		{
			if (_instance == null) {
				_allowInstantiation = true;
				_instance = new Log();
				_allowInstantiation = false;
			}
			
			return _instance;
		}
		
		static public function registerSOSTarget():void
		{
			var sosLogger:WSOSTarget = new WSOSTarget();
			sosLogger.fieldSeparator = Log.FIELD_SEPARATOR;
			sosLogger.includeCategory = Log.INCLUDE_CATEGORY;
			sosLogger.includeLevel = Log.INCLUDE_LEVEL;
			sosLogger.includeTime = Log.INCLUDE_TIME;
			sosLogger.addLogger(logger);			
		}
			
		static public function log(level:int, message:String, ...rest):void
		{
			if(verbose)
				logger.log(level, message, rest);
		}
		
		static public function debug(message:String, ...rest):void
		{
			if(verbose)
				logger.debug(message, rest);
		}
		
		static public function error(message:String, ...rest):void
		{
			if(verbose)
				logger.error(message, rest);
		}
		
		static public function fatal(message:String, ...rest):void
		{
			if(verbose)
				logger.fatal(message, rest);
		}
		
		static public function info(message:String, ...rest):void
		{
			if(verbose)
				logger.info(message, rest);
		}
		
		static public function warn(message:String, ...rest):void
		{
			if(verbose)
				logger.warn(message, rest);
		}
		
		
	}
	
}