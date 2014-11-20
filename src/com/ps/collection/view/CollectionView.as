/**
 * Created by root on 9/16/14.
 */
package com.ps.collection.view {
import com.la.mvc.view.ICollection;
import com.ps.collection.*;
import com.log.Logger;
import com.ps.cards.CardData;
import com.ps.collection.view.CollectionPage;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.Dictionary;

public class CollectionView extends Sprite implements ICollection{

    private var pages:Array;
    private var nextBtn:Sprite;
    private var previousBtn:Sprite;

    private var pageIndex:int = 0;
    private var actualPage:CollectionPage;

    private var stack:CardsStack;

    private var slotDict:Dictionary;

    private var readyBtn:ReadyBtn;
    private var cancelBtn:CancelBtn;

    public static const READY:String = 'ready';

    private var collection:Array

    public function CollectionView() {

        addEventListener(CollectionEvent.ADD_SLOT, onAddSlot, true)
        addEventListener(CollectionEvent.REMOVE_SLOT, onRemoveSlot, true)

        graphics.beginFill(0x777777, 1);
        graphics.drawRect(0,0,800,600);
        graphics.endFill();

        stack = new CardsStack();
        stack.x = 610;
        addChild(stack);

        nextBtn = new Sprite();
        nextBtn.graphics.beginFill(0xFFFFFF,1);
        nextBtn.graphics.drawRect(0,0,35,35);
        nextBtn.graphics.endFill();
        nextBtn.buttonMode = true;
        nextBtn.addEventListener(MouseEvent.CLICK, onNextClick);
        nextBtn.x = 575;
        nextBtn.y = 290;

        previousBtn = new Sprite();
        previousBtn.graphics.beginFill(0xFFFFFF,1);
        previousBtn.graphics.drawRect(0,0,35,35);
        previousBtn.graphics.endFill();
        previousBtn.buttonMode = true;
        previousBtn.x = 10;
        previousBtn.y = 290;
        previousBtn.addEventListener(MouseEvent.CLICK, onPrevClick);

        readyBtn = new ReadyBtn();
        readyBtn.x = 624;
        readyBtn.y = 555;
        readyBtn.addEventListener(ReadyBtn.READY_CLICK, onReadyClick);
        addChild(readyBtn);

        cancelBtn = new CancelBtn();
        cancelBtn.x = 660;
        cancelBtn.y = 11;
        cancelBtn.addEventListener(CancelBtn.CANCEL, onCancelClick);
        addChild(cancelBtn)

        pages = [];
        var page:CollectionPage = new CollectionPage();
        var card:CardData;

        pages.push(page);

        slotDict = new Dictionary()

        var cards:Array = CardsCache.getInstance().getCards();
        //Logger.log(cards.length.toString());
        for (var i:int = 0; i < cards.length; i ++) {
            if (page.cardsCount == 6) {
                page = new CollectionPage();
                pages.push(page);
            }
            card = cards[i];
            slotDict[card] = page.addCard(card);
        }

        actualPage = pages[0]
        addChild(actualPage)
        addChild(nextBtn);
    }

    private function onAddSlot (event:CollectionEvent) :void {
        stack.addSlot(event.getCardData())
        if (stack.getCount() == 35) {
            readyBtn.blur();
        }
    }

    private function onRemoveSlot (event:CollectionEvent) :void {
        var collectionSlot:CollectionSlot = slotDict[event.getCardData()];
        var count:int = collectionSlot.getLimit();
        count ++;
        collectionSlot.setLimit(count);
        stack.removeSlot (event.getCardData());
        if (stack.getCount() < 35) {
            readyBtn.stopBlur();
        }
    }

    private function onNextClick (event:MouseEvent) :void {
        pageIndex ++;
        if (pageIndex == pages.length - 1) {
            removeChild(nextBtn);
        }
        if (pageIndex > 0 && !this.contains(previousBtn)) {
            addChild(previousBtn);
        }
        removeChild(actualPage);
        actualPage = pages[pageIndex];
        addChildAt(actualPage,0);
    }

    private function onPrevClick (event:MouseEvent) :void {
        pageIndex --;
        if (pageIndex == 0) {
            removeChild(previousBtn);
        }

        if (!this.contains(nextBtn) && pageIndex < pages.length) {
            addChild(nextBtn);
        }
        removeChild(actualPage);
        actualPage = pages[pageIndex];
        addChildAt(actualPage,0);

    }

    private function onReadyClick (event:Event) :void {
        collection = stack.getCollection();
        dispatchEvent(new Event(READY))
    }

    public function getCollection () :Array {
        return collection;
    }

    public function placeCollection (collodion:Array) :void {
        var cardData:CardData;
        for (var i:int = 0; i < collodion.length; i ++) {
            cardData = collodion[i];
            stack.addSlot(cardData);
            var collectionSlot:CollectionSlot = slotDict[cardData];
            var count:int = collectionSlot.getLimit();
            count --;
            collectionSlot.setLimit(count);
        }
        if (stack.getCount() == 35) {
            readyBtn.blur();
        }

    }

    private function onCancelClick (event:Event) :void {
        var collection:Array = stack.getCollection();
        var cardData:CardData;
        var collectionSlot:CollectionSlot;
        Logger.log(collection.length.toString())
        while (collection.length) {
            cardData = collection.shift()
            collectionSlot = slotDict[cardData];
            var count:int = collectionSlot.getLimit();
            count ++;
            collectionSlot.setLimit(count);
        }
        stack.clear ();

    }
}
}
