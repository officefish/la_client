/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.IntroEvent;
import com.la.mvc.view.IIntro;

import flash.display.DisplayObject;

import org.robotlegs.mvcs.Mediator;

public class IntroMediator extends Mediator {

    [Inject]
    public var intro:IIntro;

    override public function onRegister():void {
        eventMap.mapListener(intro, IntroEvent.SELECT_GAME, select);
        eventMap.mapListener(intro, IntroEvent.SELECT_ARENA, select);
        eventMap.mapListener(intro, IntroEvent.SELECT_QUEST, select);
        eventMap.mapListener(intro, IntroEvent.SELECT_MARKET, select);
        eventMap.mapListener(intro, IntroEvent.SELECT_COLLECTION, select);
        eventMap.mapListener(intro, IntroEvent.SELECT_STUDY, select);
        eventMap.mapListener(intro, IntroEvent.COMPLETE, complete);
    }

    private function select (event:IntroEvent) :void {
        dispatch(event);
    }
    private function complete (event:IntroEvent) :void {
        intro.destroy ();
        if (contextView.contains(intro as DisplayObject)) contextView.removeChild(intro as DisplayObject);
        dispatch(event);
    }



    override public function onRemove():void {
        super.onRemove()
    }
}
}