/**
 * Created by root on 10/28/14.
 */
package com.la.mvc.controller.match {
import com.la.mvc.model.CollectionModel;
import com.la.mvc.model.RootModel;

import org.robotlegs.mvcs.Command;

public class InitMatchModelCommand extends Command {

    [Inject (name='collectionModel')]
    public var collectionModel:CollectionModel;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    override public function execute():void {
        collectionModel.init (rootModel.currentCollectionId);
    }
}
}