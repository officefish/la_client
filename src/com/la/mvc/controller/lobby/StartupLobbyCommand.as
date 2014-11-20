/**
 * Created by root on 10/28/14.
 */
package com.la.mvc.controller.lobby {
import com.la.mvc.model.RootModel;
import com.la.mvc.view.lobby.Lobby;
import com.la.state.GameState;

import org.robotlegs.mvcs.Command;

public class StartupLobbyCommand extends Command {

    [Inject (name='lobby')]
    public var lobby:Lobby;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;


    override public function execute():void {
        contextView.addChildAt(lobby, 0);

        rootModel.currentState = GameState.LOBBY;
    }
}
}