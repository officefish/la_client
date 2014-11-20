/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.scene {
import com.la.mvc.view.card.Card;
import com.la.mvc.view.field.IHero;
import com.ps.cards.CardData;

import flash.display.DisplayObject;

import flash.events.IEventDispatcher;

public interface IScene extends IEventDispatcher{
    function resize (stageWidth:int, stageHeight:int) :void;

    function preflopCards (vector:Vector.<CardData>) :void;
    function replacePreflopCards (vector:Vector.<CardData>) :void;
    function moveDownPreflop (vector:Vector.<Card>, shiftX:int) :void;
    function  changePreflopCards () :void;
    function placeCard (card:DisplayObject) :void;
    function endPlaceCard () :void;

    function setPlayerHero (hero:IHero) :void;
    function setOpponentHero (hero:IHero) :void;
    function welcomeAnimation () :void;
    function darken () :void;
    function lighten () :void;
}
}
