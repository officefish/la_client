/**
 * Created by root on 11/6/14.
 */
package com.la.mvc.model {
import org.robotlegs.mvcs.Actor;

public class MatchModel extends Actor {

    private var _matchId:int;
    private var _mode:int;

    private var _preflopEndFlag:Boolean = false;

    private var _playerHero:int;
    private var _opponentHero:int;

    private var _playerHeroHealth:int;
    private var _opponentHeroHealth:int;

    public function MatchModel() {
    }

    public function set matchId (value:int) :void {
        _matchId = value;
    }

    public function get matchId () :int {
        return _matchId;
    }

    public function set mode (value:int) :void {
        _mode = value;
    }

    public function get mode () :int {
        return _mode;
    }

    public function set preflopEndFlag (value:Boolean) :void {
        _preflopEndFlag = value;
    }

    public function get preflopEndFlag () :Boolean {
        return _preflopEndFlag;
    }

    public function set playerHero (value:int) :void {
        _playerHero = value;
    }

    public function get playerHero () :int {
        return _playerHero;
    }

    public function set opponentHero (value:int) :void {
        _opponentHero = value;
    }

    public function get opponentHero () :int {
        return _opponentHero;
    }

    public function set playerHeroHealth (value:int) :void {
        _playerHeroHealth = value;
    }

    public function get playerHeroHealth () :int {
        return _playerHeroHealth;
    }

    public function set opponentHeroHealth (value:int) :void {
        _opponentHeroHealth = value;
    }

    public function get opponentHeroHealth () :int {
        return _opponentHeroHealth;
    }
}
}
