/**
 * Created by root on 8/30/14.
 */
package com.ps.field.controller {
import com.log.Logger;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.eptitude.IEptitudeActivator;
import com.ps.field.Field;
import com.ps.field.IAttackAvailable;
import com.ps.field.UnitRow;
import com.ps.tokens.EptitudeActivator;
import com.ps.tokens.Token;
import com.ps.tokens.TokenEvent;

public class TreatController {

    private var field:Field;
    private var threatUnit:IAttackAvailable;
    private var units:Array;
    private var actualToken:Token;

    private var activator:IEptitudeActivator

    public function TreatController() {
    }

    public function setField (field:Field) :void {
        this.field = field;
    }

    public function threat (threatUnit:IAttackAvailable, activator:IEptitudeActivator) :void {
        this.activator = activator;
        this.threatUnit = threatUnit;
        initAssociate ();
    }

    private function initAssociate () :void {
        //Logger.log('initAssocate')
        if (threatUnit.isEnemy()) {
            units = getChildren(field.getEnemyRow(), false);
        } else {
            units = getChildren(field.getPlayerRow(), false);
        }

        if (units.length) {
            activateAssociate ();
        } else {
            initOpponent()
        }
    }

    private function activateAssociate () :void {
        if (!units.length) {
            initOpponent ();
            return;
        }

        actualToken = units.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ASSOCIATE_TREATED, onAssociateActivationComplete);
    }

    private function onAssociateActivationComplete () :void {
        activateAssociate();
    }

    private function initOpponent () :void {
        //Logger.log('initOpponent')
        if (threatUnit.isEnemy()) {
            units = getChildren(field.getPlayerRow(), false);
        } else {
            units = getChildren(field.getEnemyRow(), false);
        }

        if (units.length) {
            activateOpponent ();
        } else {
            initAll()
        }
    }

    private function activateOpponent () :void {

        if (!units.length) {
            initAll ();
            return;
        }

        actualToken = units.shift ();
        actualToken.activateEptitudes (EptitudePeriod.OPPONENT_TREATED, onOpponentActivationComplete);
    }

    private function onOpponentActivationComplete () :void {
        activateOpponent();
    }

    private function initAll () :void {
        //Logger.log('initAll')
        units = getChildren(field.getPlayerRow(), false);
        units = units.concat(getChildren(field.getEnemyRow(), false));


        if (units.length) {
            activateAll ();
        } else {
            endActivate ();
        }
    }

    private function activateAll () :void {

        if (!units.length) {
            endActivate();
            return;
        }

        actualToken = units.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ALL_TREATED, onAllActivationComplete);
    }

    private function onAllActivationComplete () :void {
        activateAll();
    }

    private function endActivate () :void {
       activator.continueActivate();
    }


    private function getChildren (row:UnitRow, shadow:Boolean = true) :Array {
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
}
}
