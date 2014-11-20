package com.ps.trajectory 
{
import com.log.Logger;
import com.ps.field.IAttackAvailable;
	import com.ps.tokens.SelectToken;
	import com.ps.tokens.Token;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class TrajectoryContainer extends Sprite
	{
		
		private static var instance:TrajectoryContainer
		private var flag:Boolean = false;
		private var position:Point;
		
		private var shirme:Sprite;

        private var playCardLevel:Sprite;
        private var placeCardLevel:Sprite;
        private var trajectoryLevel:Sprite;
        private var previewCardLevel:Sprite;
        private var attackGraphicsLevel:Sprite;
        private var previewTokensLevel:Sprite;

		
		public function TrajectoryContainer() 
		{
			if (flag) throw new Error ("This is singletone. Use getInstance() instead of creating new TraectoryContainer instance")
			
			flag = true;

            attackGraphicsLevel = new Sprite();
            attackGraphicsLevel.mouseEnabled = false;
            addChild(attackGraphicsLevel);

            trajectoryLevel = new Sprite();
            trajectoryLevel.mouseEnabled = false;
            addChild(trajectoryLevel);

            placeCardLevel = new Sprite();
            placeCardLevel.mouseEnabled = false;
            addChild(placeCardLevel);

            playCardLevel = new Sprite();
            playCardLevel.mouseEnabled = false;
            addChild(playCardLevel);

            previewCardLevel = new Sprite();
            previewCardLevel.mouseEnabled = false;
            addChild(previewCardLevel);

            previewTokensLevel = new Sprite();
            previewTokensLevel.mouseEnabled = false;
            addChild(previewTokensLevel);

		}
		
		public static function getInstance () :TrajectoryContainer {
			if (instance == null) {
				instance = new TrajectoryContainer ();
				instance.mouseEnabled = false;


			}
			
			return instance;
		}
		
		
		public function setStartPosition (position:Point) :void {
			this.position = position
		}
		
		public function startDraw () :void {
			this.stage.addEventListener (Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function stopDraw () :void {
			this.stage.removeEventListener (Event.ENTER_FRAME, onEnterFrame);
			// graphics.clear ();
		}
		
		/*
        public function clear () :void {
			//trace ('clear');
			while (this.numChildren) this.removeChildAt (0);
			graphics.clear ();
		}
		*/
		
		private function onEnterFrame (event:Event) :void {
			trajectoryLevel.graphics.clear ();
			trajectoryLevel.graphics.lineStyle (1, 0xFFFF00, 1);
			trajectoryLevel.graphics.moveTo (position.x, position.y);
			trajectoryLevel.graphics.lineTo (mouseX, mouseY);
		}
		
		public function drawLine (start:Point, end:Point) :void {
			trajectoryLevel.graphics.clear ();
			trajectoryLevel.graphics.beginFill (0xFFFF00, 1);
			trajectoryLevel.graphics.drawRect ( start.x - 5, start.y - 5, 10, 10);
			trajectoryLevel.graphics.endFill();
			trajectoryLevel.graphics.lineStyle (1, 0xFFFF00, 1);
			trajectoryLevel.graphics.moveTo (start.x, start.y);
			trajectoryLevel.graphics.lineTo (end.x, end.y);
		}
		
		public function placeUnits (units:Array) :void {
			//trace ('placeUnits');
			previewTokensLevel.addChild (getShirme());
			
			
			//trace ('placeUnits 2');
			
			var bitmapCopy:Bitmap;
			var position:Point;
			var unit:IAttackAvailable;
			var blurFlag:Boolean 
			var selectToken:SelectToken;
			
			//trace (units.length);
			
			for (var i:int = 0; i < units.length; i ++) {
				unit = units[i] as IAttackAvailable;
				blurFlag = false;
				
				if (unit is Token) {
					if ((unit as Token).hasFilters ()) {
						(unit as Token).stopBlur ();
						blurFlag = true;
					}
				}
								
				bitmapCopy = getBitmapCopy (unit as DisplayObject);
				
				 if (blurFlag) {
					 (unit as Token).blur ();
				 }
				 
				position = getPosition (unit as DisplayObject);
				selectToken = new SelectToken (unit, bitmapCopy);
				
				selectToken.x = position.x;
				selectToken.y = position.y;
				
				if (unit is Token && (unit as DisplayObject).width != Token.WIDTH) {
					selectToken.x -= 10;
					selectToken.y -= 10;
				}
				
				previewTokensLevel.addChild (selectToken);
			}
			
			stage.addEventListener (MouseEvent.CLICK, onSelectClick);
			
		}
		
		private function onSelectClick (event:MouseEvent) :void {
			stage.removeEventListener (MouseEvent.CLICK, onSelectClick);
			var selectToken:SelectToken;
			var token:IAttackAvailable;
			if (event.target is SelectToken) {
				selectToken = event.target as SelectToken;
				token = selectToken.getToken ();
			}
			
			endTokenPreview();

			dispatchEvent (new TraectoryContainerEvent (TraectoryContainerEvent.SELECT, token));
		}
		
		private function getPosition (target:DisplayObject) :Point {
			var point:Point = new Point (target.x, target.y);
			point = target.parent.localToGlobal (point);
			return point;
		}
		
		private function getBitmapCopy (target:DisplayObject) :Bitmap {
			var bitmapData:BitmapData = new BitmapData (target.width, target.height, true, 0);
			
			var matrix:Matrix = new Matrix (); 
			if (target is Token && target.width != Token.WIDTH) {
				matrix.translate (10, 10);
			}
			
			
			bitmapData.draw (target, matrix);
			var bitmap:Bitmap = new Bitmap (bitmapData);
			return bitmap;
			
		}
		
		private function getShirme () :Sprite {
			if (shirme == null) {
				shirme = new Sprite ();
			}
			shirme.graphics.clear();
			shirme.graphics.beginFill (0x222222, 0.7);
			shirme.graphics.drawRect (0, 0, stage.stageWidth, stage.stageHeight);
			shirme.graphics.endFill ();
			return shirme;
		}

        public function addToPlayCardLevel (displayObject:DisplayObject) :void {
           // Logger.log('addToPlayCardLevel')
            playCardLevel.addChild(displayObject);
        }

        public function endPlayCard () :void {
           // Logger.log('endPlayCard')
            while (playCardLevel.numChildren) playCardLevel.removeChildAt (0);
            playCardLevel.graphics.clear ();
        }

        public function addToPlaceCardLevel (displayObject:DisplayObject) :void {
           // Logger.log('addToPlaceCardLevel')
            placeCardLevel.addChild(displayObject);
        }

        public function endPlaceCard () :void {
            //Logger.log('endPlaceCard')
            while (placeCardLevel.numChildren) placeCardLevel.removeChildAt (0);
            placeCardLevel.graphics.clear ();
        }

        public function addToCardPreviewLevel (displayObject:DisplayObject) :void {
            previewCardLevel.addChild(displayObject);
        }

        public function endCardPreview () :void {
            while (previewCardLevel.numChildren) previewCardLevel.removeChildAt (0);
            previewCardLevel.graphics.clear ();
        }

        public function addToTrajectoryLevel (displayObject:DisplayObject) :void {
            trajectoryLevel.addChild(displayObject);
        }

        public function endDrawTrajectory () :void {
            while (trajectoryLevel.numChildren) trajectoryLevel.removeChildAt (0);
            trajectoryLevel.graphics.clear ();
        }

        public function addToGraphicsLevel (displayObject:DisplayObject) :void {
            attackGraphicsLevel.addChild(displayObject);
        }

        public function endDrawAttack () :void {
            while (attackGraphicsLevel.numChildren) attackGraphicsLevel.removeChildAt (0);
            attackGraphicsLevel.graphics.clear ();
        }

        public function addToTokenPreviewLevel (displayObject:DisplayObject) :void {
           previewTokensLevel.addChild(displayObject);
        }

        public function endTokenPreview () :void {
            while (previewTokensLevel.numChildren) previewTokensLevel.removeChildAt (0);
            previewCardLevel.graphics.clear ();
        }
	}

}