/**
 * Created by root on 11/15/14.
 */
package com.la.mvc.controller.match {
import com.la.event.MatchServiceEvent;
import com.la.mvc.view.deck.EnemyDeck;

import org.robotlegs.mvcs.Command;

public class ChangeOpponentPreflopCommand extends Command {

    [Inject (name='enemyDeck')]
    public var enemyDeck:EnemyDeck;

    [Inject]
    public var event:MatchServiceEvent;

    override public function execute():void {
        trace('ChangeOpponentPreflopCommand');
        //trace(event.getData().opponent_preflop)
        enemyDeck.changeCards(event.getData().opponent_preflop);
    }
}
}