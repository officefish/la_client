package com.la.mvc.view.card
{
import com.la.mvc.view.card.Card;

	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class CardSensor extends Sprite 
	{
		private var card:Card;
		public function CardSensor(card:Card) 
		{
			this.card = card;
			
			graphics.beginFill (0xFF0000, .01);
			graphics.drawRect (0, 0, 110, 160);
			graphics.endFill();
			
		}
		
		public function getCard () :Card {
			return card;
		}
		
	}

}