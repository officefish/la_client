/**
 * Created by root on 9/9/14.
 */
package com.ps.field.controller {
import com.log.Logger;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.field.Field;
import com.ps.field.IAttackAvailable;
import com.ps.tokens.Token;

public class CardSubController extends SubController {

    public function CardSubController() {

    }


    // PlayCard

    public function activatePlayCard (iniciator:IAttackAvailable, callback:Function) :void {
        this.iniciator = iniciator;
        this.callback = callback;
        token = this.iniciator as Token;
        initAssociatePlayCard ();
    }
    private function initAssociatePlayCard () :void {
        tokens = getAssociate();
        activateAssociatePlayCard()
    }
    private function activateAssociatePlayCard () :void {
        if (!tokens.length) {
            initOpponentPlayCard();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ASSOCIATE_PLAY_CARD, endAssociatePlayCard);
    }
    private function endAssociatePlayCard () :void {
        activateAssociatePlayCard()
    }
    private function initOpponentPlayCard () :void {
        tokens = getOpponent();
        activateOpponentPlayCard();
    }
    private function activateOpponentPlayCard () :void {
        if (!tokens.length) {
            initAllPlayCard();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.OPPONENT_PLAY_CARD, endOpponentPlayCard);
    }
    private function endOpponentPlayCard () :void {
        activateOpponentPlayCard()
    }
    private function initAllPlayCard () :void {
        tokens = getAll();
        activateAllPlayCard();
    }
    private function  activateAllPlayCard () :void {
        if (!tokens.length) {
            callback ();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ALL_PLAY_CARD, endAllPlayCard);
    }
    private function endAllPlayCard () :void {
        activateAllPlayCard();
    }


    // PlaceToken

    public function activatePlaceToken (iniciator:IAttackAvailable, callback:Function) :void {
        this.iniciator = iniciator;
        this.callback = callback;
        token = this.iniciator as Token;
        initAssociatePlaceToken ();
    }
    private function initAssociatePlaceToken () :void {

        tokens = getAssociate();
        activateAssociatePlaceToken ();
    }
    private function activateAssociatePlaceToken () :void {
        if (!tokens.length) {
            initAssociateRacePlaceToken();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ASSOCIATE_PLACED, associatePlaceTokenComplete);
    }
    private function associatePlaceTokenComplete () :void {
        activateAssociatePlaceToken ();
    }
    private function initAssociateRacePlaceToken () :void {

        if (token) {
           tokens = getRaceAssociate(token.getRace());
           activateAssociateRacePlaceToken ();
        } else {
            initOpponentPlaceToken();
        }
    }
    private function activateAssociateRacePlaceToken () :void {
        if (!tokens.length) {
            initOpponentPlaceToken ();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ASSOCIATE_RACE_PLACED, associateRacePlaceTokenComplete);
    }
    private function associateRacePlaceTokenComplete () :void {
        activateAssociateRacePlaceToken ();
    }
    private function initOpponentPlaceToken () :void {

        tokens = getOpponent();
        activateOpponentPlaceToken ();
    }
    private function activateOpponentPlaceToken () :void {
        if (!tokens.length) {
            initOpponentRacePlaceToken ();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.OPPONENT_PLACED, opponentPlaceTokenComplete);
    }
    private function opponentPlaceTokenComplete () :void {
        activateOpponentPlaceToken ();
    }
    private function initOpponentRacePlaceToken () :void {
        if (token) {
            tokens = getRaceOpponent(token.getRace());
            activateOpponentRacePlaceToken ();
        } else {
            initAllPlaceToken ()
        }
    }
    private function activateOpponentRacePlaceToken () :void {
        if (!tokens.length) {
            initAllPlaceToken()
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.OPPONENT_RACE_PLACED, opponentRacePlaceTokenComplete);
    }
    private function opponentRacePlaceTokenComplete () :void {
        activateOpponentRacePlaceToken ()
    }
    private function initAllPlaceToken () :void {
        tokens = getAll()
        activateAllPlaceToken ();
    }
    private function activateAllPlaceToken () :void {
        if (!tokens.length) {
            initAllRacePlaceToken ()
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ALL_PLACED, allPlaceTokenComplete);
    }
    private function allPlaceTokenComplete () :void {
        activateAllPlaceToken ();
    }
    private function initAllRacePlaceToken () :void {
        if (token) {
            tokens = getRaceAll(token.getRace())
            activateAllRacePlaceToken ();
        } else {
            callback ();
        }
    }
    private function activateAllRacePlaceToken () :void {
        if (!tokens.length) {
           callback ();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ALL_RACE_PLACED, allRacePlaceTokenComplete);
    }
    private function allRacePlaceTokenComplete () :void {
        activateAllRacePlaceToken ()
    }

    // Spell

    public function activateSpell (iniciator:IAttackAvailable, callback:Function) :void {
        this.iniciator = iniciator;
        this.callback = callback;
        token = this.iniciator as Token;
        initAssociateSpell()
    }

    private function initAssociateSpell () :void {
        tokens = getAssociate();
        activateAssociateSpell()
    }
    private function activateAssociateSpell () :void {
        if (!tokens.length) {
            initOpponentSpell();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ASSOCIATE_SPELL, onAssociateSpellComplete);
    }
    private function onAssociateSpellComplete () :void {
        activateAssociateSpell();
    }
    private function initOpponentSpell () :void {
        tokens = getOpponent();
        activateOpponentSpell()
    }
    private function activateOpponentSpell () :void {
        if (!tokens.length) {
            initAllSpell();
            return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.OPPONENT_SPELL, onOpponentSpellComplete);
    }
    private function  onOpponentSpellComplete () :void {
        activateOpponentSpell();
    }
    private function initAllSpell () :void {
        tokens = getAll();
        activateAllSpell();
    }
    private function activateAllSpell () :void {
        if (!tokens.length) {
             callback ();
             return;
        }
        actualToken = tokens.shift ();
        actualToken.activateEptitudes (EptitudePeriod.ALL_SPELL, onAllSpellComplete);
    }
    private function onAllSpellComplete () :void {
        activateAllSpell();
    }



}
}
