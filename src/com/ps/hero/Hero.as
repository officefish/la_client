package com.ps.hero 
{
import com.log.Logger;
import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeEvent;
import com.ps.field.IAttackAvailable;
import com.ps.tokens.EptitudeActivator;
import com.ps.tokens.TokenEvent;

import flash.display.Loader;
import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.display.Sprite; 
	/**
	 * ...
	 * @author 
	 */
	public class Hero extends Sprite implements IAttackAvailable
	{
		
		private var health:int;
		private var healthLabel:TextField;
		private var enemy:Boolean = false;
		private var maxHealth:int;
        private var spellBob:int = 0;

        private var callback:Function;


        public static const WIDTH:int = 100;

		
		public function Hero(health:int = 50, enemy:Boolean = false) 
		{
			this.health = health;
			this.enemy = enemy;
            this.maxHealth = health;
			
			var format:TextFormat = new TextFormat ();
			format.size = 14;
			format.bold = true; 
			
			
			graphics.beginFill (0xDDDDDD, 1);
			graphics.drawRect (0, 0, 100, 100);
			graphics.endFill ();
			
			graphics.beginFill (0x00FF00, 1);
			graphics.drawRect (82, 82, 18, 18);
			graphics.endFill ();
			
			healthLabel = new TextField ();
			healthLabel.width = 30;
			healthLabel.defaultTextFormat = format;
			healthLabel.text = "" + health;
			healthLabel.autoSize = TextFieldAutoSize.LEFT;
			healthLabel.wordWrap = true;
			healthLabel.mouseEnabled = false;
			healthLabel.selectable = false;
			
			healthLabel.x = 82;
			healthLabel.y = 82;
			addChild (healthLabel);
		}

        public function increaseSpell (power:int) :void {
            spellBob += power;
        }

        public function degreaseSpell (power:int) :void {
            spellBob -= power;
            if (spellBob < 0) {
                spellBob = 0;
            }
        }

        public function getSpellBob () :int {
            return spellBob;
        }
		
		public function isEnemy () :Boolean {
			return enemy;
		}
		
		public function getHealth ():int {
			return health;
		}

        public function getTotalHealth() :int {
            return health;
        }
		
		public function getAttack () :int {
			return 0;
		}

        public function getTotalAttack () :int {
            return 0;
        }

        public function getMaxHealth () :int {
            return maxHealth;
        }
		
		public function setHealth (value:int) :void {
			this.health = value;
			healthLabel.text = "" + value;
		}
		
		public function isProvocator () :Boolean {
			return false;
		}
		
		public function configure (eptitude:CardEptitude, callback:Function) :void {
            var newHealth:int;
            var activator:HeroEptitudeActivator = new HeroEptitudeActivator();
            activator.activateEptitude(this, eptitude, callback)

        }

        public function completeConfigure () :void {
            callback();
        }
		
		public function freeze () :void {
			
		}

        public function hasShield () :Boolean {
            return false
        }

        public function destroyShield ():void {

        }

        public function activationComplete () :void {
            dispatchEvent (new TokenEvent (TokenEvent.CONFIGURE_COMPLETE, this));
        }

        public function getPrice () :int {
            return 0;
        }

        public function cancelSelect () :void {

        }

        public function activateSpell (eptitudes:Array, callback:Function) :EptitudeActivator {
            var activator:EptitudeActivator = new EptitudeActivator (this, callback);
            activator.activateEptitudes (eptitudes);
            return activator;
        }

        public function getHealthBob() :int {
            return 0;
        }
	}

}