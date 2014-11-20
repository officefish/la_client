package com.ps.field.controller 
{
	import com.greensock.easing.Expo;
	import com.greensock.TimelineLite;
import com.log.Logger;
import com.ps.cards.Card;
	import com.ps.cards.CardData;
	import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeAttachment;
import com.ps.cards.eptitude.IEptitudeActivator;
import com.ps.cards.sale.CardSale;
import com.ps.cards.sale.CardSaleLevel;
import com.ps.collection.CardsCache;
	import com.ps.collodion.PlayerCollodion;
	import com.ps.collodion.EnemyCollodion;
	import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.collodion.ICollodion;
import com.ps.cards.PickCardLevel;
	import com.ps.collection.Collection;
	import com.ps.field.Field;
import com.ps.field.IAttackAvailable;
import com.ps.field.UnitRow;
import com.ps.hero.Hero;
import com.ps.tokens.EptitudeActivator;
import com.ps.tokens.Token;
	import com.ps.tokens.TokenEvent;
	import com.ps.trajectory.TrajectoryContainer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class CardController extends EventDispatcher
	{
		
		private static var instance:CardController;
		
		private var iniciator:Token;
		private var eptitude:CardEptitude;
		
		private var enemyCollodion:EnemyCollodion;
		private var enemyCollection:Collection;
		
		private var playerCollodion:PlayerCollodion;
		private var playerCollection:Collection;
		
		private var eptitudePower:int;
		private var reservePower:int;
		
		private var field:Field;
		private var actualCardData:CardData;
		private var actualCard:Card;
		
		private var newUnitIniciator:Token;
		private var tokens:Array;
		private var actualToken:Token;
		
		public static const PICK_CARD_COMPLETE:String = 'pickCardComplete';
		public static const PLACE_CARD_COMPLETE:String = 'placeCardComplete';
		
		private static const NEW_UNIT_EPTITUDE:int = 0;
		private static const PLACE_CARD:int = 1;
		
		private var type:int;

        private var activator:IEptitudeActivator;
        private var playerFlag:Boolean = false;

        private var uid:int;

        private var subcontroller:CardSubController;

        private var spellIniciator:IAttackAvailable;

		public function CardController() 
		{
			this.uid = Math.round(Math.random() * 10000)
		}
		
		public static function getInstance () :CardController {
			if (instance == null) {
				instance = new CardController ();
			}
			return instance;
		}
		
		public function setField (field:Field) :void {
			this.field = field;
		}
		
		public function pickCard (eptitude:CardEptitude, iniciator:Token, activator:IEptitudeActivator) :void {
						
			eptitudePower = eptitude.getPower ();
			this.iniciator = iniciator;
            this.activator = activator;

            var level:int = eptitude.getAttachment()
			
			switch (level) {
				case EptitudeAttachment.ASSOCIATE: {
					if (iniciator.isEnemy()) {
						enemyCollodion.addEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onEnemyPlaceCard);
						enemyCollodion.addCard (enemyCollection.getRandomCard());
					} else {
						playerCollodion.addEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onPlayerPlaceCard);
						playerCollodion.addCard (playerCollection.getRandomCard());
					}
					break;
				}
				case EptitudeAttachment.OPPONENT: {
					if (iniciator.isEnemy()) {
						playerCollodion.addEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onPlayerPlaceCard);
						playerCollodion.addCard (playerCollection.getRandomCard());
					} else {
						enemyCollodion.addEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onEnemyPlaceCard);
						enemyCollodion.addCard (enemyCollection.getRandomCard());
					}
					break;
				}
				case EptitudeAttachment.ALL: {
					reservePower = eptitudePower;
					playerCollodion.addEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onAllPlayerPlaceCard);
					enemyCollodion.addEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onAllEnemyPlaceCard);
					playerCollodion.addCard (playerCollection.getRandomCard());
				}
			}
			
		}
		
		private function onPlayerPlaceCard (event:Event) :void {
			eptitudePower --;
			
			if (eptitudePower <= 0) {
				playerCollodion.removeEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onPlayerPlaceCard);
                if (iniciator.isEnemy()) {
                    playerCollodion.glowAvailableCards();
                }
                activator.continueActivate();

			} else {
				playerCollodion.addCard (playerCollection.getRandomCard());
			}
		}
		
		private function onAllPlayerPlaceCard (event:Event) :void {
			eptitudePower --;
			
			if (eptitudePower <= 0) {
				playerCollodion.removeEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onAllPlayerPlaceCard);
				enemyCollodion.addCard (enemyCollection.getRandomCard());

			
			} else {
				playerCollodion.addCard (playerCollection.getRandomCard());
			}
		}
		
		private function onEnemyPlaceCard (event:Event) :void {
			eptitudePower --;
			
			if (eptitudePower <= 0) {
				enemyCollodion.removeEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onEnemyPlaceCard);
                if (iniciator.isEnemy()) {
                    playerCollodion.glowAvailableCards();
                }
                activator.continueActivate();

			} else {
				enemyCollodion.addCard (enemyCollection.getRandomCard());
			}
		}
		
		private function onAllEnemyPlaceCard (event:Event) :void {
			reservePower --;
			
			if (reservePower <= 0) {
				enemyCollodion.removeEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onAllEnemyPlaceCard); 
				completePickCard ();
			} else {
				enemyCollodion.addCard (enemyCollection.getRandomCard());
			}
		}
		
		private function completePickCard () :void {
			if (eptitudePower <= 0 && reservePower <= 0) {
                activator.continueActivate();
                dispatchEvent (new Event (PICK_CARD_COMPLETE));
			}
		}
		
		public function setEnemyCollodion (enemyCollodion:EnemyCollodion) :void {
			this.enemyCollodion = enemyCollodion;
		}
		
		public function setEnemyCollecton (collection:Collection) :void {
			this.enemyCollection = collection;
		}
		
		public function setPlayerCollodion (playerCollodion:PlayerCollodion) :void {
			this.playerCollodion = playerCollodion;
		}
		
		public function setPlayerCollection (collection:Collection) :void {
			this.playerCollection = collection;
		}
		
		public function placeNewUnit (iniciator:Token, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
			
			this.type = NEW_UNIT_EPTITUDE;
			
			newUnitIniciator = iniciator;
            this.activator = activator;
			
			var eptitude:CardEptitude = eptitude;
			var newUnitId:int = eptitude.getUnitId ();
			eptitudePower = eptitude.getPower ();
			actualCardData = CardsCache.getInstance().getCardById (newUnitId);
			//trace (cardData);
			placeToken (actualCardData);
		}
		
		private function placeToken (cardData:CardData) :void { 
			//Logger.log('placeToken')

            var card:Card = new Card (cardData);
			actualCard = card;
			
			var token:Token = new Token (card, newUnitIniciator.isEnemy());
			var index:int
			
			var playerRow:UnitRow = field.getPlayerRow ();
			var enemyRow:UnitRow = field.getEnemyRow ();

            actualToken = token;
            field.setLastPlaced(actualToken)
						
			if (newUnitIniciator.isEnemy()) {
				if (field.getVisibleTokens(enemyRow).length >= 7) {

					if (activator) {
                        activator.continueActivate()
                    } else {
                        newUnitIniciator.completeConfigure();
                    }
					return;
				}
				
				if (enemyRow.contains(newUnitIniciator)) {
					token.x = newUnitIniciator.x + Token.WIDTH + UnitRow.PADDING;
                    if (newUnitIniciator.visible) {
                        enemyRow.addChildAt (token, enemyRow.getChildIndex(newUnitIniciator) + 1);
                    } else {
                        enemyRow.addChildAt (token, enemyRow.getChildIndex(newUnitIniciator));
                    }
				} else {
					enemyRow.addChild (token);
				}
							
				field.sortUnitRow (enemyRow, 0, false) ;
				token.activateEptitudes (EptitudePeriod.SELF_PLACED, tokenPlaceComplete);

				
			} else {
				if (field.getVisibleTokens(playerRow).length >= 7) {

                    if (activator) {
                        activator.continueActivate()
                    } else {
                        newUnitIniciator.completeConfigure();
                    }
                    return;
				}
				
				if (playerRow.contains(newUnitIniciator)) {
					token.x = newUnitIniciator.x + Token.WIDTH + UnitRow.PADDING;
                    if (newUnitIniciator.visible) {
                        playerRow.addChildAt (token, playerRow.getChildIndex(newUnitIniciator) + 1);
                    } else {
                        playerRow.addChildAt (token, playerRow.getChildIndex(newUnitIniciator));
                    }
				} else {
					playerRow.addChild(token);
				}
				
				field.sortUnitRow (playerRow, 0, false);
				token.activateEptitudes (EptitudePeriod.SELF_PLACED, tokenPlaceComplete);

				
			}
		}

        private function tokenPlaceComplete () :void {
            //Logger.log('tokenPlaceComplete')
            var playerRow:UnitRow = field.getPlayerRow ();
            var enemyRow:UnitRow = field.getEnemyRow ();
            if (actualToken.isEnemy()) {
                field.centerizeRow (enemyRow, onPlaceNewUnitComplete);
            } else {
                field.centerizeRow (playerRow, onPlaceNewUnitComplete);
            }
        }

		
		private function onPlaceNewUnitComplete () :void {
			initAssociate ();
		}

        private function initAssociate () :void {
            subcontroller = new CardSubController();
            subcontroller.setField(field);
            subcontroller.activatePlaceToken(newUnitIniciator, endActivate)
		}

		private function endActivate () :void {
			destroySubcontroller()

            switch (type) {
				case NEW_UNIT_EPTITUDE: {
					eptitudePower --;
			
					if (eptitudePower == 0) {
						activator.continueActivate()
                        break;
					} else {
						placeToken (actualCardData);
					}
		    		break;
				}
				case PLACE_CARD: {
					//Logger.log('place card comlete')
                    dispatchEvent (new Event (CardController.PLACE_CARD_COMPLETE));
					break;
				}
			}
		}
		
		
		public function placeCard (card:Card, tokenPreviewIndex:int) :void {
            type = PLACE_CARD;

            if (card.getType() == CardData.SPELL) {
                playSpell (card, true);
                return;
            }
			
			var playerRow:UnitRow = field.getPlayerRow ();
			
			var token:Token = new Token (card);
			
			newUnitIniciator = token;

			var mirrow:Sprite = card.getMirrow (); 
			TrajectoryContainer.getInstance().addToPlaceCardLevel (mirrow);
			
			actualToken = token;
			actualToken.alpha = 0;

			var tokenPosition:Point;
			
			if (playerRow.numChildren) {
				playerRow.addChildAt (token, tokenPreviewIndex);
				tokenPosition = field.sortUnitRow (playerRow, tokenPreviewIndex);
			} else {
				playerRow.addChild(token);
				tokenPosition = new Point (0, 0);
			}
			var rowPosition:Point = field.centerizeRow (playerRow);
								
			var mirrowPosition:Point = new Point (tokenPosition.x + rowPosition.x, tokenPosition.y + rowPosition.y);
			var endY:int = mirrowPosition.y;
			
			mirrowPosition.x -= (Card.MIRROW_WIDTH - Token.WIDTH) / 2;
			mirrowPosition.y -= (Card.MIRROW_HEIGHT - Token.HEIGHT) / 2;
			
			var timeline:TimelineLite = new TimelineLite ({onComplete:onPlaceComplete}); 
			timeline.to (mirrow, 0.5, { x:mirrowPosition.x, y:mirrowPosition.y, ease:Expo.easeOut, onComplete:onPlaceContinue } );
			timeline.to (mirrow, 0.5, { y:endY, alpha:0, ease:Expo.easeOut});
		}

        private function playSpell (card:Card, playerFlag:Boolean) :void {
            this.playerFlag = playerFlag;
            var hero:Hero;
            if (playerFlag) {
               hero = field.getPlayerHero();
            } else {
                hero = field.getEnemyHero();
            }
            spellIniciator = hero;
            hero.activateSpell (card.getCardData().getEptitudes(), onSpellPlayComplete);
        }

        private function onSpellPlayComplete () :void {
            activateSpell()
        }

        private function activateSpell () :void {
            subcontroller = new CardSubController();
            subcontroller.setField(field)
            subcontroller.activateSpell(spellIniciator, onSpellActivationComplete)
        }
        private function onSpellActivationComplete () :void {
            destroySubcontroller()
            subcontroller = new CardSubController();
            subcontroller.setField(field)
            subcontroller.activatePlayCard(spellIniciator, onPlayCardSpellSubCtrl)
        }
        private function onPlayCardSpellSubCtrl () :void {
            endActivate ()
        }
        private function destroySubcontroller () :void {
            if (subcontroller) {
                subcontroller.destroy()
                subcontroller = null;
            }
        }
		
		private function onPlaceContinue () :void {
			actualToken.alpha = 1.0;
		}
		
		private function onPlaceComplete () :void {
            TrajectoryContainer.getInstance().endPlaceCard();
			actualToken.activateEptitudes  (EptitudePeriod.SELF_PLACED, onTokenActivationComplete);
		}
		
		private function onTokenActivationComplete () :void {
            field.setLastPlaced(actualToken)
            subcontroller = new CardSubController();
            subcontroller.setField(field)
            subcontroller.activatePlayCard(actualToken, onPlayCardTokenSubCtrl)
            //endActivate ()
		}

        private function onPlayCardTokenSubCtrl () :void {
            destroySubcontroller();
            initAssociate ();
        }
		
		public function placeEnemyCard (card:Card) :void {

            //Logger.log ('placeEnemyCard')
            type = PLACE_CARD;

            if (card.getType() == CardData.SPELL) {
                playSpell (card, false);
                return;
            }
			
			var token:Token = new Token (card, true);
			card.visible = true;

			var enemyRow:UnitRow = field.getEnemyRow ();
						
			var mirrow:Sprite = card.getShirt ();
			TrajectoryContainer.getInstance().addToPlaceCardLevel (mirrow);
			
			var mirrowStartPosition:Point = new Point (card.x, card.y);
			mirrowStartPosition = card.parent.localToGlobal (mirrowStartPosition);
			mirrow.x = mirrowStartPosition.x;
			mirrow.y = mirrowStartPosition.y;
			
			mirrow.scaleX = mirrow.scaleY = 0.72;
			
			actualToken = token;
			actualToken.alpha = 0;
            field.setLastPlaced(actualToken)

			var tokenPosition:Point;
			
			newUnitIniciator = actualToken;
			
			enemyRow.addChild (token);
			tokenPosition = field.sortUnitRow (enemyRow, enemyRow.getChildIndex(token)); 
			var rowPosition:Point =field.centerizeRow (enemyRow);
								
			var mirrowPosition:Point = new Point (tokenPosition.x + rowPosition.x, tokenPosition.y + rowPosition.y);
			var endY:int = mirrowPosition.y;
			
			mirrowPosition.x -= (Card.MIRROW_WIDTH - Token.WIDTH) / 2;
			mirrowPosition.y -= (Card.MIRROW_HEIGHT - Token.HEIGHT) / 2;
					
			var timeline:TimelineLite = new TimelineLite ( { onComplete:onPlaceComplete } );
			timeline.to (mirrow, 0.5, { x:mirrowPosition.x, y:mirrowPosition.y, scaleX:1.0, scaleY:1.0, ease:Expo.easeOut, onComplete:onPlaceContinue } );
			timeline.to (mirrow, 0.5, { y:endY, alpha:0, ease:Expo.easeOut});
		}
		

        private function onEnemyPlaceComplete () :void {
            field.setLastPlaced(actualToken)
			TrajectoryContainer.getInstance().endPlaceCard()
			activator = actualToken.activateEptitudes(EptitudePeriod.SELF_PLACED, onTokenActivationComplete);
		}

        public function sale (iniciator:Token, eptitude:CardEptitude, activator:IEptitudeActivator) :void {

            this.iniciator = iniciator;
            this.activator = activator;

            var cardSale:CardSale = eptitude.getSale();
            var collodions:Array = getCollodions (iniciator, eptitude.getAttachment());
            var collodion:ICollodion;

            for (var i:int = 0; i < collodions.length; i ++) {
                collodion = collodions[i];
                collodion.addSale (cardSale);
                if (collodion is PlayerCollodion) {
                    (collodion as PlayerCollodion).glowAvailableCards();
                }
            }

            activator.continueActivate()


        }

        private function getCollodions (iniciator:Token, level:int) :Array {
            var arr:Array = [];
            switch (level) {
                case EptitudeAttachment.ASSOCIATE: {
                    if (iniciator.isEnemy()) {
                        arr.push(enemyCollodion)
                    } else {
                        arr.push(playerCollodion);
                    }
                    break;
                }
                case EptitudeAttachment.OPPONENT: {
                    if (iniciator.isEnemy()) {
                        arr.push(playerCollodion);
                    } else {
                        arr.push(enemyCollodion);
                    }
                    break;
                }
                case EptitudeAttachment.ALL: {
                    arr.push(playerCollodion);
                    arr = arr.concat(enemyCollodion)
                }
            }
            return arr;
        }

        private function getHeroes (iniciator:Token, level:int) :Array {
            var arr:Array = [];
            switch (level) {
                case EptitudeAttachment.ASSOCIATE: {
                    if (iniciator.isEnemy()) {
                        arr.push(field.getEnemyHero())
                    } else {
                        arr.push(field.getPlayerHero());
                    }
                    break;
                }
                case EptitudeAttachment.OPPONENT: {
                    if (iniciator.isEnemy()) {
                        arr.push(field.getPlayerHero());
                    } else {
                        arr.push(field.getEnemyHero());
                    }
                    break;
                }
                case EptitudeAttachment.ALL: {
                    arr.push(field.getPlayerHero());
                    arr = arr.concat(field.getEnemyHero())
                }
            }
            return arr;
        }

        public function increaseSpell (iniciator:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
            this.iniciator = iniciator as Token;
            this.activator = activator;
            var heroes:Array = getHeroes (iniciator as Token, eptitude.getAttachment());
            var hero:Hero;
            for (var i:int = 0; i < heroes.length; i ++) {
                hero = heroes[i];
                hero.increaseSpell(eptitude.getPower())
            }

            activator.continueActivate()


        }

        public function decreaseSpell (iniciator:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
            this.iniciator = iniciator as Token;
            this.activator = activator;
            var heroes:Array = getHeroes (iniciator as Token, eptitude.getAttachment());
            var hero:Hero;
            for (var i:int = 0; i < heroes.length; i ++) {
                hero = heroes[i];
                hero.degreaseSpell(eptitude.getPower())
            }

            activator.continueActivate()

        }



		
		
		
		
		
	}

}