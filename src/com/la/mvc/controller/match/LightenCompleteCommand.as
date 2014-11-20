/**
 * Created by root on 11/15/14.
 */
package com.la.mvc.controller.match {
import com.la.mvc.service.MatchService;

import org.robotlegs.mvcs.Command;

public class LightenCompleteCommand extends Command {


    [Inject]
    public var service:MatchService;

    override public function execute():void {
        service.sendMessage('ready', {});
    }
}
}