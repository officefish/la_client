/**
 * Created by root on 9/18/14.
 */
package com.ps.collection.view {
import com.log.Logger;
import com.ps.cards.Card;
import com.ps.cards.CardData;
import com.ps.collodion.CollodionEvent;
import com.ps.field.IPlaceAvailable;
import com.ps.trajectory.TrajectoryContainer;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;

public class StackSlot extends Sprite implements IPlaceAvailable{
    private var slotLbl:TextField;
    private var countLbl:TextField;
    private var count:int;

    private var lbl:String;
    private var copy:StackSlot;

    private var card:Card;
    private var mirrow:Sprite;

    public function StackSlot(cardData:CardData) {

        this.card = new Card(cardData)
        this.lbl = cardData.getTitle();
        mirrow = card.getMirrow();

        graphics.beginFill(0xcccccc, 1);
        graphics.drawRect(0,0,185,40);
        graphics.endFill();

        var format:TextFormat = new TextFormat();
        format.size = 12;
        format.bold = true;

        slotLbl = new SlotTextField();
        slotLbl.defaultTextFormat = format;
        slotLbl.text = lbl;
        slotLbl.x = 10;
        slotLbl.width = 120;
        slotLbl.height = 20;
        slotLbl.y = 10;
        slotLbl.mouseEnabled = false;
        slotLbl.selectable = false;
        addChild(slotLbl)

        format.size = 15;

        countLbl = new SlotTextField();
        countLbl.defaultTextFormat = format;
        countLbl.x = 160;
        countLbl.y = 10;
        countLbl.width = 20;
        countLbl.height = 20;
        countLbl.mouseEnabled = false;
        countLbl.selectable = false;
        addChild(countLbl);


    }

    public function registerListeners () :void {
        addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    }

    private function onMouseUp (event:MouseEvent) :void {
        mirrow.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        mirrow.stopDrag();
        TrajectoryContainer.getInstance().endPlaceCard();

        if (!(mirrow.dropTarget is IPlaceAvailable)) {
            dispatchEvent(new CollectionEvent(CollectionEvent.REMOVE_SLOT, card.getCardData()))
        }

    }

    private function onMouseDown (event:MouseEvent) :void {

        var point:Point = new Point (0,0);
        point = (event.target as DisplayObject).localToGlobal(point);

        copy = new StackSlot(card.getCardData());
        copy.x = point.x;
        copy.y = point.y;
        copy.addEventListener(MouseEvent.MOUSE_UP, onCopyMouseUp);

        TrajectoryContainer.getInstance().addToPlaceCardLevel(copy);
        copy.startDrag ();

        count --;
        setCount(count);

        if (!count) {
            visible = false;
        }

        stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function onEnterFrame (event:Event) :void {
        if (stage.mouseX < 610) {

            stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            copy.stopDrag();
            copy.removeEventListener(MouseEvent.MOUSE_UP, onCopyMouseUp);
            TrajectoryContainer.getInstance().endPlaceCard();

            TrajectoryContainer.getInstance().addToPlaceCardLevel(mirrow);
            mirrow.x = stage.mouseX - (mirrow.width / 2);
            mirrow.y = stage.mouseY - (mirrow.height / 2);
            mirrow.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);

            mirrow.startDrag();
            stage.addEventListener(Event.ENTER_FRAME, onMirrowEnterFrame);
        }
    }

    private function onMirrowEnterFrame (event:Event) :void {
        if (mirrow.dropTarget is  IPlaceAvailable) {
            stage.removeEventListener(Event.ENTER_FRAME, onMirrowEnterFrame);
            TrajectoryContainer.getInstance().endPlaceCard();
            TrajectoryContainer.getInstance().addToPlaceCardLevel(copy);
            copy.x = stage.mouseX - (copy.width / 2);
            copy.y = stage.mouseY - (copy.height / 2);
            copy.addEventListener(MouseEvent.MOUSE_UP, onCopyMouseUp);

            mirrow.stopDrag()
            copy.startDrag()
            stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
    }

    private function onCopyMouseUp (event:MouseEvent) :void {
        stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        copy.removeEventListener(MouseEvent.MOUSE_UP, onCopyMouseUp);
        TrajectoryContainer.getInstance().endPlaceCard();
        count ++;
        setCount(count);
        visible = true;
    }


    public function setCount (value:int) :void {
        if (value) {
            countLbl.text = value.toString();
        } else {
            countLbl.text = "";
        }

        count = value;
    }

    public function getCount () :int {
        return count;
    }

    public function getCardData () :CardData {
        return card.getCardData();
    }
}
}
