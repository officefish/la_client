/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.init {
import com.la.event.GameContextEvent;
import com.la.mvc.view.IIntro;

import flash.display.DisplayObject;

import org.robotlegs.mvcs.Command;

public class InitViewCommand extends Command {

    [Inject]
    public var intro:IIntro;

    override public function execute():void {

        contextView.addChild(intro as DisplayObject);
        dispatch(new GameContextEvent(GameContextEvent.VIEW_INIT_COMPLETE));
    }
}
}