/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.controller.match {
import com.la.event.MatchEvent;
import com.la.mvc.model.CollectionModel;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.IGame;
import com.la.mvc.view.deck.EnemyDeck;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.field.IField;
import com.la.mvc.view.scene.IScene;
import com.la.state.GameState;

import flash.display.DisplayObject;


import org.robotlegs.mvcs.Command;

public class StartupMatchCommand extends Command {

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    [Inject (name='scene')]
    public var scene:IScene;

    [Inject (name='field')]
    public var field:IField;

    [Inject (name='playerDeck')]
    public var playerDeck:PlayerDeck;

    [Inject (name='enemyDeck')]
    public var enemyDeck:EnemyDeck;

    override public function execute():void {
        field.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);

        contextView.addChildAt(field as DisplayObject, 0);

        playerDeck.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
        contextView.addChild(playerDeck);
        playerDeck.visible = false;
        playerDeck.setScene(scene);
        playerDeck.setPlayDistance((field as DisplayObject).height);

        enemyDeck.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
        contextView.addChild(enemyDeck);
        enemyDeck.setScene(scene);


        scene.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
        scene.darken();
        contextView.addChild(scene as DisplayObject);

        dispatch(new MatchEvent(MatchEvent.STARTUP_COMPLETE));
    }
}
}