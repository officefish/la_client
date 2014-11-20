/**
 * Created by root on 11/3/14.
 */
package com.la.mvc.view.deck {
import com.la.assets.Assets;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class DeckHeroWidget extends Sprite {
    public function DeckHeroWidget() {
        graphics.beginFill(0xEEEEEE, 1);
        graphics.drawRect(0,0,200, 330);
        graphics.endFill();
    }

    public function setHeroData (data:Object) :void {
        while (numChildren) removeChildAt(0);

        var asset:Bitmap = Assets.getHeroAssetById(data.uid);
        asset.x = 40;
        asset.y = - 30;
        addChild(asset);

        var titleFormat:TextFormat = new TextFormat();
        titleFormat.bold = true;
        titleFormat.size = 18;
        titleFormat.align = TextFormatAlign.CENTER;

        var title:TextField = new TextField();
        title.defaultTextFormat = titleFormat;
        title.width = this.width;
        title.y = 110;
        title.text = data.title;
        addChild(title);

        var vocationFormat:TextFormat = new TextFormat();
        vocationFormat.bold = true;
        vocationFormat.size = 14;
        vocationFormat.align = TextFormatAlign.CENTER;

        var vocation:TextField = new TextField();
        vocation.defaultTextFormat = vocationFormat;
        vocation.width = this.width;
        vocation.y = 135;
        vocation.text = data.vocation;
        addChild(vocation);

        var descriptionFormat:TextFormat = new TextFormat();
        descriptionFormat.bold = true;
        descriptionFormat.size = 12;
        descriptionFormat.align = TextFormatAlign.LEFT;
        descriptionFormat.leftMargin = 10;

        var description:TextField = new TextField();
        description.defaultTextFormat = descriptionFormat;
        description.width = this.width;
        description.height = 140;
        description.wordWrap = true;
        description.y = 210;
        description.text = data.description;
        addChild(description);

        var levelSprite:Sprite = new Sprite();
        levelSprite.graphics.beginFill(0xCCCCCC,1);
        levelSprite.graphics.drawRect(0,0,30,30);
        levelSprite.graphics.endFill();
        levelSprite.y = 80;
        levelSprite.x = (this.width - levelSprite.width) / 2;
        addChild(levelSprite);

        var levelFormat:TextFormat = new TextFormat();
        levelFormat.bold = true;
        levelFormat.size = 22;
        levelFormat.align = TextFormatAlign.CENTER;

        var level:TextField = new TextField();
        level.defaultTextFormat = levelFormat;
        level.width = levelSprite.width;
        level.text = data.level;
        levelSprite.addChild(level);

        var achiveSprite = new Sprite();
        achiveSprite.y = 170;
        addChild(achiveSprite);

        var shift:int = 14;

        for (var i:int = 0; i < 4; i ++) {
            var achive:Sprite = new Sprite();
            achive.graphics.beginFill(0x777777, 1);
            achive.graphics.drawRect(0,0,30,30);
            achive.graphics.endFill();
            achive.x = 20 + (achive.width * i + shift * i);
            achiveSprite.addChild(achive);
        }




    }
}
}
