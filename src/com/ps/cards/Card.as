package com.ps.cards 
{
import com.log.Logger;
import com.ps.hero.Hero;

import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

    import ru.flasher.utils.StringUtil


/**
	 * ...
	 * @author 
	 */
	
	 
	public class Card extends Sprite
	{
		
		private var mirrow:Sprite 
		private var priceLabel:TextField;
		private var mirrowPriceLabel:TextField;
		
		private var cardSensor:CardSensor;
		private var cardData:CardData;
		
		private var attackLabel:TextField;
		private var healthLabel:TextField;
		
		private var descriptionLabel:TextField;
		private var titleLabel:TextField;
		
		public static const MIRROW_WIDTH:int = 154;
		public static const MIRROW_HEIGHT:int = 224;
		
		public static const CARD_WIDTH:int = 110;
		public static const CARD_HEIGHT:int = 160;
		
		private var shirt:Sprite;
		private var smallShirt:Sprite;

        private var price:int;
        private var defaultPrice:int;

        private var priceFormat:TextFormat;
        private var saleFormat:TextFormat;
        private var expensiveFormat:TextFormat;

        private var mirrowPriceFormat:TextFormat;
        private var mirrowSaleFormat:TextFormat;
        private var mirrowExpensiveFormat:TextFormat;

        private var hero:Hero;
	
		public function Card(cardData:CardData) 
		{
			this.cardData = cardData;
			
			graphics.beginFill (0xcccccc, 1);
			graphics.drawRect (0, 0, 110, 160);
			graphics.endFill();
									
			graphics.lineStyle (1, 0, 1);
			graphics.lineTo (110, 0);
			graphics.lineTo (110, 160);
			graphics.lineTo(0, 160);
			graphics.lineTo (0, 0);
						
			graphics.beginFill (0xffFFFF, 1);
			graphics.drawRect (0, 0, 21, 21);
			graphics.endFill ();
			
			priceFormat = new TextFormat ();
			priceFormat.size = 15;
			priceFormat.bold = true;
            priceFormat.color = 0x000000;

            saleFormat = new TextFormat ();
            saleFormat.size = 15;
            saleFormat.color = 0x00FF00;
            saleFormat.bold = true;

            expensiveFormat = new TextFormat ();
            expensiveFormat.size = 15;
            expensiveFormat.bold = true;
            expensiveFormat.color = 0xFF0000;

            price = cardData.getPrice();
            defaultPrice = price;
			
			priceLabel = new TextField ();
			priceLabel.defaultTextFormat = priceFormat;
			priceLabel.text = "" + price;
			priceLabel.autoSize = TextFieldAutoSize.LEFT;
			priceLabel.wordWrap = false;
			priceLabel.x = 4;
			//label.border = true;
			priceLabel.mouseEnabled = false;
			addChild (priceLabel);
			
			cardSensor = new CardSensor (this);
						
			mirrow = new Sprite ();
			mirrow.graphics.beginFill (0xcccccc, 1);
			mirrow.graphics.drawRect (0, 0, 154, 224);
			mirrow.graphics.endFill();
			
			shirt = new Sprite ();
			shirt.graphics.beginFill (0x444444, 1);
			shirt.graphics.drawRect (0, 0, 154, 224);
			shirt.graphics.endFill();
				
			smallShirt = new Sprite ();
			smallShirt.graphics.beginFill (0x444444, 1);
			smallShirt.graphics.drawRect (0, 0, 100, 150);
			smallShirt.graphics.endFill();
			smallShirt.graphics.lineStyle (1, 0, 1);
			smallShirt.graphics.lineTo (100, 0);
			smallShirt.graphics.lineTo (100, 150);
			smallShirt.graphics.lineTo(0, 150);
			smallShirt.graphics.lineTo (0, 0);
						
			mirrow.graphics.lineStyle (1, 0, 1);
			mirrow.graphics.lineTo (154, 0);
			mirrow.graphics.lineTo (154, 224);
			mirrow.graphics.lineTo(0, 224);
			mirrow.graphics.lineTo (0, 0);
			mirrow.graphics.lineStyle(0);

            if (getType() == CardData.UNIT) {
                mirrow.graphics.beginFill (0xFF0000, 1);
                mirrow.graphics.drawRect (0, 194, 30, 30);
                mirrow.graphics.endFill ();
            }

            if (getType() == CardData.UNIT) {
                mirrow.graphics.beginFill (0x00FF00, 1);
                mirrow.graphics.drawRect (124, 194, 30, 30);
                mirrow.graphics.endFill ();
            }

			mirrow.graphics.beginFill (0xffffff, 1);
			mirrow.graphics.drawRect (0, 0, 30, 30);
			mirrow.graphics.endFill ();
			
			var format:TextFormat = new TextFormat ();
			//format.color = 0xFFFFFF;
			format.size = 22;
			format.bold = true;

            mirrowPriceFormat = new TextFormat ();
            mirrowPriceFormat.size = 22;
            mirrowPriceFormat.bold = true;
            mirrowPriceFormat.color = 0x000000;

            mirrowSaleFormat = new TextFormat ();
            mirrowSaleFormat.size = 22;
            mirrowSaleFormat.bold = true;
            mirrowSaleFormat.color = 0x00FF00;

            mirrowExpensiveFormat = new TextFormat ();
            mirrowExpensiveFormat.size = 22;
            mirrowExpensiveFormat.bold = true;
            mirrowExpensiveFormat.color = 0xFF0000;


            mirrowPriceLabel = new TextField ();
			mirrowPriceLabel.defaultTextFormat = mirrowPriceFormat;
			mirrowPriceLabel.text = "" + price;
			mirrowPriceLabel.autoSize = TextFieldAutoSize.LEFT;
			mirrowPriceLabel.wordWrap = false;
			mirrowPriceLabel.x = 7;
			//label.border = true;
			mirrowPriceLabel.mouseEnabled = false;
			mirrow.addChild (mirrowPriceLabel);
			
			attackLabel = new TextField ();
            attackLabel.height = 25;
			attackLabel.defaultTextFormat = format;
			attackLabel.text = "" + cardData.getAttack();
			attackLabel.autoSize = TextFieldAutoSize.LEFT;
			attackLabel.wordWrap = true;
			attackLabel.mouseEnabled = false;
			
			attackLabel.x = 7;
			attackLabel.y = mirrow.height - 30;

            if (getType() == CardData.UNIT) {
                mirrow.addChild (attackLabel);
            }

			healthLabel = new TextField ();
			healthLabel.height = 25;
            healthLabel.defaultTextFormat = format;
			healthLabel.text = "" + cardData.getHealth();
			healthLabel.autoSize = TextFieldAutoSize.LEFT;
			//healthLabel.wordWrap = true;
			healthLabel.mouseEnabled = false;
			
			healthLabel.x = mirrow.width - 25;
			healthLabel.y = attackLabel.y;

            if (getType() == CardData.UNIT) {
                mirrow.addChild (healthLabel);
            }

			var titleFormat:TextFormat = new TextFormat ();
			titleFormat.align = TextFormatAlign.CENTER;
			titleFormat.size = 14;
			titleFormat.bold = true;
						
			titleLabel = new TextField ();
			titleLabel.width = 154;
			titleLabel.defaultTextFormat = titleFormat;
			titleLabel.text = cardData.getTitle ();
            titleLabel.mouseEnabled = false;
			titleLabel.y = mirrow.height - Math.round (mirrow.height * 0.5);
			//titleLabel.border = true;
			mirrow.addChild (titleLabel);
			
			var descriptionFormat:TextFormat = new TextFormat ();
			descriptionFormat.align = TextFormatAlign.CENTER;
			descriptionFormat.size = 14;
			
			descriptionLabel = new TextField ();
			descriptionLabel.width = 154;
			descriptionLabel.height = 80;
			descriptionLabel.wordWrap = true;
            descriptionLabel.mouseEnabled = false;
			//descriptionLabel.border = true;
			//descriptionLabel.autoSize = TextFieldAutoSize.CENTER;
			//descriptionLabel.border = true;
			var desciption:String = cardData.getDescription();
			if (desciption.length > 20) {
				descriptionFormat.size = 12;
			}
			
			descriptionLabel.defaultTextFormat = descriptionFormat;
			
			descriptionLabel.text = parseDescription(desciption);
			descriptionLabel.y = mirrow.height - Math.round (mirrow.height * 0.35);
			mirrow.addChild (descriptionLabel);
			
		}

        public function setHero (hero:Hero) :void {
            this.hero = hero;
        }
		
		public function getCardData () :CardData {
			return cardData;
		}
		
		public function getPrice () :int {
			return price;
		}

        public function addSale (value:int) :void {
            price -= value;

            if (price < 0) {
                price = 0;
            }

            if (price < defaultPrice) {
                mirrowPriceLabel.defaultTextFormat = mirrowSaleFormat;
                priceLabel.defaultTextFormat = saleFormat;
            } else if (price > defaultPrice) {
                mirrowPriceLabel.defaultTextFormat =mirrowExpensiveFormat
                priceLabel.defaultTextFormat = expensiveFormat;
            } else {
                mirrowPriceLabel.defaultTextFormat = mirrowPriceFormat;
                priceLabel.defaultTextFormat = priceFormat;
            }
            mirrowPriceLabel.text = '' + price;
            priceLabel.text = '' + price;

        }

        public function cancelSale (value:int) :void {
            price += value;

            if (price > defaultPrice) {
                price = defaultPrice;
            }

            if (price < defaultPrice) {
                mirrowPriceLabel.defaultTextFormat = mirrowSaleFormat;
                priceLabel.defaultTextFormat = saleFormat;
            } else {
                mirrowPriceLabel.defaultTextFormat = mirrowPriceFormat;
                priceLabel.defaultTextFormat = priceFormat;
            }
            mirrowPriceLabel.text = '' + price;
            priceLabel.text = '' + price;
        }

        public function checkSpell () :void {
            var description:String = parseDescription (cardData.getDescription())
            descriptionLabel.text = description;

        }

        private function parseDescription (str:String) :String {
            var spellBob:int = 0;
            if (hero) {
                spellBob = hero.getSpellBob();
            }
            var spellPower:int = cardData.getSpellPower() + spellBob;
            var result:String = StringUtil.format(str, spellPower)
            return result;
        }
	
		public function getMirrow () :Sprite {
			return mirrow;
		}
		
		public function getMirrowBitmap () :Bitmap {
			return getBitmapCopy (mirrow);
		}
		
		private function getBitmapCopy (target:DisplayObject) :Bitmap {
			var bitmapData:BitmapData = new BitmapData (target.width, target.height, true, 0);
			
			bitmapData.draw (target);
			var bitmap:Bitmap = new Bitmap (bitmapData);
			return bitmap;
			
		}
		
		public function getShirt () :Sprite {
			return shirt;
		}
		
		public function getSmallShirt () :Sprite {
			return smallShirt;
		}
		
		public function getSensor () :CardSensor {
			return cardSensor;
		}

		public function getType () :int {
            return cardData.getType();
        }
		
		
	}

}