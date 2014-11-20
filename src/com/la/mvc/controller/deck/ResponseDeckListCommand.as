/**
 * Created by root on 11/1/14.
 */
package com.la.mvc.controller.deck {
import com.la.mvc.service.DeckService;

import org.robotlegs.mvcs.Command;

public class ResponseDeckListCommand extends Command {

    [Inject]
    public var service:DeckService;

    override public function execute():void {
        service.responseDeckList(1);
    }
}
}