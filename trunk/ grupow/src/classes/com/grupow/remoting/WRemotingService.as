
/**
 * 
 * Grupow WRemotingService
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.remoting
{
	import com.dannypatterson.remoting.ServiceProxy;
	import com.dannypatterson.remoting.FaultEvent;
	import com.dannypatterson.remoting.ResultEvent;
	import com.dannypatterson.remoting.ServiceProxy;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class WRemotingService extends ServiceProxy implements IDisposable
	{
		
		public function wRemotingService(gateway:String, service:String, useOperationPooling:Boolean = true)
		{
			super(gateway, service, useOperationPooling);
			trace("Warning: this is a deprecated version please use RemotingService instead of this.");
		}
			
		public function dispose():void
		{
			connection.close();
			connection.removeEventListener(NetStatusEvent.NET_STATUS, onConnectionStatus);
			connection.removeEventListener(IOErrorEvent.IO_ERROR, onConnectionError);
			connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR , onConnectionError);	
		}
		
		private function getEventName(name:String):String
		{
			return "on"+name.substr(0, 1).toUpperCase()+name.substr(1, name.length);
		}
		
		protected override function onFault(event:FaultEvent):void 
		{
			super.onFault(event);
			dispatchEvent(new FaultEvent(getEventName(event.methodName)+"Fault", event.bubbles, event.cancelable, event.fault,event.methodName));
		}
		
		protected override function onResult(event:ResultEvent):void
		{
			super.onResult(event);
			dispatchEvent(new ResultEvent(getEventName(event.methodName)+"Result", event.bubbles, event.cancelable, event.result, event.methodName));
		}
		
		protected override function onTimeout(event:FaultEvent):void
		{
			super.onTimeout(event);
			dispatchEvent(new FaultEvent(getEventName(event.methodName)+"Timedout", event.bubbles, event.cancelable, event.fault,event.methodName));
		}
	}
	
}