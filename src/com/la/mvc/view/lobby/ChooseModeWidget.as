/**
 * Created by root on 10/30/14.
 */
package com.la.mvc.view.lobby {
import fl.controls.Button;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class ChooseModeWidget extends Sprite {

    private var sprintLabel:TextField;
    private var regularLabel:TextField;
    private var controlLabel:TextField;

    private var buttons:Sprite;

    private var sprintButton:Button;
    private var regularButton:Button;
    private var controlButton:Button;

    private var title:TextField;

    private var mode:int;

    public static const SELECT:String = 'modeSelect';


    public function ChooseModeWidget() {
        graphics.beginFill(0xEEEEEE, 1);
        graphics.drawRect(0,0,500,350);
        graphics.endFill();


        var format:TextFormat = new TextFormat();
        format.size = 13;
        format.bold = true;
        format.align = TextFormatAlign.LEFT;

        var sprintTxt:String = 'Предполагает короткий бой картами малой стоимости. Уровень героя игнорируется. Доступна одна базовая способность героя.';
        var regularTxt:String = 'Стандартный бой. Количество жизни героя зависит от его уровня. Герой может иcпользовать до 2 уникальных способностей.';
        var controlTxt:String = 'Контроль бой. С самого начала боя у каждого игрока все карты изначально есть на руках. Количество жизни героя зависит от уровня. Доступно четыре угикальные способности.';

        sprintLabel = new TextField();
        sprintLabel.antiAliasType = AntiAliasType.ADVANCED;
        sprintLabel.defaultTextFormat = format;
        sprintLabel.text = sprintTxt;
        sprintLabel.autoSize = TextFieldAutoSize.LEFT;
        sprintLabel.width = 140;
        sprintLabel.mouseEnabled = false;
        sprintLabel.wordWrap = true;
        sprintLabel.x = 20;
        sprintLabel.y = 80;
        addChild(sprintLabel);

        regularLabel = new TextField();
        regularLabel.antiAliasType = AntiAliasType.ADVANCED;
        regularLabel.defaultTextFormat = format;
        regularLabel.text = regularTxt;
        regularLabel.autoSize = TextFieldAutoSize.LEFT;
        regularLabel.width = 140;
        regularLabel.mouseEnabled = false;
        regularLabel.wordWrap = true;
        regularLabel.x = 185;
        regularLabel.y = 80;
        addChild(regularLabel);

        controlLabel = new TextField();
        controlLabel.antiAliasType = AntiAliasType.ADVANCED;
        controlLabel.defaultTextFormat = format;
        controlLabel.text = controlTxt;
        controlLabel.autoSize = TextFieldAutoSize.LEFT;
        controlLabel.width = 140;
        controlLabel.mouseEnabled = false;
        controlLabel.wordWrap = true;
        controlLabel.x = 345;
        controlLabel.y = 80;
        addChild(controlLabel);

        var titleFormat:TextFormat = new TextFormat();
        titleFormat.size = 16;
        titleFormat.bold = true;
        titleFormat.align = TextFormatAlign.CENTER;

        title = new TextField();
        title.antiAliasType = AntiAliasType.ADVANCED;
        title.defaultTextFormat = titleFormat;
        title.text = 'Выберите тип состязания';
        title.autoSize = TextFieldAutoSize.LEFT;
        title.width = this.width;
        title.mouseEnabled = false;
        title.wordWrap = true;
        title.y = 30;
        addChild(title);

        buttons = new Sprite();
        buttons.y = 270;
        addChild(buttons);

        sprintButton = new Button();
        sprintButton.label = 'Спринт';
        sprintButton.x = 35;
        sprintButton.addEventListener(MouseEvent.CLICK, onClick);
        buttons.addChild(sprintButton);

        regularButton = new Button();
        regularButton.label = 'Обычный';
        regularButton.x = 200;
        regularButton.addEventListener(MouseEvent.CLICK, onClick);
        buttons.addChild(regularButton);

        controlButton = new Button();
        controlButton.label = 'Контроль';
        controlButton.x = 360;
        controlButton.addEventListener(MouseEvent.CLICK, onClick);
        buttons.addChild(controlButton);

    }

    private function onClick (event:MouseEvent) :void {
        mode = buttons.getChildIndex(event.target as DisplayObject);
        dispatchEvent(new Event(SELECT));
    }

    public function getMode () :int {
        return mode;
    }
}
}
