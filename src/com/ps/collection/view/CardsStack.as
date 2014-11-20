/**
 * Created by root on 9/17/14.
 */
package com.ps.collection.view {
import com.log.Logger;
import com.ps.cards.CardData;
import com.ps.field.IPlaceAvailable;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Dictionary;


public class CardsStack extends Sprite  implements IPlaceAvailable{
    private var dictionary:Dictionary;
    private var container:Sprite;

    private var containerMask:Sprite;

    private var countLbl:TextField;
    private var slotCount:int = 0;

    public function CardsStack() {
        graphics.beginFill(0x777777, 1);
        graphics.drawRect(0,0,190,600);
        graphics.endFill();

        containerMask = new Sprite();
        containerMask.graphics.beginFill(0x00FFFF, 0.5);
        containerMask.graphics.drawRect(0,0,190,490);
        containerMask.graphics.endFill();
        containerMask.x = 3;
        containerMask.y = 60;

        var format:TextFormat = new TextFormat();
        format.size = 16;
        format.bold = true;
        format.color = 0xFFFFFF;

        countLbl = new TextField();
        countLbl.defaultTextFormat = format;
        countLbl.text = '0 / 35';
        countLbl.x = 140;
        countLbl.width = 70;
        countLbl.height = 20;
        countLbl.y = 10;
        countLbl.mouseEnabled = false;
        countLbl.selectable = false;
        addChild(countLbl)

        container = new Sprite();
        container.x = 3;
        container.y = 60;
        addChild(container);

        addChild(containerMask);
        container.mask = containerMask;

        dictionary = new Dictionary();

        container.addEventListener(MouseEvent.MOUSE_WHEEL, onRollOver);
    }

    private function onRollOver (event:MouseEvent) :void {
        if (container.height < containerMask.height) {
            return;
        }
        if (event.delta > 0) {
             container.y += 10;
            if (container.y > 60) container.y = 60;
        } else {
            container.y -= 10;
            if (container.y < (containerMask.height - container.height - 60)) {
                container.y += 10;
            }
        }
    }

    public function addSlot (cardData:CardData) :void {
        if (slotCount == 35) {
            return;
        }

        slotCount ++;
        var slot:StackSlot
        if (dictionary[cardData] == null) {
            slot = new StackSlot(cardData)
            slot.y = container.numChildren * 41;
            slot.setCount(1)
            slot.registerListeners()
            container.addChild(slot);
            dictionary[cardData] = slot;

            if (container.height > containerMask.height) {
                container.y = - (container.height - containerMask.height - 60);
            }

        } else {
            slot = dictionary[cardData]
            var count:int = slot.getCount()
            count ++
            slot.setCount(count)
        }

        countLbl.text = slotCount + ' / 35';
    }

    public function removeSlot (cardData:CardData) :void {
        slotCount --;
        var slot:StackSlot = dictionary[cardData];
        var count:int = slot.getCount();
        if (!count) {
            container.removeChild(slot);
            dictionary[cardData] = null;
        }
        countLbl.text = slotCount + ' / 35';
        sort ();
    }

    private function sort () :void {
        var slot:StackSlot;
        for (var i:int = 0; i < container.numChildren; i++) {
            slot = container.getChildAt(i) as StackSlot;
            slot.y = 41 * i;
        }
    }

    public function getCount () :int {
        return slotCount;
    }

    public function getCollection () :Array {
        var arr:Array = [];
        var slot:StackSlot;

        for (var i:int = 0; i < container.numChildren; i ++) {
            slot = container.getChildAt(i) as StackSlot;
            for (var j:int = 0; j < slot.getCount(); j ++) {
                arr.push (slot.getCardData())
            }
        }

        Logger.log(arr.length.toString())

        return arr;
    }

    public function clear () :void {
        while (container.numChildren) {
            container.removeChildAt(0);
        }
        dictionary = new Dictionary();
        slotCount = 0;
        countLbl.text = slotCount + ' / 35';
    }
}
}
