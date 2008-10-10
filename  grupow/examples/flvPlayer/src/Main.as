package  {
	
	import com.grupow.video.FLVPlayer;
	import com.grupow.video.FLVPlayerControls;
	import com.grupow.video.FLVPlayerErrorEvent;
	import com.grupow.video.FLVPlayerEvent;
	import com.grupow.video.FLVPlayerProgressEvent;
	import com.grupow.video.FLVPlayerMetadataEvent;
		
	import flash.display.MovieClip;
	import flash.display.SimpleButton
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class Main extends MovieClip
	{
	
				
		public function Main() {
		
			player_mc.videoWidth = 400;
			player_mc.videoHeight = 300;
			
			player_mc.debugMode = true;
			
			player_mc.autoRewind = true;
			
			player_mc.loop = true;
			
			player_mc.bufferTime = 3;
			player_mc.volume = 1;
														
			controls.flvPlayer =  player_mc;
						
			
			player_mc.addEventListener(FLVPlayerEvent.PLAYHEAD_UPDATE, playHeadUpdated_handler, false, 0, true);
			player_mc.addEventListener(FLVPlayerEvent.BUFFERING, buffering_handler, false, 0, true);
			player_mc.addEventListener(FLVPlayerMetadataEvent.CUE_POINT, cuepoint_handler, false, 0, true);
			
			//normal
			player_mc.play("assets/video/sample.flv");
			
			//cuePoints
			//player_mc.play("assets/video/betina.flv");
			
								
			video1_btn.addEventListener(MouseEvent.CLICK, changeVideo_handler, false, 0 , true);
			video2_btn.addEventListener(MouseEvent.CLICK, changeVideo_handler, false, 0 , true);
			video3_btn.addEventListener(MouseEvent.CLICK, changeVideo_handler, false, 0 , true);
										
		}
		
		private function cuepoint_handler(e:FLVPlayerMetadataEvent):void 
		{
			trace("__cuepoint_handler__");
			
			for (var name:String in e.info) {
				trace(name + ":" + e.info[name]);
			}

		}
		
		private function buffering_handler(e:FLVPlayerEvent):void 
		{
			buffer_mc.gotoAndStop(2);
		}
		
		private function playHeadUpdated_handler(e:FLVPlayerEvent):void 
		{			
			buffer_mc.gotoAndStop(1);
		}
		
		private function flvPlayerErrorEvent_handler(e:Event):void
		{
			trace("flvPlayerErrorEvent_handler: " + e.type);
		}
		
		private function changeVideo_handler(e:MouseEvent):void 
		{
			switch (e.target) 
			{
				case video1_btn:
					
					player_mc.play("assets/video/betina.flv");
					trace("bufferTime: ", player_mc.bufferTime);
					
					break;
					
				case video2_btn:
				
					player_mc.play("assets/video/sample.flv");
					trace("bufferTime: ", player_mc.bufferTime);
					
					break;
					
				case video3_btn:
				
					player_mc.dispose();
					
					break;
					
					
			}
		}
		
	}
	
}