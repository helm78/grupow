package com.grupow.commands 
{
	import flash.external.ExternalInterface;

	/**
	 * @author Raúl Uranga
	 */
	public class JSCommand implements ICommand 
	{
		private var _functionValue:String;
		private var _args:Array;
		
		public function JSCommand(func:String, ...rest)
		{
			_functionValue = func;
			
			_args = rest;
			
			_args.unshift(_functionValue);
		}

		public function execute():void
		{
			if (ExternalInterface.available) {
				ExternalInterface.call.apply(ExternalInterface,_args);
			}
		}
	}
}
