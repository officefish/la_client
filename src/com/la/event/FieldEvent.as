/**
 * Created by root on 10/24/14.
 */
package com.la.event {
import flash.events.Event;

public class FieldEvent extends Event {

    public static const WELCOME_COMPLETE:String = 'welcomeAnimationComplete';

    public function FieldEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable)
    }

    override public function clone():Event {
        return new FieldEvent(type, bubbles, cancelable)
    }
}

}