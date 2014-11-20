package com.ps.tokens 
{
import com.log.Logger;
import com.ps.cards.Card;
	import com.ps.cards.CardData;
	import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeAttachment;
import com.ps.cards.eptitude.EptitudeEvent;
	import com.ps.cards.eptitude.EptitudeLevel;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.eptitude.EptitudePeriod;
	import com.ps.cards.PickCardLevel;
	import com.ps.field.IAttackAvailable;
	import com.ps.field.IPlaceAvailable;
	import com.ps.trajectory.TrajectoryContainer;
	import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 
	 */
	public class Token extends Sprite implements IPlaceAvailable, IAttackAvailable
	{
		
		private static var tokenPreview:IPlaceAvailable;
		public static const WIDTH:int = 60;
		public static const HEIGHT:int = 80;
		
		private var attackLabel:TextField;
		private var healthLabel:TextField;
		private var position:Point;
		private var cardData:CardData;
		private var card:Card;
		
		private var enemy:Boolean = false;

		private var _canAttack:Boolean = false;
		
		private var eptitudes:Array;
		private var periodEptitudes:Array;
		
		internal var attackCount:int;
		
		internal var level1:Sprite;
		internal var level2:Sprite;
		internal var level3:Sprite;
		internal var level4:Sprite;
		
		private var defaultFormat:TextFormat;
		private var woundFormat:TextFormat;
        private var bonusFormat:TextFormat;
		
		internal var shadow:Sprite;
		internal var shadowFlag:Boolean = false;

        internal var shield:Sprite;
        internal var shieldFlag:Boolean = false;

        internal var provocation:Boolean = false;
        internal var provocationSprite:Sprite;
		
		internal var freezeFlag:Boolean = false;
		internal var freezeSprite:Sprite;
		
		private var _attack:int;
		private var _health:int;
		private var _maxHealth:int;
		private var _defaultHealth:int;
		private var _defaultAttack:int;

        private var dumbnessAsset:Sprite;

        private var _attackBod:int = 0;
        private var _healthBob:int = 0;

        private var spellFlag:Boolean = false;
        public var spellSprite:Sprite;

        public var spellUpSprite:Sprite;
        public var spellBob:int = 0;
        public var spellBobAttachment:int;

        public var tempEmptitudes:Array;

        private var spellUpFlag:Boolean = false;

        private  var dumbnessFlag:Boolean = false;
		
		internal static const TOKEN_FREEZE:int = 1000;

        internal var dependency:CardEptitude;
		
		
		public static function getTokenPreviewInstance () :IPlaceAvailable {
			if (tokenPreview == null) {
				tokenPreview = new Token (null);
				var tokenContainer:Sprite = tokenPreview as Sprite
				tokenContainer.graphics.clear ();
				tokenContainer.graphics.beginFill (0xFF0000, 1);
				tokenContainer.graphics.drawRect (0, 0, 60, 80);
				tokenContainer.graphics.endFill ();
				while (tokenContainer.numChildren){
					tokenContainer.removeChildAt (0);
				}
			}
			
			return tokenPreview;
		}
		
		public function Token(card:Card, enemy:Boolean = false) 
		{
			level1 = new Sprite ();
			level1.mouseEnabled = false;
			addChild (level1);
			
			level2 = new Sprite ();
			level2.mouseEnabled = false;
			addChild (level2);
			
			level2.graphics.beginFill (0xcccccc, 1);
			level2.graphics.drawRect (0, 0, 60, 80);
			level2.graphics.endFill ();
			
			shadow = new Sprite ();
			shadow.graphics.beginFill (0x222222, 0.5);
			shadow.graphics.drawRect (0, 0, 60, 80);
			shadow.graphics.endFill ();
			shadow.mouseEnabled = false;
			shadowFlag = false;

            dumbnessAsset = new Sprite();
            dumbnessAsset.graphics.beginFill (0xDDA0DD, 0.3);
            dumbnessAsset.graphics.drawRect (0, 0, 60, 80);
            dumbnessAsset.graphics.endFill ();
            dumbnessAsset.mouseEnabled = false;
			
			this.enemy = enemy;
			
			if (card == null) {
				return;
			}
			
			level3 = new Sprite ();
			level3.mouseEnabled = false;
			addChild (level3);
			
			level4 = new Sprite ();
			level4.mouseEnabled = false;
			addChild (level4);
			
			freezeSprite = new Sprite ();
			freezeSprite.graphics.beginFill (0x00FFFF, 0.7);
			freezeSprite.graphics.drawRect (0, 0, 60, 80);
			freezeSprite.graphics.endFill ();
			freezeSprite.mouseEnabled = false;
			freezeFlag = false;

            spellSprite = new Sprite ();
            spellSprite.graphics.beginFill (0x58FAF4, 0.2);
            spellSprite.graphics.drawRect (0, 0, 60, 80);
            spellSprite.graphics.endFill ();
            spellSprite.mouseEnabled = false;

            spellUpSprite = new Sprite ();
            spellUpSprite.graphics.beginFill (0xB404AE, 0.2);
            spellUpSprite.graphics.drawRect (0, 0, 60, 80);
            spellUpSprite.graphics.endFill ();
            spellUpSprite.mouseEnabled = false;


            shield = new Sprite ();
            shield.graphics.beginFill (0xFFFF00, 0.3);
            shield.graphics.drawRect (-10, -10, 80, 100);
            shield.graphics.endFill ();
            shield.mouseEnabled = false;
            shieldFlag = false;

					
			this.card = card;
			this.cardData = card.getCardData();
			
			this.eptitudes = cardData.getEptitudes();
						
			defaultFormat = new TextFormat ();
			defaultFormat.size = 14;
			defaultFormat.bold = true;
			defaultFormat.color = 0x444444;
			
			woundFormat = new TextFormat ();
			woundFormat.size = 14;
			woundFormat.bold = true;
			woundFormat.color = 0xFF0000;

            bonusFormat = new TextFormat();
            bonusFormat.size = 14;
            bonusFormat.bold = true;
            bonusFormat.color = 0x00FF00;

			
			level2.graphics.beginFill (0xFFFFFF, 1);
			level2.graphics.drawRect (0, 65, 15, 15);
			level2.graphics.endFill ();
			
			level2.graphics.beginFill (0xFFFFFF, 1);
			level2.graphics.drawRect (45, 65, 15, 15);
			level2.graphics.endFill ();
						
			attackLabel = new TextField ();
			attackLabel.defaultTextFormat = defaultFormat;
			attackLabel.text = "" + cardData.getAttack();
			attackLabel.autoSize = TextFieldAutoSize.LEFT;
			attackLabel.wordWrap = true;
			attackLabel.mouseEnabled = false;
			attackLabel.selectable = false;
			
			attackLabel.x = 1;
			attackLabel.y = 61;
			attackLabel.width = 20;
			level2.addChild (attackLabel);
			
			healthLabel = new TextField ();
			healthLabel.width = 10;
			healthLabel.defaultTextFormat = defaultFormat;
			healthLabel.text = "" + cardData.getHealth();
			healthLabel.autoSize = TextFieldAutoSize.LEFT;
			healthLabel.wordWrap = true;
			healthLabel.mouseEnabled = false;
			healthLabel.selectable = false;
			
			healthLabel.x = 47;
			healthLabel.y = 61;
			level2.addChild (healthLabel);
			
			provocationSprite = new Sprite ();
			provocationSprite.graphics.beginFill (0x777777, 1);
			provocationSprite.graphics.drawRect (-10, -10, 80, 100);
			provocationSprite.graphics.endFill ();
			provocationSprite.mouseEnabled = false;
			
			
			attackCount = 1;
			_canAttack = false;
			
			addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener (MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener (MouseEvent.MOUSE_OUT, onMouseOut);
			
			_health = cardData.getHealth ();
			_attack = cardData.getAttack ();
			setDefaultHealth (_health);
			setMaxHealth (_health);
			setDefaultAtack (_attack);
			
			periodEptitudes = [];
            tempEmptitudes = [];
		}
		
		public function freeze () :void {
			this.freezeFlag = true;
			level4.addChild (freezeSprite);
			var newEptitude:CardEptitude
			if (!containsAnyLevelEptitude(TOKEN_FREEZE)) {
				newEptitude = new CardEptitude (TOKEN_FREEZE);
				newEptitude.setPower(2);
				newEptitude.setPeriod (EptitudePeriod.START_STEP);
				addEptitude (newEptitude);
			} else {
				newEptitude = getEptitudeByType (TOKEN_FREEZE);
				newEptitude.setPower(2);
			}
		}
		
		public function getCardData () :CardData {
			return cardData;
		}


		
		private function onMouseOver (event:MouseEvent) :void {
			dispatchEvent (new TokenEvent (TokenEvent.TOKEN_MOUSE_OVER, this));
		}
		
		private function onMouseOut (event:MouseEvent) :void {
			dispatchEvent (new TokenEvent (TokenEvent.TOKEN_MOUSE_OUT, this));
		}
		
		public function activateEptitudes (period:int, callback:Function) :EptitudeActivator {



            var activator:EptitudeActivator = new EptitudeActivator (this, callback);

            var eptitude:CardEptitude;

            if (period == EptitudePeriod.END_STEP) {
                while (tempEmptitudes.length) {
                    eptitude = tempEmptitudes.shift();
                    deactivateEptitude (eptitude);
                }
            }

            if (period == EptitudePeriod.START_STEP) {
                attackCount = 1;
                if (getTotalAttack() == 0) {
                    canAttack = false;
                }
            }

			periodEptitudes = [];

            for (var i:int = 0; i < eptitudes.length; i ++) {
				eptitude = eptitudes[i];
				if (eptitude.getPeriod() == period) {
					periodEptitudes.push (eptitude);
				}
			}



			activator.activateEptitudes (periodEptitudes);
            return activator;

		}

        public function forceActivate (eptitude:CardEptitude, callback:Function) :void {
            var activator:EptitudeActivator = new EptitudeActivator (this, callback);
            activator.activateEptitudes ([eptitude]);
        }

        private function deactivateEptitude (eptitude:CardEptitude) :void {
            switch (eptitude.getType()) {
                case CardEptitude.INCREASE_ATTACK: {
                    var newAttack:int;
                    newAttack = getAttack() - eptitude.getPower();
                    if (newAttack < 0) newAttack = 0;
                    if (newAttack == 0) {
                        canAttack = false;
                        attackCount = 0;
                    }
                    setAttack (newAttack);
                    break;
                }
            }
        }

		public function configure (eptitude:CardEptitude, callback:Function) :void {
            var activator:EptitudeActivator = new EptitudeActivator (this, callback, true);
            activator.activateEptitudes ([eptitude]);
        }

        public function isProvocator () :Boolean {
            if (shadowFlag) {
                return false;
            }
            return provocation;
        }

        public function inShadow () :Boolean {
            return shadowFlag;
        }
			
		public function activateProvocation () :void {
            provocation = true;
            level1.addChild(provocationSprite);
        }

        public function deactivateProvocation () :void {
            provocation = false;
            if (level1.contains(provocationSprite)) {
                level1.removeChild (provocationSprite);
            }
        }

        public function activateShadow () :void {
            level3.addChild(shadow);
            shadowFlag = true;
        }

        public function deactivateShadow () :void {
            shadowFlag = false;
            if (level3.contains(shadow)) {
                level3.removeChild(shadow);
            }
        }

        public function isSpellInvisible () :Boolean {
            return spellFlag;
        }

        public function activateSpellInvisible () :void {
            spellFlag = true;
            level2.addChild(spellSprite);

        }

        public function deactivateSpellInvisible () :void {
            if (level2.contains(spellSprite)) {
                level2.removeChild(spellSprite);
            }
            spellFlag = false;
        }

        public function hasShield () :Boolean {
            return shieldFlag;
        }

        public function activateShield () :void {
            level4.addChild(shield)
            shieldFlag = true;
        }

        public function destroyShield () :void {
            shieldFlag = false;
            if (level4.contains(shield)) {
                level4.removeChild(shield)
            }
        }

        public function getAttackCount () :int {
            return attackCount;
        }

        public function setAttackCount (value:int) :void {
            this.attackCount  = attackCount;
        }

        public function isDoubleAttack () :Boolean {
            return attackCount > 1;
        }

        public function activateDoubleAttack () :void {
            attackCount = 2;
        }

        public function deactivateDoubleAttack () :void {
            if (attackCount > 1) {
                attackCount = 1;
            }
        }

        public function activateSpellUp () :void {
            level2.addChild(spellUpSprite)
            spellUpFlag = true;
        }

        public function deactivateSpellUp () :void {
            if (level2.contains(spellUpSprite)) {
                level2.removeChild(spellUpSprite);
            }
            spellBob = 0;
            spellUpFlag = false;
        }

        public function isSpellUp () :Boolean {
            return spellUpFlag;
        }

        public function activateFreeze () :void {
            this.freezeFlag = true;
            level4.addChild (freezeSprite);
        }

        public function deactivateFreeze () :void {
            this.freezeFlag = false;
            if (level4.contains(freezeSprite)) {
                level4.removeChild(freezeSprite);
            }
        }

        public function isFreeze () :Boolean {
            return freezeFlag;
        }

        public function isDumbness () :Boolean {
            return dumbnessFlag;
        }
		
		public function dumbness () :void {
			    dumbnessFlag = true;

                if (getHealth() > getDefaultHealth()) {
					setHealth (getDefaultHealth());
				}
                setMaxHealth(getDefaultHealth())

				if (getTotalAttack() > getDefaultAttack()) {
					setAttack (getDefaultAttack());
				}


                deactivateProvocation();
                deactivateShadow();
				deactivateDoubleAttack();
                destroyShield();

                if (getDefaultAttack() > 0 && attackCount > 0) {
                    canAttack = true;
                }

                deactivateFreeze();
                deactivateSpellInvisible();
                deactivateSpellUp()


                level3.addChild(dumbnessAsset)
				eptitudes = []
        }
		
		public function getEptitudeByType (type:int) :CardEptitude {
			var eptitude:CardEptitude;
			for (var i:int = 0; i < eptitudes.length; i ++) {
				eptitude = eptitudes[i];
				if (eptitude.getType() == type) {
					break;
				}
			}
			return eptitude;
		}
		
		public function containsAnyLevelEptitude (type:int) :Boolean {
			var flag:Boolean = false;
			var eptitude:CardEptitude
			for (var i:int = 0; i < eptitudes.length; i ++) {
				eptitude = eptitudes[i];
				if (eptitude.getType() == type) {
					flag = true;
					break;
				}
			}
			return flag;
		}
		
		public function containsEptitude (type:int) :Boolean {
			var flag:Boolean = false;
			var eptitude:CardEptitude
			for (var i:int = 0; i < eptitudes.length; i ++) {
				eptitude = eptitudes[i];
				if (eptitude.getType() == type && eptitude.getLevel() == EptitudeLevel.SELF) {
					flag = true;
					break;
				}
			}
			return flag;
		}
		
		public function addEptitude (eptitude:CardEptitude) :void {
			eptitudes.push (eptitude);
		}
		
		public function removeEptitude (eptitude:CardEptitude) :void {
			var index:int = eptitudes.indexOf (eptitude);
            eptitudes.splice (index, 1);
		}
		

	    public function set canAttack (bool:Boolean) :void {
			if (bool) {
				if (!isEnemy()) {
					level2.filters = [new GlowFilter (0x00FFFF)];
				}
				
			} else {
				if (!isEnemy()) {
					level2.filters = null;
				}
			}
			_canAttack = bool;
		}
		
		public function get canAttack () :Boolean {
			return _canAttack;
		}
		
		public function attackComplete () :void {
			attackCount --;
			if (attackCount <= 0) {
				canAttack = false;
			} else {
				blur ();
			}
			if (level3.contains (shadow)) {
				level3.removeChild (shadow);
				shadowFlag = false;
			}
			dispatchEvent (new TokenEvent (TokenEvent.ATTACK_COMPLETE, this));
		}
		
		public function cancelActivate () :void {
			dispatchEvent (new TokenEvent (TokenEvent.ACTIVATION_COMPLETE, this));
		}

        public function completeConfigure () :void {
            dispatchEvent (new TokenEvent (TokenEvent.CONFIGURE_COMPLETE, this));
        }
		
		
		
		
		private function onMouseDown (event:MouseEvent) :void {
			if (isEnemy()) {
				return;
			}
			
			if (!_canAttack) {
				return;
			}
			
			dispatchEvent (new TokenEvent (TokenEvent.TOKEN_MOUSE_DOWN, this));
			
			
		}
		
		public function attackPlayerHero () :void {
			dispatchEvent (new TokenEvent (TokenEvent.ATTACK_PLAYER_HERO, this));
		}
		
		public function attackUnit (unit:Token) :void {
			var event:TokenEvent = new TokenEvent (TokenEvent.ATTACK_UNIT, this);
			event.setTargetUnit (unit);
			dispatchEvent (event);
		}
		
		public function isEnemy () :Boolean {
			return enemy;
		}
		
		public function getPosition () :Point {
			if (position == null) {
				position = new Point ();
			}
			position.x = this.x
			position.y =  this.y;
			
			return position;
		}
		

		
		
		
		public function getShirt () :Sprite {
			return card.getShirt ();
		}
		
		

		public function setMaxHealth (value:int) :void {
			_maxHealth = value;
		}
		
		public function getMaxHealth () :int {
			return _maxHealth;
		}
		
		public function getDefaultHealth () :int {
			return _defaultHealth;
		}
		
		public function setDefaultHealth (value:int) :void {
			this._defaultHealth = value;
		}
		
		public function setDefaultAtack (value:int) :void {
			_defaultAttack = value;
		}
		
		public function getDefaultAttack () :int {
			return _defaultAttack;
		}
		
		
		public function getAttack () :int {
			return _attack;
		}

        public function getTotalAttack () :int {
            return _attack + _attackBod;
        }

        public function getTotalHealth () :int {
            return _health + _healthBob;
        }

        public function setHealthBob (value:int) :void {
            _healthBob = value;
            if (_healthBob == 0 && getHealth() == 0) {
                setHealth(1);
            }
        }

        public function getHealth () :int {
            return _health;
        }



        public function setHealth (value:int):void {
            _health = value;
            //if (!value && _healthBob) {
               // _health = 1;
          //  }
            var finalHealth:int = _health + _healthBob;
            //Logger.log (finalHealth.toString())
            if (finalHealth > getMaxHealth()) {
                healthLabel.defaultTextFormat = bonusFormat;
            }
            else if (finalHealth == getMaxHealth()) {
				healthLabel.defaultTextFormat = defaultFormat;
			} else {
				healthLabel.defaultTextFormat = woundFormat;
			}
			healthLabel.text = "" + finalHealth;
		}
		
		public function setAttack (value:int):void {
			_attack = value;
            var finalAttack:int = _attack + _attackBod;
            if (_attackBod > 0) {
                attackLabel.defaultTextFormat = bonusFormat;
            } else {
                attackLabel.defaultTextFormat = defaultFormat;
            }
			attackLabel.text = "" + finalAttack;
		}
		

		
		public function getMirrow () :Sprite {
			return card.getMirrow ();
		}
		
		public function blur () :void {
			level2.filters = [new GlowFilter (0x00FFFF)];
		}
		
		public function stopBlur () :void {
			level2.filters = null;
		}
		
		public function hasFilters () :Boolean {
			if (level2.filters == null) {
				return false;
			} else if (!level2.filters.length) {
				return false;
			} else {
				return true;
			}
			
		}



        public function getRace () :int {
            return cardData.getRace();
        }

        public function cancelSelect () :void {
            dependency = null;
        }

        public function getAttackBob () :int {
            return _attackBod
        }
        public function setAttackBob (value:int) :void {
            _attackBod = value;
        }



        public function getHealthBob () :int {
            return _healthBob;
        }

        public function getTitle () :String {
            return cardData.getTitle();
        }

        public function getCard () :Card {
            return card;
        }

        public function setEnemy (value:Boolean) :void {
            this.enemy = value;
        }

        public function copyEptitudes () :Array {
            return eptitudes.concat();
        }

        public function setEptitudes (arr:Array) :void {
            eptitudes = arr;
        }


		
		
		
		
	}

}