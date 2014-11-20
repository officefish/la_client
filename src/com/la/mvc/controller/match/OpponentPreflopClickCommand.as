/**
 * Created by root on 11/14/14.
 */
package com.la.mvc.controller.match {
import com.la.event.MatchServiceEvent;
import com.la.mvc.view.deck.EnemyDeck;

import org.robotlegs.mvcs.Command;

public class OpponentPreflopClickCommand extends Command {

    [Inject (name='enemyDeck')]
    public var enemyDeck:EnemyDeck;

    [Inject]
    public var event:MatchServiceEvent;

    override public function execute():void {
        trace(event.getData().index);
        trace(event.getData().select);
        enemyDeck.click (event.getData().index, event.getData().select);
    }
}
}