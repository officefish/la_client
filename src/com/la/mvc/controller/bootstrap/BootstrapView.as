/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.bootstrap {
import com.la.mvc.view.ICollection;
import com.la.mvc.view.IIntro;
import com.la.mvc.view.card.PreflopCard;
import com.la.mvc.view.deck.DeckList;
import com.la.mvc.view.deck.EnemyDeck;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.field.IField;
import com.la.mvc.view.lobby.Lobby;
import com.la.mvc.view.mediator.DeckListMediator;
import com.la.mvc.view.mediator.FieldMediator;
import com.la.mvc.view.mediator.IntroMediator;
import com.la.mvc.view.mediator.LobbyMediator;
import com.la.mvc.view.mediator.PlayerDeckMediator;
import com.la.mvc.view.mediator.PreflopCardMediator;
import com.la.mvc.view.mediator.SceneMediator;
import com.la.mvc.view.scene.IScene;

import org.robotlegs.core.IMediatorMap;

public class BootstrapView {
    public function BootstrapView(mediatorMap:IMediatorMap) {
        mediatorMap.mapView(IIntro, IntroMediator);
        mediatorMap.mapView(IField, FieldMediator);
        mediatorMap.mapView(IScene, SceneMediator);
        mediatorMap.mapView(PlayerDeck, PlayerDeckMediator);
        mediatorMap.mapView(Lobby, LobbyMediator);
        mediatorMap.mapView(DeckList, DeckListMediator);
        mediatorMap.mapView(PreflopCard, PreflopCardMediator);


        //mediatorMap.mapView(ICollection, CollectionView);
    }
}
}
