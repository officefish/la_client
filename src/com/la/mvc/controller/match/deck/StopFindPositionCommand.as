/**
 * Created by root on 11/17/14.
 */
package com.la.mvc.controller.match.deck {
import com.la.mvc.view.field.IField;

import org.robotlegs.mvcs.Command;

public class StopFindPositionCommand extends Command {

    [Inject (name='field')]
    public var field:IField;

    override public function execute():void {
        field.stopFindPosition();
    }
}
}