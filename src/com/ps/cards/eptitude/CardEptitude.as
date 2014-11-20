package com.ps.cards.eptitude
{
import com.ps.cards.*;
import com.ps.cards.sale.CardSale;

import flash.display.MovieClip;
	/**
	 * ...
	 * @author 
	 */
	public class CardEptitude 
	{
		
		private var type:int;
		private var period:int;
		private var power:int = 1;
		private var level:int;
		private var asset:MovieClip;
		private var unitId:int;
		private var raceId:int;
		private var subraceId:int;
        private var lifecycle:int = -1;
        private var _marker:Boolean = false;
        private var _dependency:int = 0;
        private var sale:CardSale;
        private var attachment:int;
        private var condition:int = 0;
        private var conditionValue:int = 0;
        private var count:int = 1;
        private var spellId:int;

        private var probability:int = 100;

    	public static const DEPENDENCY:int = 0;
        public static const JERK:int = 1;
		public static const DOUBLE_ATTACK:int = 2;
		public static const PASSIVE_ATTACK:int = 3;
		public static const PROVOCATION:int = 4;
		
		public static const INCREASE_ATTACK:int = 5;
		public static const INCREASE_HEALTH:int = 6;
		public static const DECREASE_ATTACK:int = 7;
		public static const DECREASE_HEALTH:int = 8;
		public static const CHANGE_ATTACK_TILL:int = 9;
		public static const CHANGE_HEALTH_TILL:int = 10;
		
		public static const FULL_HEALTH:int = 11;
		public static const DUMBNESS:int = 12;
		public static const TREATMENT:int = 13;
		
		public static const CONFIG_PASSIVE_ATTACK:int = 14;
		
		public static const PICK_CARD:int = 15;
		public static const BACK_CARD_TO_HAND:int = 16;
		
		public static const KILL:int = 17;
		public static const SHADOW:int = 18;
		
		public static const FREEZE:int = 19;
		
		public static const ASSOCIATE_NEW_UNIT:int = 20;

        public static const SHIELD:int = 21;

        public static const INCREASE_ATTACK_BOB:int = 22;
        public static const DECREASE_ATTACK_BOB:int = 23;

        public static const CAN_NOT_ATTACK:int = 24;

        public static const REPLACE_ATTACK_HEALTH:int = 25;

        public static const CARD_SALE:int = 26;

        public static const INCREASE_SPELL:int = 27;
        public static const DECREASE_SPELL:int = 28;

        public static const SPELL_INVISIBLE:int = 29;

        public static const MASSIVE_ATTACK:int = 30;

        public static const INCREASE_ATTACK_AND_HEALTH:int = 31;

        public static const INCREASE_HEALTH_BOB:int = 32;
        public static const DECREASE_HEALTH_BOB:int = 33;

        public static const ENTICE_UNIT:int = 34;

        public static const NEW_SPELL:int = 35;

        public static const COPY_UNIT:int = 36;
        public static const UNIT_CONVERTION:int = 37;

        public static const INCREASE_ATTACK_DEPENDS_ON_TOKENS_RACE:int = 38;
        public static const INCREASE_HEALTH_DEPENDS_ON_TOKENS_RACE:int = 39;
        public static const INCREASE_ATTACK_DEPENDS_ON_TOKENS:int = 40;
        public static const INCREASE_HEALTH_DEPENDS_ON_TOKENS:int = 41;
        public static const INCREASE_HEALTH_DEPENDS_ON_CARDS:int = 42;

        public static const DESCRIPTIONS:Array =
		[
            'зависимость',
			'рывок',
			'двойная аттака',
			'пассивная аттака',
			'провокация',
			'увеличение аттаки',
			'увеличение здоровья',
			'уменьшение аттаки',
			'уменьшение здоровья',
			'изменение аттаки до',
			'изменение здоровья до',
			'восстановление здоровья',
			'немота',
			'лечение',
			'оруженосец',
			'новая карта',
			'вернуть карту в руку',
			'убийство',
			'тень',
			'заморозка',
			'новый союзнический юнит',
			'новый сознический юнит особого типа',
			'новый союзнический юнит особого подтипа',
            'божественный щит',
            'увеличение аттаки(доп)',
            'уменьшение аттаки(доп)',
            'не может аттаковать',
            'скидка на карту',
            'увеличивает силу магии',
            'уменьшает силу магии',
            'неуязвим для магии',
            "массовая аттака",
            'увеличивает аттаку и здоровье',
             "увеличение здоровья(доп)",
             "уменьшение здоровья(доп)",
             'переманивание',
             'новая карта магии от юнита на столе',
             'копирование',
             'превращение',
             'увеличивает аттаку в зависимости от количества фишек определенной рассы на столе',
            'увеличивает здоровье в зависимости от количества фишек определенной рассы на столе',
            'увеличивает аттаку в завимиости от количества фишек на столе' ,
              'увеличивает здоровье в завимиости от количества фишек на столе',
              'увеличивает здоровье в завимиости от количества карт в руке'

        ]
		
		public function CardEptitude(type:int) 
		{
			this.type = type;
		}

        public function setCondition (value:int) :void {
            this.condition = value;
        }

        public function getCondition () :int {
            return condition;
        }

        public function setConditionValue (value:int) :void {
            this.conditionValue = value;
        }

        public function getConditionValue () :int {
            return conditionValue;
        }

        public function setSale (sale:CardSale) :void {
            this.sale = sale;
        }

        public function getSale () :CardSale {
            return sale;
        }
		
		public function getType () :int {
			return type;
		}
		
		public function setPeriod (value:int) :void {
			this.period = value;
		}
		
		public function getPeriod () :int {
			return period;
		}
		
		public function setLevel (value:int):void {
			this.level = value;
		}
		
		public function getLevel () :int {
			return level;
		}
		
		public function setPower (value:int) :void {
			this.power = value;
		}
		
		public function getPower () :int {
			return power;
		}
		
		public function setUnitId (value:int) :void {
			this.unitId = value;
		}
		
		public function getUnitId () :int {
			return unitId;
		}
		
		public function setRace (value:int) :void {
			this.raceId = value;
		}
		
		public function getRace () :int {
			return raceId;
		}

        public function getLifecycle () :int {
            return lifecycle;
        }

        public function  setLifecycle (value:int) :void {
            lifecycle = value;
        }
		
		public function setSubrace (value:int) :void {
			this.subraceId = value;
		}
		
		public function getSubrace () :int {
			return subraceId;
		}

        public function setAttachment (value:int) :void {
            this.attachment = value;
        }

        public function getAttachment () :int {
            return attachment;
        }
		
		public function getAsset () :MovieClip {
			if (asset == null) {
				asset = new MovieClip ();
				asset.graphics.beginFill (0xFF0000);
				asset.graphics.drawRect ( -5, -5, 10, 10);
				asset.graphics.endFill ();
			}
			return asset;
		}
		
		public function setAsset (value:MovieClip) :void {
			this.asset = value;
		}
		
		public function get description () :String {
			return DESCRIPTIONS[type];
		}
		
		public static function getRandomEptitude () :CardEptitude {
			
			
			/*
			var random:int = Math.round (Math.random () * 3);
			var eptitude:CardEptitude = new CardEptitude (random);
			//eptitude.period = EptitudePeriod.SELF_PLACED;
			eptitude.period = EptitudePeriod.SELF_PLACED;
			
			if (random == DOUBLE_ATTACK) {
				eptitude.period = EptitudePeriod.START_STEP;
			}
			
			if (random == PASSIVE_ATTACK) {
				eptitude.period = EptitudePeriod.START_STEP;
				eptitude.power = Math.ceil (Math.random() * 3);
				eptitude.level = EptitudeLevel.RANDOM_OPPONENT;
				
				
			}
			
			return eptitude;
			*/
			
			
			
			
			var eptitude:CardEptitude = new CardEptitude (CardEptitude.ASSOCIATE_NEW_UNIT);
			eptitude.period = EptitudePeriod.SELF_DIE;
			eptitude.level = EptitudeLevel.SELF;
			eptitude.power = 2;
			eptitude.unitId = 0;
			
			
			/*
			var eptitude:CardEptitude = new CardEptitude (CardEptitude.CHANGE_ATTACK_TILL);
			eptitude.period = EptitudePeriod.SELF_WOUND;
			eptitude.level = EptitudeLevel.SELF;
			eptitude.power = 4;
			eptitude.unitId = 0;
			*/
			
			return eptitude;
		}
		
		public static function getPassiveAttackEptitude () :CardEptitude {
			var eptitude:CardEptitude = new CardEptitude (CardEptitude.PASSIVE_ATTACK);
			eptitude.period = EptitudePeriod.ASSOCIATE_PLACED;
			eptitude.level = EptitudeLevel.RANDOM_OPPONENT;
			eptitude.power = 1;
			return eptitude;
		}
		
		public static function getProvocationEptitude () :CardEptitude {
			var eptitude:CardEptitude = new CardEptitude (CardEptitude.PROVOCATION);
			eptitude.period = EptitudePeriod.SELF_PLACED;
			eptitude.level = EptitudeLevel.SELF;
			return eptitude;
		}
		
		private static function getRandomPeriod () :int {
			var random:int = Math.round (Math.random ());
			return random;
		}

        public function set marker (value:Boolean) :void {
            this._marker = value;
        }

        public function get marker () :Boolean {
            return _marker;
        }

        public function set dependency (value:int) :void {
            _dependency = value;
        }

        public function get dependency () :int {
            return _dependency;
        }

        public function setProbability (value:int) :void {
            this.probability = value;
        }

        public function getProbability () :int {
            return probability;
        }

        public function setCount (value:int) :void {
            this.count = value;
        }

        public function getCount () :int {
            return count;
        }

        public function setSpellId (value:int) :void {
            this.spellId = value;
        }

        public function getSpellId () :int {
            return spellId;
        }
	}

}