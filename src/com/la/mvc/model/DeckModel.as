/**
 * Created by root on 11/8/14.
 */
package com.la.mvc.model {
import com.ps.cards.CardData;

import org.robotlegs.mvcs.Actor;

public class DeckModel extends Actor {

    private var playerCards:Vector.<CardData>;
    private var opponentCards:Vector.<CardData>;

    public function DeckModel() {
        playerCards = new Vector.<CardData>();
        opponentCards = new Vector.<CardData>();
    }

    public function addPlayerCards (vector:Vector.<CardData>) :void {
        playerCards = playerCards.concat(vector);
    }

    public function addOpponentCards (vector:Vector.<CardData>) :void {
        opponentCards = opponentCards.concat(vector);
    }

    public function getPlayerCards () :Vector.<CardData> {
        return playerCards.concat();
    }

    public function getOpponentCards () :Vector.<CardData> {
        return opponentCards;
    }

    public function clearPlayerCards () :void {
        playerCards = new Vector.<CardData>();
    }

    public function clearOpponentCards () :void {
        opponentCards = new Vector.<CardData>();
    }

    public function addPlayerCard (card:CardData) :void {
        playerCards.push(card);
    }

    public function addOpponentCard (card:CardData) :void{
        opponentCards.push(card);
    }
}
}
