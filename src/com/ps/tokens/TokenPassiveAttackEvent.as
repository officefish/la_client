package com.ps.tokens 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class TokenPassiveAttackEvent extends Event 
	{
		
		public static const ATTACK:String = 'attack';
		
		private var power:int;
		private var level:int;
		private var asset:MovieClip;
		
		public function TokenPassiveAttackEvent(type:String, level:int, power:int, asset:MovieClip, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			this.level = level;
			this.power = power;
			this.asset = asset;
			
		} 
		
		public function getLevel () :int {
			return level;
		}
		
		public function getPower () :int {
			return power;
		}
		
		public function getAsset () :MovieClip {
			return asset;
		}
		
		public override function clone():Event 
		{ 
			return new TokenPassiveAttackEvent(type, level, power, asset, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TokenPassiveAttackEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}