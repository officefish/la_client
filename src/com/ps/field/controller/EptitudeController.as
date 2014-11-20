package com.ps.field.controller
{
import com.ps.cards.eptitude.IEptitudeActivator;
import com.ps.field.*;
import com.log.Logger;
import com.ps.cards.eptitude.CardEptitude;
	import com.ps.cards.eptitude.EptitudeLevel;
import com.ps.field.Field;
import com.ps.hero.Hero;
import com.ps.tokens.EptitudeActivator;
import com.ps.tokens.Token;
	import com.ps.tokens.TokenEvent;
	import com.ps.trajectory.TraectoryContainerEvent;
	import com.ps.trajectory.TrajectoryContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * ...
	 * @author 
	 */
	public class EptitudeController extends EventDispatcher
	{
		private static var instance:EptitudeController
		
		private var playerRow:UnitRow;
		private var enemyRow:UnitRow;
		
		private var playerHero:Hero;
		private var enemyHero:Hero;
		
		private var activationCounter:int;
		
		private var actualEptitude:CardEptitude;

        private var iniciator:IAttackAvailable;

        private var units:Array;

        private var activator:IEptitudeActivator;

        private var field:Field;
		
		public static const EPTITUDE_ACTIVATION_COMPLETE:String = 'eptitudeActivationComplete';
		public static const CANCEL_SELECT:String = 'cancelSelect';
        public static const NO_SELECT_UNITS:String = 'noSelectUnits';
		
		public function EptitudeController() 
		{
			
		}
		
		public static function getInstance () :EptitudeController {
			if (instance == null) {
				instance = new EptitudeController ();
			}
			return instance;
		}
		
		public function configure (field:Field, playerRow:UnitRow, enemyRow:UnitRow, playerHero:Hero, enemyHero:Hero) :void {
			this.field = field;
            this.playerRow = playerRow;
			this.enemyRow = enemyRow;
			this.playerHero = playerHero;
			this.enemyHero = enemyHero;
		}
		
		public function selectAndActivate (eptitude:CardEptitude, iniciator:IAttackAvailable, activator:IEptitudeActivator) :void {
            this.iniciator = iniciator;
            this.activator = activator;

            var selectUnits:Array = filterSelect (eptitude, iniciator);

            //Logger.log(selectUnits.length.toString())

            if (eptitude.getCondition()) {
                var conditionController:ConditionController = new ConditionController();
                conditionController.setField(field)
                selectUnits = conditionController.checkCondition (iniciator, selectUnits, eptitude);
            }
            //Logger.log(selectUnits.length.toString())

			if (!selectUnits.length) {

               // возможно плохой код!!!
                iniciator.cancelSelect();
                activator.continueActivate();

				return;
			}
			
			actualEptitude = eptitude;
			//trace (selectUnits);
			TrajectoryContainer.getInstance().placeUnits (selectUnits);
			TrajectoryContainer.getInstance().addEventListener (TraectoryContainerEvent.SELECT, onSelect);
		}
		
		private function onSelect (event:TraectoryContainerEvent) :void {
            TrajectoryContainer.getInstance().removeEventListener (TraectoryContainerEvent.SELECT, onSelect);

            var targetToken:IAttackAvailable = event.getToken();

            if (targetToken) {

				activationCounter = 1;
    			targetToken.configure (actualEptitude, onSelectConfigureComplete);

            } else {
                field.cancelSelect(iniciator);

				// return unit to card
			}
		}

        private function onSelectConfigureComplete () :void {
            //Logger.log('onselectconfigurecomplete')
            activator.continueActivate();
        }


		
		private function filterSelect (eptitude:CardEptitude, iniciator:IAttackAvailable) :Array {
			var arr:Array = [];

            var level:int = eptitude.getLevel();
            var token:Token = iniciator as Token;
			
			switch (level) {
				
				case EptitudeLevel.SELECTED_ANY_UNIT: {
					if (iniciator.isEnemy()) {
						if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
                        arr = arr.concat (getChildren (playerRow));
					} else {
						if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
                        arr = arr.concat (getChildren (enemyRow));
					}
					break;
				}
				
				case EptitudeLevel.SELECTED_ANY: {
					if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
						arr = arr.concat (getChildren (playerRow));
					} else {
                        if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
						arr = arr.concat (getChildren (enemyRow));
					}
					arr.push (enemyHero);
					arr.push (playerHero);
					break;
				}
				
				case EptitudeLevel.SELECTED_ASSOCIATE: {
					if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
						arr.push (enemyHero);
					} else {
                        if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
						arr.push (playerHero);
					}
					break;
				}
				
				case EptitudeLevel.SELECTED_ASSOCIATE_UNIT: {
					if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
					} else {
                        if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
					}
					break;
				}
				
				case EptitudeLevel.SELECTED_OPPONENT: {
					if (iniciator.isEnemy()) {
						arr = getChildren (playerRow);
						arr.push (playerHero);
					} else {
						arr = getChildren (enemyRow);
						arr.push (enemyHero);
					}
					break;
				}
				
				case EptitudeLevel.SELECTED_OPPONENT_UNIT: {
					if (iniciator.isEnemy()) {
						arr = getChildren (playerRow);
					} else {
						arr = getChildren (enemyRow);
					}
					break;
				}

                case EptitudeLevel.SELECTED_ANY_RACE: {
                    if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getRaceChildrenExceptIniciator (enemyRow, token, eptitude.getRace());
                        } else {
                            arr = getRaceChildren(enemyRow, eptitude.getRace())
                        }
                        arr = arr.concat(getRaceChildren(playerRow, eptitude.getRace()))
                    } else {
                        if (token) {
                            arr = getRaceChildrenExceptIniciator (playerRow, token, eptitude.getRace());
                        } else {
                            arr = getRaceChildren(playerRow, eptitude.getRace())
                        }
                        arr = arr.concat(getRaceChildren(enemyRow, eptitude.getRace()))
                    }
                    break;
                }
                case EptitudeLevel.SELECTED_ASSOCIATE_SPELL: {
                    if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getSpellVisibleChildrenEcxeptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
                    } else {
                        if (token) {
                            arr = getSpellVisibleChildrenEcxeptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
                    }
                    break;
                }
                case EptitudeLevel.SELECTED_OPPONENT_SPELL: {
                    if (iniciator.isEnemy()) {
                        arr =field.getSpellVisibleTokens (playerRow);
                        arr.push (playerHero);
                    } else {
                        arr = field.getSpellVisibleTokens (enemyRow);
                        arr.push (enemyHero);
                    }
                    break;
                }
                case EptitudeLevel.SELECTED_ALL_SPELL: {
                    if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getSpellVisibleChildrenEcxeptIniciator (enemyRow, token);
                        } else {
                            arr = field.getSpellVisibleTokens (enemyRow)
                        }
                        arr = arr.concat (getChildren (playerRow));
                    } else {
                        if (token) {
                            arr = getSpellVisibleChildrenEcxeptIniciator (playerRow, token);
                        } else {
                            arr = field.getSpellVisibleTokens (playerRow)
                        }
                        arr = arr.concat (getChildren (enemyRow));
                    }
                    arr.push (enemyHero);
                    arr.push (playerHero);
                    break;
                }


			}
			
			return arr;
		}
		
		public function activateEptitude (eptitude:CardEptitude, iniciator:IAttackAvailable, activator:IEptitudeActivator) :void {
			//Logger.log ('activateEptitude: '+ CardEptitude.DESCRIPTIONS[eptitude.getType()] )

            this.iniciator = iniciator;
            this.activator = activator;

            units = getUnits (eptitude, iniciator);

            activationCounter = units.length;
            actualEptitude = eptitude;
            processActivate();
		}

        private function processActivate () :void {
            if (!units.length) {
                //Logger.log('iniciator.activationComplete()')
                activator.continueActivate ();

                //iniciator.activationComplete();
                //dispatchEvent (new Event (EPTITUDE_ACTIVATION_COMPLETE));
                return;
            }

            var unit:IAttackAvailable = units.shift();
            unit.configure (actualEptitude, onConfigureComplete);
        }
		
		private function onConfigureComplete () :void {
			processActivate()
		}
		
		private function getUnits (eptitude:CardEptitude, iniciator:IAttackAvailable) :Array {
			//trace ('getUnits');
            var level:int = eptitude.getLevel();
			var arr:Array = [];
			var index:int;
			var unit:Token;
            var token:Token = iniciator as Token;
            var conditionController:ConditionController

			switch (level) {
                case EptitudeLevel.RANDOM_ASSOCIATE_SPELL: {
                    if (iniciator.isEnemy()) {

                        arr = field.getSpellVisibleTokens(enemyRow);
                        arr.push(enemyHero)

                    } else {
                        arr = field.getSpellVisibleTokens (playerRow);
                        arr.push(playerHero)
                    }

                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

                    index = Math.round(Math.random() * (arr.length - 1));
                    arr = arr.splice(index, 1);

                    break;
                }
                case EptitudeLevel.RANDOM_ASSOCIATE: {
                    if (iniciator.isEnemy()) {

                        arr = getChildren (enemyRow);
                        arr.push(enemyHero)

                    } else {
                        arr = getChildren (playerRow);
                        arr.push(playerHero)
                    }

                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

                    index = Math.round(Math.random() * (arr.length - 1));
                    arr = arr.splice(index, 1);
                    break;
                }
                case EptitudeLevel.RANDOM_ASSOCIATE_UNIT: {
					if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
						
					} else {
                        if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
					}

                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

                    index = Math.round(Math.random() * (arr.length - 1));
                    arr = arr.splice(index, 1);
					break;
				}
				case EptitudeLevel.ALL_ASSOCIATE_UNITS: {
					if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
						
					} else {
                        if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
					}
					break;
				}

                case EptitudeLevel.RANDOM_OPPONENT: {
                    if (iniciator.isEnemy()) {
                        arr = getChildren (playerRow);
                        arr.push(playerHero)

                    } else {
                        arr = getChildren (enemyRow);
                        arr.push(enemyHero)
                    }

                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

                    index = Math.round(Math.random() * (arr.length - 1));
                    arr = arr.splice(index, 1);
                    break;
                }
                case EptitudeLevel.RANDOM_OPPONENT_SPELL: {
                    if (iniciator.isEnemy()) {
                        arr = field.getSpellVisibleTokens(playerRow);
                        arr.push(playerHero)

                    } else {
                        arr = field.getSpellVisibleTokens(enemyRow);
                        arr.push(enemyHero)
                    }

                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

                    index = Math.round(Math.random() * (arr.length - 1));
                    arr = arr.splice(index, 1);
                    break;
                }



				case EptitudeLevel.RANDOM_OPPONENT_UNIT: {
					if (iniciator.isEnemy()) {
						arr = getChildren (playerRow);
						
					} else {
						arr = getChildren (enemyRow);
					}

                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

                    index = Math.round(Math.random() * (arr.length - 1));
                    arr = arr.splice(index, 1);
					break;
				}
				
				case EptitudeLevel.ALL_OPPONENT_UNITS: {
					if (iniciator.isEnemy()) {
						arr = getChildren (playerRow);
						
					} else {
						arr = getChildren (enemyRow);
					}

                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

					break;
				}
				
				case EptitudeLevel.ALL_ASSOCIATE: {
					if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
						arr.push (enemyHero);
						
					} else {
                        if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
						arr.push (playerHero);
					}

                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
					
					break;
				}
				
				case EptitudeLevel.ALL_OPPONENT: {
					if (iniciator.isEnemy()) {
						arr = getChildren (playerRow);
						arr.push (playerHero);
						
					} else {
						arr = getChildren (enemyRow);
						arr.push (enemyHero);
					}

                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

					break;
				}
				
				case EptitudeLevel.LEFT_NEIGHBOR: {
					if (token) {
                        if (iniciator.isEnemy()) {
                            index = enemyRow.getChildIndex (token);
                            try {
                                unit = enemyRow.getChildAt (index - 1) as Token;
                                arr.push (unit);
                            } catch (e:Error) {}


                        } else {
                            index = playerRow.getChildIndex (token);
                            try {
                                unit = playerRow.getChildAt (index - 1) as Token;
                                arr.push (unit);
                            } catch (e:Error) {}

                        }
                    }

                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

					break;
				}
				case EptitudeLevel.RIGHT_NEIGHBOR: {
					if (token) {
                        if (iniciator.isEnemy()) {
                            index = enemyRow.getChildIndex (token);
                            try {
                                unit = enemyRow.getChildAt (index + 1) as Token;
                                arr.push (unit);
                            } catch (e:Error) { }
                        } else {
                            index = playerRow.getChildIndex (token);
                            try {
                                unit = playerRow.getChildAt (index + 1) as Token;
                                arr.push (unit);
                            } catch (e:Error) {}

                        }
                    }
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
    				break;
				}
				
				case EptitudeLevel.NEIGHBORS: {
                    if (token) {
                        if (iniciator.isEnemy()) {
                            index = enemyRow.getChildIndex (token);
                            try {
                                unit = enemyRow.getChildAt (index + 1) as Token;
                                arr.push (unit);
                            } catch (e:Error) { }
                            try {
                                unit = enemyRow.getChildAt (index - 1) as Token;
                                arr.push (unit);
                            } catch (e:Error) {}


                        } else {
                            index = playerRow.getChildIndex (token);
                            try {
                                unit = playerRow.getChildAt (index + 1) as Token;
                                arr.push (unit);
                            } catch (e:Error) { }
                            try {
                                unit = playerRow.getChildAt (index - 1) as Token;
                                arr.push (unit);
                            } catch (e:Error) {}
                        }
                    }
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
    				break;
				}
				
				case EptitudeLevel.ALL: {
                    //Logger.log('all')

                    if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
						arr = arr.concat (getChildren(playerRow));
					} else {
                        if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
						arr = arr.concat (getChildren(enemyRow));
					}
					arr.push (enemyHero);
					arr.push (playerHero);
                    //Logger.log(arr.length.toString())
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
					break;
				}

                case EptitudeLevel.ALL_UNIT: {
					if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
						arr = arr.concat (getChildren(playerRow));
					} else {
                        if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
						arr = arr.concat (getChildren(enemyRow));
					}
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
					break;
				}

                case EptitudeLevel.EXTRA_ALL_UNITS: {
                    arr = getChildren(playerRow, false);
                    arr = arr.concat(getChildren(enemyRow, false))
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
                    break;
                }
				case EptitudeLevel.RANDOM_ALL: {
					if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
						arr = arr.concat (getChildren(playerRow));
					} else {
                        if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
						arr = arr.concat (getChildren(enemyRow));
					}
					arr.push (enemyHero);
					arr.push (playerHero);
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

                    index = Math.round(Math.random() * (arr.length - 1));
                    arr = arr.splice(index, 1);
					break;
				}
                case EptitudeLevel.RANDOM_ALL_SPELL: {
                    if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getSpellVisibleChildrenEcxeptIniciator (enemyRow, token);
                        } else {
                            arr = field.getSpellVisibleTokens (enemyRow)
                        }
                        arr = arr.concat (getChildren(playerRow));
                    } else {
                        if (token) {
                            arr = getSpellVisibleChildrenEcxeptIniciator (playerRow, token);
                        } else {
                            arr = field.getSpellVisibleTokens (playerRow)
                        }
                        arr = arr.concat (getChildren(enemyRow));
                    }
                    arr.push (enemyHero);
                    arr.push (playerHero);
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }

                    index = Math.round(Math.random() * (arr.length - 1));
                    arr = arr.splice(index, 1);
                    break;
                }
				case EptitudeLevel.RANDOM_ALL_UNIT: {
                    if (iniciator.isEnemy()) {

                        if (token) {
                            arr = getChildrenExceptIniciator (enemyRow, token);
                        } else {
                            arr = getChildren (enemyRow)
                        }
						arr = arr.concat (getChildren(playerRow));
					} else {
                        if (token) {
                            arr = getChildrenExceptIniciator (playerRow, token);
                        } else {
                            arr = getChildren (playerRow)
                        }
						arr = arr.concat (getChildren(enemyRow));
					}
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
                    index = Math.round(Math.random() * (arr.length - 1));
                    arr = arr.splice(index, 1);
					break;
				}

                case EptitudeLevel.ALL_ASSOCIATE_UNIT_RACE: {
                    if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getRaceChildrenExceptIniciator (enemyRow, token, eptitude.getRace());
                        } else {
                            arr = getRaceChildren(enemyRow, eptitude.getRace())
                        }
                    } else {
                        if (token) {
                            arr = getRaceChildrenExceptIniciator (playerRow, token, eptitude.getRace());
                        } else {
                            arr = getRaceChildren(playerRow, eptitude.getRace())
                        }
                    }
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
                    break;
                }
                case EptitudeLevel.ALL_OPPONENT_UNIT_RACE: {
                    if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getRaceChildrenExceptIniciator (playerRow, token, eptitude.getRace());
                        } else {
                            arr = getRaceChildren(playerRow, eptitude.getRace())
                        }
                    } else {
                        if (token) {
                            arr = getRaceChildrenExceptIniciator (enemyRow, token, eptitude.getRace());
                        } else {
                            arr = getRaceChildren(enemyRow, eptitude.getRace())
                        }
                    }
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
                    break;
                }
                case EptitudeLevel.ALL_UNIT_RACE: {
                    if (iniciator.isEnemy()) {
                        if (token) {
                            arr = getRaceChildrenExceptIniciator (enemyRow, token, eptitude.getRace());
                        } else {
                            arr = getRaceChildren(enemyRow, eptitude.getRace())
                        }
                        arr = arr.concat(getRaceChildren(playerRow, eptitude.getRace(), false))
                    } else {
                        if (token) {
                            arr = getRaceChildrenExceptIniciator (playerRow, token, eptitude.getRace());
                        } else {
                            arr = getRaceChildren(playerRow, eptitude.getRace())
                        }
                        arr = arr.concat(getRaceChildren(enemyRow, eptitude.getRace(), false))
                    }
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
                    break;
                }
                case EptitudeLevel.ASSOCIATE_HERO: {
                    if (iniciator.isEnemy()) {
                        arr.push(enemyHero);
                    } else {
                        arr.push(playerHero);
                    }

                    break;
                }
                case EptitudeLevel.OPPONENT_HERO: {
                    if (iniciator.isEnemy()) {
                        arr.push(playerHero);
                    } else {
                        arr.push(enemyHero);
                    }
                    break;
                }

                case EptitudeLevel.LAST_PLACED: {
                    arr.push(field.getLastPlaced())
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
                    break;
                }

                case EptitudeLevel.LAST_PLACED_RACE: {
                    var token:Token = field.getLastPlacedRace(eptitude.getRace())
                    if (token != null) {
                        arr.push(token)
                    }
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
                    break;
                }
                case EptitudeLevel.LAST_PLACED_ASSOCIATE: {
                    var token:Token = field.getLastPlaced()
                    if (token.isEnemy() && iniciator.isEnemy()) {
                        arr.push(token)
                    }
                    if (!token.isEnemy() && !iniciator.isEnemy()) {
                        arr.push(token)
                    }
                    if (eptitude.getCondition()) {
                        conditionController = new ConditionController();
                        conditionController.setField(field)
                        arr = conditionController.checkCondition (iniciator, arr, eptitude);
                    }
                    break;
                }

                case EptitudeLevel.LAST_ATTACKED: {
                    if (field.getLastAttacked()) {
                        arr.push(field.getLastAttacked())
                    }
                    break;
                }
                case EptitudeLevel.LAST_ATTACKED_UNIT: {
                    if (field.getLastAttackedUnit()) {
                        arr.push(field.getLastAttackedUnit())
                    }
                    break;
                }
			}

			
			return arr;
		}
		
		private function getChildren (row:UnitRow, shadow:Boolean = true) :Array {
			var arr:Array = []
			var token:Token
			for (var i:int = 0; i < row.numChildren; i++) {
				token = row.getChildAt(i) as Token;
				if (shadow) {
					if (!token.inShadow()) {
						arr.push (token);
					}
				} else {
					arr.push (token);
				}
			}
			return arr;
		}

        private function getRaceChildren (row:UnitRow, raceId:int, shadow:Boolean = true) :Array {
            var arr:Array = []
            var token:Token
            for (var i:int = 0; i < row.numChildren; i++) {
                token = row.getChildAt(i) as Token;
                if (token.getRace() != raceId) {
                    continue;
                }
                if (shadow) {
                    if (!token.inShadow()) {
                        arr.push (token);
                    }
                } else {
                    arr.push (token);
                }

            }
            return arr;
        }
		
		private function getChildrenExceptIniciator (row:UnitRow, iniciator:Token, shadow:Boolean = true) :Array {
			//Logger.log('getChildrenExceptIniciator')
            var arr:Array = []
			var index:int = -1;

            if (row.contains(iniciator)) {
                index = row.getChildIndex (iniciator);
            }
            //Logger.log(index.toString())
            var token:Token
			for (var i:int = 0; i < row.numChildren; i++) {
				if (i == index) {
					continue; 
				}
				token = row.getChildAt(i) as Token;
				if (shadow) {
					if (!token.inShadow()) {
						arr.push (token);
					}
				} else {
					arr.push (token);
				}
			}
			//Logger.log(arr.length.toString())
            return arr;
		}

        private function getSpellVisibleChildrenEcxeptIniciator (row:UnitRow, iniciator:Token, shadow:Boolean = true) :Array {
            var arr:Array = []
            var index:int = row.getChildIndex (iniciator);
            var token:Token
            for (var i:int = 0; i < row.numChildren; i++) {
                if (i == index) {
                    continue;
                }
                token = row.getChildAt(i) as Token;
                if (shadow) {
                    if (!token.inShadow() && !token.isSpellInvisible()) {
                        arr.push (token);
                    }
                } else {
                    if (!token.isSpellInvisible()) {
                        arr.push (token);
                   }
                }
            }
            return arr;
        }



        private function getRaceChildrenExceptIniciator (row:UnitRow, iniciator:Token, raceId:int) :Array {
            var arr:Array = [];
            var index:int = row.getChildIndex (iniciator);
            var token:Token
            for (var i:int = 0; i < row.numChildren; i++) {
                if (i == index) {
                    continue;
                }
                token = row.getChildAt(i) as Token;
                if (token.getRace() == raceId) {
                    arr.push(token)
                }
            }
            return arr;
        }
	}

}