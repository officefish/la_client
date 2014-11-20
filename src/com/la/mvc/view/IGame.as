/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.view {
import com.ps.cards.CardData;

import flash.events.IEventDispatcher;

public interface IGame extends IEventDispatcher {
    function resize (stageWidth:int, stageHeight:int) :void;
    function startup (collection:Vector.<CardData>) :void;
}
}
