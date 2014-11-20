package com.ps.collodion
{
import com.ps.cards.*;
	import com.greensock.easing.Expo;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
import com.ps.collodion.Collodion;
import com.ps.field.Field;
	import com.ps.trajectory.TrajectoryContainer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class EnemyCollodion extends Collodion
	{
		
		private var cards:Array;
		private var cardPrice:int = 0;
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		private var field:Field;
		private var actualCard:Card
		
		public static const COMPLETE_PLACE_CARD:String = 'encompletePlaceCard';
		
		public function EnemyCollodion(stageWidth:int, stageHeight:int) 
		{
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			cards = [];
			
			this.cardsStack = new Sprite ();
			addChildAt (cardsStack, 0);
			sortCollodion ();
			
		}
		
		public function setField (field:Field) :void {
			this.field = field;
		}
		
		public function addCard (cardData:CardData, animation:Boolean = true) :Card {
			var card:Card = new Card (cardData);
            card.setHero(field.getEnemyHero());
            card.graphics.clear();
			while (card.numChildren) card.removeChildAt (0);
			card.addChild (card.getSmallShirt());
			cardsStack.addChild (card);
			var cardPosition:Point = sortCollodion (cardsStack.getChildIndex(card), animation);
			var collodionPosition:Point = centerizeCollodion (animation);
			
			if (animation) {
				var shirt:DisplayObject = card.getShirt (); 
				shirt.y = 200;
				shirt.x = stageWidth + 100;
				//shirt.alpha = 0.5;
				TrajectoryContainer.getInstance().addToPlaceCardLevel (shirt)
				cardPosition.x += collodionPosition.x;
				cardPosition.y += collodionPosition.y;
				
				actualCard = card;
				actualCard.visible = false; 
				
				var timeline:TimelineLite = new TimelineLite ({onComplete:onAddCardComplete});
				//timeline.to (shirt, 1.0, { x:500, y:100, ease:Expo.easeOut} );
				timeline.to (shirt, 1.0, { x:cardPosition.x, y:cardPosition.y, scaleX:0.675, scaleY:0.68, ease:Expo.easeOut});
			}
			
			
			return card;
		}
		
		private function onAddCardComplete () :void {
			actualCard.visible = true;
			var shirt:Sprite = actualCard.getShirt ();
			shirt.scaleX = 1.0;
			shirt.scaleY = 1.0;
			TrajectoryContainer.getInstance().endPlaceCard();
			dispatchEvent (new Event (COMPLETE_PLACE_CARD));
		}
		
		private function sortCollodion (index:int = 0, animation:Boolean = true) :Point {
			var centerX:int = stageWidth / 2;
			var yPosition:int = - (Card.CARD_HEIGHT - 40);
			var shift:int = 90 - (cardsStack.numChildren * 5);
			
			var position:Point = new Point ();
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				var shirt:Sprite = cardsStack.getChildAt (i) as Sprite;
				shirt.x = shift * i;
				if (index == i) {
					position.x = shift * i;
					
				}
				//TweenLite.to (shirt, 0.4, { x:shift * i } ); 
				shirt.y = yPosition;
				position.y = yPosition
			}
			
			return position;
		}
		
		private function centerizeCollodion (animation:Boolean = true) :Point {
			var cardStackX:int = (stageWidth - cardsStack.width) / 2
			if (animation) {
				TweenLite.to (cardsStack, 0.4, { x:cardStackX } ); 
			} else {
				cardsStack.x = cardStackX;
			}
			
			return new Point (cardStackX, cardsStack.y);
		}
		
		public function getCards () :Array {
			var arr:Array = []
			var card:Card;
			for (var i:int = 0; i < cardsStack.numChildren; i++) {
				card = cardsStack.getChildAt (i) as Card;
				arr.push (card);
			}
			return arr;
		}
		
		public function setCardPrice (value:int) :void {
			cardPrice = value;
		}
		
		public function getCardPrice () :int {
			return cardPrice;
		}
		
		public function playCard (card:Card) :void {
			field.placeEnemyCard (card);
			cardsStack.removeChild (card);
			sortCollodion ();
			centerizeCollodion ();
		}
		



		
		/*
		public function removeCard (card:CardData) :void {
			var index:int = cards.indexOf (card);
			cards.splice (index, 1);
		}
		*/
		
	}

}

/*
 private var actualCard:Card;
		private var stageHeight:int;
		private var stageWidth:int;
		
		private var cardsStack:Sprite;
		private var mirrowStack:Sprite;
		private var sensorStack:Sprite;
		
		private var mirrow:Sprite;
		
		private var dragMode:Boolean = false;
		private var field:Field;
		
		private var playerPrice:int;
		
		public function Collodion(stageWidth:int, stageHeight:int) :void  
		{
			
			
			cardsStack = new Sprite ();
			addChild (cardsStack);
			
			mirrowStack = new Sprite ();
			addChild (mirrowStack)
			
			sensorStack = new Sprite ();
			addChild (sensorStack);
			
			this.stageHeight = stageHeight;
			this.stageWidth = stageWidth;
			
			playerPrice = 0;
			
		}
		
		public function glowAvailableCards  () :void {
			
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				var card:Card = cardsStack.getChildAt (i) as Card;
				if (card.getCardData().getPrice() <= playerPrice) {
					card.filters = [new GlowFilter(0x00FFFF)]
				} else {
					card.filters = null;
				}
				
			}
		}
		
		public function setCardPrice (value:int) :void {
			playerPrice = value;
		}
		
		public function getCardPrice () :int {
			return playerPrice;
		}
		
		public function addCard (cardData:CardData) :Card {
			var card:Card = new Card (cardData);
			cardsStack.addChild (card);
			var sensor:CardSensor = card.getSensor()
			sensorStack.addChild (sensor);
			sensor.addEventListener (MouseEvent.MOUSE_OVER, onCardMouseOver)
			sensor.addEventListener (MouseEvent.MOUSE_OUT, onCardMouseOut);
			sensor.addEventListener (MouseEvent.MOUSE_DOWN, onCardMouseDown)
			sensor.addEventListener (MouseEvent.MOUSE_UP, onCardMouseUp);
			sortCollodion ();
			return card;
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
			
			while (mirrowStack.numChildren) {
				mirrowStack.removeChildAt (mirrowStack.numChildren - 1);
			}
			actualCard.visible = true;
		}
		
		private function onCardMouseOver (event:MouseEvent) :void {
			if (dragMode) {
				return;
			}
							
			var cardSensor:CardSensor
			cardSensor = event.target as CardSensor;
			
			var card:Card = cardSensor.getCard ();
			
			
			card.visible = false;
						
			actualCard = card;
			
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
			
			dragMode = true;
			mirrow.startDrag ();
			field.findTokenPosition ();
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
			field.stopFindTokenPosition ();
			stage.removeEventListener (MouseEvent.MOUSE_UP, onMirrowCardUp);
			if (mouseY < field.height) {
				cardsStack.removeChild (actualCard);
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
				
				dispatchEvent (new CollodionEvent (CollodionEvent.CARD_PLAY, actualCard.getCardData()));
				
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
*/

