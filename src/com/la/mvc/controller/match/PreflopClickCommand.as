/**
 * Created by root on 11/14/14.
 */
package com.la.mvc.controller.match {
import com.la.event.CardEvent;
import com.la.mvc.service.MatchService;

import org.robotlegs.mvcs.Command;

public class PreflopClickCommand extends Command {

    [Inject]
    public var event:CardEvent;

    [Inject]
    public var service:MatchService;


    override public function execute():void {
       service.sendMessage('preflop_click', event.data);
    }
}
}