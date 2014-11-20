/**
 * Created by root on 10/28/14.
 */
package com.la.event {
import flash.events.Event;

public class LobbyEvent extends Event {
    public static const STARTUP_LOBBY:String = 'startupLobby';
    public static const STARTUP_LOBBY_SERVICE:String = 'startupLobbyService';

    public static const INVITE:String = 'inviteUnit';
    public static const ACCEPT:String = 'acceptInvitation';
    public static const REJECT:String = 'rejectInvitation';
    public static const CANCEL:String = 'cancelInvitation';

    public static const CLOSE:String = 'closeLobby';

    private var _id:int;
    private var _mode:int;

    public function LobbyEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable)
    }

    public function getId () :int {
        return _id;
    }

    public function setId (value:int) :void {
        _id = value;
    }

    public function setMode (value:int) :void {
        this._mode = value;
    }

    public function getMode () :int {
        return _mode;
    }

    override public function clone():Event {
        var event:LobbyEvent = new LobbyEvent(type, bubbles, cancelable);
        event.setId(this.getId());
        event.setMode(this.getMode());
        return event;
    }
}

}