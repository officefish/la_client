/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.card {
import com.ps.cards.CardData;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class CardFormater {

    private static var _priceFormat:TextFormat;
    private static var _saleFormat:TextFormat;
    private static var _expensiveFormat:TextFormat;
    private static var _mirrorPriceFormat:TextFormat;
    private static var _mirrorExpensiveFormat:TextFormat;
    private static var _mirrorSaleFormat:TextFormat;
    private static var _mirrorAttackFormat:TextFormat;
    private static var _mirrorTitleFormat:TextFormat;
    private static var _mirrorDescriptionFormat:TextFormat;
    private static var _mirrorSmallDescriptionFormat:TextFormat;

    public static function drawBody (target:Sprite, width:int, height:int) :void {
        target.graphics.beginFill (0xcccccc, 1);
        target.graphics.drawRect (0, 0, width, height);
        target.graphics.endFill();

        target.graphics.lineStyle (1, 0, 1);
        target.graphics.lineTo (width, 0);
        target.graphics.lineTo (width, height);
        target.graphics.lineTo(0, height);
        target.graphics.lineTo (0, 0);

        target.graphics.beginFill (0xffFFFF, 1);
        target.graphics.drawRect (0, 0, 21, 21);
        target.graphics.endFill ();
    }

    public static function drawMirror (mirror:Sprite, width:int, height:int, type:int) :void {
        mirror.graphics.beginFill (0xcccccc, 1);
        mirror.graphics.drawRect (0, 0, 154, 224);
        mirror.graphics.endFill();

        mirror.graphics.lineStyle (1, 0, 1);
        mirror.graphics.lineTo (154, 0);
        mirror.graphics.lineTo (154, 224);
        mirror.graphics.lineTo(0, 224);
        mirror.graphics.lineTo (0, 0);
        mirror.graphics.lineStyle(0);

        if (type == CardData.UNIT) {
            mirror.graphics.beginFill (0xFFFFFF, 1);
            mirror.graphics.drawRect (0, 194, 30, 30);
            mirror.graphics.endFill ();
        }

        if (type == CardData.UNIT) {
            mirror.graphics.beginFill (0xFFFFFF, 1);
            mirror.graphics.drawRect (124, 194, 30, 30);
            mirror.graphics.endFill ();
        }

        mirror.graphics.beginFill (0xffffff, 1);
        mirror.graphics.drawRect (0, 0, 30, 30);
        mirror.graphics.endFill ();
    }

    public static function drawShirt (target:Sprite, width:int, height:int) :void {
        target.graphics.beginFill (0xFFFFFF, 1);
        target.graphics.drawRect (0, 0, width, height);
        target.graphics.endFill();
        target.graphics.lineStyle (1, 0, 1);
        target.graphics.lineTo (width, 0);
        target.graphics.lineTo (width, height);
        target.graphics.lineTo(0, height);
        target.graphics.lineTo (0, 0);
    }

    public static function drawSmallShirt (target:Sprite) :void {
        target.graphics.beginFill (0xFFFFFF, 1);
        target.graphics.drawRect (0, 0, 100, 150);
        target.graphics.endFill();
        target.graphics.lineStyle (1, 0, 1);
        target.graphics.lineTo (100, 0);
        target.graphics.lineTo (100, 150);
        target.graphics.lineTo(0, 150);
        target.graphics.lineTo (0, 0);
    }

    public static function getPriceLabel (price:int) :TextField {

        var label:TextField = new TextField();
        label.defaultTextFormat = priceFormat;
        label.text = "" + price;
        label.autoSize = TextFieldAutoSize.LEFT;
        label.wordWrap = false;
        label.x = 4;
        label.mouseEnabled = false;

        return label;
    }

    public static function getMirrorPriceLabel (price:int) :TextField {
        var label:TextField = new TextField ();
        label.defaultTextFormat = mirrorPriceFormat;
        label.text = "" + price;
        label.autoSize = TextFieldAutoSize.LEFT;
        label.wordWrap = false;
        label.x = 7;
        label.mouseEnabled = false;
        return label;
    }

    public static function getMirrorAttackLabel (attack:int) :TextField {
        var label:TextField = new TextField ();
        label.height = 25;
        label.defaultTextFormat = mirrorAttackFormat;
        label.text = "" + attack;
        label.autoSize = TextFieldAutoSize.LEFT;
        label.mouseEnabled = false;
        return label;
    }

    public static function getMirrorHealthLabel (health:int) :TextField {
        var label:TextField = new TextField ();
        label.height = 25;
        label.defaultTextFormat = mirrorHealthFormat;
        label.text = "" + health;
        label.autoSize = TextFieldAutoSize.LEFT;
        label.mouseEnabled = false;
        return label;
    }

    public static function getMirrorTitleLabel (width:int, title:String) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
        label.defaultTextFormat = mirrorTitleFormat;
        label.text = title;
        label.mouseEnabled = false;
        return label;
    }

    public static function getMirrorDescriptionLabel (width:int, height:int, description:String) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
        label.height = height;
        label.wordWrap = true;
        label.mouseEnabled = false;
        if (description.length > 20) {
            label.defaultTextFormat = mirrorSmallDescriptionFormat;
        } else {
            label.defaultTextFormat =mirrorDescriptionFormat;
        }
        label.text = description;
        return label;
    }

    public static function get priceFormat () :TextFormat {
        if (!_priceFormat) {
            _priceFormat = new TextFormat();
            _priceFormat.size = 15;
            _priceFormat.bold = true;
            _priceFormat.color = 0x000000;
        }
        return _priceFormat;
    }

    public static function get saleFormat () :TextFormat {
        if (!_saleFormat) {
            _saleFormat = new TextFormat();
            _saleFormat.size = 15;
            _saleFormat.bold = true;
            _saleFormat.color = 0x00FF00;;
        }
        return _saleFormat;
    }

    public static function get expensiveFormat () :TextFormat {
        if (!_expensiveFormat) {
            _expensiveFormat = new TextFormat();
            _expensiveFormat.size = 15;
            _expensiveFormat.bold = true;
            _expensiveFormat.color = 0xFF0000;
        }
        return _expensiveFormat;
    }

    public static function get mirrorPriceFormat () :TextFormat {
        if (!_mirrorPriceFormat) {
            _mirrorPriceFormat = new TextFormat();
            _mirrorPriceFormat.size = 22;
            _mirrorPriceFormat.bold = true;
            _mirrorPriceFormat.color = 0x000000;
        }
        return _mirrorPriceFormat;
    }

    public static function get mirrorSaleFormat () :TextFormat {
        if (!_mirrorSaleFormat) {
            _mirrorSaleFormat = new TextFormat();
            _mirrorSaleFormat.size = 22;
            _mirrorSaleFormat.bold = true;
            _mirrorSaleFormat.color = 0x00FF00;
        }
        return _mirrorSaleFormat;
    }

    public static function get mirrorExpensiveFormat () :TextFormat {
        if (!_mirrorExpensiveFormat) {
            _mirrorExpensiveFormat = new TextFormat();
            _mirrorExpensiveFormat.size = 22;
            _mirrorExpensiveFormat.bold = true;
            _mirrorExpensiveFormat.color = 0x00FF00;
        }
        return _mirrorExpensiveFormat;
    }

    public static function get mirrorAttackFormat () :TextFormat {
        if (!_mirrorAttackFormat) {
            _mirrorAttackFormat = new TextFormat();
            _mirrorAttackFormat.size = 22;
            _mirrorAttackFormat.bold = true;
            _mirrorAttackFormat.color = 0x000000;
        }
        return _mirrorAttackFormat;
    }

    public static function get mirrorHealthFormat () :TextFormat {
        return mirrorAttackFormat;
    }

    public static function get mirrorTitleFormat () :TextFormat {
        if (!_mirrorTitleFormat) {
            _mirrorTitleFormat = new TextFormat();
            _mirrorTitleFormat.align = TextFormatAlign.CENTER;
            _mirrorTitleFormat.size = 14;
            _mirrorTitleFormat.bold = true;
            _mirrorTitleFormat.color = 0x000000;
        }
        return _mirrorTitleFormat;
    }

    public static function get mirrorDescriptionFormat () :TextFormat {
        if (!_mirrorDescriptionFormat) {
            _mirrorDescriptionFormat = new TextFormat();
            _mirrorDescriptionFormat..align = TextFormatAlign.CENTER;
            _mirrorDescriptionFormat.size = 13;
            _mirrorDescriptionFormat.bold = true;
            _mirrorDescriptionFormat.color = 0x000000;
        }
        return _mirrorDescriptionFormat;
    }

    public static function get mirrorSmallDescriptionFormat () :TextFormat {
        if (!_mirrorSmallDescriptionFormat) {
            _mirrorSmallDescriptionFormat = new TextFormat();
            _mirrorSmallDescriptionFormat.align = TextFormatAlign.CENTER;
            _mirrorSmallDescriptionFormat.size = 11;
            _mirrorSmallDescriptionFormat.bold = true;
            _mirrorSmallDescriptionFormat.color = 0x000000;
        }
        return _mirrorSmallDescriptionFormat;
    }



}
}
