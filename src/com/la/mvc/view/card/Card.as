package com.la.mvc.view.card
{

import com.log.Logger;
import com.ps.cards.CardData;
import com.ps.hero.Hero;

import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
import flash.filters.GlowFilter;
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
		
		private var mirror:Sprite
		private var priceLabel:TextField;
		private var mirrorPriceLabel:TextField;
		
		private var cardSensor:CardSensor;
		private var cardData:CardData;
		
		private var attackLabel:TextField;
		private var healthLabel:TextField;
		
		private var descriptionLabel:TextField;
		private var titleLabel:TextField;
		
		public static const MIRROR_WIDTH:int = 154;
		public static const MIRROR_HEIGHT:int = 224;
		
		public static const CARD_WIDTH:int = 110;
		public static const CARD_HEIGHT:int = 160;
		
		private var shirt:Sprite;
		private var smallShirt:Sprite;

        private var price:int;
        private var defaultPrice:int;

        private var priceFormat:TextFormat;
        private var saleFormat:TextFormat;
        private var expensiveFormat:TextFormat;

        private var mirrorPriceFormat:TextFormat;
        private var mirrorSaleFormat:TextFormat;
        private var mirrorExpensiveFormat:TextFormat;

        private var hero:Hero;
	
		public function Card(cardData:CardData) {
            this.cardData = cardData;
            price = cardData.getPrice();
            defaultPrice = price;

            formatCard();
            formatMirror();
            formatShirt();

        }

        private function formatCard () :void {
            CardFormater.drawBody(this, CARD_WIDTH, CARD_HEIGHT);

            priceLabel = CardFormater.getPriceLabel (price);
            addChild (priceLabel);
            cardSensor = new CardSensor (this);
        }
        private function formatMirror () :void {
            mirror = new Sprite();

            CardFormater.drawMirror(mirror, MIRROR_WIDTH, MIRROR_HEIGHT, getType());

            mirrorPriceLabel = CardFormater.getMirrorPriceLabel(price);
            mirror.addChild (mirrorPriceLabel);

            attackLabel = CardFormater.getMirrorAttackLabel(cardData.getAttack());
            attackLabel.x = 7;
            attackLabel.y = mirror.height - 30;
            if (getType() == CardData.UNIT) {
                mirror.addChild (attackLabel);
            }

            healthLabel =  CardFormater.getMirrorHealthLabel(cardData.getHealth());
            healthLabel.x = mirror.width - 25;
            healthLabel.y = attackLabel.y;
            if (getType() == CardData.UNIT) {
                mirror.addChild (healthLabel);
            }

            titleLabel = CardFormater.getMirrorTitleLabel (MIRROR_WIDTH, cardData.getTitle());
            titleLabel.y = Math.round (mirror.height * 0.4);
            mirror.addChild (titleLabel);

            descriptionLabel = CardFormater.getMirrorDescriptionLabel(MIRROR_WIDTH, 80, parseDescription(cardData.getDescription()))
            descriptionLabel.y = Math.round (mirror.height * 0.55);
            mirror.addChild (descriptionLabel);

        }
        private function formatShirt () :void {
            shirt = new Sprite ();
            CardFormater.drawShirt(shirt, MIRROR_WIDTH, MIRROR_HEIGHT);

            smallShirt = new Sprite ();
            CardFormater.drawSmallShirt(smallShirt);
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
                mirrorPriceLabel.defaultTextFormat = mirrorSaleFormat;
                priceLabel.defaultTextFormat = saleFormat;
            } else if (price > defaultPrice) {
                mirrorPriceLabel.defaultTextFormat =mirrorExpensiveFormat
                priceLabel.defaultTextFormat = expensiveFormat;
            } else {
                mirrorPriceLabel.defaultTextFormat = mirrorPriceFormat;
                priceLabel.defaultTextFormat = priceFormat;
            }
            mirrorPriceLabel.text = '' + price;
            priceLabel.text = '' + price;

        }

        public function cancelSale (value:int) :void {
            price += value;

            if (price > defaultPrice) {
                price = defaultPrice;
            }

            if (price < defaultPrice) {
                mirrorPriceLabel.defaultTextFormat = mirrorSaleFormat;
                priceLabel.defaultTextFormat = saleFormat;
            } else {
                mirrorPriceLabel.defaultTextFormat = mirrorPriceFormat;
                priceLabel.defaultTextFormat = priceFormat;
            }
            mirrorPriceLabel.text = '' + price;
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
            var result:String = StringUtil.format(str, spellPower);
            return result;
        }
	
		public function getMirror () :Sprite {
			return mirror;
		}
		
		public function getMirrorBitmap () :Bitmap {
			return getBitmapCopy (mirror);
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

        public function glowMirror () :void {
            getMirror().filters = [new GlowFilter (0x00FFFF)];
        }

        public function stopGlowMirror () :void {
            getMirror().filters = [];
        }
		
		
	}

}