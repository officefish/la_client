package com.ps.collection
{
import com.log.Logger;
import com.ps.cards.*;
	/**
	 * ...
	 * @author 
	 */
	public class CardsCache
	{
		private static var instance:CardsCache;
		
		private var cards:Object;
		private var races:Object;
		private var subraces:Object;
		
		private var cardsCache:Array;
        private var playingCards:Array;
		
		public function CardsCache()
		{
			cards = { };
			races = { };
			subraces = { };
			cardsCache = [];
            playingCards = [];
			
		}
		
		public static function getInstance () :CardsCache {
			if (instance == null) {
				instance = new CardsCache ();
			}
			return instance;
		}
		
		public function addCard (cardData:CardData, id:int, raceId:int, subraceId:int) :void {
			if (cards[id] != null) {
                Logger.log('подробная карта уже существует');
				throw new Error ('Подобная карта уже существует');
			}
			
			cards[id] = cardData;
			
			if (races[raceId] == null) {
				races[raceId] = [];
			}
			(races[raceId] as Array).push (cardData);
			
			if (subraces[subraceId] == null) {
				subraces[subraceId] = [];
			}
			(subraces[subraceId] as Array).push (cardData);

            if (!cardData.auxiliary) {
                playingCards.push(cardData);
            }
			
			cardsCache.push (cardData);
		}
		
		public function getCardById (id:int) :CardData {
			return cards[id]
		}
		
		public function getRandomCardData () :CardData {
			var i:int = Math.floor (Math.random() * playingCards.length);
			return playingCards[i];
		}

        public function getCards () :Array {
            return playingCards.concat();
        }
	}

}