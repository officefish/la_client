/**
 * Created by root on 11/9/14.
 */
package com.la.mvc.controller.match {
import com.la.event.SceneEvent;
import com.la.mvc.service.MatchService;
import com.la.mvc.view.deck.PlayerDeck;

import org.robotlegs.mvcs.Command;

public class ResponsePreflopInitCommand extends Command {

    [Inject]
    public var service:MatchService;

    override public function execute():void {
        trace('responsePreflopInitCommand')
        service.sendMessage('end_change_preflop', {});
    }
}
}