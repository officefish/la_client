package com.ps.field 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class ActivationEvent extends Event 
	{
		
		private var period:int;
		private var playerFlag:Boolean;
		
		public static const ACTIVATION_COMPLETE:String = 'activationComplete';
		
		public function ActivationEvent(type:String, period:int, player:Boolean, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.period = period;
			this.playerFlag = player;
			
		} 
		
		public function getPeriod () :int {
			return period;
		}
		
		public function isPlayer () :Boolean {
			return playerFlag;			
		}
		
		public override function clone():Event 
		{ 
			return new ActivationEvent(type, period, playerFlag, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ActivationEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}