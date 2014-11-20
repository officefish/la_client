/**
 * Created by root on 10/14/14.
 */
package com.la.event {
import flash.events.Event;

public class GameContextEvent extends Event {

    public static const SERVICE_INIT_PROGRESS:String ='serviceInitProgress';
    public static const MODEL_INIT_PROGRESS:String = 'modelInitProgress';
    public static const VIEW_INIT_PROGRESS:String = 'viewInitProgress';
    public static const VIEW_INIT_COMPLETE:String = 'gViewInitComplete';
    public static const MODEL_INIT_COMPLETE:String = 'gModelInitComplete';
    public static const SERVICE_INIT_COMPLETE:String = 'gServiceInitComplete';

    public function GameContextEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        return new GameContextEvent(type, bubbles, cancelable)
    }
}

}