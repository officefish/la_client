/**
 * Created by root on 10/2/14.
 */
package com.la.mvc.controller.lobby {
import com.la.event.LobbyEvent;
import com.la.mvc.model.RootModel;
import com.la.mvc.service.LobbyService;
import org.robotlegs.mvcs.Command;

public class AcceptCommand extends Command{

    [Inject]
    public var service:LobbyService;

    [Inject]
    public var event:LobbyEvent;


    [Inject (name='rootModel')]
    public var model:RootModel;


    override public function execute () :void {
        service.sendMessage('accept_invite', {'player1': event.getId(), 'player2': model.userId, 'mode':event.getMode()})
    }
}
}