
/**
 * 
 * Grupow MailToCommand
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
	public class MailToCommand implements ICommand
	{
		private var _email:String;
		private var _subject:String;
		private var _body:String;
		
		public function MailToCommand(email:String = "", subject:String = "",body:String="")
		{
			this._email = email;
			this._subject = subject;
			this._body = body;
		}
		
		/* INTERFACE com.rexona.peterpan.commands.ICommand */
		
		public function execute():void
		{
			navigateToURL(new URLRequest("mailto:" + _email + "?subject=" + _subject + "&body=" + _body), "_self");
		}
		
	}
	
}