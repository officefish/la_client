package com.ps.ii 
{
import com.ps.cards.Card;
import com.ps.cards.CardData;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class IIEvent extends Event 
	{
		
		public static const END_SCENARIO:String = 'endScenario';
		public static const END_PLACE_CARDS:String = 'endPlaceCards';
		public static const PLAY_CARD:String = 'playCard';
		public static const END_UNIT_ATTACK:String = 'endUnitAttack';
		
		private var card:Card;
		
		public function IIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		}
		
		public function setCard (card:Card) :void {
			this.card = card;
		}
		
		public function getCard () :Card {
			return card;
		}
		
		public override function clone():Event 
		{ 
			return new IIEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("IIEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}