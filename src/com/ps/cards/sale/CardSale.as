/**
 * Created by root on 9/4/14.
 */
package com.ps.cards.sale {
public class CardSale {

    private var type:int;
    private var constant:Boolean;
    private var count:int;
    private var power:int;
    private var defaultCount:int;



    public function CardSale(type:int, constant:Boolean, count:int, power:int) {
        this.type = type;
        this.constant = constant;
        this.defaultCount = count;
        this.count = count;
        this.power = power;
    }

    public function getType () :int {
        return type;
    }
       public function isConstant () :Boolean {
        return constant;
    }
    public function getCount () :int {
        return count;
    }
    public function setCount (value:int) :void {
        this.count = value;
    }
    public function getDefaultCount () :int {
        return defaultCount;
    }
    public function getPower () :int {
        return power;
    }


    public static const UNIT_CARD:int =1;
    public static const UNIT_RACE_CARD:int =2;
    public static const SPELL_CARD:int = 3;
    public static const SECRET_CARD:int = 4;


}
}
