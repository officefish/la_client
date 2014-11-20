/**
 * Created by root on 11/6/14.
 */
package com.la.mvc.controller.lobby {
import com.la.event.LobbyEvent;
import com.la.event.LobbyServiceEvent;
import com.la.mvc.model.MatchModel;
import com.la.mvc.model.RootModel;
import com.la.mvc.service.LobbyService;
import com.la.mvc.view.lobby.Lobby;
import com.la.state.GameState;

import org.robotlegs.mvcs.Command;

public class CloseLobbyCommand extends Command {

    [Inject]
    public var event:LobbyServiceEvent;

    [Inject]
    public var lobbyService:LobbyService;

    [Inject(name="lobby")]
    public var lobby:Lobby;

    [Inject(name='matchModel')]
    public var matchModel:MatchModel;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    override public function execute():void {
        lobbyService.close();
        lobby.clear();

        if (contextView.contains(lobby)) {
            contextView.removeChild(lobby);
        }

        matchModel.matchId = event.getData().match_id;

        rootModel.currentState = GameState.MATCH;

        dispatch(new LobbyEvent(LobbyEvent.CLOSE));
    }
}
}