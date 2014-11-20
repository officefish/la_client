package com.ps.field 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class FieldEvent extends Event 
	{
		public static const END_STEP:String = 'endStep';
		public static const END_GAME:String = 'endGame';
		public static const ENEMY_CARD_PLAY:String = 'enemyCardPlay';
		public static const END_BACK_CARD:String = 'endBackCard';
		
		public function FieldEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new FieldEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FieldEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}