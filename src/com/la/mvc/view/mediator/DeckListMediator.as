/**
 * Created by root on 11/4/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.DeckEvent;
import com.la.event.DeckServiceEvent;
import com.la.mvc.view.deck.DeckList;

import org.robotlegs.mvcs.Mediator;

public class DeckListMediator extends Mediator {

    [Inject (name='deckList')]
    public var list:DeckList;

    override public function onRegister():void {
        eventMap.mapListener(list, DeckServiceEvent.RESPONSE_SELECT_DECK, listener);
        eventMap.mapListener(list, DeckEvent.CLOSE, close);
    }

    private function listener (event:DeckServiceEvent) :void {
        dispatch(event);
    }

    private function close (event:DeckEvent) :void {
        list.destroy ();
        if (contextView.contains(list)) contextView.removeChild(list);
        dispatch(event);
    }

    override public function onRemove():void {
        super.onRemove()
    }
}
}