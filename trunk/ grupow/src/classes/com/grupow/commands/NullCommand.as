package com.grupow.commands 
{
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class NullCommand implements ICommand 
	{
		
		public function NullCommand() 
		{
			
		}
		
		/* INTERFACE com.grupow.commands.ICommand */
		
		public function execute():void
		{
			//null
		}
		
	}
	
}