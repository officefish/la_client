/**
 * Created by root on 9/5/14.
 */
package com.ps.collodion {
import com.ps.cards.*;
import com.log.Logger;
import com.ps.cards.sale.CardSale;
import com.ps.collodion.ICollodion;

import flash.display.Sprite;

public class Collodion extends Sprite implements ICollodion{
    protected var sales:Array = [];
    protected var cardsStack:Sprite;




    public function addSale (cardSale:CardSale) :void {
        sales.push(cardSale);
        activateSale (cardSale);
    }

    private function cancelSale (sale:CardSale) :void {
        var index:int = sales.indexOf(sale)
        sales.splice(index, 1);
        var cards:Array = getSaleCards (sale.getType());
        var card:Card;
        for (var i:int = 0; i < cards.length; i++) {
            card = cards[i];
            card.cancelSale (sale.getPower());
            sale.setCount(sale.getDefaultCount())
        }

    }

    public function getNumCards () :int {
        return cardsStack.numChildren;
    }

    private function activateSale (cardSale:CardSale) :void {
        var cards:Array = getSaleCards (cardSale.getType());
        var card:Card;
        for (var i:int = 0; i < cards.length; i++) {
            card = cards[i];
            card.addSale (cardSale.getPower());
        }
    }

    private function getSaleCards (type:int) :Array {
        var arr:Array = [];
        var card:Card;
        var i:int;

        switch (type) {
            case CardSale.UNIT_CARD: {
                for (i = 0; i < cardsStack.numChildren; i++) {
                    card = cardsStack.getChildAt(i) as Card;
                    if (card.getType() == CardData.UNIT) {
                        arr.push(card);
                    }
                }
                break;
            }
            case CardSale.SPELL_CARD: {
                for (i = 0; i < cardsStack.numChildren; i++) {
                    card = cardsStack.getChildAt(i) as Card;
                    if (card.getType() == CardData.SPELL) {
                        arr.push(card);
                    }
                }
                break;
            }
            case CardSale.SECRET_CARD: {
                for (i = 0; i < cardsStack.numChildren; i++) {
                    card = cardsStack.getChildAt(i) as Card;
                    if (card.getType() == CardData.SECRET) {
                        arr.push(card);
                    }
                }
                break;
            }
        }

        return arr;
    }

    public function checkSale () :void {
        var sale:CardSale
        for (var i:int = 0; i < sales.length; i++) {
            sale = sales[i]
            if (!sale.isConstant()) {
                cancelSale(sale);
            }
        }
    }

    public function checkSaleCard (card:Card) :void {
        var sale:CardSale;
        for (var i:int = 0; i < sales.length; i++) {
            sale = sales[i];
            if (cardSatisfySale (card, sale.getType())) {
                card.addSale (sale.getPower());
            }
        }
    }

    private function cardSatisfySale (card:Card, type:int) :Boolean {
        var flag:Boolean = false;
        switch (type) {
            case CardSale.UNIT_CARD: {
                if (card.getType() == CardData.UNIT) {
                    flag = true;
                }
                break;
            }
            case CardSale.SPELL_CARD: {
                if (card.getType() == CardData.SPELL) {
                    flag = true;
                }
                break;
            }
            case CardSale.SECRET_CARD: {
                if (card.getType() == CardData.SECRET) {
                    flag = true;
                }
                break;
            }
        }
        return flag;
    }

    public function checkRemoveSale (type:int) :void {

        var typeSales:Array = getSalesByType (type);
        var sale:CardSale;
        var count:int;
        for (var i:int = 0; i < typeSales.length; i ++) {
            sale = typeSales[i];
            count = sale.getCount();
            count --;
            sale.setCount(count);
            if (count == 0) {

                cancelSale (sale);
            }
        }

    }

    private function getSalesByType (type:int) :Array {
        var arr:Array = [];
        var sale:CardSale;
        for (var i:int = 0; i < sales.length; i ++) {
            sale = sales[i];
            switch (type) {
                case CardData.UNIT: {
                    if (sale.getType() == CardSale.UNIT_CARD) {
                        arr.push(sale);
                        break;
                    }
                }
                case CardData.SPELL: {
                    if (sale.getType() == CardSale.SPELL_CARD) {
                        arr.push(sale);
                        break;
                    }
                }
                case CardData.SECRET: {
                    if (sale.getType() == CardSale.SECRET_CARD) {
                        arr.push(sale);
                        break;
                    }
                }
            }
        }
        return arr;
    }
}
}
