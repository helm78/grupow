package com.grupow.utils 
{
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class CallBack 
	{
		
		private var callbackObjVal:Object;
		private var callbackMethodVal:Function;
		
		public function CallBack(objParam:Object, methodParam:Function)
		{
			this.callbackObjVal = objParam;
			this.callbackMethodVal = methodParam;
		}
		
		public function fire(... rest):*
		{
			return callbackMethodVal.apply(callbackObjVal, rest);
			//return this.callbackObjVal[this.callbackMethodVal](parameter);
		}
		
	}
	
}