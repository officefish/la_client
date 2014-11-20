package com.ps.collection 
{
import com.ps.cards.CardData;
import com.ps.cards.CardData;
	import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeAttachment;
import com.ps.cards.eptitude.EptitudeCondition;
import com.ps.cards.sale.CardSale;
import com.ps.cards.sale.CardSaleLevel;
import com.ps.collection.CardsCache;
import com.ps.cards.eptitude.EptitudeLevel;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.collection.LocalCollection;
	/**
	 * ...
	 * @author 
	 */
	public class Collection 
	{
		private var cards:Array;
		
		public function Collection() 
		{
			cards = [];
		}

        public function getCollection () :Array {
            return cards;
        }

        public function setCollection (cards:Array) :void {
            this.cards = cards;
        }
		
		public function generateCollection (count:int) :Array {
			for (var i:int = 0; i < count; i ++) {
				//var card:CardData = getVuduOrKnight()
				var card:CardData = CardsCache.getInstance().getRandomCardData();
				cards.push (card);
			}
			
			return cards;
		}
		
		public function generateEnemyCollection (count:int) :Array {
			for (var i:int = 0; i < count; i ++) {
				//var card:CardData = getVuduOrKnight()
                var card:CardData = CardsCache.getInstance().getRandomCardData();
                cards.push (card);
			}
			
			return cards;
		}
		
		public function getRandomCard () :CardData {
			if (!cards.length) {
				return null;
			}
			
			var index:int = Math.floor (Math.random () * cards.length);
			var card:CardData = cards[index];
			
			cards.splice (index, 1);
			
			return card;
		}
		
		private function getRandomCardData () :CardData {
			//var randomAttack:int = Math.ceil (Math.random() * 5)
			//var randomHealth:int = Math.ceil (Math.random() * 5)
			//var randomPrice:int = Math.ceil (Math.random() * 5)
			//var eptitude:CardEptitude = CardEptitude.getRandomEptitude ();
			//var provocationEptitude:CardEptitude = CardEptitude.getProvocationEptitude ();
		
			//var cardData:CardData = new CardData (randomAttack, randomHealth, randomPrice, [eptitude]);
			//var passiveAttackEptitude:CardEptitude = CardEptitude.getPassiveAttackEptitude ();
			
			//var cardData:CardData = new CardData (2, 2, 2, [passiveAttackEptitude]);
            var cardData:CardData
            var eptitude:CardEptitude
            var eptitude2:CardEptitude
            var eptitude3:CardEptitude
            var eptitude4:CardEptitude
            var eptitude5:CardEptitude
            var eptitude6:CardEptitude
            var cardSale:CardSale

            eptitude = new CardEptitude (CardEptitude.KILL);
            eptitude.setLevel (EptitudeLevel.LAST_ATTACKED_UNIT);
            eptitude.setPeriod (EptitudePeriod.ATTACK);
            cardData = new CardData (2, 3, 3, [eptitude]);
            cardData.setTitle ('Императорская кобра');
            cardData.setDescription ('Првокация');
            cardData.setType(CardData.UNIT)
            cardData.setRace(1)
            cardData.setType(CardData.UNIT)


            return cardData;
		}

        private function getRandomMurlock () :CardData {
            var arr:Array = [];

            var cardData:CardData
            var eptitude:CardEptitude
            var eptitude2:CardEptitude
            var eptitude3:CardEptitude
            var eptitude4:CardEptitude
            var eptitude5:CardEptitude
            var eptitude6:CardEptitude
            var cardSale:CardSale

            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.ALL_RACE_PLACED);
            eptitude.setPower (1);
            eptitude.setRace(2);
            cardData = new CardData (1, 2, 1, [eptitude]);
            cardData.setTitle ('Мурлок волномут');
            cardData.setDescription ('каждый раз когда на поле призывается мурлок получает +1 к аттаке');
            cardData.setRace(2);
            cardData.setType(CardData.UNIT)
            arr.push(cardData)

            cardData = new CardData (2, 1, 1);
            cardData.setTitle ('Мурлок налетчик');
            cardData.setDescription ('');
            cardData.setRace(2);
            cardData.setType(CardData.UNIT)
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower (1);
            eptitude.setRace(2);
            eptitude2 = new CardEptitude (CardEptitude.DECREASE_ATTACK_BOB);
            eptitude2.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude2.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude2.setPower (1);
            eptitude2.setRace(2);

            eptitude3 = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude3.setLevel (EptitudeLevel.LAST_PLACED_RACE);
            eptitude3.setPeriod (EptitudePeriod.ALL_PLACED);
            eptitude3.setPower (1);
            eptitude3.setRace(2);
            cardData = new CardData (1, 1, 1, [eptitude, eptitude2, eptitude3]);
            cardData.setTitle ('Оракул темной чешуи');
            cardData.setDescription ('все прочие мурлоки получают +1 к аттаке');
            cardData.setRace(2);
            cardData.setType(CardData.UNIT)
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.ASSOCIATE_NEW_UNIT);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setUnitId(36);
            cardData = new CardData (2, 1, 2, [eptitude]);
            cardData.setTitle ('Мурлок волнолов');
            cardData.setDescription ('Боевой клич. Призывает на поле боя мурлока разведчика +1/+1');
            cardData.setType(CardData.UNIT)
            cardData.setRace(2);
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.PICK_CARD);
            eptitude.setAttachment(EptitudeAttachment.ALL)
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(2)
            cardData = new CardData (2, 2, 3, [eptitude]);
            cardData.setTitle ('Вайширский оракул');
            cardData.setDescription ('Боевой клич. Каждый игрок берет по две карты');
            cardData.setType(CardData.UNIT)
            cardData.setRace(2);
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.INCREASE_HEALTH);
            eptitude.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNIT_RACE);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setRace(2)
            eptitude.setPower(2)
            cardData = new CardData (2, 3, 3, [eptitude]);
            cardData.setTitle ('Вайширский провидец');
            cardData.setDescription ('Боевой клич: все прочие мурлоки получают +2 к здоровью');
            cardData.setType(CardData.UNIT)
            cardData.setRace(2);
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower (2);
            eptitude.setRace(2);
            eptitude2 = new CardEptitude (CardEptitude.DECREASE_ATTACK_BOB);
            eptitude2.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude2.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude2.setPower (2);
            eptitude2.setRace(2);
            eptitude3 = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude3.setLevel (EptitudeLevel.LAST_PLACED_RACE);
            eptitude3.setPeriod (EptitudePeriod.ALL_PLACED);
            eptitude3.setPower (2);
            eptitude3.setRace(2);
            eptitude4 = new CardEptitude (CardEptitude.INCREASE_HEALTH_BOB);
            eptitude4.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude4.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude4.setPower (1);
            eptitude4.setRace(2);
            eptitude5 = new CardEptitude (CardEptitude.DECREASE_HEALTH_BOB);
            eptitude5.setLevel (EptitudeLevel.ALL_UNIT_RACE);
            eptitude5.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude5.setPower (1);
            eptitude5.setRace(2);
            eptitude6 = new CardEptitude (CardEptitude.INCREASE_HEALTH_BOB);
            eptitude6.setLevel (EptitudeLevel.LAST_PLACED_RACE);
            eptitude6.setPeriod (EptitudePeriod.ALL_PLACED);
            eptitude6.setPower (1);
            eptitude6.setRace(2);
            cardData = new CardData (3, 3, 3, [eptitude, eptitude2, eptitude3, eptitude4, eptitude5, eptitude6]);
            cardData.setTitle ('Мурлок полководец');
            cardData.setDescription ('Все прочие мурлоки получают +2, +1');
            cardData.setRace(2);
            cardData.setType(CardData.UNIT)
            arr.push(cardData)

            // Старый мрачноглаз 2 4
            // Рывок, получает + 1 за каждого другого мурлока на поле боя
            eptitude = new CardEptitude (CardEptitude.JERK);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude2 = new CardEptitude (CardEptitude.INCREASE_ATTACK_DEPENDS_ON_TOKENS_RACE);
            eptitude2.setLevel (EptitudeLevel.SELF);
            eptitude2.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude2.setAttachment(EptitudeAttachment.ALL)
            eptitude2.setRace(2);
            cardData = new CardData (2, 4, 4, [eptitude, eptitude2]);
            cardData.setTitle ('Старый мрачноглаз');
            cardData.setDescription ('Рывок, получает + 1 за каждого другого мурлока на поле боя');
            cardData.setRace(2);
            cardData.setType(CardData.UNIT)
            arr.push(cardData)


            var index:int = Math.floor(Math.random() * arr.length)
            return arr[index]

        }

        private function getVuduOrKnight () :CardData {
            var arr:Array = [];

            var cardData:CardData
            var eptitude:CardEptitude
            var eptitude2:CardEptitude
            var eptitude3:CardEptitude
            var eptitude4:CardEptitude
            var eptitude5:CardEptitude
            var eptitude6:CardEptitude
            var cardSale:CardSale

            eptitude = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNITS);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower (1);
            eptitude2 = new CardEptitude (CardEptitude.DECREASE_ATTACK_BOB);
            eptitude2.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNITS);
            eptitude2.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude2.setPower (1);
            eptitude3 = new CardEptitude (CardEptitude.INCREASE_ATTACK_BOB);
            eptitude3.setLevel (EptitudeLevel.LAST_PLACED_ASSOCIATE);
            eptitude3.setPeriod (EptitudePeriod.ALL_PLACED);
            eptitude3.setPower (1);
            eptitude4 = new CardEptitude (CardEptitude.INCREASE_HEALTH_BOB);
            eptitude4.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNITS);
            eptitude4.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude4.setPower (1);
            eptitude5 = new CardEptitude (CardEptitude.DECREASE_HEALTH_BOB);
            eptitude5.setLevel (EptitudeLevel.ALL_ASSOCIATE_UNITS);
            eptitude5.setPeriod (EptitudePeriod.SELF_DIE);
            eptitude5.setPower (1);
            eptitude6 = new CardEptitude (CardEptitude.INCREASE_HEALTH_BOB);
            eptitude6.setLevel (EptitudeLevel.LAST_PLACED_ASSOCIATE);
            eptitude6.setPeriod (EptitudePeriod.ALL_PLACED);
            eptitude6.setPower (1);
            cardData = new CardData (6, 6, 6, [eptitude, eptitude2, eptitude3, eptitude4, eptitude5, eptitude6]);
            cardData.setTitle ('Герой Штормграда');
            cardData.setDescription ('Другие ваши существа получают +1/+1');
            cardData.setType(CardData.UNIT)
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.ENTICE_UNIT);
            eptitude.setLevel(EptitudeLevel.RANDOM_OPPONENT_UNIT);
            eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude.setCondition(EptitudeCondition.OPPONENT_UNITS_COUNT_MORE_THAN)
            eptitude.setConditionValue(3);
            cardData = new CardData (3, 3, 3, [eptitude]);
            cardData.setTitle ('Ментальный техник');
            cardData.setDescription ('Если у вашего противника 4 или более существ, вы получаете контроль на случайным существом противника');
            cardData.setType(CardData.UNIT)
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.INCREASE_SPELL);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setPower(1);
            cardData = new CardData (1, 4, 3, [eptitude]);
            cardData.setTitle ('Маг Даларана');
            cardData.setDescription ('Урон от заклинаний +1');
            cardData.setType(CardData.UNIT)
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.FREEZE);
            eptitude.setLevel(EptitudeLevel.SELECTED_OPPONENT_SPELL);
            eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude.setPower(3);
            cardData = new CardData (0, 0, 2, [eptitude]);
            cardData.setTitle ('Ледяная стрела');
            cardData.setDescription ('Наносит {0} ед. урона выбранному существу и замораживает его');
            cardData.setType(CardData.SPELL)
            cardData.setSpellPower (3);
            arr.push(cardData)


            var index:int = Math.floor(Math.random() * arr.length)
            return arr[index]

        }

        private function getSomeCardData () :CardData {
            var arr:Array = [];

            var cardData:CardData
            var eptitude:CardEptitude
            var eptitude2:CardEptitude
            var eptitude3:CardEptitude
            var eptitude4:CardEptitude
            var eptitude5:CardEptitude
            var eptitude6:CardEptitude
            var cardSale:CardSale

            eptitude = new CardEptitude (CardEptitude.INCREASE_SPELL);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setLevel (EptitudeLevel.NEIGHBORS);
            eptitude.setPeriod (EptitudePeriod.SELF_PLACED);
            eptitude.setPower(1)
            cardData = new CardData (2, 5, 4, [eptitude]);
            cardData.setTitle ('Древний маг');
            cardData.setDescription ('Боевой клич. Находящиеся по обе стороны существа получают способность "Урон от заклинаний +1"');
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.ASSOCIATE_NEW_UNIT);
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.ASSOCIATE_SPELL);
            eptitude.setPower(1)
            eptitude.setUnitId(94)
            cardData = new CardData (3, 5, 4, [eptitude]);
            cardData.setTitle ("Учительница магии");
            cardData.setDescription ('Каждый раз когда вы разыгрываете карту призывает на поле мага ученика +1/+1');
            cardData.setType(CardData.UNIT)
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.PICK_CARD);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setLevel (EptitudeLevel.SELF);
            eptitude.setPeriod (EptitudePeriod.ASSOCIATE_DIE);
            eptitude.setPower(1)
            cardData = new CardData (4, 2, 4, [eptitude]);
            cardData.setTitle ('Глава культа');
            cardData.setDescription ('Когда другое ваше существо умирает вы берете карту');
            arr.push(cardData)

            eptitude = new CardEptitude (CardEptitude.FREEZE);
            eptitude.setLevel(EptitudeLevel.SELECTED_OPPONENT_SPELL);
            eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
            eptitude.setPower(3);
            cardData = new CardData (0, 0, 2, [eptitude]);
            cardData.setTitle ('Ледяная стрела');
            cardData.setDescription ('Наносит {0} ед. урона выбранному существу и замораживает его');
            cardData.setType(CardData.SPELL)
            cardData.setSpellPower (3);
            arr.push(cardData)

            // Разрушитель ледников 1,3 (4) Тень
            // Каждый раз при разыгрывании заклинания противником кладет в руку ледяную стрелу
            eptitude = new CardEptitude (CardEptitude.NEW_SPELL);
            eptitude.setLevel(EptitudeLevel.SELF);
            eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)
            eptitude.setPeriod(EptitudePeriod.OPPONENT_SPELL)
            //eptitude.setSpellId(3);
            eptitude2 = new CardEptitude (CardEptitude.SHADOW);
            eptitude2.setLevel(EptitudeLevel.SELF);
            eptitude2.setPeriod(EptitudePeriod.SELF_PLACED)
            cardData = new CardData (0, 0, 2, [eptitude, eptitude2]);
            cardData.setTitle ('Разрушитель ледников');
            cardData.setDescription ('Каждый раз при разыгрывании заклинания противником кладет в руку ледяную стрелу');
            cardData.setType(CardData.UNIT)
            //arr.push(cardData)

            //Двойной агент клуба ветеранов 2 2 (5)
            // кладет случайное существо противника в вашу руку

            // паутина

            //

            var index:int = Math.floor(Math.random() * arr.length)
            return arr[index]
        }

		private function getRandomEnemyCardData () :CardData {
            var eptitude:CardEptitude
            var cardData:CardData


            return cardData;
		}
		
		
	}

}