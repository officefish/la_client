/**
 * Created by root on 11/2/14.
 */
package com.la.event {
import flash.events.Event;

public class DeckServiceEvent extends Event {

    private var _data:Object;

    public static const DECK_LIST_INIT:String ='deckListInit';
    public static const RESPONSE_SELECT_DECK:String = 'responseSelectDeck';
    public static const DECK_SELECT:String = 'deckSelect';

    public function DeckServiceEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
        this._data = data;
        super(type, bubbles, cancelable)
    }

    public function getData () :Object {
        return _data;
    }

    override public function clone():Event {
        return new DeckServiceEvent(type, _data, bubbles, cancelable)
    }
}

}