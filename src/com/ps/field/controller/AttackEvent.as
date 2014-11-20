package com.ps.field.controller 
{
	import com.ps.field.IAttackAvailable;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class AttackEvent extends Event 
	{
		
		private var power:int;
		private var targetUnit:IAttackAvailable;
		private var attackUint:IAttackAvailable;
		
		public static const FREEZE_COMPLETE:String = 'freezeComplete';
		public static const CLASSIC_COMPLETE:String = 'classicComplete';

		
		public function AttackEvent(type:String, attackUint:IAttackAvailable, targetUnit:IAttackAvailable, power:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.power = power;
			this.targetUnit = targetUnit;
			this.attackUint = attackUint;
			
		} 
		
		public override function clone():Event 
		{ 
			return new AttackEvent(type, attackUint, targetUnit, power, bubbles, cancelable);
		} 
		
		public function getPower () :int {
			return power;
		}
		
		public function getTargetUnit () :IAttackAvailable {
			return targetUnit;
		}
		
		public function getAttackUnit () :IAttackAvailable {
			return attackUint;
		}
		
		
		
		public override function toString():String 
		{ 
			return formatToString("AttackEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}