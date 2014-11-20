package com.ps.field 
{
	import com.greensock.easing.Expo;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
import com.log.Logger;
import com.ps.cards.Card;
	import com.ps.cards.CardData;
	import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeAttachment;
import com.ps.collection.CardsCache;
	import com.ps.collodion.PlayerCollodion;
	import com.ps.collodion.EnemyCollodion;
	import com.ps.cards.eptitude.EptitudeEvent;
	import com.ps.cards.eptitude.EptitudeLevel;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.eptitude.EptitudePeriod;
	import com.ps.collection.Collection;
import com.ps.field.controller.AttackController;
import com.ps.field.controller.AttackController;
import com.ps.field.controller.CardController;
import com.ps.field.controller.CollodionController;
import com.ps.field.controller.EnticeController;
import com.ps.field.controller.EptitudeController;
import com.ps.field.controller.FieldController;
import com.ps.field.controller.TreatController;
import com.ps.hero.Hero;
	import com.ps.popup.Popup;
import com.ps.tokens.Token;
	import com.ps.tokens.TokenEvent;
	import com.ps.trajectory.TrajectoryContainer;
	import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class Field extends Sprite implements IPlaceAvailable
	{
		private var nav:EndStepNav;
		private var playerRow:UnitRow;
		private var enemyRow:UnitRow;
		private var tokenPreviewIndex:int;
		
		private var attackUnit:Token;
		private var targetUnit:IAttackAvailable;
		
		private var enemyHero:Hero;
		private var playerHero:Hero;
		
		private var playerStep:Boolean = true;
		
		private var playerPriceToolbar:PriceToolbar;
		
		private var activationUnits:Array;
		private var activationPeriod:int;
		private var playerActivation:Boolean;

		private var attackMode:Boolean = false;
		
		private var activateUnit:IAttackAvailable;
		
		private var playerCollodion:PlayerCollodion;
		private var enemyCollodion:EnemyCollodion;
		private var actualCard:Card;

		private var selectionMode:Boolean = false;

		private var playerCollection:Collection;
		private var enemyCollection:Collection;

        private var lastPlaced:Token;

        private var lastAttacked:IAttackAvailable;


		
		public function Field() 
		{
			graphics.beginFill (0xAAAAAA, 1);
			graphics.drawRect (0, 0, 800, 480);
			graphics.endFill();
						
			nav = new EndStepNav ();
			nav.x = this.width - 100;
			nav.y = this.height / 2 - (nav.height / 2);
			addChild (nav);
			nav.addEventListener (MouseEvent.CLICK, onNavClick);
			
			enemyHero = new Hero (50, true);
			enemyHero.x = (this.width - Hero.WIDTH) / 2;
			addChild (enemyHero);
			
			playerHero = new Hero ();
			playerHero.x = (this.width - Hero.WIDTH) / 2;
			playerHero.y = this.height - playerHero.height + 5;
			addChild (playerHero);
			
			enemyRow = new UnitRow ();
			enemyRow.y = 140;
			enemyRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH)) / 2;
			addChild(enemyRow);
			
			playerRow = new UnitRow ();
			playerRow.y = 260;
			playerRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH)) / 2;
			addChild(playerRow);
			
			playerPriceToolbar = new PriceToolbar ();
			var widget:Sprite = playerPriceToolbar.getWidget ();
			widget.x = this.width - widget.width;
			widget.y = 450;
			addChild (widget);

            this.addEventListener (EptitudeEvent.ACTIVATE, onEptitudeActivate, true);
            this.addEventListener (EptitudeEvent.SELECT, onEptitudeSelect, true);

            this.addEventListener (EptitudeEvent.PASSIVE_ATTACK, onPassiveAttack, true);
            this.addEventListener (EptitudeEvent.DEATH, onTokenDeath, true);
            this.addEventListener (EptitudeEvent.FREEZE, onTokenFreeze, true);

            this.addEventListener(EptitudeEvent.TREATMENT, onTokenTreat, true);

            this.addEventListener (EptitudeEvent.PICK_CARD, onPickCard, true);
            this.addEventListener (EptitudeEvent.BACK_CARD_TO_HAND, onBackCardToHand, true);
            this.addEventListener (EptitudeEvent.CARD_SALE, onCardSale, true);
            this.addEventListener(EptitudeEvent.INCREASE_SPELL, onIncreaseSpell, true);
            this.addEventListener(EptitudeEvent.DECREASE_SPELL, onDecreaseSpell, true);
            this.addEventListener(EptitudeEvent.NEW_SPELL, onNewSpell, true);
            this.addEventListener(EptitudeEvent.INCREASE_HEALTH_DEPENDS_ON_CARDS, onIncreaseHealthDependsOnCards, true);

            this.addEventListener(EptitudeEvent.INCREASE_ATTACK_DEPENDS_ON_TOKENS, onIncreaseAttackDependsOnTokens, true)
            this.addEventListener(EptitudeEvent.INCREASE_HEALTH_DEPENDS_ON_TOKENS, onIncreaseHealthDependsOnTokens, true)
            this.addEventListener(EptitudeEvent.INCREASE_ATTACK_DEPENDS_ON_TOKENS_RACE, onIncreaseAttackDependsOnTokensRace, true)
            this.addEventListener(EptitudeEvent.INCREASE_HEALTH_DEPENDS_ON_TOKENS_RACE, onIncreaseHealthDependsOnTokensRace, true)

            this.addEventListener (EptitudeEvent.NEW_UNIT, onNewUnit, true);
            this.addEventListener(EptitudeEvent.COPY_UNIT, onCopyUnit, true);
            this.addEventListener(EptitudeEvent.UNIT_CONVERTION, onUnitConvertion, true)

            this.addEventListener(EptitudeEvent.ENTICE_UNIT, onEnticeUnit, true);

            this.addEventListener (TokenEvent.ATTACK_UNIT, onAttackUnit, true);
            this.addEventListener (TokenEvent.ATTACK_PLAYER_HERO, onAttackPlayerHero, true);

            this.addEventListener (TokenEvent.TOKEN_MOUSE_UP, onTokenMouseUp, true);
            this.addEventListener (TokenEvent.TOKEN_MOUSE_DOWN, onTokenMouseDown, true);
            this.addEventListener (TokenEvent.TOKEN_MOUSE_OVER, onTokenMouseOver, true);
            this.addEventListener (TokenEvent.TOKEN_MOUSE_OUT, onTokenMouseOut, true);





        }



        // Обработка событий активатора способностей

        // активация
        private function onEptitudeActivate (event:EptitudeEvent) :void {
            activateUnit = event.target as IAttackAvailable;
            var eptitudeController:EptitudeController = new EptitudeController();
            eptitudeController.configure(this, playerRow, enemyRow, playerHero, enemyHero);
            eptitudeController.activateEptitude (event.getEptitude(), activateUnit, event.getActivator());
        }

        // select
        private function onEptitudeSelect (event:EptitudeEvent) :void {
            selectionMode = true;
            activateUnit = event.target as IAttackAvailable;
            var eptitudeController:EptitudeController = new EptitudeController();
            eptitudeController.configure(this, playerRow, enemyRow, playerHero, enemyHero);
            eptitudeController.selectAndActivate (event.getEptitude(), activateUnit, event.getActivator());
        }

        public function cancelSelect (iniciator:IAttackAvailable) :void {
            if (iniciator is Token) {
                var token:Token = iniciator as Token;
                var newPrice:int = playerCollodion.getCardPrice() + token.getCard().getPrice()
                playerCollodion.setCardPrice (newPrice);
                setPlayerPrice (newPrice);

                var eptitude:CardEptitude = new CardEptitude(CardEptitude.BACK_CARD_TO_HAND)
                eptitude.setAttachment(EptitudeAttachment.ASSOCIATE)

                var controller:CollodionController = new CollodionController();
                controller.setField (this);
                controller.setEnemyCollecton (enemyCollection);
                controller.setEnemyCollodion (enemyCollodion);
                controller.setPlayerCollection (playerCollection);
                controller.setPlayerCollodion (playerCollodion);
                controller.backCardToHand (iniciator, eptitude, null);


            } else if (iniciator is Hero) {
                actualCard = playerCollodion.getActualCard()
                var newPrice:int = playerCollodion.getCardPrice() + actualCard.getPrice()
                setPlayerPrice (newPrice);
                playerCollodion.setCardPrice (newPrice);
                backPlayerSpellToHand (actualCard);
            }
        }



        // TODO мутная функция
        private function onEptControllerComplete (event:Event) :void {
            selectionMode = false;
        }


        // Обработка уникальных аттак

        // заморозка
        public function onTokenFreeze (event:EptitudeEvent) :void {
            var targetUnit:IAttackAvailable = event.target as IAttackAvailable;
            var attackController:AttackController = new AttackController ();
            attackController.setField (this);
            attackController.freeze (activateUnit, targetUnit, event.getEptitude(), event.getActivator());
        }

        // убийство
        private function onTokenDeath (event:EptitudeEvent) :void {
            //Logger.log('onTokenDeath')
            var token:Token = event.target as Token;

            var attackController:AttackController = new AttackController ();
            attackController.setField (this);
            attackController.kill (attackUnit, token, event.getActivator());
        }

        // пассивная аттака (скорее всего не рабочая, работает inversePassiveAttack)
        private function onPassiveAttack (event:EptitudeEvent) :void {
            targetUnit =  event.target as IAttackAvailable;
            //Logger.log (activateUnit.getTitle());

            var attackController:AttackController = new AttackController ();
            attackController.setField (this);
            attackController.passiveAttack (activateUnit, targetUnit, event.getEptitude(), event.getActivator());
        }

        // обработка лечения
        private function onTokenTreat (event:EptitudeEvent) :void {
            var treatUnit:IAttackAvailable = event.target as IAttackAvailable;
            var treatController:TreatController = new TreatController();
            treatController.setField(this);
            treatController.threat(treatUnit, event.getActivator());
        }

        // переманивание
        private function onEnticeUnit (event:EptitudeEvent) :void {
            var controller:EnticeController = new EnticeController();
            controller.setField(this);
            controller.enticeUnit(event.target as Token, activateUnit, event.getEptitude(), event.getActivator())
        }




        // field controller

        public function placeCard (card:Card) :void {
            var controller:FieldController = new FieldController();
            controller.setField (this);
            controller.setEnemyCollodion (enemyCollodion);
            controller.setPlayerCollodion (playerCollodion);
            controller.placeCard (card, tokenPreviewIndex);
        }
        public function placeEnemyCard (card:Card) :void {
            var controller:FieldController =  new FieldController();
            controller.setField (this);
            controller.setEnemyCollodion (enemyCollodion);
            controller.setPlayerCollodion (playerCollodion);
            controller.placeEnemyCard (card);
        }
        public function onNewUnit (event:EptitudeEvent) :void {
            var iniciator:Token = event.target as Token;
            var controller:FieldController =  new FieldController();
            controller.setField (this);
            controller.setEnemyCollodion (enemyCollodion);
            controller.setPlayerCollodion (playerCollodion);
            controller.placeNewUnit (iniciator, event.getEptitude(), event.getActivator());
        }

        private function onCopyUnit (event:EptitudeEvent) :void {
            var iniciator:Token = event.target as Token;
            var controller:FieldController =  new FieldController();
            controller.setField (this);
            controller.setEnemyCollodion (enemyCollodion);
            controller.setPlayerCollodion (playerCollodion);
            controller.copyUnit (iniciator, activateUnit as Token, event.getEptitude(), event.getActivator());
        }

        private function onUnitConvertion (event:EptitudeEvent):void {
            var iniciator:Token = event.target as Token;
            var controller:FieldController =  new FieldController();
            controller.setField (this);
            controller.convert (iniciator, event.getEptitude(), event.getActivator());
        }

        private function  onIncreaseAttackDependsOnTokens (event:EptitudeEvent) :void {
            var iniciator:Token = event.target as Token;
            var controller:FieldController =  new FieldController();
            controller.setField (this);
            controller.increaseAttackDependsOnTokens (iniciator, event.getEptitude(), event.getActivator());
        }

        private function onIncreaseHealthDependsOnTokens (event:EptitudeEvent) :void {
            var iniciator:Token = event.target as Token;
            var controller:FieldController =  new FieldController();
            controller.setField (this);
            controller.increaseHealthDependsOnTokens (iniciator, event.getEptitude(), event.getActivator());
        }

        private function  onIncreaseAttackDependsOnTokensRace (event:EptitudeEvent) :void {
            var iniciator:Token = event.target as Token;
            var controller:FieldController =  new FieldController();
            controller.setField (this);
            controller.increaseAttackDependsOnTokensRace (iniciator, event.getEptitude(), event.getActivator());
        }

        private function onIncreaseHealthDependsOnTokensRace (event:EptitudeEvent) :void {
            var iniciator:Token = event.target as Token;
            var controller:FieldController =  new FieldController();
            controller.setField (this);
            controller.increaseHealthDependsOnTokensRace (iniciator, event.getEptitude(), event.getActivator());
        }



        // обработка способностей cвязанных с картами
        private function onPickCard (event:EptitudeEvent) :void {

            activateUnit = event.target as IAttackAvailable;
            var token:Token = activateUnit as Token;
            var controller:CollodionController = new CollodionController()
            controller.setField (this);
            controller.setEnemyCollecton (enemyCollection);
            controller.setEnemyCollodion (enemyCollodion);
            controller.setPlayerCollection (playerCollection);
            controller.setPlayerCollodion (playerCollodion);
            controller.pickCard(activateUnit, event.getEptitude(), event.getActivator());
        }

        private function onIncreaseSpell (event:EptitudeEvent) :void {
            activateUnit = event.target as IAttackAvailable;
            var controller:CollodionController = new CollodionController();
            controller.setField (this);
            controller.setEnemyCollecton (enemyCollection);
            controller.setEnemyCollodion (enemyCollodion);
            controller.increaseSpell(activateUnit, event.getEptitude(), event.getActivator())
        }
        private function onDecreaseSpell (event:EptitudeEvent) :void {
            activateUnit = event.target as IAttackAvailable;
            var controller:CollodionController = new CollodionController();
            controller.setField (this);
            controller.setEnemyCollecton (enemyCollection);
            controller.setEnemyCollodion (enemyCollodion);
            controller.decreaseSpell(activateUnit, event.getEptitude(), event.getActivator())
        }

        public function onCardSale (event:EptitudeEvent) :void {
            var iniciator:Token = event.target as Token;
            var controller:CollodionController = new CollodionController();
            controller.setEnemyCollodion (enemyCollodion);
            controller.setPlayerCollodion (playerCollodion);
            controller.setField (this);
            controller.sale (iniciator, event.getEptitude(), event.getActivator());
        }


        private function onBackCardToHand (event:EptitudeEvent) :void {
            //activateUnit =
            activateUnit = event.target as Token;

            var controller:CollodionController = new CollodionController();
            controller.setField (this);
            controller.setEnemyCollecton (enemyCollection);
            controller.setEnemyCollodion (enemyCollodion);
            controller.setPlayerCollection (playerCollection);
            controller.setPlayerCollodion (playerCollodion);
            controller.backCardToHand (activateUnit, event.getEptitude(), event.getActivator());

        }

        private function onIncreaseHealthDependsOnCards (event:EptitudeEvent) :void {

            var controller:CollodionController = new CollodionController();
            controller.setField (this);
            controller.setEnemyCollodion (enemyCollodion);
            controller.setPlayerCollodion (playerCollodion);
            controller.increaseHealthDependsOnCards (event.target as Token, event.getEptitude(), event.getActivator());
        }

        private function backPlayerSpellToHand (card:Card) :void {
            var mirrow:Sprite = card.getMirrow ();
            TrajectoryContainer.getInstance().addToPlayCardLevel (mirrow);
            actualCard = playerCollodion.addCard (card.getCardData (), false);
            var cardPosition:Point = new Point (actualCard.x, actualCard.y);
            cardPosition = actualCard.parent.localToGlobal (cardPosition);
            actualCard.visible = false;
            var timeline:TimelineLite = new TimelineLite ();
            timeline.to (mirrow, 0.7, { x:cardPosition.x, y:cardPosition.y, scaleX:0.72, scaleY:0.72, ease:Expo.easeOut, onComplete:onBackSpellComplete } );
        }

        private function onBackSpellComplete () :void {
            actualCard.visible = true;
            TrajectoryContainer.getInstance().endPlayCard();
            if (playerStep) {
                playerCollodion.glowAvailableCards();
            }
        }

        private function onNewSpell (event:EptitudeEvent) :void {
            var controller:CollodionController = new CollodionController();
            controller.setField (this);
            controller.setEnemyCollecton (enemyCollection);
            controller.setEnemyCollodion (enemyCollodion);
            controller.setPlayerCollection (playerCollection);
            controller.setPlayerCollodion (playerCollodion);
            controller.newSpellFromToken(event.target as IAttackAvailable, event.getEptitude(), event.getActivator());
        }







        // ссылки на колоды и коллекции
        public function setEnemyCollodion (collodion:EnemyCollodion) :void {
            enemyCollodion = collodion;
        }
        public function setPlayerCollection (collection:Collection) :void {
            playerCollection = collection;
        }
        public function setEnemyCollection (collection:Collection) :void {
            enemyCollection = collection;
        }
        public function setPlayerCollodion (collodion:PlayerCollodion) :void {
            playerCollodion = collodion;
        }

        // конец игры


		//ссылки на объекты стола
		public function getPlayerHero () :Hero {
			return playerHero;
		}
		public function getEnemyHero () :Hero {
			return enemyHero;
		}
        public function getEnemyUnits (shadow:Boolean = true) :Array {
            var arr:Array = [];
            var token:Token;
            for (var i:int = 0; i < enemyRow.numChildren; i ++) {
                token = enemyRow.getChildAt (i) as Token;
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
        public function getPlayerUnits (shadow:Boolean = true) :Array {
            var arr:Array = [];
            var token:Token;
            for (var i:int = 0; i < playerRow.numChildren; i ++) {
                token = playerRow.getChildAt (i) as Token;
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
        public function getEnemyRow () :UnitRow {
            return enemyRow;
        }
        public function getPlayerRow () :UnitRow {
            return playerRow;
        }
        public function getProvocators (row:UnitRow) :Array {
            var provocators:Array = [];
            for (var i:int = 0; i < row.numChildren; i ++) {
                var token:Token = row.getChildAt (i) as Token;
                if (token.isProvocator()) {
                    provocators.push (token);
                }
            }
            return provocators;
        }
        public function getPlayerProvocators () :Array {
            return getProvocators (playerRow);
        }
        public function getEnemyProvocators () :Array {
            return getProvocators (enemyRow);
        }
        public function getVisibleTokens (row:UnitRow) :Array {
            var arr:Array = [];
            var token:Token;
            for (var i:int = 0; i < row.numChildren; i ++) {
                token = row.getChildAt(i) as Token;
                if (token.visible) {
                    arr.push (token);
                }
            }
            return arr;
        }
        public function getVisibleRaceTokens (row:UnitRow, raceId:int) :Array {
            var arr:Array = [];
            var token:Token;
            for (var i:int = 0; i < row.numChildren; i ++) {
                token = row.getChildAt(i) as Token;
                if (token.visible && raceId == token.getRace()) {
                    arr.push (token);
                }
            }
            return arr;
        }

        public function getSpellVisibleTokens (row:UnitRow, shadow:Boolean = true) :Array {
            var arr:Array = [];
            var token:Token;
            for (var i:int = 0; i < row.numChildren; i ++) {
                token = row.getChildAt(i) as Token;
                if (token.visible && !token.isSpellInvisible()) {
                    if (shadow) {
                        if (!token.inShadow()) {
                            arr.push(token)
                        }
                    } else {
                        arr.push (token);
                    }

                }
            }
            return arr;
        }


        public function getEnemyRowNumChildren () :int {
            return enemyRow.numChildren
        }
        public function getPlayerRowNumChildren () :int {
            return playerRow.numChildren;
        }

        public function setLastPlaced (token:Token) :void {
            this.lastPlaced = token;
        }

        public function getLastPlaced () :Token {
            return lastPlaced;
        }

        public function getLastPlacedRace (raceId:int) :Token {
            var token:Token;
            if (lastPlaced == null) {
                return null;
            }

            if (lastPlaced.getRace() == raceId) {
                token = lastPlaced;
            }
            return token;
        }


		// сортировка стола
        public function sortUnitRow (unitRow:UnitRow, index:int = 0, animation:Boolean = true) :Point {

            var position:Point;

            var visibleTokens:Array = getVisibleTokens (unitRow);
            var availablePositions:Array = getRowAvailablePositions(visibleTokens.length);

            for (var i:int = 0; i < visibleTokens.length; i ++) {
                var unit:DisplayObject = visibleTokens[i];
                if (animation) {
                    TweenLite.to (unit, 0.4, { x: availablePositions[i] } );
                } else {
                    unit.x = availablePositions[i];
                }

                if (i == index) {
                    position = new Point (availablePositions[i], unit.y);
                }
            }
            return position;
        }
        public function centerizeRow (unitRow:UnitRow, callback:Function = null) :Point {
            var visibleTokens:Array = getVisibleTokens (unitRow);
            var xPos:int = (this.width - ((UnitRow.PADDING * (visibleTokens.length - 1)) + (Token.WIDTH * visibleTokens.length))) / 2;
            TweenLite.to (unitRow, 0.4, { x: xPos , onComplete:callback } );

            return new Point (xPos, unitRow.y);
        }


		// работа мыши с юнитами на столе
		private function onTokenMouseOver (event:TokenEvent) :void {
			//trace (event.getToken());
			//trace (selectionMode);
			
			if (attackMode) {
				return;
			}
			
			if (selectionMode) {
				return;
			}
			
			//trace ('onTokenMouseOver')
			
			var token:Token = event.getToken () as Token;
			var mirrow:Sprite = token.getMirrow ();
			
			var mirrowPosition:Point = new Point(token.x, token.y); 
			mirrowPosition = token.parent.localToGlobal(mirrowPosition);
			
			if (mouseX > (stage.stageWidth / 2) + 30) {
				mirrowPosition.x -= Card.MIRROW_WIDTH + 20;
			} else {
				mirrowPosition.x += Token.WIDTH + 20;
			}
			
			mirrowPosition.y -= (mirrow.height - Token.HEIGHT) / 3;
			
			mirrow.x = mirrowPosition.x;
			mirrow.y = mirrowPosition.y;
			
			mirrow.alpha = 0;
			TweenLite.to (mirrow, 1.0, {alpha:1, ease:Expo.easeInOut});
			
			TrajectoryContainer.getInstance().addToCardPreviewLevel (mirrow);
		}
		private function onTokenMouseOut (event:TokenEvent) :void {
			//trace (event.getToken());
			if (attackMode) {
				return;
			}
			
			if (selectionMode) {
				return;
			}
			
			TrajectoryContainer.getInstance().endCardPreview();
			
			//trace ('onTokenMouseOut');
		}
        private function onTokenMouseDown (event:TokenEvent) :void {

            if (!playerStep) {
                return;
            }

            TrajectoryContainer.getInstance().endDrawTrajectory();
            TrajectoryContainer.getInstance().endCardPreview();

            attackMode = true;

            attackUnit = (event.getToken () as Token);

            var xPosition:int = attackUnit.x + attackUnit.parent.x + Token.WIDTH/2;
            var yPosition:int = attackUnit.y + + attackUnit.parent.y + (attackUnit.height / 2) + this.y;
            TrajectoryContainer.getInstance().setStartPosition (new Point (xPosition, yPosition));
            TrajectoryContainer.getInstance().startDraw ();



            stage.addEventListener (MouseEvent.MOUSE_UP, onStageMouseUp);
        }
        private function onStageMouseUp (event:MouseEvent) :void {
            stage.removeEventListener (MouseEvent.MOUSE_UP, onStageMouseUp);
            TrajectoryContainer.getInstance().stopDraw ();
            TrajectoryContainer.getInstance().endDrawTrajectory();

            attackMode = false;

            if (event.target is IAttackAvailable) {
                var token:IAttackAvailable = event.target as IAttackAvailable;

                if (token.isEnemy()) {
                    (event.target as EventDispatcher).dispatchEvent (new TokenEvent (TokenEvent.TOKEN_MOUSE_UP, event.target as IAttackAvailable));
                }
            }
        }
        private function onTokenMouseUp (event:TokenEvent) :void {

            if (!playerStep) {
                return;
            }

            var attackController:AttackController = new AttackController ();
            attackController.setField (this);
            attackController.attack (attackUnit, event.getToken (), playerStep);

        }
		
		// апи для Game и ii
        public function setPlayerPrice (value:int) :void {
			playerPriceToolbar.setStepPrice (value);
		}
		private function onAttackPlayerHero (event:TokenEvent) :void {
			attackUnit = event.getToken () as Token;
			
			var attackController:AttackController = new AttackController ();
			attackController.setField (this);
			attackController.attack (attackUnit, playerHero, playerStep);
		}
		public function enemyUnitsCanAttack () :void {
			unitsCanAttack (enemyRow);
		}
		public function playerUnitsCanAttack () :void {
			unitsCanAttack (playerRow);
		}
		public function unitsCanAttack (row:UnitRow) :void {
			for (var i:int = 0; i < row.numChildren; i ++) {
				var unit:Token = row.getChildAt (i) as Token;
				unit.canAttack = true;
			}
		}
		private function onAttackUnit (event:TokenEvent) :void {
			attackUnit = event.getToken () as Token;
			activateUnit = attackUnit;

            var attackController:AttackController = new AttackController ();
            attackController.setField (this);
            attackController.attack (attackUnit, event.getTargetUnit(), playerStep);
			//attack (event.getTargetUnit());
		}
        public function setPlayerStep (value:Boolean) :void {
            addChild (enemyRow)
            addChild (playerRow);
            playerStep = value;
        }
        public function activatePlayer (period:int) :void {
            activationUnits = [];
            activationPeriod = period;
            playerActivation = true;
            for (var i:int = 0; i < playerRow.numChildren; i ++) {
                activationUnits.push (playerRow.getChildAt(i));
            }
            activateUnits (activationPeriod);
        }
        public function activateEnemy (period:int) :void {
            activationUnits = [];
            activationPeriod = period;
            playerActivation = false;
            for (var i:int = 0; i < enemyRow.numChildren; i ++) {
                activationUnits.push (enemyRow.getChildAt(i));
            }
            activateUnits (activationPeriod);
        }
        private function activateUnits (period:int) :void {
            if (!activationUnits.length) {
                dispatchEvent (new ActivationEvent (ActivationEvent.ACTIVATION_COMPLETE, activationPeriod, playerActivation));
                return;
            }

            var unit:Token = activationUnits.shift ();
            unit.activateEptitudes(period, onUnitActivationComplete);

        }
        private function onUnitActivationComplete () :void {
            activateUnits (activationPeriod);
        }
        public function deactivatePlayer () :void {
            addChild (playerRow);
            addChild (enemyRow)
            playerStep = false;
        }

		// размещение готового юнита
        public function findTokenPosition () :void {

            if (!playerRow.numChildren) {
                return;
            }

            playerRow.addChild (tokenPreview);
            playerRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH) * playerRow.numChildren) / 2;

            tokenPreview.x = (playerRow.numChildren - 1) * ( UnitRow.PADDING + Token.WIDTH);

            this.addEventListener (Event.ENTER_FRAME, onEnterFrame);
        }
        private function onEnterFrame (event:Event) :void {
            var mouseLocalX:int = mouseX - playerRow.x;
            var index:int = findNearNumberIndex (getRowAvailablePositions(playerRow.numChildren), mouseLocalX);
            if (playerRow.contains(tokenPreview)) playerRow.removeChild (tokenPreview);
            playerRow.addChildAt (tokenPreview, index);
            tokenPreviewIndex = index;
            sortUnitRow (playerRow);
        }
		private function get tokenPreview () :Sprite {
			return Token.getTokenPreviewInstance() as Sprite
		}
		public function stopFindTokenPosition () :void {
			if (!playerRow.numChildren) {
				playerRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH) * playerRow.numChildren) / 2;
				return;
			}
			
			if (playerRow.contains(tokenPreview)) playerRow.removeChild (tokenPreview);
			centerizeRow (playerRow);
			sortUnitRow (playerRow);
			this.removeEventListener (Event.ENTER_FRAME, onEnterFrame);
			
		}
		public function getRowAvailablePositions (index:int) :Array {
			var arr:Array = [];
			for (var i:int = 0; i < index; i ++) {
				arr.push (( UnitRow.PADDING + Token.WIDTH) * i);
			}
			return arr;
		}

		// функция возвращает индекс близжайшего числа к заданному
		// Вернет -1 если неверны входящие параметры или массив если пуст
		private function findNearNumberIndex( arr:Array, targetNumber:Number ):int
		{
			// проверяем входящие аргументы
			if( !arr || isNaN( targetNumber ) )
				return -1;
		 
			// currDelta - текущая разница
			var currDelta:Number;
		 
			// nearDelta - наименьшая разница
			var nearDelta:Number;
		 
			// nearIndex - индекс наименьшей разницы. Задаем изначально равным -1.
			// если массив с нулевой длиной - возвратится эта самая -1
			var nearIndex:Number = -1;
		 
			// счетчик
			var i:Number = arr.length;
		 
			// начинаем крутить цикл с конца массива.
			// с конца - чтобы не заводить доп. переменную
			while( i-- )
			{
				// берем по модулю раницу между заданным числом и текущим по индексу массива
				currDelta = Math.abs( targetNumber - arr[i] );
		 
				// если nearIndex меньше нуля
				// (т.е мы в первый раз должны занести currDelta, чтобы было с чем сравнивать последующие итерации)
				// или currDelta меньше nearDelta
				if( nearIndex < 0 || currDelta < nearDelta )
				{
					// задаем индекс (наименьшей разницы) как текущий индекс
					nearIndex = i;
					// задаем наименьшую разницу как текущую
					nearDelta = currDelta;
				}
			}
		 
			// возвращаем индекс наименьшей разницы
			return nearIndex;
		}


        // переход хода
        private function onNavClick (event:MouseEvent) :void {
            dispatchEvent (new FieldEvent(FieldEvent.END_STEP));
        }

        // уборка мусора (кривая TODO нормальную уборку)
		public function destroy () :void {
			this.removeEventListener (TokenEvent.TOKEN_MOUSE_UP, onTokenMouseUp, true);
			this.removeEventListener (TokenEvent.TOKEN_MOUSE_DOWN, onTokenMouseDown, true);
			this.removeEventListener (TokenEvent.ATTACK_PLAYER_HERO, onAttackPlayerHero, true);
			this.removeEventListener (TokenEvent.ATTACK_UNIT, onAttackUnit, true);
			this.removeEventListener (TokenEvent.TOKEN_MOUSE_OVER, onTokenMouseOver, true);
			this.removeEventListener (TokenEvent.TOKEN_MOUSE_OUT, onTokenMouseOut, true);
		}

        public function setSelectionMode (value:Boolean) :void {
            selectionMode = value;
        }

        public function setLastAttacked (unit:IAttackAvailable) :void {
            this.lastAttacked = unit;
        }

        public function getLastAttacked () :IAttackAvailable {
            return lastAttacked;
        }

        public function getLastAttackedUnit () :Token {
            if (lastAttacked is Token) {
                return lastAttacked as Token;
            } else {
                return null;
            }
        }

        public function isPlayerStep () :Boolean {
            return playerStep;
        }
		
	}
	
	
	
	

}