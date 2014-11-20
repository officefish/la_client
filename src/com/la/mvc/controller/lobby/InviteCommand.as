/**
 * Created by root on 10/2/14.
 */
package com.la.mvc.controller.lobby {
import com.la.event.LobbyEvent;
import com.la.mvc.model.HeroModel;
import com.la.mvc.service.LobbyService;

import org.robotlegs.mvcs.Command;


public class InviteCommand extends Command{

    [Inject]
    public var service:LobbyService;

    [Inject]
    public var event:LobbyEvent;

    [Inject (name='heroModel')]
    public var heroModel:HeroModel;


    override public function execute () :void {
        service.sendMessage('invite_to_game',
                {
            'unit':event.getId(),
            'hero_uid':heroModel.type,
            'level':heroModel.level,
            'mode':event.getMode()
            })
    }
}
}
