/**
 * Created by root on 10/23/14.
 */
package com.la.state {
import enumeration.UintEnumeration;

public class GameState extends UintEnumeration {

    public static const INTRO:GameState                 =  new GameState(0);
    public static const MATCH:GameState                 =  new GameState(1);
    public static const ARENA:GameState                 =  new GameState(2);
    public static const COLLECTION:GameState            =  new GameState(3);
    public static const MARKET:GameState                =  new GameState(4);
    public static const QUEST:GameState                 =  new GameState(5);
    public static const STUDY:GameState                 =  new GameState(6);
    public static const LOBBY:GameState                 =  new GameState(7);
    public static const DECK_LIST:GameState             =  new GameState(8);
    public static const PREFLOP:GameState               =  new GameState(9);
    public static const PREFLOP_SELECT:GameState        =  new GameState(10);
    public static const PLAYER_STEP_PREVIEW:GameState   =  new GameState(11);
    public static const PLAYER_STEP:GameState           =  new GameState(12);
    public static const OPPONENT_STEP:GameState         =  new GameState(13);


    public function GameState(value:uint) {
        super (value);
    }
}
}
