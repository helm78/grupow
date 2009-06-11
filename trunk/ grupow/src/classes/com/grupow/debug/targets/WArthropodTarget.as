package com.grupow.debug.targets
{
	import com.grupow.debug.targets.utils.arthropod.Debug;
	import com.grupow.debug.WLogEvent;
	import com.grupow.debug.WLogEventLevel;
	
	/**
	 * ...
	 * @author David Gamez
	 */
	public class WArthropodTarget extends WLineFormattedTarget
	{
		public function WArthropodTarget()
		{
			super();	
		}
		
		public function password(value:String = null):void
		{
			Debug.password = value;
		}
		override public function logEvent(event:WLogEvent):void
		{
			super.logEvent(event);
			//*/
			switch(event.level) {
				
				case WLogEventLevel.DEBUG:
					Debug.log(event.message.toString());
			
					break;	
	    		case WLogEventLevel.INFO:
					Debug.log(event.message.toString(), Debug.GREEN);
					
					break;
	    		case WLogEventLevel.ERROR:
					Debug.log(event.message.toString(), Debug.BLUE);
					
					break;
	    		case WLogEventLevel.WARN:
					Debug.log(event.message.toString(), Debug.PINK);
					
					break;
	    		case WLogEventLevel.FATAL:
					Debug.log(event.message.toString(), Debug.RED);

	    			break;
			}
			//*/
		}
		override public function internalLog(message:String):void
		{
			//trace("WArthropodTarget: ", message);
		}
	}
	
}