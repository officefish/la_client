/**
 * Created by root on 10/26/14.
 */
package com.la.mvc.controller.deck {
import com.la.event.DeckEvent;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.scene.IScene;

import org.robotlegs.mvcs.Command;

public class CardsAddedCommand extends Command {

    [Inject]
    public var event:DeckEvent;

    [Inject (name='scene')]
    public var scene:IScene;

    [Inject (name='playerDeck')]
    public var playerDeck:PlayerDeck;

    override public function execute():void {
       scene.moveDownPreflop(event.data.cards, playerDeck.shiftX);
    }
}
}