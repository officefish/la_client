/**
 * Created by root on 11/2/14.
 */
package com.la.mvc.controller.deck {
import com.la.event.DeckServiceEvent;
import com.la.mvc.view.deck.DeckList;

import org.robotlegs.mvcs.Command;

public class DeckListInitCommand extends Command {

    [Inject (name='deckList')]
    public var list:DeckList;

    [Inject]
    public var event:DeckServiceEvent;

    override public function execute():void {
        list.setDeckListData(event.getData())
    }
}
}