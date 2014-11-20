/**
 * Created by root on 10/2/14.
 */
package com.la.mvc.controller.lobby {
import com.la.event.LobbyEvent;
import com.la.mvc.service.LobbyService;
import org.robotlegs.mvcs.Command;


public class CancelCommand extends Command{
    [Inject]
    public var service:LobbyService;

    [Inject]
    public var event:LobbyEvent;

    override public function execute () :void {
        service.sendMessage('cancel_invite', {'unit':event.getId()})
    }
}
}
