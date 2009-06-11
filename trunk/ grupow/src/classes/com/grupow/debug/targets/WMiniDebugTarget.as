package com.grupow.debug.targets
{
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	/**
	 * ...
	 * @author David Gamez
	 */
	public class WMiniDebugTarget extends WLineFormattedTarget
	{
		private var _lc:LocalConnection;
		private var _method:String;
		private var _connection:String;
		
		public function WMiniDebugTarget(connection:String = "_mdbtrace", method:String = "trace")
		{
			super();

			_lc = new LocalConnection();
			_lc.addEventListener(StatusEvent.STATUS, onStatus);
			_lc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_connection = connection;
			_method = method;
		}
		
	

		private function onStatus(e:StatusEvent):void
		{
			if (e.level == "error")
				trace("Warning: MiniDebugTarget send failed: " + e.code);
		}

		private function onSecurityError(e:SecurityErrorEvent):void
		{
			trace("Error: security error on MiniDebugTarget's local connction");
		}
	
		override public function internalLog(message:String):void
		{
			_lc.send(_connection, _method, message);
		}
		
	}
	
}