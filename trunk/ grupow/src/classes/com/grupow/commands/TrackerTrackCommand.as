package com.grupow.commands 
{
	import com.grupow.tracking.iTrackable;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class TrackerTrackCommand implements ICommand
	{
		private var tracker:iTrackable;
		private var action:String;
		
		public function TrackerTrackCommand(tracker:iTrackable,action:String) 
		{
			this.tracker = tracker;
			this.action = action;
		}
		
		/* INTERFACE com.grupow.commands.ICommand */
		
		public function execute():void
		{
			this.tracker.track(this.action);
		}
		
	}
}