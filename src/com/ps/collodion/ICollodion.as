/**
 * Created by root on 9/4/14.
 */
package com.ps.collodion {
import com.ps.cards.*;
import com.ps.cards.sale.CardSale;

public interface ICollodion {
    function addSale(sale:CardSale):void;
    function checkSaleCard(card:Card):void;
    function getNumCards():int;


}
}
