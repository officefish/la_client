/**
 * Created by root on 10/2/14.
 */
package com.la.mvc.controller.lobby {
import com.la.event.LobbyServiceEvent;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.lobby.Lobby;

import org.robotlegs.mvcs.Command;


public class JoinToLobbyCommand extends Command {

    [Inject]
    public var lobbyEvent:LobbyServiceEvent;

    [Inject(name="lobby")]
    public var lobby:Lobby;

    [Inject (name='rootModel')]
    public var model:RootModel;


    override public function execute () :void {
        var id:uint = lobbyEvent.getData()['id'];
        var hero_uid:uint = lobbyEvent.getData()['hero_uid'];
        var level:uint = lobbyEvent.getData()['level'];
        var player:Boolean = false;
        if (model.userId == id) player = true;
        lobby.addUnit(id, hero_uid, level, player);
    }
}
}
