/**
 * Created by root on 10/23/14.
 */
package com.la.mvc {
import com.la.mvc.controller.bootstrap.BootstrapClasses;
import com.la.mvc.controller.bootstrap.BootstrapController;
import com.la.mvc.controller.bootstrap.BootstrapModel;
import com.la.mvc.controller.bootstrap.BootstrapService;
import com.la.mvc.controller.bootstrap.BootstrapView;

import flash.display.DisplayObjectContainer;

import org.robotlegs.base.ViewInterfaceMediatorMap;
import org.robotlegs.core.IMediatorMap;

import org.robotlegs.mvcs.Context;

public class GameContext extends Context {
    public function GameContext(contextView:DisplayObjectContainer) {
        _mediatorMap = new ViewInterfaceMediatorMap(contextView, createChildInjector(), reflector);
        super (contextView, true);
    }

    override public function startup () :void {
        configure();
        super.startup();
    }

    private function configure () :void {
        new BootstrapClasses(injector);
        new BootstrapController(commandMap);
        new BootstrapModel(injector);
        new BootstrapService(injector);
        new BootstrapView(mediatorMap);
    }


}
}
