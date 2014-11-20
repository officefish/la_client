/**
 * Created by root on 11/1/14.
 */
package com.la.mvc.service {
import com.adobe.serialization.json.JSON;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.DataLoader;
import com.greensock.loading.LoaderMax;
import com.la.event.DeckServiceEvent;
import com.la.event.DeckServiceEvent;

import flash.net.URLRequest;
import flash.net.URLRequestMethod;

import flash.net.URLVariables;

import org.robotlegs.mvcs.Actor;

public class DeckService extends Actor {

    private var queue:LoaderMax;
    public function DeckService () :void {
    }

   public function responseDeckList (playerId:int) :void {
       var url:String = 'http://127.0.0.1:8000/api/get_deck_list/?user_id=' + playerId;
       var loader:DataLoader = new DataLoader(url, {'noCache':true, onProgress:progressHandler, onComplete:completeResponseDeckList, onError:errorHandler});
       loader.load();
   }

   public function select (playerId:int, deckId:int, heroId:int) :void {
       var url:String = 'http://127.0.0.1:8000/api/select_deck/?user_id=' + playerId + '&deck_id=' + deckId +'&hero_id='+heroId;
       var loader:DataLoader = new DataLoader(url, {'noCache':true, onProgress:progressHandler, onComplete:completeSelect, onError:errorHandler});
       loader.load();
   }

    function progressHandler(event:LoaderEvent):void {
        trace("progress: " + event.target.progress);
    }

    function completeResponseDeckList(event:LoaderEvent):void {
        trace(event.target.content);
        parseDeckList (event.target.content)
    }

    function completeSelect (event:LoaderEvent) :void {
        dispatch (new DeckServiceEvent(DeckServiceEvent.DECK_SELECT, com.adobe.serialization.json.JSON.decode(event.target.content)));
    }

    private function parseDeckList (responseStr:String) :void {
        var response:Object = com.adobe.serialization.json.JSON.decode(responseStr);

        var serviceData:Object = {}
        if (response.status == 'success') {
            serviceData.heroes = response.heroes as Array;
            serviceData.activeDeck = response.actual_deck;
            serviceData.activeHero = response.actual_hero;
            dispatch(new DeckServiceEvent(DeckServiceEvent.DECK_LIST_INIT, serviceData))
        }
    }

    function errorHandler(event:LoaderEvent):void {
        trace("error occured with " + event.target + ": " + event.text);
    }
}
}
