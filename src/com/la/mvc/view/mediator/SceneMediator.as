/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.SceneEvent;
import com.la.mvc.view.scene.IScene;

import org.robotlegs.mvcs.Mediator;

public class SceneMediator extends Mediator {

    [Inject (name='scene')]
    public var scene:IScene;

    override public function onRegister():void {
        eventMap.mapListener(scene, SceneEvent.CHANGE_PREFLOP, listener);
        eventMap.mapListener(scene, SceneEvent.PREFLOP_INIT, listener);
        eventMap.mapListener(scene, SceneEvent.PREFLOP_COMPLETE, listener);
        eventMap.mapListener(scene, SceneEvent.WELCOME_COMPLETE, listener);
        eventMap.mapListener(scene, SceneEvent.LIGHTEN_COMPLETE, listener);
    }

    private function listener (event:SceneEvent) :void {
        dispatch(event);
    }

    override public function onRemove():void {
        super.onRemove()
    }
}
}