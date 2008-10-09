package com.grupow.video {
	
	import flash.events.Event;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class FLVPlayerEvent extends Event
	{
		public static const PLAYHEAD_UPDATE:String = "playheadeUpdate";
		public static const READY:String = "ready";
		public static const BUFFERING:String = "buffering";
		public static const COMPLETE:String = "complete";
		public static const AUTO_REWOUND:String = "autoRewound";
		public static const STOPPED:String = "stoopped";
		public static const PAUSED:String = "paused";
		public static const START_PLAYING:String = "startplaying";
		
		
		public var time:Number;
		
		/*/
		READY
		Dispatched when an FLV file is loaded and ready to display. It starts the first time you enter a 
		responsive state after you load a new FLV file with the play() or load() method. 
		It starts only once for each FLV file that is loaded. 
		
		PAUSED_STATE_ENTERED
		Dispatched when the player enters the paused state. This happens when you call the pause() method or
		click the corresponding control and it also happens in some cases when the FLV file is loaded and 
		the autoPlay property is false (the state may be stopped instead).
		
		PLAYING_STATE_ENTERED
		Dispatched when the playing state is entered. This may not occur immediately after the play() method is
		called or the corresponding control is clicked; often the buffering state is entered first,
		and then the playing state. 
		
		STOPPED_STATE_ENTERED
		Dispatched when entering the stopped state. This happens when you call the stop() method or click the stopButton control.
		It also happens, in some cases, if the autoPlay property is false (the state might become paused instead) when the FLV file is loaded.
		The FLVPlayback instance also dispatches this event when the playhead stops at the end of the FLV file because it has reached the end of the timeline.
		//*/
		
		public function FLVPlayerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,playheadTime:Number = 0) {
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event {
            return new FLVPlayerEvent(type, bubbles, cancelable);
        }
		
	}
	
}