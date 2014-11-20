/**
 * Created by root on 9/23/14.
 */
package com.la.mvc.view.lobby {
import com.la.assets.Assets;
import com.transform.Transform;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class Unit extends Sprite implements IUnit{

    private var id:int;
    private var label:TextField;

    private var inviteSprite:Sprite;
    private var inviteLabel:TextField;

    private var confirmInviteLbl:TextField;

    private var block:Boolean = false;

    private var rejectLabel:TextField;

    private var _hero:int;
    private var _level:int;

    private var asset:Bitmap;

    private var levelLabel:TextField;

    public static const INVITE:String = 'invite';

    public function Unit(id:int, hero:int, level:int, player:Boolean = false) {

        this.id = id;


        graphics.beginFill(0xCCCCCC, 1);
        graphics.drawRect(0,0,310,35);
        graphics.endFill();

        var format:TextFormat = new TextFormat();
        format.size = 14;
        format.bold = true;

        if (player) {
            format.color = 0xFFFFFF;
        }
        this.hero = hero;
        this.level = level;

        asset = Assets.getHeroAssetById(hero);
        asset = Transform.scale(asset, 0.29);
        addChild(asset);

        var format:TextFormat = new TextFormat();
        format.size = 14;
        format.bold = true;

        label = new TextField();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.defaultTextFormat = format;
        label.text = 'player_';
        label.autoSize = TextFieldAutoSize.LEFT;
        label.appendText(id.toString());
        label.x = 60;
        label.y = 5;
        addChild(label);

        levelLabel = new TextField();
        levelLabel.antiAliasType = AntiAliasType.ADVANCED;
        levelLabel.defaultTextFormat = format;
        levelLabel.text = level.toString();
        levelLabel.autoSize = TextFieldAutoSize.LEFT;
        levelLabel.x = 38;
        levelLabel.y = 5;
        addChild(levelLabel);

        var inviteFormat:TextFormat = new TextFormat();
        inviteFormat.size = 12;
        inviteFormat.bold = true;
        inviteFormat.color = 0x555555;

        inviteLabel = new TextField();
        inviteLabel.defaultTextFormat = inviteFormat;
        inviteLabel.antiAliasType = AntiAliasType.ADVANCED;
        inviteLabel.autoSize = TextFieldAutoSize.LEFT;
        inviteLabel.mouseEnabled = false;
        inviteLabel.text = 'пригласить';
        inviteLabel.y = 7;

        var confirmInviteFormat:TextFormat = new TextFormat();
        confirmInviteFormat.size = 12;
        confirmInviteFormat.bold = true;
        confirmInviteFormat.color = 0x228B22;

        confirmInviteLbl = new TextField()
        confirmInviteLbl.defaultTextFormat = confirmInviteFormat;
        confirmInviteLbl.antiAliasType = AntiAliasType.ADVANCED;
        confirmInviteLbl.autoSize = TextFieldAutoSize.LEFT;
        confirmInviteLbl.mouseEnabled = false;
        confirmInviteLbl.text = 'приглашен';
        confirmInviteLbl.y = 7;
        confirmInviteLbl.x = 230;

        var rejectFormat:TextFormat = new TextFormat();
        rejectFormat.size = 12;
        rejectFormat.bold = true;
        rejectFormat.color = 0x6A5ACD;

        rejectLabel = new TextField()
        rejectLabel.defaultTextFormat = rejectFormat;
        rejectLabel.antiAliasType = AntiAliasType.ADVANCED;
        rejectLabel.autoSize = TextFieldAutoSize.LEFT;
        rejectLabel.mouseEnabled = false;
        rejectLabel.text = 'отклонено';
        rejectLabel.y = 7;
        rejectLabel.x = 230;

        inviteSprite = new Sprite();
        inviteSprite.addChild(inviteLabel)
        inviteSprite.x = 230;
        inviteSprite.buttonMode = true;
        inviteSprite.addEventListener(MouseEvent.CLICK, onClick)
        if (!player) {
            addChild(inviteSprite);
        }
    }

    public function confirmInvite () :void {
        removeChild(inviteSprite);
        addChild(confirmInviteLbl);
    }

    public function confirmCancel () :void {
        if (contains(confirmInviteLbl)) {
            removeChild(confirmInviteLbl)
        }
        addChild(inviteSprite);
        block = false;
    }

    public function reject () :void {
        if (contains(confirmInviteLbl)) {
            removeChild(confirmInviteLbl)
        }
        if (contains(inviteSprite)) {
            removeChild(inviteSprite)
        }
        addChild(rejectLabel);
        block = true;
    }

    private function onClick (event:MouseEvent) :void {
        if (block) return;
        block = true;
        dispatchEvent(new Event(INVITE))
    }

    public function getId () :int {
        return id;
    }

    public function set hero (value:int) :void {
        this._hero = value;
    }

    public function  get hero () :int {
        return _hero;
    }

    public function set level (value:int) :void {
        this._level = value;
    }

    public function get level () :int {
        return _level;
    }
}
}
