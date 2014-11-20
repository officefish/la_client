/**
 * Created by root on 9/12/14.
 */
package com.ps.field.controller {
import com.greensock.TimelineLite;
import com.greensock.easing.Expo;
import com.log.Logger;
import com.ps.cards.Card;
import com.ps.cards.CardData;
import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeAttachment;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.eptitude.IEptitudeActivator;
import com.ps.collection.CardsCache;
import com.ps.collection.Collection;
import com.ps.collodion.EnemyCollodion;
import com.ps.collodion.PlayerCollodion;
import com.ps.field.Field;
import com.ps.field.FieldEvent;
import com.ps.field.IAttackAvailable;
import com.ps.field.UnitRow;
import com.ps.hero.Hero;
import com.ps.tokens.Token;
import com.ps.trajectory.TrajectoryContainer;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

public class FieldController {

    private var eptitude:CardEptitude;

    private var enemyCollodion:EnemyCollodion;
    private var playerCollodion:PlayerCollodion;

    private var iniciator:IAttackAvailable;
    private var activator:IEptitudeActivator;

    private var type:int;

    private var field:Field;
    private var actualCardData:CardData;
    private var actualCard:Card;

    private var eptitudePower:int;

    private var actualToken:Token;
    private var subcontroller:CardSubController;
    private var playerFlag:Boolean;

    private var enemyFlag:Boolean = false;


    private static const NEW_UNIT:int = 0;
    private static const PLACE_CARD:int = 1;

    public function FieldController() {
    }

    public function setField (field:Field) :void {
        this.field = field;
    }
    public function setEnemyCollodion (enemyCollodion:EnemyCollodion) :void {
        this.enemyCollodion = enemyCollodion;
    }
    public function setPlayerCollodion (playerCollodion:PlayerCollodion) :void {
        this.playerCollodion = playerCollodion;
    }



    public function placeNewUnit (iniciator:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {

        this.type = NEW_UNIT;

        this.iniciator = iniciator;
        this.activator = activator;

        var eptitude:CardEptitude = eptitude;
        var newUnitId:int = eptitude.getUnitId ();
        eptitudePower = eptitude.getPower ();
        actualCardData = CardsCache.getInstance().getCardById (newUnitId);
        placeToken (actualCardData);
    }

    private function placeToken (cardData:CardData) :void {
        //Logger.log('placeToken')

        var card:Card = new Card (cardData);
        actualCard = card;

        var token:Token = new Token (card, iniciator.isEnemy());
        var index:int

        var playerRow:UnitRow = field.getPlayerRow ();
        var enemyRow:UnitRow = field.getEnemyRow ();

        actualToken = token;
        field.setLastPlaced(actualToken)

        var doIniciator:DisplayObject = iniciator as DisplayObject;

        if (iniciator.isEnemy()) {
            if (field.getVisibleTokens(enemyRow).length >= 7) {
                activator.continueActivate()
                return;
            }


            if (enemyRow.contains(iniciator as DisplayObject)) {
                token.x = doIniciator.x + Token.WIDTH + UnitRow.PADDING;
                if (doIniciator.visible) {
                    enemyRow.addChildAt (token, enemyRow.getChildIndex(doIniciator) + 1);
                } else {
                    enemyRow.addChildAt (token, enemyRow.getChildIndex(doIniciator));
                }
            } else {
                enemyRow.addChild (token);
            }

            field.sortUnitRow (enemyRow, 0, false) ;
            token.activateEptitudes (EptitudePeriod.SELF_PLACED, tokenPlaceComplete);


        } else {
            if (field.getVisibleTokens(playerRow).length >= 7) {
                 activator.continueActivate()
            }

            if (playerRow.contains(doIniciator)) {
                token.x = doIniciator.x + Token.WIDTH + UnitRow.PADDING;
                if (doIniciator.visible) {
                    playerRow.addChildAt (token, playerRow.getChildIndex(doIniciator) + 1);
                } else {
                    playerRow.addChildAt (token, playerRow.getChildIndex(doIniciator));
                }
            } else {
                playerRow.addChild(token);
            }

            field.sortUnitRow (playerRow, 0, false);
            token.activateEptitudes (EptitudePeriod.SELF_PLACED, tokenPlaceComplete);


        }
    }

    private function tokenPlaceComplete () :void {
        var playerRow:UnitRow = field.getPlayerRow ();
        var enemyRow:UnitRow = field.getEnemyRow ();
        if (actualToken.isEnemy()) {
            field.centerizeRow (enemyRow, onPlaceNewUnitComplete);
        } else {
            field.centerizeRow (playerRow, onPlaceNewUnitComplete);
        }
    }


    private function onPlaceNewUnitComplete () :void {
        initAssociate ();
    }

    private function initAssociate () :void {
        subcontroller = new CardSubController();
        subcontroller.setField(field);
        subcontroller.activatePlaceToken(iniciator, endActivate)
    }

    public function placeCard (card:Card, tokenPreviewIndex:int) :void {
        type = PLACE_CARD;
        enemyFlag = false;

        if (card.getType() == CardData.SPELL) {
            playSpell (card, true);
            return;
        }

        var playerRow:UnitRow = field.getPlayerRow ();

        var token:Token = new Token (card);

        iniciator = token;

        var mirrow:Sprite = card.getMirrow ();
        TrajectoryContainer.getInstance().addToPlaceCardLevel (mirrow);

        actualToken = token;
        actualToken.alpha = 0;
        field.setLastPlaced(actualToken)


        var tokenPosition:Point;

        if (playerRow.numChildren) {
            playerRow.addChildAt (token, tokenPreviewIndex);
            tokenPosition = field.sortUnitRow (playerRow, tokenPreviewIndex);
        } else {
            playerRow.addChild(token);
            tokenPosition = new Point (0, 0);
        }
        var rowPosition:Point = field.centerizeRow (playerRow);

        var mirrowPosition:Point = new Point (tokenPosition.x + rowPosition.x, tokenPosition.y + rowPosition.y);
        var endY:int = mirrowPosition.y;

        mirrowPosition.x -= (Card.MIRROW_WIDTH - Token.WIDTH) / 2;
        mirrowPosition.y -= (Card.MIRROW_HEIGHT - Token.HEIGHT) / 2;

        var timeline:TimelineLite = new TimelineLite ({onComplete:onPlaceComplete});
        timeline.to (mirrow, 0.5, { x:mirrowPosition.x, y:mirrowPosition.y, ease:Expo.easeOut, onComplete:onPlaceContinue } );
        timeline.to (mirrow, 0.5, { y:endY, alpha:0, ease:Expo.easeOut});
    }

    private function playSpell (card:Card, playerFlag:Boolean) :void {
        this.playerFlag = playerFlag;
        var hero:Hero;
        if (playerFlag) {
            hero = field.getPlayerHero();
        } else {
            hero = field.getEnemyHero();
        }
        iniciator = hero;
        hero.activateSpell (card.getCardData().getEptitudes(), onSpellPlayComplete);
    }

    private function onSpellPlayComplete () :void {
        activateSpell()
    }

    private function activateSpell () :void {
        subcontroller = new CardSubController();
        subcontroller.setField(field)
        subcontroller.activateSpell(iniciator, onSpellActivationComplete)
    }
    private function onSpellActivationComplete () :void {
        destroySubcontroller()
        subcontroller = new CardSubController();
        subcontroller.setField(field)
        subcontroller.activatePlayCard(iniciator, onPlayCardSpellSubCtrl)
    }
    private function onPlayCardSpellSubCtrl () :void {
        endActivate ()
    }


    private function onPlaceContinue () :void {
        actualToken.alpha = 1.0;
    }

    private function onPlaceComplete () :void {

        TrajectoryContainer.getInstance().endPlaceCard();
        actualToken.activateEptitudes  (EptitudePeriod.SELF_PLACED, onTokenActivationComplete);
    }

    private function onTokenActivationComplete () :void {
        if (field.getPlayerRow().contains(actualToken) || field.getEnemyRow().contains(actualToken)) {
            field.setLastPlaced(actualToken)
            subcontroller = new CardSubController();
            subcontroller.setField(field)
            subcontroller.activatePlayCard(actualToken, onPlayCardTokenSubCtrl)
        } else {
            endActivate()
        }

        //Logger.log('onTokenActivationComplete');

        //endActivate ()
    }

    private function onPlayCardTokenSubCtrl () :void {
        destroySubcontroller();
        initAssociate ();
    }

    public function placeEnemyCard (card:Card) :void {
        enemyFlag = true;

        type = PLACE_CARD;

        if (card.getType() == CardData.SPELL) {
            playSpell (card, false);
            return;
        }

        var token:Token = new Token (card, true);
        card.visible = true;

        var enemyRow:UnitRow = field.getEnemyRow ();

        var mirrow:Sprite = card.getShirt ();
        TrajectoryContainer.getInstance().addToPlaceCardLevel (mirrow);

        var mirrowStartPosition:Point = new Point (card.x, card.y);
        mirrowStartPosition = card.parent.localToGlobal (mirrowStartPosition);
        mirrow.x = mirrowStartPosition.x;
        mirrow.y = mirrowStartPosition.y;

        mirrow.scaleX = mirrow.scaleY = 0.72;

        actualToken = token;
        actualToken.alpha = 0;
        field.setLastPlaced(actualToken)

        var tokenPosition:Point;

        iniciator = actualToken;

        enemyRow.addChild (token);
        tokenPosition = field.sortUnitRow (enemyRow, enemyRow.getChildIndex(token));
        var rowPosition:Point =field.centerizeRow (enemyRow);

        var mirrowPosition:Point = new Point (tokenPosition.x + rowPosition.x, tokenPosition.y + rowPosition.y);
        var endY:int = mirrowPosition.y;

        mirrowPosition.x -= (Card.MIRROW_WIDTH - Token.WIDTH) / 2;
        mirrowPosition.y -= (Card.MIRROW_HEIGHT - Token.HEIGHT) / 2;

        var timeline:TimelineLite = new TimelineLite ( { onComplete:onPlaceComplete } );
        timeline.to (mirrow, 0.5, { x:mirrowPosition.x, y:mirrowPosition.y, scaleX:1.0, scaleY:1.0, ease:Expo.easeOut, onComplete:onPlaceContinue } );
        timeline.to (mirrow, 0.5, { y:endY, alpha:0, ease:Expo.easeOut});
    }


    private function onEnemyPlaceComplete () :void {
        field.setLastPlaced(actualToken)
        TrajectoryContainer.getInstance().endPlaceCard()
        activator = actualToken.activateEptitudes(EptitudePeriod.SELF_PLACED, onTokenActivationComplete);
    }


    public function copyUnit (iniciator:Token, target:Token, eptitude:CardEptitude, activator:IEptitudeActivator) :void {

        this.activator = activator;
        this.iniciator = iniciator;

        var index:int;
        var card:Card = new Card (iniciator.getCardData());
        var token:Token = new Token (card, target.isEnemy());

        if (target.isEnemy()) {
            index = field.getEnemyRow().getChildIndex(target);
            field.getEnemyRow().removeChild(target);
            field.getEnemyRow().addChildAt(token, index);
            token.x = target.x;
            //field.getEnemyRow().addChild(token);
            //field.sortUnitRow(field.getEnemyRow(),0, false)
        } else {
            index = field.getPlayerRow().getChildIndex(target);
            field.getPlayerRow().removeChild(target);
            field.getPlayerRow().addChildAt(token, index);
            token.x = target.x;
        }

        if (iniciator.isProvocator()) {
            token.activateProvocation()
        }
        if (iniciator.hasShield()) {
            token.activateShield()
        }
        if (iniciator.inShadow()) {
            token.activateShadow()
        }
        if (iniciator.isSpellInvisible()) {
            token.activateSpellInvisible()
        }
        if (iniciator.isSpellUp()) {
            token.activateSpellUp()
        }
        if (iniciator.isDoubleAttack()) {
            token.activateDoubleAttack()
        }
        if (iniciator.isFreeze()) {
            token.activateFreeze()
        }
        if (iniciator.isDumbness()) {
            token.dumbness()
        }
        token.setEptitudes(iniciator.copyEptitudes());

        token.setHealth(iniciator.getHealth())
        token.setAttack(iniciator.getAttack())
        token.setMaxHealth(iniciator.getMaxHealth())



        actualToken = token;
        checkSpellUp();

    }

    private function checkSpellUp () :void {
        if (actualToken.containsAnyLevelEptitude(CardEptitude.INCREASE_SPELL)) {
            var eptitude:CardEptitude = actualToken.getEptitudeByType(CardEptitude.INCREASE_SPELL)
            actualToken.forceActivate (eptitude, checkAttackBob);
        } else {
            checkAttackBob()
        }
    }

    private function checkAttackBob () :void {

        if (actualToken.containsAnyLevelEptitude(CardEptitude.INCREASE_ATTACK_BOB)) {
            var eptitude:CardEptitude = actualToken.getEptitudeByType(CardEptitude.INCREASE_ATTACK_BOB)
            actualToken.forceActivate (eptitude, checkHealthBob);
        } else {
            checkHealthBob()
        }
    }

    private function checkHealthBob () :void {
        if (actualToken.containsAnyLevelEptitude(CardEptitude.INCREASE_HEALTH_BOB)) {
            var eptitude:CardEptitude = actualToken.getEptitudeByType(CardEptitude.INCREASE_HEALTH_BOB)
            actualToken.forceActivate (eptitude, endCopy);
        } else {
            endCopy()
        }
    }

    private function endCopy () :void {
        activator.continueActivate()
    }

    public function convert (iniciator:Token, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
        var newUnitId:int = eptitude.getUnitId ();
        eptitudePower = eptitude.getPower ();
        actualCardData = CardsCache.getInstance().getCardById (newUnitId);

        var card:Card = new Card (actualCardData);
        var token:Token = new Token (card, iniciator.isEnemy());

        var index:int;

        if (iniciator.isEnemy()) {
            index = field.getEnemyRow().getChildIndex(iniciator);
            field.getEnemyRow().removeChild(iniciator);
            field.getEnemyRow().addChildAt(token, index);
            token.x = (iniciator).x;
            //field.getEnemyRow().addChild(token);
            //field.sortUnitRow(field.getEnemyRow(),0, false)
        } else {
            index = field.getPlayerRow().getChildIndex(iniciator);
            field.getPlayerRow().removeChild(iniciator);
            field.getPlayerRow().addChildAt(token, index);
            token.x = iniciator.x;
        }
        activator.continueActivate()

    }

    public function increaseAttackDependsOnTokens (iniciator:Token, eptitude:CardEptitude, activator:IEptitudeActivator):void {
        var level:int = eptitude.getAttachment();
        var numTokens:int = getNumTokens(iniciator, level) - 1;
        iniciator.setAttack(iniciator.getAttack() + numTokens)
        activator.continueActivate();
    }

    public function increaseHealthDependsOnTokens (iniciator:Token, eptitude:CardEptitude, activator:IEptitudeActivator):void {
        var level:int = eptitude.getAttachment();
        var numTokens:int = getNumTokens(iniciator, level) - 1;
        var newHealth:int = iniciator.getAttack() + numTokens
        if (newHealth > iniciator.getMaxHealth()) {
            iniciator.setMaxHealth(newHealth)
        }
        iniciator.setHealth(newHealth);
        activator.continueActivate();
    }

    public function increaseAttackDependsOnTokensRace (iniciator:Token, eptitude:CardEptitude, activator:IEptitudeActivator):void {
        var level:int = eptitude.getAttachment();
        var numTokens:int = getNumTokensRace(iniciator, level, eptitude.getRace()) - 1;
        iniciator.setAttack(iniciator.getAttack() + numTokens)
        activator.continueActivate();
    }

    public function increaseHealthDependsOnTokensRace (iniciator:Token, eptitude:CardEptitude, activator:IEptitudeActivator):void {
        var level:int = eptitude.getAttachment();
        var numTokens:int = getNumTokensRace(iniciator, level, eptitude.getRace()) - 1;
        var newHealth:int = iniciator.getAttack() + numTokens
        if (newHealth > iniciator.getMaxHealth()) {
            iniciator.setMaxHealth(newHealth)
        }
        iniciator.setHealth(newHealth);
        activator.continueActivate();
    }

    private function getNumTokens (iniciator:Token, level:int) :int {
        var numTokens:int = 0;
        switch (level) {
            case EptitudeAttachment.ASSOCIATE: {
                if (iniciator.isEnemy()) {
                    numTokens = field.getEnemyRow().numChildren;
                } else {
                    numTokens = field.getPlayerRow().numChildren;
                }
                break;
            }
            case EptitudeAttachment.OPPONENT: {
                if (iniciator.isEnemy()) {
                    numTokens = field.getPlayerRow().numChildren;
                } else {
                    numTokens = field.getEnemyRow().numChildren;
                }
                break;
            }
            case EptitudeAttachment.ALL: {
                numTokens = field.getPlayerRow().numChildren;
                numTokens += field.getEnemyRow().numChildren;
                break;
            }
        }
        return numTokens;
    }

    private function getNumTokensRace (iniciator:Token, level:int, raceId:int) :int {
        var numTokens:int = 0;
        switch (level) {
            case EptitudeAttachment.ASSOCIATE: {
                if (iniciator.isEnemy()) {
                    numTokens = field.getVisibleRaceTokens(field.getEnemyRow(), raceId).length;
                } else {
                    numTokens = field.getVisibleRaceTokens(field.getPlayerRow(), raceId).length;
                }
                break;
            }
            case EptitudeAttachment.OPPONENT: {
                if (iniciator.isEnemy()) {
                    numTokens = field.getVisibleRaceTokens(field.getPlayerRow(), raceId).length;
                } else {
                    numTokens = field.getVisibleRaceTokens(field.getEnemyRow(), raceId).length;
                }
                break;
            }
            case EptitudeAttachment.ALL: {
                numTokens = field.getVisibleRaceTokens(field.getEnemyRow(), raceId).length;
                numTokens += field.getVisibleRaceTokens(field.getPlayerRow(), raceId).length;
                break;
            }
        }
        return numTokens;
    }


    private function destroySubcontroller () :void {
        if (subcontroller) {
            subcontroller.destroy()
            subcontroller = null;
        }
    }

    private function endActivate () :void {
        destroySubcontroller()

        switch (type) {
            case NEW_UNIT: {
                eptitudePower --;

                if (eptitudePower == 0) {
                    activator.continueActivate()
                    break;
                } else {
                    placeToken (actualCardData);
                }
                break;
            }
            case PLACE_CARD: {
                if (enemyFlag) {
                    field.dispatchEvent (new FieldEvent (FieldEvent.ENEMY_CARD_PLAY));
                }
                break;
            }
        }
    }


}
}
