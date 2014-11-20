/**
 * Created by root on 11/17/14.
 */
package com.la.mvc.controller.match.deck {
import com.la.event.DeckEvent;
import com.la.mvc.service.MatchService;
import com.la.mvc.view.field.IField;

import org.robotlegs.mvcs.Command;

public class ResponseCardPlayCommand extends Command {

    [Inject (name='field')]
    public var field:IField;

    [Inject]
    public var event:DeckEvent;

    [Inject]
    public var service:MatchService;

    override public function execute():void {

        service.sendMessage('play_card', {'index':event.data.index, 'position':field.getTokenPreviewIndex()});
    }
}
}