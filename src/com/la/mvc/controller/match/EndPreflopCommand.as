/**
 * Created by root on 11/9/14.
 */
package com.la.mvc.controller.match {
import com.la.event.MatchServiceEvent;
import com.la.event.SceneEvent;
import com.la.mvc.model.DeckModel;
import com.la.mvc.model.MatchModel;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.card.Card;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.scene.IScene;
import com.la.state.GameState;
import com.ps.cards.CardData;

import org.robotlegs.mvcs.Command;

public class EndPreflopCommand extends Command {

    [Inject (name='playerDeck')]
    public var playerDeck:PlayerDeck;

    [Inject (name='deckModel')]
    public var model:DeckModel;

    [Inject (name='scene')]
    public var scene:IScene;

    [Inject]
    public var event:MatchServiceEvent;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    [Inject(name='matchModel')]
    public var matchModel:MatchModel;

    override public function execute():void {


        switch (rootModel.currentState) {
            case GameState.PREFLOP_SELECT:
            {
                if (matchModel.preflopEndFlag) {
                    return;
                }
                matchModel.preflopEndFlag = true;

                var vectorData:Vector.<CardData> = getCardDataVector(event.getData().preflop);
                moveDownPreflop(vectorData);
                break;
            }
            case GameState.PREFLOP:
            {


                scene.changePreflopCards ();
                break;
            }
        }
    }

    private function moveDownPreflop (preflopData:Vector.<CardData>) :void {
        model.clearPlayerCards();
        model.addPlayerCards(preflopData);
        var cards:Vector.<Card> = playerDeck.addCards(model.getPlayerCards());
        scene.moveDownPreflop(cards, playerDeck.shiftX);
    }

    private function getCardDataVector (data:Array) :Vector.<CardData> {
        var vector:Vector.<CardData> = new Vector.<CardData>();
        for (var i:int = 0; i < data.length; i ++) {

            var attack:int = data[i].attack;
            var health:int = data[i].health;
            var price:int = data[i].price;
            var title:String = data[i].title;
            var description:String = data[i].description;

            var cardData:CardData = new CardData(attack, health, price);

            cardData.id = data[i].id;

            cardData.setTitle(title);
            cardData.setDescription(description);
            vector.push(cardData)
        }
        return vector;
    }
}
}