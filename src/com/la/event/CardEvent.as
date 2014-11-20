/**
 * Created by root on 11/14/14.
 */
package com.la.event {
import flash.events.Event;

public class CardEvent extends Event {

    private var _data:Object;

    public static const PREFLOP_CLICK:String = 'preflopClick';

    public function CardEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
        _data = data;
        super(type, bubbles, cancelable);
    }

    public function get data () :Object {
        return _data;
    }

    override public function clone():Event {
        return new CardEvent(type, data, bubbles, cancelable);
    }
}

}