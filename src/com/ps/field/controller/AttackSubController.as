/**
 * Created by root on 9/9/14.
 */
package com.ps.field.controller {
import com.log.Logger;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.field.Field;
import com.ps.field.UnitRow;
import com.ps.tokens.Token;

public class AttackSubController extends SubController {


    public function AttackSubController() {
    }

    public function activateWound (token:Token, callback:Function) :void {
        this.callback = callback
        this.iniciator = token;
        initAssociateWound();
        //callback ();
    }

    private function initAssociateWound () :void {
        tokens = getAssociate();
        activateAssociateWound ();
    }

    private function activateAssociateWound () :void {
        if (!tokens.length) {
            initOpponentWound();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ASSOCIATE_WOUND, associateWoundComplete);
    }

    private function associateWoundComplete () :void {
        activateAssociateWound()
    }

    private function initOpponentWound () :void {
        tokens = getOpponent();
        activateOpponentWound ();
    }

    private function activateOpponentWound () :void {
        if (!tokens.length) {
            initAllWound();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.OPPONENT_WOUND, opponentWoundComplete);
    }

    private function opponentWoundComplete () :void {
        activateOpponentWound()
    }

    private function initAllWound () :void {
        tokens = getAll();
        activateAllWound ();
    }

    private function activateAllWound () :void {
        if (!tokens.length) {
            callback ()
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ALL_WOUND, allWoundComplete);
    }

    private function allWoundComplete () :void {
        activateAllWound()
    }


    public function activateDeath (token:Token, callback:Function) :void {
        this.callback = callback
        this.iniciator = token
        initAssociateDeath();
    }
    private function initAssociateDeath () :void {
        tokens = getAssociate();
        activateAssociateDeath ();
    }

    private function activateAssociateDeath () :void {
        if (!tokens.length) {
            initOpponentDeath();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ASSOCIATE_DIE, associateDeathComplete);
    }

    private function associateDeathComplete () :void {
        activateAssociateDeath()
    }

    private function initOpponentDeath () :void {
        tokens = getOpponent();
        activateOpponentDeath ();
    }

    private function activateOpponentDeath () :void {
        if (!tokens.length) {
            initAllDeath();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.OPPONENT_DIE, opponentDeathComplete);
    }

    private function opponentDeathComplete () :void {
        activateOpponentDeath()
    }

    private function initAllDeath () :void {
        tokens = getAll();
        activateAllDeath ();
    }

    private function activateAllDeath () :void {
        if (!tokens.length) {
            callback ()
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ALL_DIE, allDeathComplete);
    }

    private function allDeathComplete () :void {
        activateAllDeath()
    }





}
}
