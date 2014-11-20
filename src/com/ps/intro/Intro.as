/**
 * Created by root on 9/15/14.
 */
package com.ps.intro {
import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.la.event.IntroEvent;
import com.la.mvc.view.IIntro;
import com.ps.intro.toolbar.CollectionBtn;
import com.ps.intro.toolbar.GameBtn;
import com.ps.intro.toolbar.LobbyBtn;
import com.ps.intro.toolbar.StuddyBtn;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import com.greensock.TweenLite;
import com.greensock.plugins.TweenPlugin;
import com.greensock.plugins.ColorTransformPlugin;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class Intro extends Sprite implements IIntro {

    private var circle:Sprite;
    private var gameBtn:LobbyBtn;
    private var collectionBtn:LobbyBtn;
    private var studyBtn:LobbyBtn;

    private var disk:Sprite = new Sprite();

    private var gameLeftShirme:Sprite;
    private var gameRightShirme:Sprite;

    private var maskSprite;

    public static const NEW_GAME:String = 'newGame';
    public static const LOUNCH_GAME:String = 'lounchGame';
    public static const OPEN_COLLECTION:String = 'openCollection';

    private var collectionUpShirme:Sprite;
    private var collectionDownShirme:Sprite;

    public function Intro() {

        var lWidth:int = 800;
        var lHeight:int = 580;

        TweenPlugin.activate([ColorTransformPlugin]);

        graphics.beginFill(0xAAAAAA, 1);
        graphics.drawRect(0,0,800,600);
        graphics.endFill();

        graphics.lineStyle(1,0xEEEEEE,1);
        graphics.moveTo(358,0);
        graphics.lineTo(358,600);

        graphics.moveTo(287,0);
        graphics.lineTo(287,600);

        graphics.moveTo(0,248);
        graphics.lineTo(800,248);

        maskSprite = new Sprite();
        maskSprite.graphics.beginFill(0xAAAAAA, 1);
        maskSprite.graphics.drawRect(0,0,800,600);
        maskSprite.graphics.endFill();
        this.mask = maskSprite;

        circle = new Sprite();
        circle.graphics.beginFill(0xAAAAAA);
        circle.graphics.drawCircle(0, 0, 150);
        circle.graphics.endFill();

        disk = new Sprite();
        disk.x = lWidth/2;
        disk.y = lHeight/2;

        gameBtn = new GameBtn('Игра', lWidth, lHeight);
        gameBtn.addEventListener(MouseEvent.CLICK, onGameClick);
        gameBtn.buttonMode = true;
        gameBtn.x = - 145;
        gameBtn.y = 40;
        disk.addChild(gameBtn);

        collectionBtn = new CollectionBtn('Коллекция карт', lWidth, lHeight)
        collectionBtn.addEventListener(MouseEvent.CLICK, onCollectionClick)
        collectionBtn.x = -143;
        collectionBtn.y = 44;
        disk.addChild(collectionBtn);

        studyBtn = new StuddyBtn('Обучение', lWidth, lHeight);
        studyBtn.addEventListener(MouseEvent.CLICK, onStudyClick)
        studyBtn.y = -114;
        studyBtn.x = -100;
        disk.addChild(studyBtn);

        gameLeftShirme = new Sprite();
        gameLeftShirme.graphics.beginFill(0xAAAAAA, 1);
        gameLeftShirme.graphics.drawRect(0,0,358,600);
        gameLeftShirme.graphics.endFill();
        gameLeftShirme.graphics.lineStyle(1,0xEEEEEE,1);
        gameLeftShirme.graphics.moveTo(287,0);
        gameLeftShirme.graphics.lineTo(287,600);
        gameLeftShirme.graphics.moveTo(0,248);
        gameLeftShirme.graphics.lineTo(358,248);

        gameRightShirme = new Sprite();
        gameRightShirme.graphics.beginFill(0xAAAAAA, 1);
        gameRightShirme.graphics.drawRect(-440,0,440,600);
        gameRightShirme.graphics.endFill();
        gameRightShirme.graphics.lineStyle(1,0xEEEEEE,1);
        gameRightShirme.graphics.moveTo(-440,248);
        gameRightShirme.graphics.lineTo(0,248);

        gameRightShirme.x = 800;

        collectionUpShirme = new Sprite();
        collectionUpShirme.graphics.beginFill(0xAAAAAA,1);
        collectionUpShirme.graphics.drawRect(0,0,800,247);
        collectionUpShirme.graphics.endFill();
        collectionUpShirme.graphics.lineStyle(1,0xEEEEEE,1);
        collectionUpShirme.graphics.moveTo(358,0);
        collectionUpShirme.graphics.lineTo(358,247);

        collectionUpShirme.graphics.moveTo(287,0);
        collectionUpShirme.graphics.lineTo(287,247);

        collectionDownShirme = new Sprite();
        collectionDownShirme.graphics.beginFill(0xAAAAAA,1);
        collectionDownShirme.graphics.drawRect(0,-351,800,351);
        collectionDownShirme.graphics.endFill();
        collectionDownShirme.y = 600;

        collectionDownShirme.graphics.lineStyle(1,0xEEEEEE,1);
        collectionDownShirme.graphics.moveTo(358,-351);
        collectionDownShirme.graphics.lineTo(358,0);

        collectionDownShirme.graphics.moveTo(287,-351);
        collectionDownShirme.graphics.lineTo(287,0);

        addChild(disk);


    }

    private function onGameClick (event:MouseEvent) :void {
        destroyListeners();
        addChildAt(gameLeftShirme, 0);
        addChildAt(gameRightShirme, 0);
        TweenLite.to (disk, 0.5, {rotationZ:-270, ease:Expo.easeInOut, onComplete:onGameClickContinue});

    }

    private function onGameClickContinue () :void {

        dispatchEvent(new IntroEvent(IntroEvent.SELECT_GAME));
        //dispatchEvent(new Event(Intro.NEW_GAME));

        graphics.clear();

        gameBtn.y = 146;
        gameBtn.x = 1 - 440;
        gameBtn.rotationZ = -270;

        studyBtn.x = 156 - 440;
        studyBtn.y = 192;
        studyBtn.rotationZ = -270;

        collectionBtn.x = 356;
        collectionBtn.y = 148;
        collectionBtn.rotationZ = -270;

        gameRightShirme.addChild(gameBtn);
        gameRightShirme.addChild(studyBtn);
        gameLeftShirme.addChild(collectionBtn);

        TweenLite.to (gameLeftShirme, 1.5, {rotationY:180, ease:Expo.easeIn});
        TweenLite.to (gameRightShirme, 1.5, {rotationY:-180, onComplete:onGameComplete, ease:Expo.easeIn});


    }

    private function onGameComplete () :void {
        dispatchEvent(new IntroEvent(IntroEvent.COMPLETE));
    }

    private function onCollectionClick (event:MouseEvent) :void {
        destroyListeners();


        addChildAt(collectionUpShirme, 0);
        addChildAt(collectionDownShirme, 0);
        TweenLite.to (disk, 0.5, {rotationZ:-180, ease:Expo.easeInOut, onComplete:onCollectionContinue});
    }

    private function onCollectionContinue () :void {

        dispatchEvent(new IntroEvent(IntroEvent.SELECT_COLLECTION));

        graphics.clear();

        collectionBtn.x = 543;
        collectionBtn.y = 246;
        collectionBtn.rotationZ = -180;

        gameBtn.x = 545;
        gameBtn.y = -350;
        gameBtn.rotationZ = -180;

        studyBtn.x = 500;
        studyBtn.y = - 195;
        studyBtn.rotationZ = - 180;

        collectionDownShirme.addChild(gameBtn);
        collectionDownShirme.addChild(studyBtn);
        collectionUpShirme.addChild(collectionBtn);

        TweenLite.to (collectionUpShirme, 1.5, {rotationX:-180, ease:Expo.easeIn});
        TweenLite.to (collectionDownShirme, 1.5, {rotationX:180, onComplete:onCollectionComplete, ease:Expo.easeIn});

    }

    private function onCollectionComplete () :void {

    }

    private function onStudyClick (event:MouseEvent) :void {
        destroyListeners();
        TweenLite.to (disk, 0.5, {rotationZ:270, ease:Expo.easeInOut});
    }

    private function destroyListeners () :void {
        studyBtn.destroyListeners();
        collectionBtn.destroyListeners();
        gameBtn.destroyListeners();
    }

    public function destroy () :void {
        gameBtn.removeEventListener(MouseEvent.CLICK, onGameClick);
        collectionBtn.removeEventListener(MouseEvent.CLICK, onCollectionClick)
        studyBtn.removeEventListener(MouseEvent.CLICK, onStudyClick)
        gameBtn = null;
        collectionBtn = null;
        studyBtn = null;
        disk = null;

    }

    public function defaultView () :void {

        if (contains(collectionUpShirme)) removeChild(collectionUpShirme);
        if (contains(collectionDownShirme)) removeChild(collectionDownShirme);
        if (contains(gameLeftShirme)) removeChild(gameLeftShirme)
        if (contains(gameRightShirme)) removeChild(gameRightShirme)

        graphics.clear();
        graphics.beginFill(0xAAAAAA, 1);
        graphics.drawRect(0,0,800,600);
        graphics.endFill();

        graphics.lineStyle(1,0xEEEEEE,1);
        graphics.moveTo(358,0);
        graphics.lineTo(358,600);

        graphics.moveTo(287,0);
        graphics.lineTo(287,600);

        graphics.moveTo(0,248);
        graphics.lineTo(800,248);

        gameBtn.x = - 145;
        gameBtn.y = 40;
        gameBtn.rotationZ = 0;
        disk.addChild(gameBtn);

        collectionBtn.x = -143;
        collectionBtn.y = 44;
        collectionBtn.rotationZ = 0;
        disk.addChild(collectionBtn);

        studyBtn.y = -114;
        studyBtn.x = -100;
        studyBtn.rotationZ = 0;
        disk.addChild(studyBtn);

        studyBtn.activateListeners()
        collectionBtn.activateListeners()
        gameBtn.activateListeners()

        disk.rotationZ = 0;

        collectionUpShirme.rotationX = 0;
        collectionDownShirme.rotationX = 0;
        gameLeftShirme.rotationY = 0;
        gameRightShirme.rotationY = 0;
        gameLeftShirme.rotationZ = 0;
        gameRightShirme.rotationZ = 0;
        gameLeftShirme.rotationX = 0;
        gameRightShirme.rotationX = 0;
    }


}
}
