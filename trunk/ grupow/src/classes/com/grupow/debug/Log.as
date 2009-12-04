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
			//traceLogger.addLogger(logger);		
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
		static public function registerTraceTarget():void
		{
			var traceLogger:WTraceTarget = new WTraceTarget();
			traceLogger.fieldSeparator = Log.FIELD_SEPARATOR;
			traceLogger.includeCategory = Log.INCLUDE_CATEGORY;
			traceLogger.includeLevel = Log.INCLUDE_LEVEL;
			traceLogger.includeTime = Log.INCLUDE_TIME;
			traceLogger.addLogger(logger);			
		}
			
		static public function log(level:int, message:String, ...rest):void
		{
			var _params:Array = [level,message];
			_params = _params.concat(rest);
			
			if(verbose)
				logger.log.apply(null, _params);
				
		}
		
		static public function debug(message:String, ...rest):void
		{
			var _params:Array = [message];
			_params = _params.concat(rest);
			
			if(verbose)
				logger.debug.apply(null, _params);
		}
		
		static public function error(message:String, ...rest):void
		{
			var _params:Array = [message];
			_params = _params.concat(rest);
			
			if(verbose)
				logger.error.apply(null, _params);
		}
		
		static public function fatal(message:String, ...rest):void
		{
			var _params:Array = [message];
			_params = _params.concat(rest);
			
			if(verbose)
				logger.fatal.apply(null, _params);
		}
		
		static public function info(message:String, ...rest):void
		{
			var _params:Array = [message];
			_params = _params.concat(rest);
			
			if(verbose)
				logger.info.apply(null, _params);
		}
		
		static public function warn(message:String, ...rest):void
		{
			var _params:Array = [message];
			_params = _params.concat(rest);
			
			if(verbose)
				logger.warn.apply(null, _params);
		}
		
		
	}
	
}