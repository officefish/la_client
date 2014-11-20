package com.ps.tokens 
{
	import com.ps.field.IAttackAvailable;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class TokenEvent extends Event 
	{
		protected var token:IAttackAvailable;
		
		public static const TOKEN_MOUSE_UP:String = 'token_mouse_up';
		public static const TOKEN_MOUSE_DOWN:String = 'token_mouse_down';
		public static const TOKEN_MOUSE_OVER:String = 'token_mouse_over';
		public static const TOKEN_MOUSE_OUT:String = 'token_nouse_out';
		
		public static const ATTACK_COMPLETE:String = 'attackComplete';
		public static const ATTACK_PLAYER_HERO:String = 'attackPlayerHero';
		
		public static const ACTIVATION_COMPLETE:String = 'activationCompete';
		
		public static const ATTACK_UNIT:String = 'attackUnit';
		
		public static const PASSIVE_ATTACK:String = 'passiveAttack';
		
		public static const CONFIGURE_COMPLETE:String = 'configureComplete';
		
		public static const DEATH:String = 'unitDeath';
		
		public static const BACK_CARD_TO_HAND:String = 'backCardToHand';

    	protected var targetUnit:IAttackAvailable;

		
		public function TokenEvent(type:String, target:IAttackAvailable, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.token = target;
			
		} 
		
		public function setTargetUnit (unit:IAttackAvailable) :void {
			this.targetUnit = unit;
		}
		
		public function getTargetUnit () :IAttackAvailable {
			return targetUnit;
		}
		
		public function getToken () :IAttackAvailable {
			return token;
		}
		
		public override function clone():Event 
		{ 
			return new TokenEvent(type, token, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TokenEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}