package com.grupow.loading 
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	
	/**
	* ...
	* @author Raúl Uranga
	*/
	public class BulkLoaderListener extends EventDispatcher
	{
		
		public static const PROGRESS:String = "progress";
		public static const COMPLETE:String = "complete";
		
		private var _qloader:BulkLoader;
		private var _items:Array;
		private var _started:Boolean;
		private var _initializated:Boolean;
				
		public function BulkLoaderListener(loader:BulkLoader) 
		{
			this._qloader = loader;
			_items = new Array();
			_initializated = false;
		}
		
		private function progress_handler(e:ProgressEvent):void 
		{
			//bubbles
			this.dispatchEvent(new Event(QueueListener.PROGRESS));
		}
		
		private function complete_handler(e:Event):void 
		{
			//bubbles
			for each (var item:LoadingItem in _items) {
				if (!item.isLoaded) {
					return;
				}
            }
			//TODO deberia de dispararse una sola vez, y lo hace varias veces
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
		public function getProgress():Number
		{
			//trace(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::getProgress")
			
			var _totalpercent:Number = 0;
			
			for each (var item:LoadingItem in _items) {
				_totalpercent += item.percentLoaded;
				//trace("item.percentLoaded: ", item.percentLoaded);
            }			
			
			return (_totalpercent / _items.length);
		}
		
		public function getWeightPercent():Number
		{
			//trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>getProgress")
			
			var weightPercentLoaded:Number = 0;
			var totalWeigh:Number = 0;
			
			for each (var item:LoadingItem in _items) {
				totalWeigh += item.weight;
				weightPercentLoaded += item._weightPercentLoaded;
				
				//trace("item.weight: ", item.weight);
				//trace("item._weightPercentLoaded: ", item._weightPercentLoaded);
            }	
			
			return (weightPercentLoaded / totalWeigh);
		}
			
		public function registerItem(key:String):void 
		{
			var item:LoadingItem = _qloader.get(key);
			item.addEventListener(ProgressEvent.PROGRESS, progress_handler, false, 0, true);
			item.addEventListener(Event.COMPLETE, complete_handler, false, 0, true);	
			_items.push(item);
		}
		
		public function isLoaded():Boolean 
		{
			for each (var item:LoadingItem in _items) {
				if (!item.isLoaded)	
					return false;
            }
			
			return true;
		}
			
		public function dispose():void
		{
			for each (var item:LoadingItem in _items) {
				item.removeEventListener(ProgressEvent.PROGRESS, progress_handler);
				item.removeEventListener(Event.COMPLETE, complete_handler);
			}
			//remove reference!
			_qloader = null;
			_items = null;
		}
		
	}
	
}