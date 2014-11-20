/**
 * Created by root on 9/10/14.
 */
package com.ps.field.controller {
import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.log.Logger;
import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.eptitude.IEptitudeActivator;
import com.ps.field.Field;
import com.ps.field.IAttackAvailable;
import com.ps.field.UnitRow;
import com.ps.tokens.EptitudeActivator;
import com.ps.tokens.Token;
import com.ps.trajectory.TrajectoryContainer;

import flash.display.Sprite;

import flash.geom.Point;

public class EnticeController {

    private var iniciator:IAttackAvailable;
    private var actiator:IEptitudeActivator;
    private var actualEptitude:CardEptitude;

    private var iniciatorRow:UnitRow;
    private var opponentRow:UnitRow;

    private var field:Field;
    private var token:Token;

    private var subcontroller:CardSubController;
    private var enticeStarter:IAttackAvailable;


    /*

    В целом достаточно простой класс, но если переманивает существа динамически прибовляющие аттаку и здоровье
    (INCREASE_ATTACK_BOB, DECREASE_ATTACK_BOB) начинается изъебство, а именно:

    1. кикает динамическую аттаку или здоровье в старом ряду.
    2. активирует динамическую аттаку или здоровье в новом ряду
    3. Важно! снижает динамическую аттаку или здоровье существу иницировавшему переманивание поскольку,
    его инициализация еще не закончена и метод который активирует динамическую аттаку и здоровье будет вызван
    к нему второй раз позже при его естественной инициализации, поскольку к тому моменту как мы закончим активировать
    именно эту способность существо с динамической аттакой или здоровьем уже будет полноценным юнитом и вызовет
    увеличение аттаки, здоровья к ASSOCIATE_LAST_PLACED существу
    Другими словами конкретно на существе активировавшем переманивание динамические аттаки, здоровье сработают и
    на уровне ALL_ASSOCIATE_UNITS и на уровне ASSOCIATE_LAST_PLACED
    4. enticeStarter это существо которое активировало переманивание доступно через field который сохраняет activateUnit
    перед тем как отфильтровать его и запустить контроллер способностей (EptitudeController)

     */

    public function EnticeController() {

    }

    public function setField (field:Field) :void {
        this.field = field;
    }

    public function enticeUnit (iniciator:IAttackAvailable, enticeStarter:IAttackAvailable, eptitude:CardEptitude, activator:IEptitudeActivator) :void {
        this.iniciator = iniciator;
        this.actualEptitude = eptitude;
        this.actiator = activator;
        this.enticeStarter = enticeStarter;


        if (iniciator.isEnemy()) {
            iniciatorRow = field.getEnemyRow();
            opponentRow = field.getPlayerRow();
        } else {
            iniciatorRow = field.getPlayerRow();
            opponentRow = field.getEnemyRow();
        }

        token = iniciator as Token;

        var tokenPosition:Point = new Point(token.x, token.y);
        tokenPosition = token.parent.localToGlobal(tokenPosition);

        iniciatorRow.removeChild(token);

        token.x = tokenPosition.x;
        token.y = tokenPosition.y;

        TrajectoryContainer.getInstance().addToTrajectoryLevel(token);
        tokenPreview.visible = false;
        opponentRow.addChild(tokenPreview);
        tokenPreview.x = (opponentRow.numChildren - 1) * ( UnitRow.PADDING + Token.WIDTH);
        var tokenPreviewPosition:Point = new Point (tokenPreview.x, tokenPreview.y);
        tokenPreviewPosition = tokenPreview.parent.localToGlobal(tokenPreviewPosition);
        opponentRow.removeChild(tokenPreview);
        tokenPreview.visible = true;

        token.setAttackBob(0)
        token.setAttack(token.getAttack())
        token.setHealthBob(0)
        token.setHealth(token.getHealth())

        TweenLite.to (token, 0.5, {x:tokenPreviewPosition.x, y:tokenPreviewPosition.y, ease:Expo.easeOut, onComplete:onEnticeComplete})

    }

    private function onEnticeComplete () :void {
        opponentRow.addChild(token);
        token.y = 0;
        token.x = (opponentRow.numChildren - 1) * ( UnitRow.PADDING + Token.WIDTH);
        field.sortUnitRow(iniciatorRow)
        field.centerizeRow(iniciatorRow)
        field.centerizeRow(opponentRow, reactivateEptitudes);
    }

    private function reactivateEptitudes () :void {
        if (token.containsAnyLevelEptitude(CardEptitude.INCREASE_ATTACK_BOB)) {
            var eptitude:CardEptitude = token.getEptitudeByType(CardEptitude.DECREASE_ATTACK_BOB)
            token.forceActivate (eptitude, iniciatorAttackComplete);
        } else {
            checkHealthBob()
        }
    }
    private function iniciatorAttackComplete () {
        token.setEnemy(!token.isEnemy())
        var eptitude:CardEptitude = token.getEptitudeByType(CardEptitude.INCREASE_ATTACK_BOB)
        if (enticeStarter is Token) {
            (enticeStarter as Token).setAttackBob((enticeStarter as Token).getAttackBob() - eptitude.getPower())
        }
        token.forceActivate (eptitude, enticeStarterAttackComplete);

    }
    private function enticeStarterAttackComplete () :void {
        token.setEnemy(!token.isEnemy())
        checkHealthBob ();
    }
    private function checkHealthBob () :void {
        if (token.containsAnyLevelEptitude(CardEptitude.INCREASE_HEALTH_BOB)) {
            var eptitude:CardEptitude = token.getEptitudeByType(CardEptitude.DECREASE_HEALTH_BOB)
            token.forceActivate (eptitude, iniciatorHealthComplete);
        } else {
            checkIncreaseSpell()
        }
    }
    private function iniciatorHealthComplete () :void {
        token.setEnemy(!token.isEnemy())
        var eptitude:CardEptitude = token.getEptitudeByType(CardEptitude.INCREASE_HEALTH_BOB)
        if (enticeStarter is Token) {
            (enticeStarter as Token).setHealthBob((enticeStarter as Token).getHealthBob() - eptitude.getPower())
        }
        token.forceActivate (eptitude, enticeStarterHealthComplete);
    }

    private function enticeStarterHealthComplete () :void {
        token.setEnemy(!token.isEnemy())
        checkIncreaseSpell()
    }

    private function checkIncreaseSpell () :void {
        if (token.containsAnyLevelEptitude(CardEptitude.INCREASE_SPELL)) {
            var eptitude:CardEptitude = token.getEptitudeByType(CardEptitude.DECREASE_SPELL)
            token.forceActivate (eptitude, iniciatorSpellComplete);
        } else {
            placeTokenIniciator ();
        }
    }

    private function iniciatorSpellComplete () :void {
        token.setEnemy(!token.isEnemy())
        var eptitude:CardEptitude = token.getEptitudeByType(CardEptitude.INCREASE_SPELL)
        token.forceActivate (eptitude, enticeStarterSpellComplete);
    }

    private function enticeStarterSpellComplete () :void {
        token.setEnemy(!token.isEnemy())
        placeTokenIniciator();
    }

    private function placeTokenIniciator () :void {
        token.setEnemy(!token.isEnemy())
        field.setLastPlaced(token);
        subcontroller = new CardSubController();
        subcontroller.setField(field);
        subcontroller.activatePlaceToken(token, endEntice)
    }

    private function endEntice () :void {
        subcontroller.destroy();
        subcontroller = null;
        if (actiator) {
            actiator.continueActivate()
        } else {
            iniciator.completeConfigure();
        }
    }

    private function get tokenPreview () :Sprite {
        return Token.getTokenPreviewInstance() as Sprite
    }
}
}
