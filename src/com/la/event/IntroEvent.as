/**
 * Created by root on 10/23/14.
 */
package com.la.event {
import flash.events.Event;

public class IntroEvent extends Event {

    public static const SELECT_COLLECTION:String = 'selectCollection';
    public static const SELECT_GAME:String = 'selectGame';
    public static const SELECT_STUDY:String = 'selectStudy';
    public static const SELECT_MARKET:String = 'selectMarket';
    public static const SELECT_QUEST:String = 'selectQuest';
    public static const SELECT_ARENA:String = 'selectArena';
    public static const COMPLETE:String = 'introComplete';

    public function IntroEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable)
    }

    override public function clone():Event {
        return new IntroEvent(type, bubbles, cancelable)
    }
}

}