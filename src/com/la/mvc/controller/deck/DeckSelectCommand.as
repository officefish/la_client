/**
 * Created by root on 11/4/14.
 */
package com.la.mvc.controller.deck {
import com.la.event.DeckServiceEvent;
import com.la.event.LobbyEvent;
import com.la.mvc.model.HeroModel;
import com.la.mvc.view.deck.DeckList;


import org.robotlegs.mvcs.Command;

public class DeckSelectCommand extends Command {

    [Inject]
    public var event:DeckServiceEvent;

    [Inject (name='heroModel')]
    public var heroModel:HeroModel;

    [Inject (name='deckList')]
    public var list:DeckList;



    override public function execute():void {
        dispatch(new LobbyEvent(LobbyEvent.STARTUP_LOBBY));

        heroModel.heroId = event.getData().hero_id;
        heroModel.deckId = event.getData().deck_id;
        heroModel.type = event.getData().hero_uid;
        heroModel.level = event.getData().level;

        list.close();


    }
}
}