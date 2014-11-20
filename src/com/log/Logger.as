/**
 * Created by root on 8/30/14.
 */

package com.log {

import flash.display.Stage;
import flash.text.TextField;


public class Logger {
    private static var _stage:Stage;
    private static var _tf:TextField;

    public static function setStage(stage:Stage):void {
        _stage = stage;
    }

    public static function log(msg:String):void {
         tf.appendText(', ' + msg);
        //_stage.addChild(tf)
    }

    private static function get tf ():TextField {
        if (_tf == null) {
            _tf = new TextField();
            _tf.width = 500;
            _tf.wordWrap = true;
        }
        return _tf;
    }

}
}


