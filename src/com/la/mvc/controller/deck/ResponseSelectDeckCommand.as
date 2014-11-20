/**
 * Created by root on 11/4/14.
 */
package com.la.mvc.controller.deck {
import com.la.event.DeckServiceEvent;
import com.la.mvc.service.DeckService;

import org.robotlegs.mvcs.Command;

public class ResponseSelectDeckCommand extends Command {

    [Inject]
    public var service:DeckService;

    [Inject]
    public var event:DeckServiceEvent;

    override public function execute():void {
        service.select (1, event.getData().deck, event.getData().hero);
    }
}
}