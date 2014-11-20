/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.controller.match {
import com.la.event.SceneEvent;
import com.la.mvc.service.MatchService;


import org.robotlegs.mvcs.Command;

public class ResponseChangePreflopCommand extends Command {

    [Inject]
    public var event:SceneEvent;

    [Inject]
    public var service:MatchService;

    override public function execute():void {

        trace('responseChangePreflopCommand')
        var replacement:Array = event.data.replacement;

        service.sendMessage('change_preflop', {'preflop':replacement});
    }
}
}