/**
 * Created by root on 9/6/14.
 */
package com.ps.collection {
import com.ps.cards.CardData;
import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeLevel;
import com.ps.cards.eptitude.EptitudePeriod;
import com.ps.cards.sale.CardSale;

public class SpellCollection {
    private static var instance:SpellCollection;

    public function SpellCollection()
    {

    }

    public static function getInstance () :SpellCollection {
        if (instance == null) {
            instance = new SpellCollection();
        }
        return instance;
    }

    public function simulateCollection () :void {
        var eptitude:CardEptitude;
        var eptitude2:CardEptitude;
        var eptitude3:CardEptitude;
        var eptitude4:CardEptitude;

        var cardData:CardData;
        var cardSale:CardSale

        eptitude = new CardEptitude (CardEptitude.FREEZE);
        eptitude.setLevel(EptitudeLevel.SELECTED_OPPONENT_SPELL);
        eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
        eptitude.setPower(3);
        cardData = new CardData (0, 0, 2, [eptitude]);
        cardData.setTitle ('Ледяная стрела');
        cardData.setDescription ('Наносит {0} ед. урона выбранному существу и замораживает его');
        cardData.setType(CardData.SPELL)
        cardData.setSpellPower (3);
        CardsCache.getInstance().addCard (cardData, 1000, 0, 0);

        eptitude = new CardEptitude (CardEptitude.UNIT_CONVERTION);
        eptitude.setLevel(EptitudeLevel.SELECTED_OPPONENT_SPELL);
        eptitude.setPeriod(EptitudePeriod.SELF_PLACED)
        eptitude.setUnitId(1002)
        cardData = new CardData (0, 0, 4, [eptitude]);
        cardData.setTitle ('Превращение');
        cardData.setDescription ('Превращает выбранное существо в овцу 1/1');
        cardData.setType(CardData.SPELL)
        CardsCache.getInstance().addCard (cardData, 1001, 0, 0);

        cardData = new CardData (1, 1, 0);
        cardData.setTitle ('Овца');
        cardData.setDescription ('');
        cardData.auxiliary = true;
        CardsCache.getInstance().addCard (cardData, 1002, 0, 0);

    }
}
}
