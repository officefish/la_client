/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.bootstrap {
import com.la.mvc.model.CollectionModel;
import com.la.mvc.model.DeckModel;
import com.la.mvc.model.HeroModel;
import com.la.mvc.model.MatchModel;
import com.la.mvc.model.RootModel;

import org.robotlegs.core.IInjector;

public class BootstrapModel {
    public function BootstrapModel(injector:IInjector) {
        injector.mapSingleton(RootModel, 'rootModel');
        injector.mapSingleton(CollectionModel, 'collectionModel');
        injector.mapSingleton(HeroModel, 'heroModel');
        injector.mapSingleton(MatchModel, 'matchModel');
        injector.mapSingleton(DeckModel, 'deckModel');
    }
}
}
