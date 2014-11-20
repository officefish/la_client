/**
 * Created by root on 11/15/14.
 */
package com.la.mvc.controller.match.step {
import com.la.event.MatchServiceEvent;
import com.la.mvc.model.DeckModel;
import com.la.mvc.model.MatchModel;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.field.IField;
import com.la.state.GameState;
import com.ps.cards.CardData;
import com.ps.cards.CardData;

import org.robotlegs.mvcs.Command;

public class ReadyCommand extends Command {

    [Inject (name='field')]
    public var field:IField;

    [Inject (name='playerDeck')]
    public var playerDeck:PlayerDeck;

    [Inject]
    public var event:MatchServiceEvent;

    [Inject (name='deckModel')]
    public var model:DeckModel;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;



    override public function execute():void {

        rootModel.currentState = GameState.PLAYER_STEP_PREVIEW;

        var cardData:CardData = getCardData(event.getData().card);
        model.addPlayerCard(cardData);

        field.enableStepButton ();

        playerDeck.price = event.getData().price;
        //playerDeck.unblock();

        playerDeck.addCard(cardData, true);

        field.setPlayerPrice (playerDeck.price)
    }

    private function getCardData (card:Object) :CardData {
       var attack:int = card.attack;
       var health:int = card.health;
       var price:int = card.price;
       var title:String = card.title;
       var description:String = card.description;
       var cardData:CardData = new CardData(attack, health, price);
       cardData.id = card.id;
       cardData.setTitle(title);
       cardData.setDescription(description);
       return cardData;

    }
}
}