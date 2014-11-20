/**
 * Created by root on 9/24/14.
 */
package com.la.mvc.view.lobby {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class Stack extends Sprite{

    private var container:Sprite
    private var bar:Sprite;

    private var label:TextField

    private var lbl:String;

    public function Stack(lbl:String, width:int, height:int) {


        this.lbl = lbl;

        bar = new Sprite();
        bar.graphics.beginFill(0xEEEEEE,1);
        bar.graphics.drawRect(0,0,width,40);
        bar.graphics.endFill();
        addChild(bar)

        var format:TextFormat = new TextFormat();
        format.size = 14;
        format.bold = true;
        format.color = 0x777777;

        label = new TextField();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.defaultTextFormat = format;
        label.text = lbl;
        label.autoSize = TextFieldAutoSize.LEFT;
        label.x = 15;
        label.y = 10;
        bar.addChild(label)


        container = new Sprite();
        container.graphics.beginFill(0xEEEEEE, 1);
        container.graphics.drawRect(0,0,width, height);
        container.graphics.endFill();
        container.y = 41;
        addChild(container)
    }

    public function addUnit (unit:DisplayObject) :void {
        container.addChild(unit);
        label.text = lbl + ' (' + container.numChildren + ')';
    }

    public function clear () :void {
        while (container.numChildren) container.removeChildAt(0);
        label.text = lbl;
    }

    public function removeUnit (unit:DisplayObject) :void {
        if (container.contains(unit)) container.removeChild(unit);
        label.text = lbl + ' (' + container.numChildren + ')';
    }

    public function sort () :void {
        for (var i:int = 0 ; i < container.numChildren; i ++) {
            var unit:DisplayObject = container.getChildAt(i)
            unit.y = 5 + (unit.height + 1) * i
        }
    }

    public function getUnitById (id:int) :IUnit {
        var targetUnit:IUnit;
        for (var i:int = 0 ; i < container.numChildren; i ++) {
            var unit:IUnit = container.getChildAt(i) as IUnit
            if (unit.getId() == id) {
                targetUnit = unit;
                break;
            }
        }
        return targetUnit;
    }
}
}
