package com.ps.cards.eptitude
{
import com.ps.cards.eptitude.CardEptitude;
import com.ps.tokens.EptitudeActivator;

import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class EptitudeEvent extends Event 
	{
		protected var eptitude:CardEptitude;
		public static const ACTIVATE:String = 'activate_eptitude';
		public static const SELECT:String = 'select_then_activate';
		public static const PICK_CARD:String = 'pickCard';
		public static const FREEZE:String = 'freeze';
		public static const NEW_UNIT:String = 'newUnit';
		public static const PASSIVE_ATTACK:String = 'passiveAttack';
        public static const DEATH:String = 'unitDeath';
        public static const TREATMENT:String = 'threatment';
        public static const CARD_SALE:String = 'cardSale';
        public static const INCREASE_SPELL:String = 'increaseSpell';
        public static const DECREASE_SPELL:String = 'degreaseSpell';
        public static const ENTICE_UNIT:String = 'enticeUnit';
        public static const BACK_CARD_TO_HAND:String = 'backCardToHand';
        public static const NEW_SPELL:String = 'newSpell';
        public static const COPY_UNIT:String = 'copyUnit';
        public static const UNIT_CONVERTION:String = 'unitConvertion';
        public static const INCREASE_HEALTH_DEPENDS_ON_CARDS:String = 'increaseHealthdependsonCards';
        public static const INCREASE_ATTACK_DEPENDS_ON_TOKENS:String = 'increaseAttackdependsonTokens';
        public static const INCREASE_HEALTH_DEPENDS_ON_TOKENS:String = 'increaseHealthdependsonTokens';
        public static const INCREASE_ATTACK_DEPENDS_ON_TOKENS_RACE:String = 'increaseAttackdependsonTokensRace';
        public static const INCREASE_HEALTH_DEPENDS_ON_TOKENS_RACE:String = 'increaseHealthdependsonTokensRace';


        protected var activator:IEptitudeActivator;
				
		public function EptitudeEvent(type:String, eptitude:CardEptitude, activator:IEptitudeActivator, bubbles:Boolean=false, cancelable:Boolean=false)
		{ 
			super(type, bubbles, cancelable);
			this.eptitude = eptitude;
            this.activator = activator;
			
		} 
		
		public function getEptitude () :CardEptitude {
			return eptitude;
		}

        public function getActivator () :IEptitudeActivator {
            return activator;
        }
		
		public override function clone():Event 
		{ 
			return new EptitudeEvent(type, eptitude, activator, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EptitudeEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}