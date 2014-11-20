package com.ps.game 
{
import com.la.mvc.view.IGame;
import com.log.Logger;
import com.ps.cards.CardData;
import com.ps.collodion.CollodionEvent;
	import com.ps.collodion.EnemyCollodion;
	import com.ps.cards.eptitude.EptitudePeriod;
	import com.ps.collection.Collection;
	import com.ps.field.ActivationEvent;
	import com.ps.field.controller.AttackController;
	import com.ps.field.controller.CardController;
	import com.ps.field.FieldEvent;
	import com.ps.ii.II;
	import com.ps.ii.IIEvent;
import com.ps.popup.Popup;

import flash.display.Sprite;
	import com.ps.field.Field
	import com.ps.collodion.PlayerCollodion;
	import flash.events.Event;
import flash.events.MouseEvent;

/**
	 * ...
	 * @author 
	 */
	public class Game extends Sprite implements IGame
	{
		private var field:Field;
		private var collodion:PlayerCollodion;
		private var _ii:II;
		
		private var playerCollection:Collection;
		private var enemyCollection:Collection;
		
		private var playerPrice:int;
		private var enemyPrice:int;
		
		private var enemyCollodion:EnemyCollodion;
		
		public function Game()
		{
			field = new Field ();
			field.addEventListener (FieldEvent.END_STEP, onFieldNavClick);
			field.addEventListener (FieldEvent.ENEMY_CARD_PLAY, onEnemyCardPlay);
			field.addEventListener (ActivationEvent.ACTIVATION_COMPLETE, onActivationComplete);
            field.addEventListener(AttackController.PLAYER_WIN, onPlayerWin);
            field.addEventListener(AttackController.ENEMY_WIN, onEnemyWin);

			field.y = 50;
			addChild (field);
			field.setPlayerCollodion (collodion);
			field.setEnemyCollodion (enemyCollodion);

			_ii = new II ();
			_ii.addEventListener (IIEvent.END_SCENARIO, onIIEndScenario);
			_ii.addEventListener (IIEvent.END_PLACE_CARDS, onIIEndPlaceCards);
			_ii.addEventListener (IIEvent.PLAY_CARD, onIICardPlay);
			_ii.addEventListener (IIEvent.END_UNIT_ATTACK, onIIEndUnitAttack);
		}

        public function resize (stageWidth:int, stageHeight:int) :void {

            collodion = new PlayerCollodion (stageWidth, stageHeight);
            collodion.addEventListener (CollodionEvent.CARD_PLAY, onCardPlay);
            collodion.setField (field);
            addChild (collodion);

            enemyCollodion = new EnemyCollodion (stageWidth, stageHeight);
            enemyCollodion.setField (field);
            addChild (enemyCollodion);
        }

        private function onPlayerWin (event:Event) :void {
            Popup.getInstance().warning ('Прими мои поздравления! Ты победил!');
            stage.addEventListener (MouseEvent.CLICK, onStageClick);
        }
        private function onEnemyWin (event:Event):void {
            Popup.getInstance().warning ('Увы, ты проиграл.');
            stage.addEventListener (MouseEvent.CLICK, onStageClick);
        }
        private function onStageClick (event:MouseEvent) :void {
            stage.removeEventListener (MouseEvent.CLICK, onStageClick);
            _ii.stop ();
            dispatchEvent (new GameEvent (GameEvent.END_GAME));
        }


        private function onCardPlay (event:CollodionEvent) :void {
			var actualPrice:int = collodion.getCardPrice ();
			var cardPrice:int = event.getPrice();
			actualPrice -= cardPrice;
			field.setPlayerPrice (actualPrice);
			collodion.setCardPrice (actualPrice);
			collodion.glowAvailableCards ();
		}

        public function startup (collection:Vector.<CardData>) :void {

            var list:Array = []
            for (var i:int = 0; i < collection.length; i ++) {
                list.push(collection[i]);
            }

            this.playerCollection = new Collection ();
            this.playerCollection.setCollection (list); //generateCollection (35);
            field.setPlayerCollection (this.playerCollection);

            enemyCollection = new Collection ();
            enemyCollection.generateEnemyCollection (35);
            field.setEnemyCollection (enemyCollection);

            playerPrice = 1;
            enemyPrice = 0;

            field.setPlayerPrice (playerPrice);
            collodion.setCardPrice (playerPrice);
            collodion.addCard (playerCollection.getRandomCard ());
            collodion.glowAvailableCards ();

        }
		
		private function onIICardPlay (event:IIEvent) :void {
			
			/*
			field.addEnemyToken (event.getCardData());
			enemyCollodion.removeCard (event.getCardData());
			*/
			var newPrice:int = enemyCollodion.getCardPrice() - event.getCard().getPrice();
			enemyCollodion.setCardPrice (newPrice);
            enemyCollodion.checkRemoveSale (event.getCard().getType());
            _ii.setPrice (enemyCollodion.getCardPrice());
			
			enemyCollodion.playCard (event.getCard());
		}
		
		private function onEnemyCardPlay (event:FieldEvent) :void {
			_ii.setRowNumChildren (field.getEnemyRowNumChildren());
			_ii.checkCards ();
		}
		
		private function onIIEndUnitAttack (event:IIEvent) :void {
			_ii.setPlayerProvocators (field.getPlayerProvocators());
			_ii.playScenario ();
		}

		private function onIIEndPlaceCards (event:IIEvent) :void {
			var enemyUnits:Array = field.getEnemyUnits (false);
			_ii.configureUnits (enemyUnits);
						
			_ii.setPlayerProvocators (field.getPlayerProvocators());
			_ii.playScenario ();
		}
		
		private function onIIEndScenario (event:IIEvent) :void {
			field.activateEnemy (EptitudePeriod.END_STEP);
		}
		
		private function onGameEnd (event:Event) :void {

		}
		
		private function onFieldNavClick (event:FieldEvent) :void {
			field.activatePlayer (EptitudePeriod.END_STEP);
		}
		
		
		private function onActivationComplete (event:ActivationEvent) :void {
			
			var period:int = event.getPeriod();
			var player:Boolean = event.isPlayer();
			if (player) {
				finishPlayerActivation (period);
			} else {
				finishEnemyActivation (period);
			}
		}
		
		private function finishPlayerActivation (period:int) :void {
			
			switch (period) {
				case EptitudePeriod.START_STEP: {
					field.setPlayerStep (true);
					collodion.glowAvailableCards ();
					break;
				}
				case EptitudePeriod.END_STEP: {
					field.deactivatePlayer ();
					field.enemyUnitsCanAttack ();
					collodion.stopGlowCards ();
					enemyCollodion.addEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onEnemyPlaceCard);
					enemyCollodion.addCard (enemyCollection.getRandomCard());
					
					break;
				}
			}
		}
		
		private function onEnemyPlaceCard (event:Event) :void {
			
			enemyCollodion.removeEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onEnemyPlaceCard);
			
			if (enemyPrice < 10) {
						enemyPrice ++;
					}
			enemyCollodion.setCardPrice (enemyPrice);
            enemyCollodion.checkSale();
					
			field.activateEnemy (EptitudePeriod.START_STEP);
		}
		
		private function finishEnemyActivation (period:int) :void {
			switch (period) {
				case EptitudePeriod.START_STEP: {
					_ii.setPrice (enemyCollodion.getCardPrice());
					_ii.setRowNumChildren (field.getEnemyRowNumChildren());
					_ii.placeCards (enemyCollodion.getCards());
					break;
				}
				case EptitudePeriod.END_STEP: {
					collodion.addEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onPlayerPlaceCard);
					collodion.addCard (playerCollection.getRandomCard ());
					break;
				}
			}
		}
		
		private function onPlayerPlaceCard (event:Event) :void {

			collodion.removeEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onPlayerPlaceCard);

			field.playerUnitsCanAttack ();
			
			if (playerPrice < 10) {
				playerPrice ++;
			}
			field.setPlayerPrice (playerPrice);
			collodion.setCardPrice (playerPrice);
            collodion.checkSale();
			
			field.activatePlayer (EptitudePeriod.START_STEP);
		}
		
		public function destroy () :void {
			field.destroy ();
		}
		
	}

}