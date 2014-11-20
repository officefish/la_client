/**
 * Created by root on 9/18/14.
 */
package com.ps.collection.view {
import com.ps.cards.CardData;

import flash.events.Event;

public class CollectionEvent extends Event {

    public static const ADD_SLOT:String = 'addSlot'
    public static const REMOVE_SLOT:String = 'removeSlot';

    private var cardData:CardData;

    public function CollectionEvent(type:String, cardData:CardData, bubbles:Boolean = false, cancelable:Boolean = false) {
        super (type, bubbles, cancelable);
        this.cardData = cardData;
    }

    public function getCardData () :CardData {
        return cardData;
    }

    override public function clone () :Event {
        return new CollectionEvent(type, cardData, bubbles, cancelable);
    }
}
}
