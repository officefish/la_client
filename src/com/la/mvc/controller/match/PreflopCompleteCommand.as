/**
 * Created by root on 10/26/14.
 */
package com.la.mvc.controller.match {
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.field.IField;
import com.la.mvc.view.field.IHero;
import com.la.mvc.view.scene.IScene;

import org.robotlegs.mvcs.Command;

public class PreflopCompleteCommand extends Command {

    [Inject (name='playerDeck')]
    public var playerDeck:PlayerDeck;

    [Inject (name='field')]
    public var field:IField;

    [Inject (name = 'playerHero')]
    public var playerHero:IHero;

    [Inject (name = 'opponentHero')]
    public var opponentHero:IHero;

    [Inject (name='scene')]
    public var scene:IScene;


    override public function execute():void {
        playerDeck.visible = true;
        scene.lighten ();

        field.addPlayerHero (playerHero);
        field.addOpponentHero (opponentHero);

        playerHero.showHealth();
        opponentHero.showHealth();
    }
}
}