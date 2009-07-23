package com.grupow.core 
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Raúl Uranga
	 */
	public class ContentManager extends EventDispatcher
	{
		protected var nextState:IContentState = new NullContentState();
		protected var previousState:IContentState = new NullContentState();
		protected var currentState:IContentState = new NullContentState();
		
		public function ContentManager() 
		{
			
		}
				
		public function getCurrentState():IContentState
		{
			return currentState;
		}
		
		public function setNextState(state:IContentState):void
		{
			nextState = state;
		}
		
		public function getNextState():IContentState
		{
			return nextState;
		}
		
		public function setPreviousState(state:IContentState):void
		{
			previousState = state;
		}
		
		public function getPreviousState():IContentState
		{
			return previousState;
		}
		
		public function setState(state:IContentState):void
		{
			currentState.exit();
			previousState = currentState;
			currentState = state;
			currentState.enter();
		}
		
		public function gotoNextState():void
		{
			this.setState(this.nextState);
		}
		
		public function gotoPreviousState():void
		{
			this.setState(this.previousState);
		}
		
		
	}
	
}