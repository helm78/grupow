﻿
/**
 * 
 * Grupow NullCommand
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

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