/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.bootstrap {

import com.la.mvc.view.ICollection;
import com.la.mvc.view.IGame;
import com.la.mvc.view.IIntro;
import com.la.mvc.view.deck.DeckList;
import com.la.mvc.view.deck.EnemyDeck;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.field.Field;
import com.la.mvc.view.field.IField;
import com.la.mvc.view.lobby.Lobby;
import com.la.mvc.view.scene.IScene;
import com.la.mvc.view.scene.Scene;
import com.ps.collection.view.CollectionView;
import com.ps.game.Game;
import com.ps.intro.Intro;
import com.la.mvc.view.field.Hero;
import com.la.mvc.view.field.IHero;

import org.robotlegs.core.IInjector;

public class BootstrapClasses {
    public function BootstrapClasses(injector:IInjector) {
        injector.mapClass(IIntro, Intro);
        injector.mapSingletonOf(IGame, Game, 'game');
        injector.mapSingletonOf(ICollection, CollectionView, 'collection');
        injector.mapSingletonOf(IScene, Scene, 'scene');
        injector.mapSingletonOf(IField, Field, 'field');

        var playerHero:Hero = new Hero();
        playerHero.isEnemy = false;
        injector.mapValue(IHero, playerHero, 'playerHero');

        var opponentHero:Hero = new Hero();
        opponentHero.isEnemy = true;
        injector.mapValue(IHero, opponentHero, 'opponentHero');

        injector.mapSingletonOf(PlayerDeck, PlayerDeck, 'playerDeck');
        injector.mapSingletonOf(EnemyDeck, EnemyDeck, 'enemyDeck');
        injector.mapSingletonOf(Lobby, Lobby, 'lobby');

        injector.mapSingletonOf(DeckList, DeckList, 'deckList');
    }
}
}
