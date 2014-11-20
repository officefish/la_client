/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.intro {
import com.la.mvc.model.RootModel;
import com.la.mvc.view.ICollection;
import com.la.state.GameState;

import flash.display.DisplayObject;

import org.robotlegs.mvcs.Command;

public class SelectCollectionCommand extends Command {

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    [Inject (name='collection')]
    public var collection:ICollection;

    override public function execute():void {

        contextView.addChildAt(collection as DisplayObject, 0);
        rootModel.currentState = GameState.COLLECTION;
    }
}
}