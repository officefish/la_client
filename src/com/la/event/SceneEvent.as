/**
 * Created by root on 10/25/14.
 */
package com.la.event {
import flash.events.Event;

public class SceneEvent extends Event {

    private var _data:Object;

    public static const CHANGE_PREFLOP:String = 'replacePreflop';
    public static const PREFLOP_INIT:String = 'preflopInit';
    public static const PREFLOP_COMPLETE:String = 'preflopComplete';
    public static const WELCOME_COMPLETE:String = 'welcomeAnimationComplete';
    public static const LIGHTEN_COMPLETE:String = 'lightenComplete';

    public function SceneEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
        this._data = data;
        super(type, bubbles, cancelable)
    }

    public function get data () :Object {
        return _data;
    }

    public function set data (value:Object) :void {
        _data = value;
    }

    override public function clone():Event {
        return new SceneEvent(type, data, bubbles, cancelable)
    }
}

}