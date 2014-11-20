/**
 * Created by root on 11/14/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.CardEvent;
import com.la.mvc.view.card.PreflopCard;

import org.robotlegs.mvcs.Mediator;

public class PreflopCardMediator extends Mediator {

    [Inject]
    public var card:PreflopCard;

    override public function onRegister():void {
        eventMap.mapListener(card, CardEvent.PREFLOP_CLICK, listener);
    }

    private function listener (event:CardEvent) :void {
        dispatch(event);
    }

    override public function onRemove():void {
        super.onRemove()
    }
}
}