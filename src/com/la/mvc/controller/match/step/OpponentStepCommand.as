/**
 * Created by root on 11/17/14.
 */
package com.la.mvc.controller.match.step {
import com.la.event.MatchServiceEvent;
import com.la.mvc.model.DeckModel;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.deck.EnemyDeck;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.field.IField;
import com.la.state.GameState;
import com.ps.cards.CardData;

import org.robotlegs.mvcs.Command;

public class OpponentStepCommand extends Command {

    [Inject]
    public var event:MatchServiceEvent;

    [Inject (name='enemyDeck')]
    public var enemyDeck:EnemyDeck;

    [Inject (name='playerDeck')]
    public var playerDeck:PlayerDeck;

    [Inject (name='field')]
    public var field:IField;


    [Inject (name='deckModel')]
    public var model:DeckModel;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;




    override public function execute():void {
        trace('opponent_step_command');

        rootModel.currentState = GameState.OPPONENT_STEP;

        var cardData:CardData = getCardData(event.getData().opponent_card);
        model.addOpponentCard(cardData);

        field.disableStepButton();

        enemyDeck.price = event.getData().opponent_price;
        enemyDeck.addCard(cardData, true);

        playerDeck.block();

        field.setOpponentPrice(enemyDeck.price);
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