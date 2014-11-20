package com.ps.game 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameEvent extends Event 
	{
		
		public static const END_GAME:String = 'endGame';
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new GameEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}