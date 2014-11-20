/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.view.deck {
import com.la.mvc.view.card.Card;
import com.ps.cards.CardData;

public interface IDeck {
    function addCard (card:CardData, quick:Boolean = false) :Card;
    function addCards (cards:Vector.<CardData>, quick:Boolean = false) :Vector.<Card>;
    function resize (stageWidth:int, stageHeight:int) :void;
    function set price (value:int) :void;
    function get price () :int;
    function get shiftX () :int;
    function block () :void
    function unblock () :void
}
}
