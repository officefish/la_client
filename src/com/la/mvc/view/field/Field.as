/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.greensock.easing.ExpoOut;
import com.la.event.FieldEvent;
import com.la.mvc.view.token.Token;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

public class Field extends Sprite implements IField {

    private var stageWidth:int;
    private var stageHeight:int;

    private var playerHero:IHero;
    private var opponentHero:IHero;

    private var stepButton:StepButton;

    private var playerPriceWidget:PriceWidget;
    private var opponentPriceWidget:PriceWidget;


    private var playerRow:UnitRow;
    private var opponentRow:UnitRow;

    private var tokenPreviewIndex:int = 0;

    public function Field() {

    }

    public function clear () :void {
        while (numChildren) removeChildAt(0);
    }

    public function resize (stageWidth:int, stageHeight:int) :void {
        this.stageWidth = stageWidth;
        this.stageHeight = stageHeight;
        graphics.clear();
        graphics.beginFill (0xDDDDDD, 1);
        graphics.drawRect (0, 40, stageWidth, stageHeight-100);
        graphics.endFill();

        stepButton = new StepButton();
        stepButton.x = stageWidth - 100;
        stepButton.y = stageHeight / 2 - (stepButton.height / 2);
        addChild (stepButton);

        playerPriceWidget = new PriceWidget();
        playerPriceWidget.x = this.width - playerPriceWidget.width;
        playerPriceWidget.y = stageHeight - 90;
        addChild (playerPriceWidget);

        opponentPriceWidget = new PriceWidget();
        opponentPriceWidget.x = this.width - opponentPriceWidget.width;
        opponentPriceWidget.y = 40;
        addChild (opponentPriceWidget);

        opponentRow = new UnitRow();
        opponentRow.y = 140;
        opponentRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH)) / 2;
        addChild(opponentRow);

        playerRow = new UnitRow ();
        playerRow.y = 260;
        playerRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH)) / 2;
        addChild(playerRow);
    }

    public function setBackground (background:IBackground) :void {

    }

    public function addPlayerHero (hero:IHero) :void {
        this.playerHero = hero;
        addChild(playerHero as DisplayObject);


    }

    public function addOpponentHero (hero:IHero) :void {
        this.opponentHero = hero;
        addChild(opponentHero as DisplayObject);
    }

    public function enableStepButton () :void {
        stepButton.enable();
    }

    public function disableStepButton () :void {
        stepButton.disable();
    }

    public function setPlayerPrice (value:int) :void {
        playerPriceWidget.setPrice(value);
    }

    public function setOpponentPrice (value:int) :void {
        opponentPriceWidget.setPrice(value);
    }

    public function findPosition () :void {

        if (!playerRow.numChildren) {
            return;
        }

        playerRow.addChild (tokenPreview);
        playerRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH) * playerRow.numChildren) / 2;

        tokenPreview.x = (playerRow.numChildren - 1) * ( UnitRow.PADDING + Token.WIDTH);

        this.addEventListener (Event.ENTER_FRAME, onEnterFrame);

    }

    public function stopFindPosition () :void {

        if (!playerRow.numChildren) {
            playerRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH) * playerRow.numChildren) / 2;
            return;
        }

        if (playerRow.contains(tokenPreview)) playerRow.removeChild (tokenPreview);

        centerizeRow (playerRow);
        sortUnitRow (playerRow);

        this.removeEventListener (Event.ENTER_FRAME, onEnterFrame);

    }

    public function getTokenPreviewIndex () :int {
        return tokenPreviewIndex;
    }

    private function get tokenPreview () :Sprite {
        return Token.getTokenPreviewInstance() as Sprite
    }



    private function onEnterFrame (event:Event) :void {
        var mouseLocalX:int = mouseX - playerRow.x;
        var index:int = findNearNumberIndex (getRowAvailablePositions(playerRow.numChildren), mouseLocalX);
        if (playerRow.contains(tokenPreview)) playerRow.removeChild (tokenPreview);
        playerRow.addChildAt (tokenPreview, index);
        tokenPreviewIndex = index;
        sortUnitRow (playerRow);
    }



    public function getRowAvailablePositions (index:int) :Array {
        var arr:Array = [];
        for (var i:int = 0; i < index; i ++) {
            arr.push (( UnitRow.PADDING + Token.WIDTH) * i);
        }
        return arr;
    }

    // функция возвращает индекс близжайшего числа к заданному
    // Вернет -1 если неверны входящие параметры или массив если пуст
    private function findNearNumberIndex( arr:Array, targetNumber:Number ):int
    {
        // проверяем входящие аргументы
        if( !arr || isNaN( targetNumber ) )
            return -1;

        // currDelta - текущая разница
        var currDelta:Number;

        // nearDelta - наименьшая разница
        var nearDelta:Number;

        // nearIndex - индекс наименьшей разницы. Задаем изначально равным -1.
        // если массив с нулевой длиной - возвратится эта самая -1
        var nearIndex:Number = -1;

        // счетчик
        var i:Number = arr.length;

        // начинаем крутить цикл с конца массива.
        // с конца - чтобы не заводить доп. переменную
        while( i-- )
        {
            // берем по модулю раницу между заданным числом и текущим по индексу массива
            currDelta = Math.abs( targetNumber - arr[i] );

            // если nearIndex меньше нуля
            // (т.е мы в первый раз должны занести currDelta, чтобы было с чем сравнивать последующие итерации)
            // или currDelta меньше nearDelta
            if( nearIndex < 0 || currDelta < nearDelta )
            {
                // задаем индекс (наименьшей разницы) как текущий индекс
                nearIndex = i;
                // задаем наименьшую разницу как текущую
                nearDelta = currDelta;
            }
        }

        // возвращаем индекс наименьшей разницы
        return nearIndex;
    }

    // сортировка стола
    public function sortUnitRow (unitRow:UnitRow, index:int = 0, animation:Boolean = true) :Point {

        var position:Point;

        var visibleTokens:Array = getVisibleTokens (unitRow);
        var availablePositions:Array = getRowAvailablePositions(visibleTokens.length);

        for (var i:int = 0; i < visibleTokens.length; i ++) {
            var unit:DisplayObject = visibleTokens[i];
            if (animation) {
                TweenLite.to (unit, 0.4, { x: availablePositions[i] } );
            } else {
                unit.x = availablePositions[i];
            }

            if (i == index) {
                position = new Point (availablePositions[i], unit.y);
            }
        }
        return position;
    }
    public function centerizeRow (unitRow:UnitRow, callback:Function = null) :Point {
        var visibleTokens:Array = getVisibleTokens (unitRow);
        var xPos:int = (this.width - ((UnitRow.PADDING * (visibleTokens.length - 1)) + (Token.WIDTH * visibleTokens.length))) / 2;
        TweenLite.to (unitRow, 0.4, { x: xPos , onComplete:callback } );

        return new Point (xPos, unitRow.y);
    }

    public function getVisibleTokens (row:UnitRow) :Array {
        var arr:Array = [];
        var token:Token;
        for (var i:int = 0; i < row.numChildren; i ++) {
            token = row.getChildAt(i) as Token;
            if (token.visible) {
                arr.push (token);
            }
        }
        return arr;
    }






}
}
