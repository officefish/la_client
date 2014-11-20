/**
 * Created by root on 11/9/14.
 */
package com.la.mvc.controller.match {
import com.la.event.MatchServiceEvent;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.scene.IScene;
import com.la.state.GameState;
import com.ps.cards.CardData;

import org.robotlegs.mvcs.Command;

public class ChangePreflopCommand extends Command {

    [Inject]
    public var event:MatchServiceEvent;

    [Inject (name='scene')]
    public var scene:IScene;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    override public function execute():void {
        rootModel.currentState = GameState.PREFLOP_SELECT;
        
        var cardDatas:Vector.<CardData> = getCardDataVector(event.getData().preflop);
        scene.replacePreflopCards(cardDatas);

    }

    private function getCardDataVector (data:Array) :Vector.<CardData> {
        var vector:Vector.<CardData> = new Vector.<CardData>();
        for (var i:int = 0; i < data.length; i ++) {

            var attack:int = data[i].attack;
            var health:int = data[i].health;
            var price:int = data[i].price;
            var title:String = data[i].title;
            var description:String = data[i].description;

            var cardData:CardData = new CardData(attack, health, price);

            cardData.id = data[i].id;

            cardData.setTitle(title);
            cardData.setDescription(description);
            vector.push(cardData)
        }
        return vector;
    }
}
}