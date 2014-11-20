/**
 * Created by root on 10/26/14.
 */
package com.la.event {
import flash.events.Event;

public class DeckEvent extends Event {

    public static const CARDS_ADDED:String = 'cardsAdded';
    public static const STARTUP_DECK_LIST:String = 'startupDeckList';
    public static const STARTUP_DECK_SERVICE:String = 'startupDeckService';
    public static const SELECT:String = 'deckListItemSelect';
    public static const CLOSE:String = 'deckClose';
    public static const PLAYER_CARD_ADDED:String = 'playerCardAdded';

    public static const FIND_POSITION:String = 'findPosition';
    public static const STOP_FIND_POSITION:String = 'stopFindPosition';

    public static const PLAYER_CARD_PLAY:String = 'playerCardPlay';


    private var _data:Object;

    public function DeckEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
        _data = data;
        super(type, bubbles, cancelable);
    }

    public function get data () :Object {
        return _data;
    }

    override public function clone():Event {
        return new DeckEvent(type, data, bubbles, cancelable);
    }
}

}