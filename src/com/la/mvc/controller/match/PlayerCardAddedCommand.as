/**
 * Created by root on 11/16/14.
 */
package com.la.mvc.controller.match {
import com.la.mvc.model.RootModel;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.state.GameState;

import org.robotlegs.mvcs.Command;

public class PlayerCardAddedCommand extends Command {

    [Inject (name='playerDeck')]
    public var playerDeck:PlayerDeck;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    override public function execute():void {

        switch (rootModel.currentState) {
            case GameState.PLAYER_STEP_PREVIEW: {
                rootModel.currentState = GameState.PLAYER_STEP;
                playerDeck.unblock();
                playerDeck.glowAvailableCards();
                break;
            }

        }
    }
}
}