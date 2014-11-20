package com.ps.cards 
{
	/**
	 * ...
	 * @author 
	 */
	public class CardData 
	{
		
		private var _attack:int;
		private var _health:int;
		
		private var _price:int;
		private var _eptitudes:Array;
		
		private var _maxHealth:int;
		private var _defaultHealth:int;
		private var _defaultAttack:int;
		
		private var _title:String;
		private var _description:String;

        private var raceId:int;
        private var subraceId:int;

        private var type:int;

        private var spellPower:int;

        public static const UNIT:int = 0;
        public static const SPELL:int = 1;
        public static const SECRET:int = 2;

        private var _id:int;

        private var auxiliaryFlag:Boolean = false;
		
		
		
		public function CardData(attack:int, health:int, price:int, eptitudes:Array = null) 
		{
			this._attack = attack;
			this._health = health;
			this._maxHealth = health;
			this._defaultHealth = health;
			this._price = price;
			this._eptitudes = eptitudes;
			this._defaultAttack = attack;
		}
		
		public function getAttack () :int {
			return _attack;
		}
		
		public function getHealth () :int {
			return _health;
		}
		
		public function getPrice () :int {
			return _price;
		}
		
		public function setAttack (value:int) :void {
			this._attack = value;
		}
		
		public function getEptitudes () :Array {
			if (_eptitudes == null) {
				_eptitudes = [];
			}
			return _eptitudes.concat();
		}
		
		public function setHealth (value:int) :void {
			this._health = value;
		}
		
		public function setMaxHealth (value:int) :void {
			this._maxHealth = value;
		}
		
		public function setDefaultHealth (value:int) :void {
			this._defaultHealth = value;
		}
		
		public function getMaxHealth () :int {
			return _maxHealth;
		}
		
		public function getDefaultHealth () :int {
			return _defaultHealth;
		}
		
		public function getDefaultAttack () :int {
			return _defaultAttack;
		}
		
		public function setTitle (value:String) :void {
			this._title = value;
		}
		
		public function getTitle () :String {
			return _title;
		}
		
		public function setDescription (value:String) :void {
			_description = value;
		}
		
		public function getDescription () :String {
			return _description;
		}

        public function  setRace (raceId:int) :void {
            this.raceId = raceId;
        }

        public function getRace () :int {
            return raceId;
        }

        public function  setSubrace (subraceId:int) :void {
            this.subraceId;
        }

        public function  getSubrace () :int {
            return subraceId;
        }

        public function setType (value:int) :void {
            this.type = value;
        }
		public function getType () :int {
            return type;
        }

        public function setSpellPower (value:int) :void {
            this.spellPower = value;
        }
        public function getSpellPower () :int {
            return spellPower;
        }

        public function set auxiliary (value:Boolean) :void {
            auxiliaryFlag = value;
        }

        public function get auxiliary () :Boolean {
            return auxiliaryFlag;
        }

        public function set id (value:int) :void {
            this._id = value;
        }

        public function  get id () :int {
            return _id;
        }
	}

}