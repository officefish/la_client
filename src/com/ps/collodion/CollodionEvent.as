package com.ps.collodion
{
import com.ps.cards.*;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class CollodionEvent extends Event 
	{
		
		private var cardData:CardData;
        private var price:int;
		
		public static const CARD_PLAY:String = 'cardPlay';
		
		public function CollodionEvent(type:String, cardData:CardData, price:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{ 
			this.cardData = cardData;
            this.price = price;
			super(type, bubbles, cancelable);
			
		}

        public function getPrice () :int {
            return price
        }
		
		public function getCardData () :CardData {
			return cardData;
		}
		
		public override function clone():Event 
		{ 
			return new CollodionEvent(type, cardData, price, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CollodionEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}