/**
 * Created by root on 10/2/14.
 */
package com.la.event {
import flash.events.Event;

public class LobbyServiceEvent extends Event {

    private var data:Object;

    public static const PLAYERS_INIT:String = 'playersInit';
    public static const USER_JOIN:String = 'userJoin';

    public static const INVITE:String = 'invite'
    public static const CONFIRM_SEND_INVITE:String = 'confirmSendInvite';
    public static const CANCEL_INVITE:String = 'cancelInvite';
    public static const CONFIRM_SEND_CANCEL:String = 'confirmSendCancel';
    public static const REJECT_INVITE:String = 'rejectInvite';
    public static const CONFIRM_SEND_REJECT:String = 'confirmSendReject';
    public static const USER_LEAVE:String = 'userLeave';
    public static const ACCEPT_INVITATION:String = 'acceptInvitation';


    public function LobbyServiceEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
        super (type, bubbles, cancelable);
        this.data = data;
    }
    
    public function getData () :Object {
        return data;
    }

    override public function clone () :Event {
        return new LobbyServiceEvent(type, data, bubbles, cancelable);
    }
}
}
