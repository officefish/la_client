/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.bootstrap {
import com.la.event.CardEvent;
import com.la.event.DeckEvent;
import com.la.event.DeckServiceEvent;
import com.la.event.FieldEvent;
import com.la.event.LobbyEvent;
import com.la.event.LobbyServiceEvent;
import com.la.event.MatchEvent;
import com.la.event.MatchServiceEvent;
import com.la.event.SceneEvent;
import com.la.mvc.controller.deck.CardsAddedCommand;
import com.la.mvc.controller.deck.DeckListInitCommand;
import com.la.mvc.controller.deck.DeckSelectCommand;
import com.la.mvc.controller.deck.ResponseSelectDeckCommand;
import com.la.mvc.controller.deck.ResponseDeckListCommand;
import com.la.mvc.controller.deck.StartupDeckListCommand;
import com.la.mvc.controller.init.InitModelCommand;
import com.la.mvc.controller.init.InitServiceCommand;
import com.la.mvc.controller.init.InitViewCommand;
import com.la.mvc.controller.lobby.CloseLobbyCommand;
import com.la.mvc.controller.match.ChangeOpponentPreflopCommand;
import com.la.mvc.controller.match.ChangePreflopCommand;
import com.la.mvc.controller.match.EndPreflopCommand;
import com.la.mvc.controller.match.OpponentPreflopClickCommand;
import com.la.mvc.controller.match.PlayerCardAddedCommand;
import com.la.mvc.controller.match.PreflopClickCommand;
import com.la.mvc.controller.match.deck.ResponseCardPlayCommand;
import com.la.mvc.controller.match.step.ReadyCommand;
import com.la.mvc.controller.match.LightenCompleteCommand;
import com.la.mvc.controller.match.ResponsePreflopInitCommand;
import com.la.mvc.controller.match.StartupMatchServiceCommand;
import com.la.mvc.controller.match.deck.FindPositionCommand;
import com.la.mvc.controller.match.deck.StopFindPositionCommand;
import com.la.mvc.controller.match.step.OpponentStepCommand;
import com.la.mvc.controller.state.ChangeStateCommand;
import com.la.mvc.controller.intro.SelectArenaCommand;
import com.la.mvc.controller.intro.SelectCollectionCommand;
import com.la.mvc.controller.intro.SelectGameCommand;
import com.la.mvc.controller.intro.SelectMarketCommand;
import com.la.mvc.controller.intro.SelectQuestCommand;
import com.la.mvc.controller.intro.SelectStudyCommand;
import com.la.event.GameContextEvent;
import com.la.event.IntroEvent;
import com.la.mvc.controller.lobby.AcceptCommand;
import com.la.mvc.controller.lobby.CancelCommand;
import com.la.mvc.controller.lobby.InitPlayersCommand;
import com.la.mvc.controller.lobby.InviteCommand;
import com.la.mvc.controller.lobby.JoinToLobbyCommand;
import com.la.mvc.controller.lobby.RejectCommand;
import com.la.mvc.controller.lobby.StartupLobbyCommand;
import com.la.mvc.controller.lobby.StartupLobbyServiceCommand;
import com.la.mvc.controller.match.InitMatchModelCommand;
import com.la.mvc.controller.match.MatchConnectionInitCommand;
import com.la.mvc.controller.match.PreflopCompleteCommand;
import com.la.mvc.controller.match.WelcomeCompleteCommand;
import com.la.mvc.controller.match.ResponseChangePreflopCommand;
import com.la.mvc.controller.match.StartupMatchCommand;
import com.la.mvc.controller.match.WelcomeMatchCommand;

import org.robotlegs.base.ContextEvent;
import org.robotlegs.core.ICommandMap;

public class BootstrapController {
    public function BootstrapController(commandMap:ICommandMap) {

        // Launch application;

        // init model
        commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitModelCommand, ContextEvent);
        // init services
        commandMap.mapEvent(GameContextEvent.MODEL_INIT_COMPLETE, InitServiceCommand, GameContextEvent);
        // init view
        commandMap.mapEvent(GameContextEvent.SERVICE_INIT_COMPLETE, InitViewCommand, GameContextEvent);

        // intro
        commandMap.mapEvent(IntroEvent.SELECT_GAME,SelectGameCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.SELECT_COLLECTION, SelectCollectionCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.SELECT_STUDY, SelectStudyCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.SELECT_MARKET, SelectMarketCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.SELECT_QUEST, SelectQuestCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.SELECT_ARENA, SelectArenaCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.COMPLETE, ChangeStateCommand);

        // deckList
        commandMap.mapEvent(DeckEvent.STARTUP_DECK_LIST, StartupDeckListCommand, DeckEvent);
        commandMap.mapEvent(DeckEvent.STARTUP_DECK_SERVICE, ResponseDeckListCommand, DeckEvent);
        commandMap.mapEvent(DeckServiceEvent.DECK_LIST_INIT, DeckListInitCommand, DeckServiceEvent);
        commandMap.mapEvent(DeckServiceEvent.RESPONSE_SELECT_DECK, ResponseSelectDeckCommand, DeckServiceEvent);
        commandMap.mapEvent(DeckServiceEvent.DECK_SELECT, DeckSelectCommand, DeckServiceEvent);
        commandMap.mapEvent(DeckEvent.CLOSE, ChangeStateCommand);

        // lobby
        commandMap.mapEvent(LobbyEvent.STARTUP_LOBBY, StartupLobbyCommand, LobbyEvent);
        commandMap.mapEvent(LobbyEvent.STARTUP_LOBBY_SERVICE, StartupLobbyServiceCommand, LobbyEvent);
        commandMap.mapEvent(LobbyServiceEvent.PLAYERS_INIT, InitPlayersCommand, LobbyServiceEvent);
        commandMap.mapEvent(LobbyServiceEvent.USER_JOIN, JoinToLobbyCommand, LobbyServiceEvent);

        commandMap.mapEvent(LobbyEvent.INVITE, InviteCommand, LobbyEvent);
        commandMap.mapEvent(LobbyEvent.ACCEPT, AcceptCommand, LobbyEvent);
        commandMap.mapEvent(LobbyEvent.REJECT, RejectCommand, LobbyEvent);
        commandMap.mapEvent(LobbyEvent.CANCEL, CancelCommand, LobbyEvent);

        commandMap.mapEvent(LobbyServiceEvent.ACCEPT_INVITATION, CloseLobbyCommand, LobbyServiceEvent);
        commandMap.mapEvent(LobbyEvent.CLOSE, ChangeStateCommand);

        // match
        commandMap.mapEvent(MatchEvent.STARTUP_MATCH, StartupMatchCommand, MatchEvent);
        commandMap.mapEvent(MatchEvent.STARTUP_COMPLETE, StartupMatchServiceCommand, MatchEvent);

        // preflop
        commandMap.mapEvent(MatchServiceEvent.CONNECTION_INIT, MatchConnectionInitCommand, MatchServiceEvent);
        commandMap.mapEvent(MatchServiceEvent.PREFLOP_INIT, WelcomeMatchCommand, MatchServiceEvent);
        commandMap.mapEvent(MatchEvent.INIT_MATCH_MODEL, InitMatchModelCommand, MatchEvent);
        commandMap.mapEvent(MatchEvent.COLLECTION_INIT, WelcomeMatchCommand, MatchEvent);
        commandMap.mapEvent(SceneEvent.WELCOME_COMPLETE, WelcomeCompleteCommand, SceneEvent);
        commandMap.mapEvent(SceneEvent.CHANGE_PREFLOP, ResponseChangePreflopCommand, SceneEvent);
        commandMap.mapEvent(MatchServiceEvent.CHANGE_PREFLOP, ChangePreflopCommand, MatchServiceEvent);
        commandMap.mapEvent(SceneEvent.PREFLOP_INIT, ResponsePreflopInitCommand, SceneEvent);
        commandMap.mapEvent(DeckEvent.CARDS_ADDED, CardsAddedCommand, DeckEvent);
        commandMap.mapEvent(SceneEvent.PREFLOP_COMPLETE, PreflopCompleteCommand, SceneEvent);

        commandMap.mapEvent(CardEvent.PREFLOP_CLICK, PreflopClickCommand, CardEvent);
        commandMap.mapEvent(MatchServiceEvent.OPPONENT_PREFLOP_CLICK, OpponentPreflopClickCommand, MatchServiceEvent);
        commandMap.mapEvent(MatchServiceEvent.CHANGE_OPPONENT_PREFLOP, ChangeOpponentPreflopCommand, MatchServiceEvent);

        commandMap.mapEvent(MatchServiceEvent.END_PREFLOP, EndPreflopCommand, MatchServiceEvent);
        commandMap.mapEvent(SceneEvent.LIGHTEN_COMPLETE, LightenCompleteCommand, SceneEvent);

        // step
        commandMap.mapEvent(MatchServiceEvent.READY, ReadyCommand, MatchServiceEvent);
        commandMap.mapEvent(MatchServiceEvent.OPPONENT_STEP, OpponentStepCommand, MatchServiceEvent);
        commandMap.mapEvent(DeckEvent.PLAYER_CARD_ADDED, PlayerCardAddedCommand, DeckEvent);

        // playCard
        commandMap.mapEvent(DeckEvent.FIND_POSITION, FindPositionCommand, DeckEvent);
        commandMap.mapEvent(DeckEvent.STOP_FIND_POSITION, StopFindPositionCommand, DeckEvent);
        commandMap.mapEvent(DeckEvent.PLAYER_CARD_PLAY, ResponseCardPlayCommand, DeckEvent);



    }
}
}
