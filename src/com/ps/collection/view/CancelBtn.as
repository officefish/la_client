/**
 * Created by root on 9/19/14.
 */
package com.ps.collection.view {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

public class CancelBtn extends Sprite {

    private var lbl:TextField;

    public static const CANCEL:String = 'cancel'

    public function CancelBtn() {

        var format:TextFormat = new TextFormat();
        format.color = 0xffffff;
        format.size = 14;
        format.bold = true;

        lbl = new TextField();
        lbl.defaultTextFormat = format;
        lbl.width = 70;
        lbl.height = 30;
        lbl.text = 'Сбросить'
        lbl.mouseEnabled = false;
        addChild(lbl);

        buttonMode = true;

        addEventListener(MouseEvent.CLICK, onClick)

    }

    private function onClick (event:MouseEvent) :void {
        dispatchEvent(new Event(CANCEL))
    }
}
}
