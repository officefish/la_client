/**
 * Created by root on 10/28/14.
 */
package com.la.mvc.controller.lobby {
import com.la.mvc.model.HeroModel;
import com.la.mvc.model.RootModel;
import com.la.mvc.service.LobbyService;

import org.robotlegs.mvcs.Command;

public class StartupLobbyServiceCommand extends Command {

    [Inject]
    public var service:LobbyService;


    [Inject (name='rootModel')]
    public var model:RootModel;

    [Inject (name='heroModel')]
    public var heroModel:HeroModel;


    override public function execute():void {
        trace('startupLobbyServiceCommand ' + heroModel.type + ', ' + heroModel.level);
        service.init();
        service.setUserData({'id':model.userId, 'hero_id':heroModel.heroId, 'deck_id':heroModel.deckId, 'hero_uid':heroModel.type, 'level':heroModel.level});
        service.connect();
    }
}
}