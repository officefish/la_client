/**
 * Created by root on 9/9/14.
 */
package com.ps.field.controller {
import com.ps.field.Field;
import com.ps.field.IAttackAvailable;
import com.ps.field.UnitRow;
import com.ps.tokens.Token;

public class SubController {

    protected var field:Field
    protected var callback:Function;
    protected var tokens:Array;
    protected var iniciator:IAttackAvailable;
    protected var actualToken:Token;
    protected var token:Token;


    public function SubController() {
    }

    public function setField (field:Field) :void {
        this.field = field;
    }

    public function destroy () :void {
        this.field = null;
        this.callback = null;
        this.tokens = null;
        this.iniciator = null;
        this.actualToken = null;
        this.token = null;
    }

    protected function getRaceAssociate (raceId:int) :Array {
        var arr:Array;

        if (iniciator.isEnemy()) {
            if (token) {
                arr = getRaceChildrenExceptIniciator(field.getEnemyRow(), token, raceId, false)
            } else {
                arr = getRaceChildren(field.getEnemyRow(), raceId, false)
            }
        } else {
            if (token) {
                arr = getRaceChildrenExceptIniciator(field.getPlayerRow(), token, raceId, false)
            } else {
                arr = getRaceChildren(field.getPlayerRow(), raceId, false)
            }
        }
        return arr;
    }

    protected function getAssociate () :Array {
        var arr:Array;

        if (iniciator.isEnemy()) {
            if (token) {
                arr = getChildrenExceptIniciator(field.getEnemyRow(), token, false)
            } else {
                arr = getChildren(field.getEnemyRow(), false)
            }

        } else {
            if (token) {
                arr = getChildrenExceptIniciator(field.getPlayerRow(), token, false)
            } else {
                arr = getChildren(field.getPlayerRow(), false)
            }
        }

        return arr;
    }

    protected function getOpponent () :Array {
        var arr:Array;
        if (iniciator.isEnemy()) {
            arr = getChildren(field.getPlayerRow(), false)
        } else {
            arr = getChildren(field.getEnemyRow(), false)
        }
        return arr;
    }

    protected function getRaceOpponent (raceId:int) :Array {
        var arr:Array;
        if (iniciator.isEnemy()) {
            arr = getRaceChildren(field.getPlayerRow(), raceId, false)
        } else {
            arr = getRaceChildren(field.getEnemyRow(), raceId, false)
        }
        return arr;
    }

    protected function getAll () :Array {
        var arr:Array;
        if (iniciator.isEnemy()) {
            if (token) {
                arr = getChildrenExceptIniciator(field.getEnemyRow(), token, false)
            } else {
                arr = getChildren(field.getEnemyRow(), false)
            }

            arr = arr.concat(getChildren(field.getPlayerRow(), false))

        } else {
            if (token) {
                arr = getChildrenExceptIniciator(field.getPlayerRow(), token, false)
            } else {
                arr = getChildren(field.getPlayerRow(), false)
            }

            arr = arr.concat(getChildren(field.getEnemyRow(), false))
        }
        return arr;
    }

    protected function getRaceAll (raceId:int) :Array {
        var arr:Array;
        if (iniciator.isEnemy()) {
               arr = getRaceChildrenExceptIniciator(field.getEnemyRow(), token, raceId, false)
               arr = arr.concat(getRaceChildren(field.getPlayerRow(), raceId, false))
        } else {
            arr = getRaceChildrenExceptIniciator(field.getPlayerRow(), token, raceId, false)
               arr = arr.concat(getRaceChildren(field.getEnemyRow(), raceId, false))
        }
        return arr;
    }

    protected function getRaceChildren (row:UnitRow, raceId:int, shadow:Boolean = true) :Array {
        var arr:Array = []
        var token:Token
        for (var i:int = 0; i < row.numChildren; i++) {
            token = row.getChildAt(i) as Token;
            if (shadow) {
                if (!token.inShadow()) {
                    if (token.getRace() == raceId) {
                        arr.push (token);
                    }
                }
            } else {
                if (token.getRace() == raceId) {
                    arr.push (token);
                }
            }
        }
        return arr;
    }


    protected function getChildren (row:UnitRow, shadow:Boolean = true) :Array {
        var arr:Array = []
        var token:Token
        for (var i:int = 0; i < row.numChildren; i++) {
            token = row.getChildAt(i) as Token;
            if (shadow) {
                if (!token.inShadow()) {
                    arr.push (token);
                }
            } else {
                arr.push (token);
            }
        }
        return arr;
    }

    protected function getChildrenExceptIniciator (row:UnitRow, iniciator:Token, shadow:Boolean = true) :Array {
        var arr:Array = []
        var index:int = row.getChildIndex (iniciator);
        var token:Token
        for (var i:int = 0; i < row.numChildren; i++) {
            if (i == index) {
                continue;
            }
            token = row.getChildAt(i) as Token;
            if (shadow) {
                if (!token.inShadow()) {
                    arr.push (token);
                }
            } else {
                arr.push (token);
            }
        }
        return arr;
    }

    protected function getRaceChildrenExceptIniciator (row:UnitRow, iniciator:Token, raceId:int, shadow:Boolean = true) :Array {
        var arr:Array = []
        var index:int = row.getChildIndex (iniciator);
        var token:Token
        for (var i:int = 0; i < row.numChildren; i++) {
            if (i == index) {
                continue;
            }
            token = row.getChildAt(i) as Token;
            if (shadow) {
                if (!token.inShadow()) {
                    if (token.getRace() == raceId) {
                        arr.push (token);
                    }
                }
            } else {
                if (token.getRace() == raceId) {
                    arr.push (token);
                }
            }
        }
        return arr;
    }
}
}
