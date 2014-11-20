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
import com.ps.cards.eptitude.IEptitudeActivator;
import com.ps.cards.sale.CardSale;
import com.ps.collection.CardsCache;
import com.ps.collection.Collection;
import com.ps.collodion.EnemyCollodion;
import com.ps.collodion.ICollodion;
import com.ps.collodion.PlayerCollodion;
import com.ps.field.Field;
import com.ps.field.FieldEvent;
import com.ps.field.IAttackAvailable;
import com.ps.field.UnitRow;
import com.ps.hero.Hero;
import com.ps.tokens.Token;
import com.ps.trajectory.TrajectoryContainer;

import flash.display.Loader;

import flash.display.Sprite;

import flash.events.Event;
import flash.geom.Point;

public class CollodionController {

    private var activator:IEptitudeActivator;
    private var iniciator:IAttackAvailable;
    private var eptitude:CardEptitude;

    private var enemyCollodion:EnemyCollodion;
    private var enemyCollection:Collection;

    private var playerCollodion:PlayerCollodion;
    private var playerCollection:Collection;

    private var eptitudePower:int;
    private var reservePower:int;

    private var field:Field;

    private var backCardToken:Token;
    private var actualCard:Card;



    public function CollodionController() {
    }

    public function setEnemyCollodion (enemyCollodion:EnemyCollodion) :void {
        this.enemyCollodion = enemyCollodion;
    }

    public function setEnemyCollecton (collection:Collection) :void {
        this.enemyCollection = collection;
    }

    public function setPlayerCollodion (playerCollodion:PlayerCollodion) :void {
        this.playerCollodion = playerCollodion;
    }

    public function setPlayerCollection (collection:Collection) :void {
        this.playerCollection = collection;
    }


    public function setField (field:Field) :void {
        this.field = field;
    }

    public function pickCard (iniciator:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {

        eptitudePower = eptitude.getPower ();
        this.iniciator = iniciator;
        this.activator = activator;

        var level:int = eptitude.getAttachment()

        switch (level) {
            case EptitudeAttachment.ASSOCIATE: {
                if (iniciator.isEnemy()) {
                    enemyCollodion.addEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onEnemyPickCard);
                    enemyCollodion.addCard (enemyCollection.getRandomCard());
                } else {
                    playerCollodion.addEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onPlayerPickCard);
                    playerCollodion.addCard (playerCollection.getRandomCard());
                }
                break;
            }
            case EptitudeAttachment.OPPONENT: {
                if (iniciator.isEnemy()) {
                    playerCollodion.addEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onPlayerPickCard);
                    playerCollodion.addCard (playerCollection.getRandomCard());
                } else {
                    enemyCollodion.addEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onEnemyPickCard);
                    enemyCollodion.addCard (enemyCollection.getRandomCard());
                }
                break;
            }
            case EptitudeAttachment.ALL: {
                reservePower = eptitudePower;
                playerCollodion.addEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onAllPickCard);
                enemyCollodion.addEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onAllEnemyPlaceCard);
                playerCollodion.addCard (playerCollection.getRandomCard());
            }
        }

    }

    private function onPlayerPickCard (event:Event) :void {
        eptitudePower --;

        if (eptitudePower <= 0) {
            playerCollodion.removeEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onPlayerPickCard);
            if (iniciator.isEnemy()) {
                playerCollodion.glowAvailableCards();
            }
            activator.continueActivate();

        } else {
            playerCollodion.addCard (playerCollection.getRandomCard());
        }
    }

    private function onAllPickCard (event:Event) :void {
        eptitudePower --;

        if (eptitudePower <= 0) {
            playerCollodion.removeEventListener (PlayerCollodion.COMPLETE_PLACE_CARD, onAllPickCard);
            enemyCollodion.addCard (enemyCollection.getRandomCard());


        } else {
            playerCollodion.addCard (playerCollection.getRandomCard());
        }
    }

    private function onEnemyPickCard (event:Event) :void {
        eptitudePower --;

        if (eptitudePower <= 0) {
            enemyCollodion.removeEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onEnemyPickCard);
            if (iniciator.isEnemy()) {
                playerCollodion.glowAvailableCards();
            }
            activator.continueActivate();

        } else {
            enemyCollodion.addCard (enemyCollection.getRandomCard());
        }
    }

    private function onAllEnemyPlaceCard (event:Event) :void {
        reservePower --;

        if (reservePower <= 0) {
            enemyCollodion.removeEventListener (EnemyCollodion.COMPLETE_PLACE_CARD, onAllEnemyPlaceCard);
            completePickCard ();
        } else {
            enemyCollodion.addCard (enemyCollection.getRandomCard());
        }
    }

    private function completePickCard () :void {
        if (eptitudePower <= 0 && reservePower <= 0) {
            activator.continueActivate();
            //dispatchEvent (new Event (PICK_CARD_COMPLETE));
        }
    }

    public function sale (iniciator:Token, eptitude:CardEptitude, activator:IEptitudeActivator) :void {

        this.iniciator = iniciator;
        this.activator = activator;

        var cardSale:CardSale = eptitude.getSale();
        var collodions:Array = getCollodions (iniciator, eptitude.getAttachment());
        var collodion:ICollodion;

        for (var i:int = 0; i < collodions.length; i ++) {
            collodion = collodions[i];
            collodion.addSale (cardSale);
            if (collodion is PlayerCollodion) {
                (collodion as PlayerCollodion).glowAvailableCards();
            }
        }

        activator.continueActivate()


    }

    private function getCollodions (iniciator:Token, level:int) :Array {
        var arr:Array = [];
        switch (level) {
            case EptitudeAttachment.ASSOCIATE: {
                if (iniciator.isEnemy()) {
                    arr.push(enemyCollodion)
                } else {
                    arr.push(playerCollodion);
                }
                break;
            }
            case EptitudeAttachment.OPPONENT: {
                if (iniciator.isEnemy()) {
                    arr.push(playerCollodion);
                } else {
                    arr.push(enemyCollodion);
                }
                break;
            }
            case EptitudeAttachment.ALL: {
                arr.push(playerCollodion);
                arr = arr.concat(enemyCollodion)
            }
        }
        return arr;
    }

    private function getHeroes (iniciator:Token, level:int) :Array {
        var arr:Array = [];
        switch (level) {
            case EptitudeAttachment.ASSOCIATE: {
                if (iniciator.isEnemy()) {
                    arr.push(field.getEnemyHero())
                } else {
                    arr.push(field.getPlayerHero());
                }
                break;
            }
            case EptitudeAttachment.OPPONENT: {
                if (iniciator.isEnemy()) {
                    arr.push(field.getPlayerHero());
                } else {
                    arr.push(field.getEnemyHero());
                }
                break;
            }
            case EptitudeAttachment.ALL: {
                arr.push(field.getPlayerHero());
                arr = arr.concat(field.getEnemyHero())
            }
        }
        return arr;
    }

    public function increaseSpell (iniciator:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
        this.iniciator = iniciator as Token;
        this.activator = activator;
        var heroes:Array = getHeroes (iniciator as Token, eptitude.getAttachment());
        var hero:Hero;
        for (var i:int = 0; i < heroes.length; i ++) {
            hero = heroes[i];
            hero.increaseSpell(eptitude.getPower())
        }

        activator.continueActivate()


    }

    public function decreaseSpell (iniciator:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
        this.iniciator = iniciator as Token;
        this.activator = activator;
        var heroes:Array = getHeroes (iniciator as Token, eptitude.getAttachment());
        var hero:Hero;
        for (var i:int = 0; i < heroes.length; i ++) {
            hero = heroes[i];
            hero.degreaseSpell(eptitude.getPower())
        }

        activator.continueActivate()

    }

    public function backCardToHand (iniciator:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {

        this.iniciator = iniciator;
        this.activator = activator;

        var level:int = eptitude.getAttachment();
        var enemyFlag:Boolean = iniciator.isEnemy();

        if (level == EptitudeAttachment.ASSOCIATE) {
            if (enemyFlag) {
                backCardToEnemyHand(iniciator as Token)
            } else {
                backCardToPlayerHand(iniciator as Token)
            }
        } else {
            if (enemyFlag) {
                backCardToPlayerHand(iniciator as Token)
            } else {
                backCardToEnemyHand(iniciator as Token)
            }
        }
    }

    private function backCardToPlayerHand (token:Token) :void {

        backCardToken = token;

        var mirrow:Sprite = token.getMirrow ();
        mirrow.alpha = 0.5;
        var tokenPosition:Point = new Point (token.x, token.y);
        tokenPosition = token.parent.localToGlobal (tokenPosition);
        tokenPosition.x -= ((Card.MIRROW_WIDTH - Token.WIDTH) / 2);
        mirrow.x = tokenPosition.x;
        mirrow.y = tokenPosition.y;

        TrajectoryContainer.getInstance().addToPlayCardLevel (mirrow);

        var yCof:int = tokenPosition.y - (Card.MIRROW_HEIGHT - Token.HEIGHT) / 2;

        actualCard = playerCollodion.addCard (token.getCardData (), false);

        var cardPosition:Point = new Point (actualCard.x, actualCard.y);

        cardPosition = actualCard.parent.localToGlobal (cardPosition);
        actualCard.visible = false;

        var timeline:TimelineLite = new TimelineLite ();
        timeline.to (mirrow, 0.4, { y:yCof, alpha:1, ease:Expo.easeOut, onComplete:continueBackCardToHand } );
        timeline.to (mirrow, 0.4, { x:cardPosition.x, y:cardPosition.y, scaleX:0.72, scaleY:0.72, ease:Expo.easeOut, onComplete:onBackComplete } );
    }

    private function backCardToEnemyHand (token:Token) :void {

        backCardToken = token;

        var shirt:Sprite = token.getShirt ();
        shirt.alpha = 0.5;

        var tokenPosition:Point = new Point (token.x, token.y);
        tokenPosition = token.parent.localToGlobal (tokenPosition);
        tokenPosition.x -= ((Card.MIRROW_WIDTH - Token.WIDTH) / 2);

        shirt.x = tokenPosition.x;
        shirt.y = tokenPosition.y;

        TrajectoryContainer.getInstance().addToPlayCardLevel (shirt);

        var yCof:int = tokenPosition.y - (Card.MIRROW_HEIGHT - Token.HEIGHT) / 2;

        actualCard = enemyCollodion.addCard (token.getCardData (), false);

        var cardPosition:Point = new Point (actualCard.x, actualCard.y);

        cardPosition = actualCard.parent.localToGlobal (cardPosition);
        actualCard.visible = false;

        var timeline:TimelineLite = new TimelineLite ();
        timeline.to (shirt, 0.4, { y:yCof, alpha:1, ease:Expo.easeOut, onComplete:continueBackCardToHand} );
        timeline.to (shirt, 0.4, { x:cardPosition.x, y:cardPosition.y, scaleX:0.675, scaleY:0.675, ease:Expo.easeOut, onComplete:onBackComplete});
    }



    private function continueBackCardToHand () :void {
        var enemyRow:UnitRow = field.getEnemyRow()
        var playerRow:UnitRow = field.getPlayerRow()

        if (backCardToken.isEnemy()) {
            enemyRow.removeChild (backCardToken);
            field.sortUnitRow (enemyRow);
            field.centerizeRow (enemyRow);
        } else {
            playerRow.removeChild (backCardToken);
            field.sortUnitRow (playerRow);
            field.centerizeRow (playerRow);
        }
    }
    private function onBackComplete () :void {
        //Logger.log('onBackComplete');
        backCardToken.getMirrow().scaleX = 1;
        backCardToken.getMirrow().scaleY = 1;
        backCardToken.getShirt().scaleX = 1;
        backCardToken.getShirt().scaleY = 1;

        actualCard.visible = true;
        TrajectoryContainer.getInstance().endPlayCard();

        if (field.isPlayerStep()) {
            playerCollodion.glowAvailableCards();
        }
        //selectionMode = false;
        if (activator) {
            //Logger.log('continueActivate')
            activator.continueActivate();
        }

        //field.dispatchEvent (new FieldEvent (FieldEvent.END_BACK_CARD));
    }


    public function newSpellFromToken (iniciator:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
         //Logger.log('newCardFromToken');

        this.iniciator = iniciator;
        this.activator = activator;

        var level:int = eptitude.getAttachment();
        var enemyFlag:Boolean = iniciator.isEnemy();

        var newCardId:int = eptitude.getSpellId();
        var cardData:CardData = CardsCache.getInstance().getCardById (newCardId);

        if (level == EptitudeAttachment.ASSOCIATE) {
            if (enemyFlag) {
                newCardToEnemyHand(iniciator as Token, cardData)
            } else {
                newCardToPlayerHand(iniciator as Token, cardData)
            }
        } else {
            if (enemyFlag) {
                newCardToPlayerHand(iniciator as Token, cardData)
            } else {
                newCardToEnemyHand(iniciator as Token, cardData)
            }
        }
    }

    private function newCardToPlayerHand (token:Token, cardData:CardData) :void {

        //backCardToken = token;

        actualCard = playerCollodion.addCard (cardData, false);

        var mirrow:Sprite = actualCard.getMirrow ();
        mirrow.alpha = 0.5;
        var tokenPosition:Point = new Point (token.x, token.y);
        tokenPosition = token.parent.localToGlobal (tokenPosition);
        tokenPosition.x -= ((Card.MIRROW_WIDTH - Token.WIDTH) / 2);
        mirrow.x = tokenPosition.x;
        mirrow.y = tokenPosition.y;

        TrajectoryContainer.getInstance().addToPlayCardLevel (mirrow);

        var yCof:int = tokenPosition.y - (Card.MIRROW_HEIGHT - Token.HEIGHT) / 2;

        var cardPosition:Point = new Point (actualCard.x, actualCard.y);

        cardPosition = actualCard.parent.localToGlobal (cardPosition);
        actualCard.visible = false;

        var timeline:TimelineLite = new TimelineLite ();
        timeline.to (mirrow, 0.4, { y:yCof, alpha:1, ease:Expo.easeOut} );
        timeline.to (mirrow, 0.4, { x:cardPosition.x, y:cardPosition.y, scaleX:0.72, scaleY:0.72, ease:Expo.easeOut, onComplete:onNewCardComplete});
    }

    private function onNewCardComplete () :void {
        actualCard.getMirrow().scaleX = 1;
        actualCard.getMirrow().scaleY = 1;
        actualCard.getShirt().scaleX = 1;
        actualCard.getShirt().scaleY = 1;

        actualCard.visible = true;
        TrajectoryContainer.getInstance().endPlayCard();

        if (field.isPlayerStep()) {
            playerCollodion.glowAvailableCards();
        }
        //selectionMode = false;
        if (activator) {
            activator.continueActivate();
        }

    }

    private function newCardToEnemyHand (token:Token, cardData:CardData) :void {

        actualCard = enemyCollodion.addCard (cardData, false);

        var shirt:Sprite = token.getShirt ();
        shirt.alpha = 0.5;

        var tokenPosition:Point = new Point (token.x, token.y);
        tokenPosition = token.parent.localToGlobal (tokenPosition);
        tokenPosition.x -= ((Card.MIRROW_WIDTH - Token.WIDTH) / 2);

        shirt.x = tokenPosition.x;
        shirt.y = tokenPosition.y;

        TrajectoryContainer.getInstance().addToPlayCardLevel (shirt);

        var yCof:int = tokenPosition.y - (Card.MIRROW_HEIGHT - Token.HEIGHT) / 2;

        var cardPosition:Point = new Point (actualCard.x, actualCard.y);

        cardPosition = actualCard.parent.localToGlobal (cardPosition);
        actualCard.visible = false;

        var timeline:TimelineLite = new TimelineLite ();
        timeline.to (shirt, 0.4, { y:yCof, alpha:1, ease:Expo.easeOut} );
        timeline.to (shirt, 0.4, { x:cardPosition.x, y:cardPosition.y, scaleX:0.675, scaleY:0.675, ease:Expo.easeOut, onComplete:onNewCardComplete});

    }

    public function increaseHealthDependsOnCards (iniciator:Token, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
        var level:int = eptitude.getAttachment();
        var numCards:int
        if (iniciator.isEnemy()) {
            if (level == EptitudeAttachment.ASSOCIATE) {
                numCards = enemyCollodion.getNumCards ();
            } else {
                numCards = playerCollodion.getNumCards ();
            }
        } else {
            if (level == EptitudeAttachment.ASSOCIATE) {
                numCards = playerCollodion.getNumCards ();
            } else {
                numCards = enemyCollodion.getNumCards ();
            }

            var newHealth:int = iniciator.getHealth() + numCards;
            if (newHealth > iniciator.getMaxHealth()) {
                iniciator.setMaxHealth(newHealth);
            }
            iniciator.setHealth(newHealth);
            activator.continueActivate();

        }
    }



}
}
