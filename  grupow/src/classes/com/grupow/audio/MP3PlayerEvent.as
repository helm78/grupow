package com.grupow.audio
{
	import flash.events.Event;
		
	/**
	 * ...
	 * @author David Gámez
 	 *
 	 *
 	 *
 	 *
 	 * 
	 */
	public class MP3PlayerEvent extends Event
	{
		
		public static const EVENT_TIME_CHANGE:String = 'Mp3Player.TimeChange';
		public static const EVENT_VOLUME_CHANGE:String = 'Mp3Player.VolumeChange';
		public static const EVENT_PAN_CHANGE:String = 'Mp3Player.PanningChange';
		public static const EVENT_PAUSE:String = 'Mp3Player.Pause';
		public static const EVENT_UNPAUSE:String = 'Mp3Player.Unpause';
		public static const EVENT_PLAY:String = 'Mp3Player.Play';
		
		public static const PLAYHEAD_UPDATE:String = "Mp3Player.playheadeUpdate";
		public static const READY:String = "Mp3Player.ready";
		public static const BUFFERING:String = "Mp3Player.buffering";
		public static const SOUND_COMPLETE :String = Event.SOUND_COMPLETE;
		public static const AUTO_REWOUND:String = "Mp3Player.autoRewound";
		public static const STOPPED:String = "Mp3Player.stoopped";
		public static const PAUSED:String = "Mp3Player.paused";
		public static const START_PLAYING:String = "Mp3Player.startplaying";
		
		public static const LOAD_COMPLETE :String = "loadComplete";
		
		public static const COMPLETE:String = "complete";
		
		//public var time:Number;
		
		public function MP3PlayerEvent(type:String)
		{	
			super(type,false,false);
		}
		
		public override function clone():Event {
            return new MP3PlayerEvent(type);
        }
		
	}
	
}