
/**
 * 
 * Grupow ViewManager
 * Copyright (c) 2010 ruranga@grupow.com
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 **/

package com.grupow.display 
{
	import com.grupow.events.ViewEvent;

	import flash.utils.Dictionary;
	import flash.events.EventDispatcher;

	/**
	 * ...
	 * @author Raúl Uranga
	 */

	public class ViewManager extends EventDispatcher 
	{
		private var _viewsDic:Dictionary;
		private var _views:Array;
		//		private var _currentView:AbstractView;
		private var _currentViewObj:ViewData;

		public function ViewManager()
		{
			_viewsDic = new Dictionary(true);
			_views = new Array();
		}

		private function openNextView_handler(event:ViewEvent):void 
		{
			_currentViewObj.view.removeEventListener(ViewEvent.CLOSED, openNextView_handler);
			_currentViewObj.view.open();
		}

		public function addView(view:AbstractView,name:String):Boolean
		{
			for each (var data : ViewData in _views) {
				if (data.name == name) return false;
			}
			
			var viewObj:ViewData = new ViewData();
			viewObj.name = name;
			viewObj.view = view;
			
			this._viewsDic[name] = viewObj;
			this._views.push(viewObj);
			
			return true;
		}

		public function openView(name:String):AbstractView 
		{
			if (_viewsDic[name] == null) {
				//silently fail
				trace("Error: The string identifier [" + name + "] of the view to open is not added");
				return new AbstractView();
			}
			
			var viewObj:ViewData = _viewsDic[name] as ViewData;
			
			if(_currentViewObj != null) {
				
				_currentViewObj.view.close();
				_currentViewObj.view.addEventListener(ViewEvent.CLOSED, openNextView_handler);
				_currentViewObj = viewObj;
			} else {
				
				_currentViewObj = viewObj;
				_currentViewObj.view.open();
			}
			
			return _currentViewObj.view as AbstractView;
		}

		public function closeView(name:String):void 
		{
			if (_viewsDic[name] == null) {
				//silently fail
				trace("Error: The string identifier [" + name + "] of the view to open is not added");
				return;
			}
			
			var viewObj:ViewData = _viewsDic[name] as ViewData;
			viewObj.view.close();
		}

		public function getIsViewOpened(name:String):Boolean 
		{
			if (_viewsDic[name] == null) {
				//silently fail
				trace("Error: The string identifier [" + name + "] view is not added");
				return false;
			}
			
			var viewObj:ViewData = _viewsDic[name] as ViewData;
			return viewObj.view.getIsOpen();
		}

		public function getView(name:String):AbstractView 
		{
			if (_viewsDic[name] == null) {
				//silently fail
				trace("Error: The string identifier [" + name + "] view is not added");
				return null;
			}
			
			var viewObj:ViewData = _viewsDic[name] as ViewData;
			return viewObj.view;
		}

		public function get currentView():AbstractView 
		{
			return _currentViewObj.view;
		}

		public function get currentViewData():Object
		{
			return _currentViewObj;
		}
	}
}

import com.grupow.display.AbstractView;

class ViewData 
{

	public var name:String;
	public var view:AbstractView;
}
