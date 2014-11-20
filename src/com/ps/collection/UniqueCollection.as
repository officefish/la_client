/**
 * Created by root on 9/13/14.
 */
package com.ps.collection {
import com.ps.cards.CardData;
import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeAttachment;
import com.ps.cards.eptitude.EptitudeLevel;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.sale.CardSale;
import com.ps.collection.UniqueCollection;
import com.ps.collection.UniqueCollection;

public class UniqueCollection {
    private static var instance:UniqueCollection;

    public function UniqueCollection()
    {

    }

    public static function getInstance () :UniqueCollection {
        if (instance == null) {
            instance = new UniqueCollection();
        }
        return instance;
    }

    public function simulateCollection () :void {

        var eptitude:CardEptitude;
        var eptitude2:CardEptitude;
        var eptitude3:CardEptitude;
        var eptitude4:CardEptitude;
        var eptitude5:CardEptitude;
        var eptitude6:CardEptitude;

        var cardData:CardData;
        var cardSale:CardSale

        eptitude = new CardEptitude(CardEptitude.BACK_CARD_TO_HAND);
        eptitude.setAttachment(EptitudeAttachment.OPPONENT);
        eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
        eptitude.setLevel(EptitudeLevel.SELECTED_OPPONENT_UNIT)
        cardData = new CardData (2, 3, 3, [eptitude]);
        cardData.setTitle ('Ветеран разведчик');
        cardData.setDescription ('Убирает со стола в вашу руку одного из выбранных существ противника');
        cardData.setType(CardData.UNIT)
        CardsCache.getInstance().addCard (cardData, 2000, 0, 0);

        eptitude = new CardEptitude(CardEptitude.NEW_SPELL);
        eptitude.setAttachment(EptitudeAttachment.ASSOCIATE);
        eptitude.setPeriod(EptitudePeriod.ASSOCIATE_SPELL)
        eptitude.setLevel(EptitudeLevel.SELF)
        eptitude.setSpellId(1000)
        eptitude2 = new CardEptitude (CardEptitude.SHADOW);
        eptitude2.setLevel(EptitudeLevel.SELF);
        eptitude2.setPeriod(EptitudePeriod.SELF_PLACED)
        cardData = new CardData (1, 1, 3, [eptitude, eptitude2]);
        cardData.setTitle ('Разрушитель ледников');
        cardData.setDescription ('Каждый раз при разыгрывании заклинания противником кладет в руку ледяную стрелу');
        cardData.setType(CardData.UNIT)
        CardsCache.getInstance().addCard (cardData, 2000, 0, 0);

    }



    }
}
