/**
 * Created by root on 10/2/14.
 */
package com.la.mvc.controller.lobby {
import com.la.event.LobbyServiceEvent;
import com.la.mvc.view.lobby.Lobby;

import org.robotlegs.mvcs.Command;

public class InitPlayersCommand extends Command {

    [Inject]
    public var serviceEvent:LobbyServiceEvent;

    [Inject(name="lobby")]
    public var lobby:Lobby;

    override public function execute () :void {
        var players:Array = serviceEvent.getData()['players'];
        while (players.length) {
            var playerData:Object = players.shift();
            lobby.addUnit(playerData.id, playerData.hero_uid, playerData.level, false)
        }
    }
}
}
