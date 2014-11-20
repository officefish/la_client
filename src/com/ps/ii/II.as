package com.ps.ii 
{
	import adobe.utils.CustomActions;

import com.log.Logger;

import com.ps.cards.Card;
import com.ps.cards.CardData;
	import com.ps.tokens.Token;
	import com.ps.tokens.TokenEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * ...
	 * @author 
	 */
	public class II extends EventDispatcher
	{
		
		private var units:Array;
		private var actualUnit:Token;
		private var price:int;
		
		private var cards:Array;
		
		private var playerProvocators:Array;
		
		private var rowNumChildren:int = 0;
		
		public function II() 
		{
			
		}
		
		public function configureUnits (units:Array) :void {
			this.units = units;
		}
		
		public function placeCards (cards:Array) :void {
			this.cards = cards;
			checkCards ();
			
		}
		
		public function setRowNumChildren (value:int) :void {
			this.rowNumChildren = value;
		}
		
		public function checkCards () :void {
			if (rowNumChildren >= 7) {
				dispatchEvent (new IIEvent (IIEvent.END_PLACE_CARDS));
				return;
			}
			
			if (!cards.length) {
				dispatchEvent (new IIEvent (IIEvent.END_PLACE_CARDS));
				return;
			}
			
			var card:Card = cards.shift ();
			if (card.getPrice() <= this.price) {
				var event:IIEvent = new IIEvent (IIEvent.PLAY_CARD);
				event.setCard (card);
				dispatchEvent (event);
			} else {
				checkCards ();
			}
		}
		
		public function playScenario () :void {
			
			if (units.length) {
				actualUnit = units.shift ();
				if (actualUnit.canAttack) {
					actualUnit.addEventListener (TokenEvent.ATTACK_COMPLETE, onUnitAttackComplete);

					if (playerProvocators.length) {

						actualUnit.attackUnit (playerProvocators[0]);
					} else {
						actualUnit.attackPlayerHero ();
					}
				} else {
					playScenario ();
				}
			
			} else {
				dispatchEvent (new IIEvent (IIEvent.END_SCENARIO));
			}
		}
		
		public function setPlayerProvocators (provocators:Array) :void {
			playerProvocators = provocators;
		}
		
		private function onUnitAttackComplete (event:TokenEvent) :void {
			if (actualUnit.canAttack) {
				units.unshift (actualUnit);
			} 
			
			actualUnit.removeEventListener (TokenEvent.ATTACK_COMPLETE, onUnitAttackComplete);
			dispatchEvent (new IIEvent(IIEvent.END_UNIT_ATTACK));	
		}
		
		public function stop () :void {
			if (actualUnit) {
				actualUnit.removeEventListener (TokenEvent.ATTACK_COMPLETE, onUnitAttackComplete);
			}
			actualUnit = null;
		}
		
		public function setPrice (value:int) :void {
			this.price = value;
		}
		
	}

}