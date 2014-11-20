/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.controller.match {
import com.la.event.SceneEvent;
import com.la.mvc.model.DeckModel;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.deck.EnemyDeck;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.scene.IScene;
import com.la.state.GameState;
import com.ps.cards.CardData;

import org.robotlegs.mvcs.Command;

public class WelcomeCompleteCommand extends Command {


    [Inject (name='deckModel')]
    public var model:DeckModel;

    [Inject (name='scene')]
    public var scene:IScene;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    [Inject (name='enemyDeck')]
    public var enemyDeck:EnemyDeck;

    override public function execute():void {

        trace('welcomecompletecommands')

        rootModel.currentState = GameState.PREFLOP;

        scene.preflopCards(model.getPlayerCards());

        var cardDatas:Vector.<CardData> = model.getOpponentCards();

        enemyDeck.addCards(cardDatas, true);


    }
}
}