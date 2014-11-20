/**
 * Created by root on 9/16/14.
 */
package com.ps.intro.toolbar {
import com.greensock.TweenLite;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import mx.events.ModuleEvent;

public class LobbyBtn extends Sprite {

    private var bg:Sprite;
    protected var lbl:TextField;

    private var label:String;
    private var format:TextFormat;


    public function LobbyBtn(label:String, lWidth:int, lHeight:int) {
        this.label = label;
        bg = initBackground (lWidth, lHeight);
        bg.addEventListener(MouseEvent.MOUSE_OVER, onBtnMouseOver)
        bg.addEventListener(MouseEvent.MOUSE_OUT, onBtnMouseOut);
        addChild(bg);

        this.lbl = initLabel (label);
        addChild(lbl);
        placeLabel ();

    }

    public function destroyListeners () :void {
        bg.removeEventListener(MouseEvent.MOUSE_OVER, onBtnMouseOver)
        bg.removeEventListener(MouseEvent.MOUSE_OUT, onBtnMouseOut);
        removeChild(lbl);
        TweenLite.to(bg, 0.5, {colorTransform:{tint:0x444444, tintAmount:1.0}});
    }

    public function activateListeners () :void {
        bg.addEventListener(MouseEvent.MOUSE_OVER, onBtnMouseOver)
        bg.addEventListener(MouseEvent.MOUSE_OUT, onBtnMouseOut);

        this.lbl = initLabel (label);
        lbl.antiAliasType = AntiAliasType.ADVANCED;
        addChild(lbl);
        placeLabel ();

        TweenLite.to(bg, 0, {colorTransform:{tint:0x777777, tintAmount:1.0}});
    }

    protected function initBackground (lWidth:int, lHeight:int) :Sprite {
        var sprite:Sprite = new Sprite();
        return sprite;
    }

    protected function initLabel (label:String):TextField {
        format = new TextFormat();
        format.font = 'Arial'
        format.size = 14;
        format.color = 0xFFFFFF;

        var tf:TextField = new TextField();
       // tf.antiAliasType = AntiAliasType.ADVANCED;
        tf.defaultTextFormat = format;
        tf.text = label;
        tf.autoSize = TextFieldAutoSize.LEFT;
        tf.wordWrap = false;
        tf.selectable = false;
        tf.mouseEnabled = false;
        return tf;
    }

    protected function placeLabel () :void {

    }

    private function onBtnMouseOver (event:MouseEvent) :void {
        TweenLite.to(event.target, 0.5, {colorTransform:{tint:0x444444, tintAmount:1.0}});
    }

    private function onBtnMouseOut (event:MouseEvent) :void {
        TweenLite.to(event.target, 0.5, {colorTransform:{tint:0x777777, tintAmount:1.0}});

    }
}
}
