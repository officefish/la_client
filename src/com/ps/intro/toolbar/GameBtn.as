/**
 * Created by root on 9/16/14.
 */
package com.ps.intro.toolbar {
import flash.display.Sprite;

public class GameBtn extends LobbyBtn{
    public function GameBtn(label:String, lWidth:int, lHeight:int) {
        super (label, lWidth, lHeight);
    }

    override protected function initBackground (lWidth:int, lHeight:int) :Sprite {
        var gameBtn:Sprite = new Sprite();

        gameBtn.graphics.beginFill(0x777777, 1);
        gameBtn.graphics.lineStyle(2, 0x777777, 1);
        gameBtn.graphics.curveTo(-20,-75,42,-150)
        gameBtn.graphics.lineTo(290-42,-150);
        gameBtn.graphics.curveTo(310,-75,290,0);
        gameBtn.graphics.lineTo(0,0);
        gameBtn.buttonMode = true;
        return gameBtn;
    }

    override protected function placeLabel () :void {
        lbl.x = (this.width - lbl.width) / 2;
        lbl.y = -80;
    }
}
}
