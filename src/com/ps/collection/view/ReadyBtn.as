/**
 * Created by root on 9/19/14.
 */
package com.ps.collection.view {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

public class ReadyBtn extends Sprite {

    private var lbl:TextField;

    public static const READY_CLICK:String = 'ready click';

    public function ReadyBtn()
    {
        graphics.beginFill(0xAAAAAA, 1);
        graphics.drawRect(0,0,170,40);
        graphics.endFill();

        buttonMode = true;

        var format:TextFormat = new TextFormat();
        format.size = 16;
        format.bold = true;

        lbl = new TextField();
        lbl.defaultTextFormat = format;
        lbl.x = 60;
        lbl.y = 10;
        lbl.width = 75;
        lbl.height = 20;
        lbl.text = 'Готово';
        lbl.mouseEnabled = false;
        addChild(lbl);
    }

    public function blur () :void {
        graphics.clear()
        graphics.beginFill(0x2ECCFA, 1);
        graphics.drawRect(0,0,170,40);
        graphics.endFill();
        addEventListener(MouseEvent.CLICK, onClick)
    }

    public function stopBlur () :void {
        graphics.clear()
        graphics.beginFill(0xAAAAAA, 1);
        graphics.drawRect(0,0,170,40);
        graphics.endFill();
        removeEventListener(MouseEvent.CLICK, onClick)
    }

    private function onClick (event:MouseEvent) :void {
        dispatchEvent(new Event(READY_CLICK))
    }
}
}
