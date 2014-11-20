/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.model {
import com.la.event.GameContextEvent;
import com.la.state.GameState;

import org.robotlegs.mvcs.Actor;

public class RootModel extends Actor {

    private var _currentState:GameState;
    private var _currentCollectionId:int;
    private var _userId:int;

    public function RootModel() {
    }

    public function set currentState (state:GameState) :void {
        this._currentState = state;
    }

    public function get currentState () :GameState {
        return _currentState;
    }

    public function set currentCollectionId (value:int) :void {
        _currentCollectionId = value;
    }

    public function get currentCollectionId () :int {
        return _currentCollectionId;
    }

    public function set userId (value:int) :void {
        _userId = value;
    }

    public function get userId () :int {
        return _userId;
    }

    public function init () :void {
        currentCollectionId = 0;
        userId = Math.random() * 100000;
        dispatch(new GameContextEvent(GameContextEvent.MODEL_INIT_COMPLETE));
    }
}
}
