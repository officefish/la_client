/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.init {
import com.la.event.GameContextEvent;

import org.robotlegs.mvcs.Command;

public class InitServiceCommand extends Command {

    override public function execute():void {
        dispatch(new GameContextEvent(GameContextEvent.SERVICE_INIT_COMPLETE));
    }
}
}