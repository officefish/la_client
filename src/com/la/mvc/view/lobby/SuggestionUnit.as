/**
 * Created by root on 9/24/14.
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

public class SuggestionUnit extends Sprite implements IUnit {

    private var id:int;
    private var label:TextField;

    private var cancelSprite:Sprite;
    private var cancelLabel:TextField;

    private var block:Boolean = false;

    private var _mode:int;
    private var _hero:int;
    private var _level:int;

    private var asset:Bitmap;

    private var levelLabel:TextField;
    private var modeLabel:TextField;

    public static const CANCEL:String = 'cancel_invite';

    public function SuggestionUnit(id:int, hero:int, level:int, mode:int){
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

        cancelSprite = new Sprite();
        cancelSprite.buttonMode = true;
        addChild(cancelSprite)

        cancelSprite.addEventListener(MouseEvent.CLICK, onClick);

        var supportFormat:TextFormat = new TextFormat();
        supportFormat.size = 12;
        supportFormat.bold = true;
        supportFormat.color = 0x555555;


        cancelLabel = new TextField();
        cancelLabel.defaultTextFormat = supportFormat;
        cancelLabel.antiAliasType = AntiAliasType.ADVANCED;
        cancelLabel.autoSize = TextFieldAutoSize.LEFT;
        cancelLabel.mouseEnabled = false;
        cancelLabel.text = 'отменить';
        cancelLabel.y = 7;
        cancelSprite.addChild(cancelLabel);
        cancelSprite.x = 300;
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

    public function getId () :int {
        return id;
    }

    private function onClick (event:MouseEvent) :void {
        if (block) return;
        block = true;
        dispatchEvent(new Event(CANCEL));
    }

    public function getMode () :int {
        return _mode;
    }
}
}
