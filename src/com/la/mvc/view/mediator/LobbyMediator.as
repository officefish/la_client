/**
 * Created by root on 10/2/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.LobbyEvent;
import com.la.event.LobbyServiceEvent;
import com.la.mvc.view.lobby.Lobby;

import org.robotlegs.mvcs.Mediator;

public class LobbyMediator extends Mediator {

    [Inject(name="lobby")]
    public var lobby:Lobby;

    override public function onRegister():void {
        eventMap.mapListener(lobby, LobbyEvent.INVITE, handleLobbyEvent);
        eventMap.mapListener(lobby, LobbyEvent.CANCEL, handleLobbyEvent);
        eventMap.mapListener(lobby, LobbyEvent.REJECT, handleLobbyEvent);
        eventMap.mapListener(lobby, LobbyEvent.ACCEPT, handleLobbyEvent);

        eventMap.mapListener(eventDispatcher, LobbyServiceEvent.INVITE, onInvite);
        eventMap.mapListener(eventDispatcher, LobbyServiceEvent.CONFIRM_SEND_INVITE, onConfirmSendInvite);
        eventMap.mapListener(eventDispatcher, LobbyServiceEvent.CANCEL_INVITE, onCancelInvite);
        eventMap.mapListener(eventDispatcher, LobbyServiceEvent.CONFIRM_SEND_CANCEL, onConfirmSendCancel);
        eventMap.mapListener(eventDispatcher, LobbyServiceEvent.REJECT_INVITE, onRejectInvite);
        eventMap.mapListener(eventDispatcher, LobbyServiceEvent.CONFIRM_SEND_REJECT, onConfirmSendReject);
        eventMap.mapListener(eventDispatcher, LobbyServiceEvent.USER_LEAVE, onUserLeave);

    }

    private function handleLobbyEvent (event:LobbyEvent) :void {
        dispatch(event);
    }

    private function onInvite (event:LobbyServiceEvent) :void {
        var id:int = event.getData()['id'];
        var mode:int = event.getData()['mode'];
        var hero:int = event.getData()['hero'];
        var level:int = event.getData()['level'];
        lobby.invite(id, mode, hero, level);
    }
    private function onConfirmSendInvite (event:LobbyServiceEvent) :void {
        var id:int = event.getData()['id'];
        var mode:int = event.getData()['mode'];
        var hero:int = event.getData()['hero'];
        var level:int = event.getData()['level'];
        lobby.confirmInvite(id, mode, hero, level);
    }
    private function onCancelInvite (event:LobbyServiceEvent) :void {
        var id:int = event.getData()['id'];
        lobby.cancelInvite(id)
    }
    private function onConfirmSendCancel (event:LobbyServiceEvent) :void {
        var id:int = event.getData()['id'];
        lobby.confirmCancel(id)
    }
    private function onRejectInvite (event:LobbyServiceEvent) :void {
        var id:int = event.getData()['id'];
        lobby.rejectInvite(id)
    }
    private function onConfirmSendReject (event:LobbyServiceEvent) :void {
        var id:int = event.getData()['id'];
        lobby.confirmReject(id)
    }
    private function onUserLeave (event:LobbyServiceEvent) :void {
        var id:int = event.getData()['id'];
        lobby.removeUnit(id);
    }




}
}
