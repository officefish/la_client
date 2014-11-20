/**
 * Created by root on 9/23/14.
 */
package com.la.mvc.view.lobby {
import com.greensock.events.LoaderEvent;
import com.la.event.LobbyEvent;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;

public class Lobby extends Sprite {

    private var playersStack:Stack;
    private var inviteStack:Stack;
    private var suggestionStack:Stack;

    private var darkenSprite:Sprite;
    private var chooseModeWidget:ChooseModeWidget;
    private var id:int;

    public function Lobby() {

        playersStack = new Stack('Список игроков', 320,540);
        playersStack.x = 10;
        playersStack.y = 10;
        addChild(playersStack)

        inviteStack = new Stack('Вас пригласили', 380, 240);
        inviteStack.x = 410;
        inviteStack.y = 10;
        addChild(inviteStack);

        suggestionStack = new Stack('Вы пригласили', 380, 240);
        suggestionStack.x = 410;
        suggestionStack.y = 310;
        addChild(suggestionStack);

        addEventListener(Unit.INVITE, onInvite, true);
        addEventListener(SuggestionUnit.CANCEL, onCancel, true);
        addEventListener(InviteUnit.ACCEPT, onAccept, true);
        addEventListener(InviteUnit.REJECT, onReject, true);


    }



    public function clear () :void {
        playersStack.clear ();
        suggestionStack.clear ();
        inviteStack.clear ();
    }

    private function onInvite (event:Event) :void {
        var unit:Unit = event.target as Unit;
        id = unit.getId();
        darken();
        chooseMode();

    }

    private function chooseMode () :void {
        if (!chooseModeWidget) {
            chooseModeWidget = new ChooseModeWidget();
            chooseModeWidget.addEventListener(ChooseModeWidget.SELECT, onModeSelect);
        }
        chooseModeWidget.x = (stage.stageWidth - chooseModeWidget.width) / 2;
        chooseModeWidget.y = (stage.stageHeight - chooseModeWidget.height) / 2;
        addChild(chooseModeWidget);
    }

    private function onModeSelect (event:Event) :void {
         var e:LobbyEvent = new LobbyEvent(LobbyEvent.INVITE);
         e.setMode (chooseModeWidget.getMode());
         e.setId(id);
         removeChild(chooseModeWidget);
         removeChild(darkenSprite);
         dispatchEvent(e);

    }

    private function darken () :void {
        if (darkenSprite == null) {
            darkenSprite = new Sprite();
        }
        darkenSprite.graphics.clear();
        darkenSprite.graphics.beginFill(0x222222, 0.8);
        darkenSprite.graphics.drawRect(0,0,this.stage.stageWidth, stage.stageHeight);
        darkenSprite.graphics.endFill();
        addChild(darkenSprite);
    }

    private function onCancel (event:Event) :void {
        var unit:IUnit = event.target as IUnit;
        var id:int = unit.getId();
        var e:LobbyEvent = new LobbyEvent(LobbyEvent.CANCEL);
        e.setId(id);
        dispatchEvent(e);
    }

    private function onReject (event:Event) :void {
        var unit:IUnit = event.target as IUnit;
        var id:int = unit.getId();
        var e:LobbyEvent = new LobbyEvent(LobbyEvent.REJECT);
        e.setId(id);
        dispatchEvent(e);
    }

    private function onAccept (event:Event) :void {
        var unit:IUnit = event.target as IUnit;
        var id:int = unit.getId();
        trace(unit);
        var mode:int = (unit as InviteUnit).getMode();
        var e:LobbyEvent = new LobbyEvent(LobbyEvent.ACCEPT);
        e.setId(id);
        e.setMode(mode);
        dispatchEvent(e);
    }

    public function addUnit (id:int, hero_uid:int, level:int, player:Boolean) :void {
        var unit:Unit = new Unit(id, hero_uid, level, player);
        unit.x = 5;
        playersStack.addUnit(unit);
        playersStack.sort()
    }

    public function removeUnit (id:int) :void {
        var targetUnit:IUnit = playersStack.getUnitById(id);
        if (targetUnit) {
            playersStack.removeUnit(targetUnit as Unit);
            playersStack.sort()
        }
        targetUnit = suggestionStack.getUnitById(id);
        if (targetUnit) {
            suggestionStack.removeUnit(targetUnit as SuggestionUnit);
            suggestionStack.sort()
        }
        targetUnit = inviteStack.getUnitById(id);
        if (targetUnit) {
            inviteStack.removeUnit(targetUnit as InviteUnit);
            inviteStack.sort()
        }
    }

    public function confirmInvite (id:int, mode:int, hero_uid:int, level:int) :void {
        var targetUnit:IUnit = playersStack.getUnitById(id);
        if (targetUnit) {
            (targetUnit as Unit).confirmInvite();
        }
        var unit:SuggestionUnit = new SuggestionUnit(id, hero_uid, level, mode);
        unit.x = 5;
        suggestionStack.addUnit(unit);
        suggestionStack.sort()
        

    }

    public function cancelInvite (id:int) :void {
        var targetUnit:IUnit = inviteStack.getUnitById(id);
        if (targetUnit) {
            inviteStack.removeUnit(targetUnit as DisplayObject);
            inviteStack.sort()
        }

    }

    public function invite (id:int, mode:int, hero_uid:int, level:int) :void {
        var initiator:IUnit = playersStack.getUnitById(id);
        if (initiator) {
            var unit:InviteUnit = new InviteUnit(id, hero_uid, level, mode);
            unit.x = 5;
            inviteStack.addUnit(unit);
            inviteStack.sort()

        }
    }

    public function confirmCancel (id:int) :void {
        var targetUnit:IUnit = suggestionStack.getUnitById(id);
        if (targetUnit) {
            suggestionStack.removeUnit(targetUnit as DisplayObject);
            suggestionStack.sort()
        }
        targetUnit = playersStack.getUnitById(id);
        if (targetUnit) {
            (targetUnit as Unit).confirmCancel();
        }
    }

    public function rejectInvite (id:int) :void {
        var targetUnit:IUnit = suggestionStack.getUnitById(id);
        if (targetUnit) {
            suggestionStack.removeUnit(targetUnit as DisplayObject);
            suggestionStack.sort();
        }
        targetUnit = playersStack.getUnitById(id);
        if (targetUnit) {
            (targetUnit as Unit).reject();
        }
    }

    public function confirmReject (id:int) :void {
        cancelInvite(id);
    }



}
}
