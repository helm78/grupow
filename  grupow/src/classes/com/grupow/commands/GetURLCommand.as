﻿
/**
 * 
 * Grupow GetURLCommand
 * Copyright (c) 2009 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.commands 
{
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class GetURLCommand implements ICommand
	{
		private var url:String;
		private var window:String;
		
		public function GetURLCommand(url:String, window:String = "_blank")
		{
			this.url = url;
			this.window = window;
		}
		
		/* INTERFACE com.rexona.peterpan.commands.ICommand */
		
		public function execute():void
		{
			navigateToURL(new URLRequest(url), window);
		}
		
	}
	
}