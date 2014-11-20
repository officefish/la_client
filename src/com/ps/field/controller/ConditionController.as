/**
 * Created by root on 9/9/14.
 */
package com.ps.field.controller {
import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeCondition;
import com.ps.field.Field;
import com.ps.field.IAttackAvailable;
import com.ps.field.UnitRow;

public class ConditionController {

    private var field:Field;

    public function ConditionController() {
    }

    public function setField (field:Field) :void {
        this.field = field;
    }

    public function checkCondition (iniciator:IAttackAvailable, units:Array, eptitude:CardEptitude) :Array {
        var arr:Array = []
        var unit:IAttackAvailable;
        for (var i:int = 0; i < units.length; i ++) {
            unit = units[i]
            switch (eptitude.getCondition()) {
                case EptitudeCondition.ATTACK_MORE_THAN: {
                    if (unit.getTotalAttack() > eptitude.getConditionValue()) {
                        arr.push(unit)
                        break;
                    }
                }
                case EptitudeCondition.ATTACK_LESS_THAN: {
                    if (unit.getTotalAttack() < eptitude.getConditionValue()) {
                        arr.push(unit)
                        break;
                    }
                }
                case EptitudeCondition.OPPONENT_UNITS_COUNT_MORE_THAN: {
                    var row:UnitRow;
                    if (iniciator.isEnemy()) {
                        row = field.getPlayerRow()
                    } else {
                        row = field.getEnemyRow()
                    }

                    if (row.numChildren > eptitude.getConditionValue()) {
                        arr.push(unit)
                    }
                    break;
                }
            }
        }
        return arr;
    }
}
}
