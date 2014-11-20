/**
 * Created by root on 11/7/14.
 */
package com.la.mvc.controller.match {
import com.la.mvc.model.MatchModel;
import com.la.mvc.model.RootModel;
import com.la.mvc.service.MatchService;

import org.robotlegs.mvcs.Command;

public class StartupMatchServiceCommand extends Command {

    [Inject(name='matchModel')]
    public var matchModel:MatchModel;

    [Inject (name='rootModel')]
    public var model:RootModel;

    [Inject]
    public var service:MatchService;

    override public function execute():void {
        service.init(matchModel.matchId);
        service.setUserData({'id':model.userId})
        service.connect();
    }
}
}