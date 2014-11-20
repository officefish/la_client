/**
 * Created by root on 9/16/14.
 */
package com.ps.intro.toolbar {
import flash.display.Sprite;

public class CollectionBtn extends LobbyBtn {
    public function CollectionBtn(label:String, lWidth:int, lHeight:int) {
        super (label, lWidth, lHeight);
    }

    override protected function initBackground (lWidth:int, lHeight:int) :Sprite {
        var collectionBtn:Sprite = new Sprite()
        collectionBtn.graphics.beginFill(0x777777, 1)
        collectionBtn.graphics.lineStyle(2,0x777777,1);
        collectionBtn.graphics.curveTo(40,105,145,110);
        collectionBtn.graphics.curveTo(250,105,286,0);
        collectionBtn.graphics.lineTo(0,0);
        collectionBtn.buttonMode = true;
        return collectionBtn;
    }

    override protected function placeLabel () :void {
        lbl.x = (this.width - lbl.width) / 2;
        lbl.y = 40;
    }
}
}
