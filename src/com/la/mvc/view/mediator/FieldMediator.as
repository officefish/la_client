/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.FieldEvent;
import com.la.event.MatchEvent;
import com.la.mvc.view.field.IField;

import org.robotlegs.mvcs.Mediator;

public class FieldMediator extends Mediator {

    [Inject (name='field')]
    public var field:IField;

    override public function onRegister():void {
        //eventMap.mapListener(field, FieldEvent.WELCOME_COMPLETE, listener);
    }

    private function listener (event:FieldEvent) :void {
        dispatch(event);
    }

    override public function onRemove():void {
        super.onRemove()
    }
}
}