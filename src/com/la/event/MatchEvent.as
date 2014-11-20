/**
 * Created by root on 10/24/14.
 */
package com.la.event {
import flash.events.Event;

public class MatchEvent extends Event {

    public static const STARTUP_MATCH:String = 'startupMatch';
    public static const COLLECTION_INIT:String = 'collectionInit';
    public static const PREFLOP:String = 'preflop';
    public static const INIT_MATCH_MODEL:String = 'initMatchModel';
    public static const STARTUP_COMPLETE:String = 'startupComplete';


    public function MatchEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable)
    }

    override public function clone():Event {
        return new MatchEvent(type, bubbles, cancelable)
    }
}

}