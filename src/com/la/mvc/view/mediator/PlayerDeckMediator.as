/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.DeckEvent;
import com.la.mvc.view.deck.PlayerDeck;

import org.robotlegs.mvcs.Mediator;

public class PlayerDeckMediator extends Mediator {

    [Inject (name='playerDeck')]
    public var playerDeck:PlayerDeck;

    override public function onRegister():void {
        eventMap.mapListener(playerDeck, DeckEvent.CARDS_ADDED, listener);
        eventMap.mapListener(playerDeck, DeckEvent.PLAYER_CARD_ADDED, listener);
        eventMap.mapListener(playerDeck, DeckEvent.FIND_POSITION, listener);
        eventMap.mapListener(playerDeck, DeckEvent.STOP_FIND_POSITION, listener);
        eventMap.mapListener(playerDeck, DeckEvent.PLAYER_CARD_PLAY, listener);
    }
    private function listener (event:DeckEvent) :void {
       dispatch(event);
    }
    override public function onRemove():void {
        super.onRemove()
    }
}
}