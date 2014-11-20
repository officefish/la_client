/**
 * Created by root on 10/29/14.
 */
package com.la.mvc.model {
import org.robotlegs.mvcs.Actor;

public class HeroModel extends Actor {

    private var _level:int;
    private var _type:int;
    private var _hero_id:int;
    private var _deck_id:int;

    public function HeroModel() {

    }

    public function set type (value:int) :void {
        this._type = value;
    }

    public function get type () :int {
        return _type;
    }

    public function set level (value:int) :void {
        _level = value;
    }

    public function get level () :int {
        return _level;
    }

    public function set heroId (value:int) :void {
        _hero_id = value;
    }

    public function get heroId () :int {
        return _hero_id;
    }

    public function set deckId (value:int) :void {
        _deck_id = value;
    }

    public function get deckId () :int {
        return _deck_id;
    }
}
}
