/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
import flash.events.IEventDispatcher;

public interface IField extends IEventDispatcher{
    function resize (stageWidth:int, stageHeight:int) :void;
    function setBackground (background:IBackground) :void;

    function addPlayerHero (hero:IHero) :void;
    function addOpponentHero (hero:IHero) :void;

    function enableStepButton () :void;
    function disableStepButton () :void;

    function setPlayerPrice (value:int) :void;
    function setOpponentPrice (value:int) :void;

    function findPosition () :void;
    function stopFindPosition () :void;
    function getTokenPreviewIndex () :int;





}
}
