/**
 * Created by root on 9/2/14.
 */
package com.ps.tokens {
import com.log.Logger;
import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeAttachment;
import com.ps.cards.eptitude.EptitudeEvent;
import com.ps.cards.eptitude.EptitudeLevel;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.PickCardLevel;
import com.ps.cards.eptitude.IEptitudeActivator;
import com.ps.field.IAttackAvailable;

public class EptitudeActivator implements IEptitudeActivator{

    private var iniciator:IAttackAvailable;
    private var selfFlag:Boolean;
    private var callback:Function;
    private var eptitudes:Array

    public function EptitudeActivator(iniciator:IAttackAvailable, callback:Function, selfFlag:Boolean = false) {
        this.iniciator = iniciator;
        this.selfFlag = selfFlag;
        this.callback = callback;
        eptitudes = [];
    }

    public function activateEptitudes (eptitudes:Array) :void {
        this.eptitudes = eptitudes
        activate();
    }

    private function activate () :void {
       // Logger.log(eptitudes.length.toString())

        if (!eptitudes.length) {

            callback();
            //dispatchEvent (new TokenEvent (TokenEvent.ACTIVATION_COMPLETE, this));
            return;
        }

        var eptitude:CardEptitude = eptitudes.shift();

        var probability:Number = eptitude.getProbability() / 100;

        if (Math.random() >= probability) {
            activate();
            return;
        }


        var newAttack:int;
        var newHealth:int;

        var level:int;
        var power:int;
        var newEptitude:CardEptitude
        var bob:int;

        var token:Token
        if (iniciator is Token) {
            token = iniciator as Token;
        }

        if (token) {
            if (eptitude.marker) {
                //Logger.log('mark eptitude')
                token.dependency = eptitude;
            }
            if (eptitude.dependency) {
                //Logger.log('eptitude has dependency')
                if (!token.dependency) {
                    activate();
                    return;
                }
                //Logger.log ('token has dependency');
                if (token.dependency.getType() != eptitude.dependency) {
                    //Logger.log('token dependency and eptityde dependency is not equal')
                    activate();
                    return;
                }
            }
        }


        if (!selfFlag) {
            switch (eptitude.getLevel()) {
                case EptitudeLevel.SELECTED_OPPONENT_UNIT:
                {
                    if (iniciator.isEnemy()) {
                        eptitude.setLevel(EptitudeLevel.RANDOM_OPPONENT_UNIT);
                        break;
                    } else {
                        iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.SELECT, eptitude, this));
                        return;
                    }
                }
                case EptitudeLevel.SELECTED_OPPONENT:
                {
                    if (iniciator.isEnemy()) {
                        eptitude.setLevel(EptitudeLevel.RANDOM_OPPONENT);
                        break;
                    } else {
                        iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.SELECT, eptitude, this));
                        return;
                    }
                }
                case EptitudeLevel.SELECTED_ASSOCIATE_UNIT:
                {
                    if (iniciator.isEnemy()) {
                        eptitude.setLevel(EptitudeLevel.RANDOM_ASSOCIATE_UNIT);
                        break;
                    } else {
                        iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.SELECT, eptitude, this));
                        return;
                    }
                }
                case EptitudeLevel.SELECTED_ASSOCIATE:
                {
                    if (iniciator.isEnemy()) {
                        eptitude.setLevel(EptitudeLevel.RANDOM_ASSOCIATE);
                        break;
                    } else {
                        iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.SELECT, eptitude, this));
                        return;
                    }
                }

                case EptitudeLevel.SELECTED_ANY:
                {
                    if (iniciator.isEnemy()) {
                        eptitude.setLevel(EptitudeLevel.RANDOM_ALL);
                        break;
                    } else {
                        iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.SELECT, eptitude, this));
                        return;
                    }
                }

                case EptitudeLevel.SELECTED_ANY_UNIT:
                {
                    if (iniciator.isEnemy()) {
                        eptitude.setLevel(EptitudeLevel.RANDOM_ALL_UNIT);
                        break;
                    } else {
                        iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.SELECT, eptitude, this));
                        return;
                    }
                }
                case EptitudeLevel.SELECTED_ALL_SPELL:
                {
                    if (iniciator.isEnemy()) {
                        eptitude.setLevel(EptitudeLevel.RANDOM_ALL_SPELL);
                        break;
                    } else {
                        iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.SELECT, eptitude, this));
                        return;
                    }
                }
                case EptitudeLevel.SELECTED_OPPONENT_SPELL:
                {
                    if (iniciator.isEnemy()) {
                        eptitude.setLevel(EptitudeLevel.RANDOM_OPPONENT_SPELL);
                        break;
                    } else {
                        iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.SELECT, eptitude, this));
                        return;
                    }
                }
                case EptitudeLevel.SELECTED_ASSOCIATE_SPELL:
                {
                    if (iniciator.isEnemy()) {
                        eptitude.setLevel(EptitudeLevel.RANDOM_ASSOCIATE_SPELL);
                        break;
                    } else {
                        iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.SELECT, eptitude, this));
                        return;
                    }
                }

                case EptitudeLevel.SELECTED_OPPONENT_UNIT_RICE:
                case EptitudeLevel.SELECTED_OPPONENT_UNIT_SUBRICE:
                case EptitudeLevel.SELECTED_OPPONENT_CONDITION:
                case EptitudeLevel.SELECTED_ASSOCIATE_UNIT_RICE:
                case EptitudeLevel.SELECTED_ASSOCIATE_UNIT_SUBRICE:
                case EptitudeLevel.SELECTED_ASSOCIATE_CONDITION:
                case EptitudeLevel.SELECTED_ANY_RACE:
                case EptitudeLevel.SELECTED_ANY_SUBRACE:
                case EptitudeLevel.SELECTED_ANY_CONDITION:
                {
                    iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.SELECT, eptitude, this));
                    return;
                }
            }

            if (eptitude.getLevel() != EptitudeLevel.SELF) {
                //Logger.log ('activate eptitudes');
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.ACTIVATE, eptitude, this));
                return;
            }
        }


        switch (eptitude.getType()) {
            case CardEptitude.SHADOW:
            {
                if (!token) break;
                token.activateShadow()
                break;
            }
            case CardEptitude.SHIELD:
            {
                if (!token) break;
                token.activateShield()
                break;
            }
            case CardEptitude.CAN_NOT_ATTACK:
            {
                if (!token) break;
                eptitude.setPeriod(EptitudePeriod.START_STEP);
                token.canAttack = false;
                break;
            }
            case CardEptitude.DOUBLE_ATTACK:
            {
                if (!token) break;
                token.attackCount = 2;
                eptitude.setPeriod(EptitudePeriod.START_STEP);
                break;
            }
            case CardEptitude.PROVOCATION:
            {
                if (!token) break;
                token.activateProvocation();
                break;
            }
            case CardEptitude.JERK:
            {
                if (!token) break;
                token.canAttack = true;
                break;
            }

            case CardEptitude.INCREASE_ATTACK:
            {
                if (!token) break;
                token.setAttack(token.getAttack() + eptitude.getPower());
                // TODO вынести код повыше
                if (eptitude.getLifecycle() >= 0) {
                    newEptitude = new CardEptitude(CardEptitude.INCREASE_ATTACK);
                    newEptitude.setPeriod(EptitudePeriod.ACTIVATED);
                    newEptitude.setPower(eptitude.getPower())
                    newEptitude.setLifecycle(eptitude.getLifecycle())
                    token.tempEmptitudes.push(newEptitude)
                }
                break;
            }

            case CardEptitude.REPLACE_ATTACK_HEALTH:
            {
                if (!token) break;
                newAttack = token.getHealth();
                newHealth = token.getAttack();

                token.setAttack(newAttack);

                if (newHealth > token.getMaxHealth()) {
                    token.setMaxHealth(newHealth)
                }

                token.setHealth(newHealth)

                if (token.getHealth() == 0) {
                    eptitude.setLevel(EptitudeLevel.SELF)
                    token.dispatchEvent(new EptitudeEvent(EptitudeEvent.DEATH, eptitude, this));
                    return;
                }
                break;
            }

            case CardEptitude.DECREASE_ATTACK:
            {
                if (!token) break;
                newAttack = token.getAttack() - eptitude.getPower();
                if (newAttack < 0) newAttack = 0;
                if (newAttack == 0) {
                    token.canAttack = false;
                    token.attackCount = 0;
                }
                token.setAttack(newAttack);
                break;
            }

            case CardEptitude.CHANGE_ATTACK_TILL:
            {
                if (!token) break;
                newAttack = eptitude.getPower();
                if (newAttack == 0) {
                    token.canAttack = false;
                    token.attackCount = 0;
                }
                token.setAttack(newAttack);
                break;
            }

            case CardEptitude.INCREASE_ATTACK_BOB:
            {
                if (!token) break;
                bob = token.getAttackBob();
                bob += eptitude.getPower();
                token.setAttackBob(bob);
                token.setAttack(token.getAttack());
                break;
            }

            case CardEptitude.DECREASE_ATTACK_BOB:
            {
                if (!token) break;
                bob = token.getAttackBob();
                bob -= eptitude.getPower();
                if (bob < 0) {
                    bob = 0;
                }
                token.setAttackBob(bob);
                token.setAttack(token.getAttack());
                break;
            }

            case CardEptitude.INCREASE_HEALTH_BOB:
            {
                if (!token) break;
                bob = token.getHealthBob()
                bob += eptitude.getPower();
                token.setHealthBob(bob);
                token.setHealth(token.getHealth());
                break;
            }

            case CardEptitude.DECREASE_HEALTH_BOB:
            {
                if (!token) break;
                bob = token.getHealthBob()
                bob -= eptitude.getPower();
                if (bob < 0) {
                    bob = 0;
                }
                token.setHealthBob(bob);
                token.setHealth(token.getHealth());
                break;
            }
            case CardEptitude.DUMBNESS:
            {
                if (!token) break;
                token.dumbness();
                if (token.spellBob > 0) {
                    eptitude = new CardEptitude(CardEptitude.DECREASE_SPELL);
                    eptitude.setPower(token.spellBob);
                    eptitude.setAttachment(token.spellBobAttachment)
                    iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.DECREASE_SPELL, eptitude, this));
                    return;
                }
                break;
            }

            // special attack Eptitudes

            case CardEptitude.PASSIVE_ATTACK:
            {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.PASSIVE_ATTACK, eptitude, this));
                return;
            }
            case CardEptitude.CONFIG_PASSIVE_ATTACK:
            {
                //iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.ACTIVATE, eptitude, this));
                return;
            }
            case CardEptitude.KILL:
            {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.DEATH, eptitude, this));
                return;
            }
            case CardEptitude.FREEZE:
            {
               iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.FREEZE, eptitude, this));
               return;
            }
            case Token.TOKEN_FREEZE:
            {
                if (!token) break;
                var freezeEptitude:CardEptitude = token.getEptitudeByType(Token.TOKEN_FREEZE);
                power = freezeEptitude.getPower();
                power--;
                freezeEptitude.setPower(power);
                if (power <= 0) {
                    token.removeEptitude(freezeEptitude);
                    if (token.level4.contains(token.freezeSprite)) {
                        token.level4.removeChild(token.freezeSprite);
                        token.freezeFlag = false;
                        token.canAttack = true;
                    }
                } else {
                    token.canAttack = false;
                }
                break;
            }

            // health eptitudes

            case CardEptitude.CHANGE_HEALTH_TILL:
            {
                if (!token) break;
                token.setMaxHealth(eptitude.getPower());
                token.setHealth(token.getMaxHealth());
                break;
            }
            case CardEptitude.INCREASE_HEALTH:
            {
                if (!token) break;
                token.setMaxHealth(token.getMaxHealth() + eptitude.getPower());
                token.setHealth(token.getHealth() + eptitude.getPower());
                token.dispatchEvent(new EptitudeEvent(EptitudeEvent.TREATMENT, eptitude, this))
                return;
            }
            case CardEptitude.DECREASE_HEALTH:
            {
                if (!token) break;
                var newMaxHealth:int = token.getMaxHealth() - eptitude.getPower();
                if (newMaxHealth <= 0) newMaxHealth = 1;

                token.setMaxHealth(newMaxHealth);

                newHealth = token.getHealth() - eptitude.getPower();
                if (newHealth < 0) newHealth = 0;

                token.setHealth(newHealth);
                if (token.getHealth() == 0) {
                    iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.DEATH, eptitude, this));
                    return;
                }
                break;
            }
            case CardEptitude.INCREASE_ATTACK_AND_HEALTH:
            {
                if (!token) break;
                token.setAttack(token.getAttack() + eptitude.getPower());
                if (eptitude.getLifecycle() >= 0) {
                    newEptitude = new CardEptitude(CardEptitude.INCREASE_ATTACK);
                    newEptitude.setPeriod(EptitudePeriod.ACTIVATED);
                    newEptitude.setPower(eptitude.getPower())
                    newEptitude.setLifecycle(eptitude.getLifecycle())
                    token.tempEmptitudes.push(newEptitude)
                }

                token.setMaxHealth(token.getMaxHealth() + eptitude.getPower());
                token.setHealth(token.getHealth() + eptitude.getPower());
                token.dispatchEvent(new EptitudeEvent(EptitudeEvent.TREATMENT, eptitude, this))
                return;
             }
            case CardEptitude.MASSIVE_ATTACK:
            {

                if (!token) break;

                if (token.getHealth() == 0) {
                    break;
                }
                newHealth = token.getHealth() - eptitude.getPower();
                if (newHealth < 0) newHealth = 0;

                token.setHealth(newHealth);
                if (token.getHealth() == 0) {
                    iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.DEATH, eptitude, this));
                    return;
                }
                break;
            }
            case CardEptitude.FULL_HEALTH:
            {
                if (!token) break;
                if (token.getHealth() == token.getMaxHealth()) {
                    break;
                }
                token.setHealth(token.getMaxHealth());
                token.dispatchEvent(new EptitudeEvent(EptitudeEvent.TREATMENT, eptitude, this))
                return;
            }
            case CardEptitude.TREATMENT:
            {
                if (!token) break;
                if (token.getHealth() == token.getMaxHealth()) {
                    break;
                }
                newHealth = token.getHealth() + eptitude.getPower();
                if (newHealth > token.getMaxHealth()) {
                    newHealth = token.getMaxHealth()
                }
                token.setHealth(newHealth);
                token.dispatchEvent(new EptitudeEvent(EptitudeEvent.TREATMENT, eptitude, this))
                return;
            }

            // card eptitudes

            case CardEptitude.PICK_CARD:
            {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.PICK_CARD, eptitude, this));
                return;
            }

            case CardEptitude.BACK_CARD_TO_HAND:
            {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.BACK_CARD_TO_HAND, eptitude, this));
                return;
            }
            case CardEptitude.ASSOCIATE_NEW_UNIT:
            {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.NEW_UNIT, eptitude, this));
                return;
            }
            case CardEptitude.CARD_SALE:
            {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.CARD_SALE, eptitude, this));
                return;
            }

            // spell

            case CardEptitude.INCREASE_SPELL:
            {
                if (token) {
                    token.spellBob += eptitude.getPower();
                    token.spellBobAttachment = eptitude.getAttachment();
                    token.activateSpellUp ();
                }
                if (!token.containsAnyLevelEptitude(CardEptitude.INCREASE_SPELL)) {
                    newEptitude = new CardEptitude (CardEptitude.INCREASE_SPELL);
                    newEptitude.setPeriod (EptitudePeriod.ACTIVATED);
                    newEptitude.setLevel(EptitudeLevel.SELF)
                    newEptitude.setPower(eptitude.getPower())
                    token.addEptitude (newEptitude);
                }

                newEptitude = new CardEptitude (CardEptitude.DECREASE_SPELL);
                newEptitude.setPeriod (EptitudePeriod.SELF_DIE);
                newEptitude.setLevel(EptitudeLevel.SELF)
                newEptitude.setPower(eptitude.getPower())
                token.addEptitude (newEptitude);
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.INCREASE_SPELL, eptitude, this));
                return;
            }
            case CardEptitude.DECREASE_SPELL:
            {
                token.spellBob -= eptitude.getPower();
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.DECREASE_SPELL, eptitude, this));
                return;
            }
            case CardEptitude.SPELL_INVISIBLE:
            {
               if (!token) break;
               token.activateSpellInvisible();
               break;
            }

            case CardEptitude.ENTICE_UNIT:
            {
                token.dispatchEvent (new EptitudeEvent (EptitudeEvent.ENTICE_UNIT, eptitude, this));
                return;
            }

            case CardEptitude.NEW_SPELL: {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.NEW_SPELL, eptitude, this));
                return;
            }
            case CardEptitude.COPY_UNIT: {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.COPY_UNIT, eptitude, this));
                return;
            }
            case CardEptitude.UNIT_CONVERTION: {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.UNIT_CONVERTION, eptitude, this));
                return;
            }
            case CardEptitude.INCREASE_HEALTH_DEPENDS_ON_CARDS: {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.INCREASE_HEALTH_DEPENDS_ON_CARDS, eptitude, this));
                return;
            }

            case CardEptitude.INCREASE_ATTACK_DEPENDS_ON_TOKENS: {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.INCREASE_ATTACK_DEPENDS_ON_TOKENS, eptitude, this));
                return;
            }
            case CardEptitude.INCREASE_HEALTH_DEPENDS_ON_TOKENS: {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.INCREASE_HEALTH_DEPENDS_ON_TOKENS, eptitude, this));
                return;
            }
            case CardEptitude.INCREASE_ATTACK_DEPENDS_ON_TOKENS_RACE: {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.INCREASE_ATTACK_DEPENDS_ON_TOKENS_RACE, eptitude, this));
                return;
            }
            case CardEptitude.INCREASE_HEALTH_DEPENDS_ON_TOKENS_RACE: {
                iniciator.dispatchEvent(new EptitudeEvent(EptitudeEvent.INCREASE_HEALTH_DEPENDS_ON_TOKENS_RACE, eptitude, this));
                return;
            }

        }
        activate();
    }

    public function continueActivate () :void {
        activate();
    }
}
}
