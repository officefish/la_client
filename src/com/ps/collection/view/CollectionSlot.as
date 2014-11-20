/**
 * Created by root on 9/17/14.
 */
package com.ps.collection.view {
import com.log.Logger;
import com.ps.cards.Card;
import com.ps.field.IPlaceAvailable;
import com.ps.trajectory.TraectoryContainerEvent;
import com.ps.trajectory.TrajectoryContainer;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;

import mx.events.ModuleEvent;

public class CollectionSlot extends Sprite {

    private var card:Card;
    private var clone1:Sprite;
    private var clone2:Sprite;
    private var actualAsset:Sprite;

    private var limitLbl:TextField;
    private var limit:int = 2;

    private var blockSprite:Sprite;

    public function CollectionSlot(card:Card) {
        this.card = card;
        clone1 = getClone(card.getMirrow());
        clone2 = getClone(card.getMirrow());

        actualAsset = new StackSlot (card.getCardData());
        actualAsset.addEventListener(MouseEvent.MOUSE_UP, onAssetMouseUp);

        var format:TextFormat = new TextFormat();
        format.size = 14;
        format.bold = true;
        format.color = 0xFFFFFF;

        limitLbl = new TextField();
        limitLbl.defaultTextFormat = format;
        limitLbl.text = '2';
        limitLbl.mouseEnabled = false;
        limitLbl.width = 30;
        limitLbl.height = 20;
        limitLbl.x = 75;
        limitLbl.y = 220;
        addChild(limitLbl);

        blockSprite = new Sprite();
        blockSprite.graphics.beginFill(0x777777, 0.7)
        blockSprite.graphics.drawRect(0,0,154,224);
        blockSprite.graphics.endFill();

        addChild(clone1)
        addChild(clone2)
        clone2.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        clone2.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }

    private function onMouseDown (event:MouseEvent) :void {
        var point:Point = new Point (0,0);
        point = (event.target as DisplayObject).parent.localToGlobal(point);
        clone2.x = point.x;
        clone2.y = point.y;

        TrajectoryContainer.getInstance().addToPlaceCardLevel(clone2);
        clone2.startDrag ();

        stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function onEnterFrame (event:Event) :void {
        if (stage.mouseX > 620) {
            stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            TrajectoryContainer.getInstance().addToPlaceCardLevel(actualAsset);
            actualAsset.x = stage.mouseX - (actualAsset.width / 2);
            actualAsset.y = stage.mouseY - (actualAsset.height / 2);
            clone2.stopDrag ();
            clone2.x = 0;
            clone2.y = 0;
            addChild(clone2);
            actualAsset.startDrag();
            stage.addEventListener(Event.ENTER_FRAME, onAssetEnterFrame);

        }
    }

    private function onAssetEnterFrame (event:Event) :void {
        if (stage.mouseX < 620) {
            stage.removeEventListener(Event.ENTER_FRAME, onAssetEnterFrame);
            TrajectoryContainer.getInstance().endPlaceCard();
            TrajectoryContainer.getInstance().addToPlaceCardLevel(clone2);
            clone2.x = stage.mouseX - (clone2.width / 2);
            clone2.y = stage.mouseY - (clone2.height / 2);
            actualAsset.stopDrag()
            clone2.startDrag()
            stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
    }

    private function onMouseUp (event:MouseEvent) :void {
        stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        stage.removeEventListener(Event.ENTER_FRAME, onAssetEnterFrame);

        clone2.stopDrag ();
        clone2.x = 0;
        clone2.y = 0;
        addChild(clone2);

    }

    private function onAssetMouseUp (event:MouseEvent) :void {
        stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        stage.removeEventListener(Event.ENTER_FRAME, onAssetEnterFrame);

        actualAsset.stopDrag();
        TrajectoryContainer.getInstance().endPlaceCard();
        dispatchEvent(new CollectionEvent(CollectionEvent.ADD_SLOT, card.getCardData()))
        limit --
        setLimit(limit);

    }

    public function getLimit () :int {
        return limit;
    }

    public function setLimit (value:int) :void {
        limit = value;
        if (!limit) {
           limitLbl.text = '';
           clone2.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
           clone2.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
           addChild(blockSprite)
        } else {
            limitLbl.text = limit.toString();
            clone2.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            clone2.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            if (contains(blockSprite)) {
                removeChild(blockSprite)
            }
        }
    }

    private function getClone (asset:Sprite) :Sprite {

        /*
        if (stage.hasEventListener(Event.ENTER_FRAME)) {
            stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);

        }
        */
        var sprite:Sprite = new Sprite();
        var bitmapData:BitmapData = new BitmapData(asset.width, asset.height, true, 0x00FFFFFF);
        bitmapData.draw(asset);
        var bitmap:Bitmap = new Bitmap(bitmapData);
        sprite.addChild(bitmap);
        return sprite;

    }
}
}
