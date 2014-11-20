/**
 * Created by root on 9/8/14.
 */
package ru.flasher.utils {
public class StringUtil {
        private static const regExp:RegExp = /{(\w)}/g;
        private static var repl:Array;

        public static function format (source:String, ... args):String
        {
            repl = args;
            return source.replace(regExp, replaceFunc);
        }

        private static function replaceFunc (substr:String, group:int, i:uint, str:String):String
        {
            return repl[group];
        }
    }
}
