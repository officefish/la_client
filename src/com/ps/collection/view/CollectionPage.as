/**
 * Created by root on 9/16/14.
 */
package com.ps.collection.view {
import com.log.Logger;
import com.ps.cards.Card;
import com.ps.cards.CardData;

import flash.display.Sprite;

public class CollectionPage extends Sprite {

    private var cards:Array
    private var shiftX:int = 50;
    private var shiftY:int = 60;

    public function CollectionPage() {
        cards = [];
        graphics.beginFill(0x555555, 1);
        graphics.drawRect(0,0,618,600);
        graphics.endFill();
    }

    public function get cardsCount () :int {
        return cards.length;
    }

    public function addCard (cardData:CardData) :CollectionSlot{
        //Logger.log((cardData is CardData).toString());
        var card:Card = new Card(cardData);
        var slot:CollectionSlot = new CollectionSlot(card)
        //Logger.log(cardData.getTitle().toString())
        cards.push(cardData);

        addChild(slot);
        slot.x = shiftX;
        slot.y = shiftY;
        shiftX += 180;
        if (cardsCount == 3) {
            shiftX = 50;
            shiftY += 40 + card.getMirrow().height;
        }
        return slot;

    }
}
}
