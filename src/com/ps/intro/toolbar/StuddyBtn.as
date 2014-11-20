/**
 * Created by root on 9/16/14.
 */
package com.ps.intro.toolbar {
import flash.display.Sprite;

import mx.events.ModuleEvent;

public class StuddyBtn extends LobbyBtn {
    public function StuddyBtn(label:String, lWidth:int, lHeight:int) {
        super (label, lWidth, lHeight);
    }

    override protected function initBackground (lWidth:int, lHeight:int) :Sprite {
        var studyBtn:Sprite = new Sprite();
        studyBtn.graphics.beginFill(0x777777)
        studyBtn.graphics.lineStyle(2,0x777777,1);
        studyBtn.graphics.curveTo(100,-75,198,0);
        studyBtn.graphics.lineTo(0,0);
        studyBtn.buttonMode = true;
        return studyBtn;
    }

    override protected function placeLabel () :void {
        lbl.x = (this.width - lbl.width) / 2;
        lbl.y = -27;
    }
}
}
