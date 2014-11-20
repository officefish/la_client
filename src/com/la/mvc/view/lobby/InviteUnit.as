/**
 * Created by root on 9/24/14.
 */
package com.la.mvc.view.lobby {
import com.la.assets.Assets;
import com.transform.Transform;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class InviteUnit extends Sprite implements IUnit{
    private var id:int
    private var label:TextField

    private var acceptSprite:Sprite;
    private var rejectSprite:Sprite;

    private var acceptLabel:TextField;
    private var rejectLabel:TextField;

    private var block:Boolean = false;

    private var _mode:int;
    private var _hero:int;
    private var _level:int;

    private var asset:Bitmap;

    private var levelLabel:TextField;
    private var modeLabel:TextField;

    public static const ACCEPT:String = 'accept_invite';
    public static const REJECT:String = 'reject_invite';

    public function InviteUnit(id:int, hero:int, level:int, mode:int) {
        this.id = id;

        this.hero = hero;
        this.level = level;

        this._mode = mode;

        asset = Assets.getHeroAssetById(hero);
        asset = Transform.scale(asset, 0.29);
        addChild(asset);

        graphics.beginFill(0xCCCCCC, 1);
        graphics.drawRect(0,0,370,35);
        graphics.endFill();

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

        modeLabel = new TextField();
        modeLabel.antiAliasType = AntiAliasType.ADVANCED;
        modeLabel.defaultTextFormat = format;
        modeLabel.text = '(' + modeToString(mode) + ')';
        modeLabel.autoSize = TextFieldAutoSize.LEFT;
        modeLabel.x = 175;
        modeLabel.y = 5;
        addChild(modeLabel);



        var supportFormat:TextFormat = new TextFormat();
        supportFormat.size = 12;
        supportFormat.bold = true;
        supportFormat.color = 0x555555;

        acceptSprite = new Sprite();
        acceptSprite.buttonMode = true;
        addChild(acceptSprite)
        acceptSprite.addEventListener(MouseEvent.CLICK, onAcceptClick);

        acceptLabel = new TextField();
        acceptLabel.defaultTextFormat = supportFormat;
        acceptLabel.antiAliasType = AntiAliasType.ADVANCED;
        acceptLabel.autoSize = TextFieldAutoSize.LEFT;
        acceptLabel.mouseEnabled = false;
        acceptLabel.text = 'принять';
        acceptLabel.y = 7;
        acceptSprite.addChild(acceptLabel)

        acceptSprite.x = 270;

        rejectSprite = new Sprite();
        rejectSprite.buttonMode = true;
        addChild(rejectSprite)
        rejectSprite.addEventListener(MouseEvent.CLICK, onRejectClick)

        rejectLabel = new TextField();
        rejectLabel.defaultTextFormat = supportFormat;
        rejectLabel.antiAliasType = AntiAliasType.ADVANCED;
        rejectLabel.autoSize = TextFieldAutoSize.LEFT;
        rejectLabel.mouseEnabled = false;
        rejectLabel.text = 'откл.';
        rejectLabel.y = 7;
        rejectSprite.addChild(rejectLabel)

        rejectSprite.x = 325;

    }

    private function modeToString (value:int) :String {
        var label:String;
        switch (value) {
            case 0: {
                label = 'спринт';
                break;
            }
            case 1: {
                label = 'обычный';
                break;
            }
            case 2: {
                label = 'контроль';
                break;
            }
        }
        return label;
    }

    private function onAcceptClick (event:MouseEvent) :void {
        if (block) return;
        block = true;
        dispatchEvent(new Event(ACCEPT))
    }

    private function onRejectClick (event:MouseEvent) :void {
        if (block) return;
        block = true;
        dispatchEvent(new Event(REJECT))
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

    public function getMode () :int {
        return _mode;
    }
}
}
