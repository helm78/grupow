﻿package com.grupow.commands 
{
	import com.grupow.display.IView;
	
	/**
	 * ...
	 * @author Raúl Uranga
	 */
	public class OpenViewCommand implemets ICommand
	{
		private var view:IView
		public function OpenViewCommand(view:IView) 
		{
			this.view = view;
		}
		
		/* INTERFACE com.grupow.commands.ICommand */
		
		public function execute():void
		{
			view.open();
		}
		
	}
	
}