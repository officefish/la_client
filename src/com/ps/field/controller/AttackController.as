package com.ps.field.controller 
{
	import com.greensock.easing.Expo;
	import com.greensock.TimelineLite;
import com.log.Logger;
import com.ps.cards.eptitude.CardEptitude;
	import com.ps.cards.eptitude.EptitudeLevel;
	import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.eptitude.IEptitudeActivator;
import com.ps.field.Field;
	import com.ps.field.IAttackAvailable;
	import com.ps.field.UnitRow;
import com.ps.hero.Hero;
import com.ps.popup.Popup;
import com.ps.tokens.EptitudeActivator;
import com.ps.tokens.Token;
	import com.ps.tokens.TokenEvent;
	import com.ps.trajectory.TrajectoryContainer;
	import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class AttackController extends EventDispatcher
	{
		private static var instance:AttackController;
		
		private var targetUnit:IAttackAvailable;
		private var attackUnit:IAttackAvailable;
		private var power:int;
		private var playerStep:Boolean;

        private var activator:IEptitudeActivator;
		
		private var field:Field;
		
		private var type:int;
		
		public static const CLASSIC_ATTACK:int = 0;
		public static const PASSIVE_ATTACK:int = 1;
        public static const KILL:int = 2;
        public static const FREEZE:int = 3;
		
		private var passiveAttackUnit:IAttackAvailable;
		private var passiveAttackTarget:IAttackAvailable;

        public static const PLAYER_WIN:String = 'playerWin';
        public static const ENEMY_WIN:String = 'enemyWin';

        private var subcontroller:AttackSubController;

        private var startAttackUnitHealth:int;
        private var startTargetUnitHealth:int;
		
		public function AttackController() 
		{
			
		}
		
		public static function getInstance () :AttackController {
			if (instance == null) {
				instance = new AttackController ();
			}
			return instance;
		}
		
		public function setField (field:Field) :void {
			this.field = field;
		}
		
		public function freeze (attackUnit:IAttackAvailable, targetUnit:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
			this.activator = activator;

            this.type = FREEZE;

            this.targetUnit = targetUnit;
			this.attackUnit = attackUnit;

            this.startAttackUnitHealth = attackUnit.getHealth();
            this.startTargetUnitHealth = targetUnit.getHealth();

			power = eptitude.getPower();
			var asset:MovieClip = eptitude.getAsset (); 
			
			var aU:DisplayObject = attackUnit as DisplayObject;
			
			var attack_pt:Point = new Point(aU.x, aU.y); 
			attack_pt = aU.parent.localToGlobal(attack_pt);
			attack_pt.x += aU.width / 2;
			attack_pt.y += aU.height / 2;
			
			var tU:DisplayObject = targetUnit as DisplayObject 
			
			var target_pt:Point = new Point (tU.x, tU.y);
			target_pt = tU.parent.localToGlobal (target_pt)
			target_pt.x += tU.width / 2;
			target_pt.y += tU.height / 2;
			
			TrajectoryContainer.getInstance().addToGraphicsLevel(asset);
			asset.x = attack_pt.x;
			asset.y = attack_pt.y;
			var timeline:TimelineLite = new TimelineLite ({onComplete:onFreezeComplete});
			timeline.to (asset, .5, { x:target_pt.x, y:target_pt.y , ease:Expo.easeInOut}); 
		}
		
		private function onFreezeComplete () :void {

            TrajectoryContainer.getInstance().endDrawAttack();
			//dispatchEvent (new AttackEvent (AttackEvent.FREEZE_COMPLETE, attackUnit, targetUnit, power));
            var spellBob:int = 0;
            if (attackUnit is Hero) {
                spellBob = (attackUnit as Hero).getSpellBob();
            }

            var targetHealth:int = targetUnit.getTotalHealth() - (power + spellBob);
            if (targetHealth < 0) targetHealth = 0;

            if (targetUnit.hasShield() && power) {
                targetUnit.destroyShield()
            } else {
                targetUnit.setHealth (targetHealth - targetUnit.getHealthBob());
            }
            targetUnit.freeze ();

            if (!targetUnit.getTotalHealth()) {

                if (targetUnit is Token) {
                    var tU:Token = targetUnit as Token;
                    tU.visible = false;

                } else {
                    endGame ();
                    return;
                }
            }


            if (checkTargetWound(targetUnit)) return;
            if (checkTargetDeath(targetUnit)) return;
            if (centerizeTargetUnitRow (targetUnit, endAttack)) return;
            endAttack();

			
		}

        private function endAttack () :void {
            field.setSelectionMode(false);
            switch (type) {
                case CLASSIC_ATTACK: {
                    (attackUnit as Token).attackComplete ();
                    break;
                }
                case KILL:
                case FREEZE:
                case PASSIVE_ATTACK:
                {
                    activator.continueActivate()
                    break;
                }


            }
        }

        public function kill (attackUnit:IAttackAvailable, targetUnit:IAttackAvailable, activator:IEptitudeActivator) :void {
            //Logger.log ('Kill. ' + targetUnit.isEnemy());

            this.activator = activator;
            this.attackUnit = attackUnit;
            this.targetUnit = targetUnit;
            type = KILL;
            targetUnit.setHealth (0);

            if (checkTargetWound(targetUnit)) return;
            if (checkTargetDeath(targetUnit)) return;
            if (centerizeTargetUnitRow (targetUnit, endAttack)) return;
            endAttack();

        }
		
		public function attack (attackUnit:IAttackAvailable, targetUnit:IAttackAvailable, playerStep:Boolean) :void {
					
			field.setSelectionMode(true);
            this.targetUnit = targetUnit;
			this.attackUnit = attackUnit; 
			this.playerStep = playerStep;

            this.startAttackUnitHealth = attackUnit.getHealth();
            this.startTargetUnitHealth = targetUnit.getHealth();
			
			type = CLASSIC_ATTACK;
			
			if (targetUnit is Token) {
				if (( targetUnit as Token).inShadow()) {
					Popup.getInstance().warning ("Вы не можете атаковать замаскированного соперника");
					return;
				}
			}
			
			//attackMode = true;
			var aU:Token = attackUnit as Token;
			
			aU.stopBlur ();		
			
			if (playerStep) {
				if (field.getEnemyProvocators().length && !targetUnit.isProvocator()) 
				{
					aU.blur ();
					Popup.getInstance().warning ("Вы должны аттаковать провокатора");
					return;
				}
			} 
			
			var attack_pt:Point = new Point(aU.x, aU.y); 
			attack_pt = aU.parent.localToGlobal(attack_pt);
			
			var tU:DisplayObject = targetUnit as DisplayObject
			
			var target_pt:Point = new Point (tU.x, tU.y);
			target_pt = tU.parent.localToGlobal (target_pt)
			if (targetUnit.isEnemy()) {
				target_pt.y += tU.height/2 - 10;
			} else {
				target_pt.y -= tU.height/2 - 10;
			}
						
			var deltaX:int = target_pt.x - attack_pt.x + ((tU.width - aU.width) / 2);
			var deltaY:int = target_pt.y - attack_pt.y;
			
			var start_pt:Point = aU.getPosition ();
			var end_pt:Point = new Point (start_pt.x + deltaX, start_pt.y + deltaY);
						
			var timeline:TimelineLite = new TimelineLite ({onComplete:onAttackComplete});
			timeline.to (aU, .2, { x:end_pt.x, y:end_pt.y , ease:Expo.easeInOut, onComplete:onAttack} );
			timeline.to (aU, .8, { x:start_pt.x, y:start_pt.y, ease:Expo.easeOut } );
		}
		
		private function onAttack () :void {
			
			var targetHealth:int = targetUnit.getTotalHealth() - attackUnit.getTotalAttack()
            if (targetHealth < 0) targetHealth = 0;
			
			var exAttackUnitHealth:int = attackUnit.getTotalHealth()
            var attackUnitHealth:int = attackUnit.getTotalHealth() - targetUnit.getTotalAttack()
			if (attackUnitHealth < 0) attackUnitHealth = 0;
			
			if (targetUnit.hasShield()) {
                targetUnit.destroyShield()
            } else {
                targetUnit.setHealth (targetHealth - targetUnit.getHealthBob());
            }

           if (attackUnit.hasShield() && exAttackUnitHealth != attackUnitHealth) {
               attackUnit.destroyShield()
           } else {
               attackUnit.setHealth (attackUnitHealth - attackUnit.getHealthBob());
           }
           field.setLastAttacked(targetUnit);
		}
		
		private function onAttackComplete () :void {
				var aU:Token = attackUnit as Token;
			if (!aU.getTotalHealth()) {
				aU.visible = false;

			}

			if (!targetUnit.getTotalHealth()) {
				
				if (targetUnit is Token) {
					var tU:Token = targetUnit as Token;
					tU.visible = false;
					
				} else {
					endGame ();
                    return;
				}
			}

            if (attackUnit is Token) {
                (attackUnit as Token).activateEptitudes(EptitudePeriod.ATTACK, activateWoundAndDeath)
            } else {
                activateWoundAndDeath()
            }


		}

        private function activateWoundAndDeath() :void {
            if (checkAttackWound(attackUnit)) return;
            if (checkAttackDeath(attackUnit)) return;
            if (centerizeAttackUnitRow(attackUnit)) return;
            if (checkTargetWound(targetUnit)) return;
            if (checkTargetDeath(targetUnit)) return;
            if (centerizeTargetUnitRow (targetUnit, endAttack)) return;
            endAttack();
        }
		
		private function endGame () :void {
            if (field.getEnemyHero().getHealth() <= 0) {
                field.dispatchEvent(new Event(PLAYER_WIN))
            }  else {
                field.dispatchEvent(new Event(ENEMY_WIN));
            }
		}

        public function passiveAttack (attackUnit:IAttackAvailable, targetUnit:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
            this.activator = activator;
            lounchPassiveAttack(attackUnit, targetUnit, eptitude)
        }

        private function lounchPassiveAttack (attackUnit:IAttackAvailable, targetUnit:IAttackAvailable, eptitude:CardEptitude) :void {
			type = PASSIVE_ATTACK;
			power = eptitude.getPower();
			var level:int = eptitude.getLevel();
			var asset:MovieClip = eptitude.getAsset ();
            this.attackUnit =  attackUnit;
            this.targetUnit = targetUnit;

            this.startAttackUnitHealth = attackUnit.getHealth();
            this.startTargetUnitHealth = targetUnit.getHealth();

			var aU:Token = attackUnit as Token;
			var tU:DisplayObject = targetUnit as DisplayObject;
			
			var attack_pt:Point = new Point(aU.x, aU.y); 
			attack_pt = aU.parent.localToGlobal(attack_pt);
			attack_pt.x += aU.width / 2;
			attack_pt.y += aU.height / 2;
			
			var target_pt:Point = new Point (tU.x, tU.y);
			target_pt = tU.parent.localToGlobal (target_pt)
			target_pt.x += tU.width / 2;
			target_pt.y += tU.height / 2;
			
			TrajectoryContainer.getInstance().addToGraphicsLevel (asset);
			asset.x = attack_pt.x;
			asset.y = attack_pt.y;
			var timeline:TimelineLite = new TimelineLite ({onComplete:onPassiveAttackComplete});
			timeline.to (asset, .5, { x:target_pt.x, y:target_pt.y , ease:Expo.easeInOut});
			
			
		}
		
		private function onPassiveAttackComplete () :void {
			
			TrajectoryContainer.getInstance().endDrawAttack();
            var spellBob:int = 0;
            if (attackUnit is Hero) {
                spellBob = (attackUnit as Hero).getSpellBob();
            }

            var targetHealth:int = targetUnit.getTotalHealth() - (power + spellBob);
			if (targetHealth < 0) targetHealth = 0;

            if (targetUnit.hasShield()) {
                targetUnit.destroyShield()
            } else {
                targetUnit.setHealth (targetHealth - targetUnit.getHealthBob());
            }

			if (!targetUnit.getTotalHealth()) {
				
				if (targetUnit is Token) {
					var tU:Token = targetUnit as Token;
					tU.visible = false;
					
				} else {
					endAttack ();
				}
			}
			
			if (checkTargetWound(targetUnit)) return;
			if (checkTargetDeath(targetUnit)) return;
			if (centerizeTargetUnitRow (targetUnit, endAttack)) return;
			endAttack();
		}

        private function checkAttackWound (attackUnit:IAttackAvailable) :Boolean {
            //Logger.log('checkAttackWound')
            var woundFlag:Boolean = false;

            var aU:Token = attackUnit as Token;

            if (aU.getHealth() != startAttackUnitHealth) {
                woundFlag = true;
                aU.activateEptitudes (EptitudePeriod.SELF_WOUND, onAttackWoundActivate);
            }

            return woundFlag;
        }

        private function destroySubcontroller () :void {
            if (subcontroller) {
                subcontroller.destroy();
                subcontroller = null;
            }
        }

        private function onAttackWoundActivate () :void {
            var token:Token = attackUnit as Token;
            if (token) {
                subcontroller = new AttackSubController();
                subcontroller.setField(field)
                subcontroller.activateWound(token, onAttackWoundActivationComplete)
            } else {
                onAttackWoundActivationComplete ()
            }
        }

        private function onAttackWoundActivationComplete () :void {
            destroySubcontroller();
            if (checkAttackDeath(attackUnit)) return;
            if (centerizeAttackUnitRow(attackUnit)) return;
            if (checkTargetWound(targetUnit)) return;
            if (checkTargetDeath(targetUnit)) return;
            if (centerizeTargetUnitRow (targetUnit, endAttack)) return;
            endAttack();
        }

        private function checkAttackDeath (attackUnit:IAttackAvailable) :Boolean {
            var deathFlag:Boolean = false;
            var aU:Token = attackUnit as Token;
            if (aU.getTotalHealth() <= 0) {
                aU.visible = false;
                deathFlag = true;
                aU.activateEptitudes (EptitudePeriod.SELF_DIE, onAttackDeathActivate);
            }
            return deathFlag;
        }

        private function onAttackDeathActivate () :void {
            var token:Token = attackUnit as Token;
            if (token) {
                subcontroller = new AttackSubController();
                subcontroller.setField(field)
                subcontroller.activateDeath(token, onAttackDeathActivationComplete)
            } else {
                onAttackDeathActivationComplete ()
            }
        }

        private function onAttackDeathActivationComplete () :void {
            destroySubcontroller()
            if (centerizeAttackUnitRow(attackUnit)) return;
            if (checkTargetWound(targetUnit)) return;
            if (checkTargetDeath(targetUnit)) return;
            if (centerizeTargetUnitRow (targetUnit, endAttack)) return;
            endAttack();
        }

        private function centerizeAttackUnitRow (attackUnit:IAttackAvailable) :Boolean {
            var centerizeFlag:Boolean = false;

            var enemyRow:UnitRow = field.getEnemyRow ();
            var playerRow:UnitRow = field.getPlayerRow ();

            var aU:Token = attackUnit as Token;
            if (aU.getTotalHealth() <= 0) {

                if (aU.isEnemy()) {

                    if (enemyRow.contains (aU)) {
                        enemyRow.removeChild (aU);
                    }
                    field.sortUnitRow (enemyRow);
                    field.centerizeRow (enemyRow, onAttackCompleteCenterize);

                } else {

                    if (playerRow.contains (aU)) {
                        playerRow.removeChild (aU);
                    }
                    field.sortUnitRow (playerRow);
                    field.centerizeRow (playerRow, onAttackCompleteCenterize);
                }

                centerizeFlag = true;
                aU.visible = true;

            }
            return centerizeFlag
        }

        private function onAttackCompleteCenterize () :void {
            if (checkTargetWound(targetUnit)) return;
            if (checkTargetDeath(targetUnit)) return;
            if (centerizeTargetUnitRow (targetUnit, endAttack)) return;
            endAttack();
        }

        private function checkTargetWound (targetUnit:IAttackAvailable) :Boolean {
            var woundFlag:Boolean = false;

            if (targetUnit is Token) {
                var tU:Token = targetUnit as Token;
                if (tU.getHealth() != startTargetUnitHealth) {
                    woundFlag = true;
                    tU.activateEptitudes (EptitudePeriod.SELF_WOUND, onTargetWoundActivate);
                }
            }
            return woundFlag;
        }

        private function onTargetWoundActivate () :void {
            var token:Token = targetUnit as Token;
            if (token) {
                subcontroller = new AttackSubController();
                subcontroller.setField(field)
                subcontroller.activateWound(token, onTargetWoundActivationComplete)
            } else {
                onTargetWoundActivationComplete ()
            }
        }

        private function onTargetWoundActivationComplete () :void {
            destroySubcontroller();
            if (checkTargetDeath(targetUnit)) return;
            if (centerizeTargetUnitRow (targetUnit, endAttack)) return;
            endAttack();
        }



        //private function

        private function checkTargetDeath (targetUnit:IAttackAvailable) :Boolean {
            var deathFlag:Boolean = false;

            if (!targetUnit.getTotalHealth()) {

                if (targetUnit is Token) {
                    var tU:Token = targetUnit as Token;
                    tU.visible = false;
                    deathFlag = true;

                    //Logger.log('activateEptitude Self die ' + tU.getTitle())
                    tU.activateEptitudes (EptitudePeriod.SELF_DIE, onTargetDeathActivate);

                } else {
                    endGame ();
                    return true;
                }

            }

            return deathFlag;
        }

        private function onTargetDeathActivate () :void {
            var token:Token = targetUnit as Token;
            if (token) {
                subcontroller = new AttackSubController();
                subcontroller.setField(field)
                subcontroller.activateDeath(token, onTargetDeathActivationComplete)
            } else {
                onTargetDeathActivationComplete ()
            }
        }

        private function onTargetDeathActivationComplete () :void {
            destroySubcontroller();
            if (centerizeTargetUnitRow (targetUnit, endAttack)) return;
            endAttack();
        }

        private function centerizeTargetUnitRow (targetUnit:IAttackAvailable, callback:Function) :Boolean {
           // Logger.log('centerizeTargetUnitRow');
            var centerizeFlag:Boolean = false;


            var enemyRow:UnitRow = field.getEnemyRow ();
            var playerRow:UnitRow = field.getPlayerRow ();

            if (targetUnit is Token) {
                var tU:Token = targetUnit as Token;
                if (!tU.getTotalHealth()) {

                    if (tU.isEnemy()) {

                        if (enemyRow.contains (tU)) {
                            enemyRow.removeChild (tU);
                        }
                        field.sortUnitRow (enemyRow);
                        field.centerizeRow (enemyRow, callback);

                    } else {

                        if (playerRow.contains (tU)) {
                            playerRow.removeChild (tU);
                        }
                        field.sortUnitRow (playerRow);
                        field.centerizeRow (playerRow, callback);
                    }

                    centerizeFlag = true;
                    tU.visible = true;
                }
            }

            return centerizeFlag
        }
	}

}