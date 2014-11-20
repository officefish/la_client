package com.ps.collodion
{
import com.ps.cards.*;
	/**
	 * ...
	 * @author 
	 */
	import com.greensock.easing.Expo;
	import com.greensock.easing.ExpoInOut;
	import com.greensock.TimelineLite;
import com.log.Logger;
import com.ps.field.IPlaceAvailable;
	import com.ps.trajectory.TrajectoryContainer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.ps.field.Field;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	public class PlayerCollodion extends Collodion
	{
		
		private var actualCard:Card;
		private var stageHeight:int;
		private var stageWidth:int;
		
		private var mirrowStack:Sprite;
		private var sensorStack:Sprite;
		
		private var mirrow:Sprite;
		
		private var dragMode:Boolean = false;
		private var field:Field;
		
		private var playerPrice:int;

    	public static const COMPLETE_PLACE_CARD:String = 'completePlaceCard';

		
		public function PlayerCollodion(stageWidth:int, stageHeight:int) :void
		{
			cardsStack = new Sprite ();
			addChild (cardsStack);
			
			mirrowStack = new Sprite ();
			addChild (mirrowStack);
			
			sensorStack = new Sprite ();
			addChild (sensorStack);
			
			this.stageHeight = stageHeight;
			this.stageWidth = stageWidth;
			
			playerPrice = 0;

            sales = [];
			
		}
		
		public function glowAvailableCards  () :void {
			
			var numChildren:int = field.getPlayerRowNumChildren() 

            for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				var card:Card = cardsStack.getChildAt (i) as Card;
				if (card.getPrice() <= playerPrice && numChildren < 7) {
					card.filters = [new GlowFilter(0x00FFFF)]
				} else {
					card.filters = null;
				}
			}
		}
		
		public function stopGlowCards () :void {
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				var card:Card = cardsStack.getChildAt (i) as Card;
				card.filters = null;
			}
		}
		
		public function setCardPrice (value:int) :void {
			playerPrice = value;
		}
		
		public function getCardPrice () :int {
			return playerPrice;
		}
		
		public function addCard (cardData:CardData, animation:Boolean = true) :Card {
			var card:Card = new Card (cardData);
            card.setHero(field.getPlayerHero())
			cardsStack.addChildAt (card, cardsStack.numChildren);
			var sensor:CardSensor = card.getSensor()
			sensorStack.addChild (sensor);
			sensor.addEventListener (MouseEvent.MOUSE_OVER, onCardMouseOver);
			sensor.addEventListener (MouseEvent.MOUSE_OUT, onCardMouseOut);
			sensor.addEventListener (MouseEvent.MOUSE_DOWN, onCardMouseDown);
			sensor.addEventListener (MouseEvent.MOUSE_UP, onCardMouseUp);
			sortCollodion ();
			
			if (animation) {
				var cardMirrow:DisplayObject = card.getMirrowBitmap ();
				cardMirrow.y = 300;
				cardMirrow.x = stageWidth + 100;
				TrajectoryContainer.getInstance().addToPlaceCardLevel (cardMirrow)
				
				var cardPosition:Point = new Point (card.x, card.y);
				cardPosition = card.parent.localToGlobal (cardPosition);
				
				actualCard = card;
				actualCard.visible = false;
				
				var timeline:TimelineLite = new TimelineLite ({onComplete:onAddCardComplete});
				timeline.to (cardMirrow, 1.0, { x:500, y:200, ease:Expo.easeOut} );
				timeline.to (cardMirrow, 0.5, { x:cardPosition.x, y:cardPosition.y, scaleX:0.72, scaleY:0.72, ease:Expo.easeInOut});
			}
			return card;
		}
		
		private function onAddCardComplete () :void {
			actualCard.visible = true;
            checkSaleCard(actualCard);
			var cardMirrow:Sprite = actualCard.getMirrow ();
			cardMirrow.scaleX = 1.0;
			cardMirrow.scaleY = 1.0;
			TrajectoryContainer.getInstance().endPlaceCard();

            while (mirrowStack.numChildren) {
                mirrowStack.removeChildAt (mirrowStack.numChildren - 1);
            }
            for (var i:int = 0; i < cardsStack.numChildren; i ++) {
                actualCard = cardsStack.getChildAt(i) as Card;
                actualCard.visible = true;
            }

			dispatchEvent (new Event (COMPLETE_PLACE_CARD));
		}
		
		public function setField (field:Field) :void {
			this.field = field;
		}
		
		private function sortCollodion () :void {
			var centerX:int = stageWidth / 2;
			var yPosition:int = stageHeight - 50;
			var shift:int = 90 - (cardsStack.numChildren * 5);
			
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				var card:Card = cardsStack.getChildAt (i) as Card;
				card.x = card.getSensor().x  = shift * i;
				card.y = card.getSensor().y = yPosition;
			}
			
			cardsStack.x = sensorStack.x = (stageWidth - cardsStack.width) / 2
		}
		
		private function onCardMouseOut (event:MouseEvent) :void {
			if (dragMode) {
				return;
			}
			
			TrajectoryContainer.getInstance().endTokenPreview();
            while (mirrowStack.numChildren) {
				mirrowStack.removeChildAt (mirrowStack.numChildren - 1);
			}
			actualCard.visible = true;
		}
		
		private function onCardMouseOver (event:MouseEvent) :void {
			if (dragMode) {
				return;
			}

            TrajectoryContainer.getInstance().endTokenPreview();
            var cardSensor:CardSensor;
			cardSensor = event.target as CardSensor;
			
			var card:Card = cardSensor.getCard ();
			card.visible = false;
						
			actualCard = card;
            actualCard.checkSpell ();
			
			var mirrowCard:Sprite = card.getMirrow ();
			
			mirrowStack.addChild (mirrowCard);
			mirrowCard.x = event.target.x + event.target.parent.x - 15;
			mirrowCard.y = stageHeight - (mirrowCard.height + 20);
			
			mirrow = mirrowCard;
			
			
			
		}
		
		private function onCardMouseDown (event:MouseEvent) :void {
			
			var cardPrice:int = actualCard.getPrice ();
			if (cardPrice > playerPrice) {
				return;
			}
			
			var numChildren:int = field.getPlayerRowNumChildren (); 
			if (numChildren >= 7) {
				return;
			}
			
			dragMode = true;
			mirrow.startDrag ();

            if (actualCard.getType() == CardData.UNIT) {
                field.findTokenPosition ();
            }

			stage.addEventListener (MouseEvent.MOUSE_UP, onMirrowCardUp);

			//event.target.startDrag();
		}
		
		private function onCardMouseUp (event:MouseEvent) :void {
			dragMode = false;
			mirrow.stopDrag ();
			skipPlaingCard ();
		}
		
		private function onMirrowCardUp (event:MouseEvent) :void {
			dragMode = false;
			mirrow.stopDrag();

            if (actualCard.getType() == CardData.UNIT) {
                field.stopFindTokenPosition ();
            }


			stage.removeEventListener (MouseEvent.MOUSE_UP, onMirrowCardUp);
			if (mouseY < field.height) {
				cardsStack.removeChild (actualCard);
				checkRemoveSale (actualCard.getType());
                actualCard.filters = null;
				if (mirrowStack.contains(mirrow)) {
					mirrowStack.removeChild (mirrow);
				}
				var sensor:CardSensor = actualCard.getSensor()
				sensorStack.removeChild (sensor);
				sensor.removeEventListener (MouseEvent.MOUSE_OVER, onCardMouseOver)
				sensor.removeEventListener (MouseEvent.MOUSE_OUT, onCardMouseOut);
				sensor.removeEventListener (MouseEvent.MOUSE_DOWN, onCardMouseDown);
				sensor.removeEventListener (MouseEvent.MOUSE_UP, onCardMouseUp);
				sortCollodion ();
				field.placeCard (actualCard)
				
				dispatchEvent (new CollodionEvent (CollodionEvent.CARD_PLAY, actualCard.getCardData(), actualCard.getPrice()));
				
			} else {
				skipPlaingCard ();
			}
			
		}
		
		private function onMirrowCardOut (event:MouseEvent) :void {
			var mirrowCard:Sprite = event.target as Sprite;
			skipPlaingCard ();
		}
		
		private function skipPlaingCard () :void {
			if (mirrowStack.contains(mirrow)) {
				mirrowStack.removeChild (mirrow);
			}
			actualCard.visible = true;
		}

        public function getActualCard () :Card {
            return actualCard;
        }


		
		
		
	}

}