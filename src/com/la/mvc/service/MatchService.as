/**
 * Created by root on 11/7/14.
 */
package com.la.mvc.service {
/**
 * Created by root on 10/3/14.
 */

import com.la.event.MatchServiceEvent;
import com.la.socket.IWebSocketWrapper;
import com.la.socket.SocketFactory;
import com.worlize.websocket.WebSocketErrorEvent;
    import com.worlize.websocket.WebSocketEvent;
    import com.worlize.websocket.WebSocketMessage;

    import org.robotlegs.mvcs.Actor;


    public class MatchService extends Actor {


        private static const PREFLOP:String = 'preflop';
        private static const CHANGE_PREFLOP:String = 'change_preflop';
        private static const END_PREFLOP:String = 'end_preflop';
        private static const OPPONENT_PREFLOP_CLICK:String = 'opponent_preflop_click';
        private static const CHANGE_OPPONENT_PREFLOP:String = 'change_opponent_preflop';
        private static const READY:String = 'ready';
        private static const OPPONENT_STEP:String = 'opponent_step';

        private var wrapper:IWebSocketWrapper;
        private var userId:uint;
        private var reconnectFlag:Boolean = false;

        public function init (match_id:uint) :void {

            var lobby_domain:String = '127.0.0.1';
            var lobby_port:uint = 8003;
            var lobby_path:String = 'match/' + match_id;

            if (wrapper) {
                wrapper.destroyListeners()
                wrapper.destroy();
            }

            wrapper = SocketFactory.newSocketService()
                    .configure(lobby_domain, lobby_port, lobby_path)
                    .configureListeners(onOpen, onClose, onMessage, onFail)
        }

        public function setUserData (data:Object) :void {
            this.userId = data['id'];
        }

        public function connect () :void {
            wrapper.connect();
        }

        public function reconnect () :void {
            reconnectFlag = true;
            wrapper.connect();
        }

        public function sendMessage (type:String, data:Object) :void {
            var msg:Object = {}
            msg['target'] = userId;
            msg['type'] = type;
            msg['status'] = 'success';
            msg['data'] = data
            var json:String = JSON.stringify(msg);
            if (wrapper.readyState == 1) {
                wrapper.send(json);
            } else {
               // dispatch(new MatchServiceEvent(MatchServiceEvent.ABORT_CONNECTION, {}))
            }

        }

        public function close () :void {
            wrapper.destroyListeners();
            wrapper.destroy();
            wrapper = null;
        }

        private function onOpen(event:WebSocketEvent):void {


            var msg:Object = {};
            msg['id'] = userId;
            msg['status'] = 'success';

            if (reconnectFlag) {
                reconnectFlag = false;
                msg['type'] = 'reconnect_to_match';
            } else {
                msg['type'] = 'connect_to_match';
            }


            var json:String = JSON.stringify(msg);
            wrapper.send(json);
        }

        private function onClose(event:WebSocketEvent):void {
            trace("Disconnected");
        }

        private function onFail(event:WebSocketErrorEvent):void {
            trace("Connection Failure: " + event.text);
        }

        private function onMessage(event:WebSocketEvent):void {
            if (event.message.type === WebSocketMessage.TYPE_UTF8) {
                var response:Object = JSON.parse(event.message.utf8Data)
                parseResponse(response);
            }
            else if (event.message.type === WebSocketMessage.TYPE_BINARY) {
                trace("Got binary message of length " + event.message.binaryData.length);
            }
        }

        private function parseResponse (response:Object) :void {
            var data:Object = {}

            trace(response.type);
            switch (response.type) {
                case PREFLOP:
                {

                    dispatch(new MatchServiceEvent(MatchServiceEvent.CONNECTION_INIT, response.data));
                    break;
                }

                case CHANGE_PREFLOP: {

                    dispatch(new MatchServiceEvent(MatchServiceEvent.CHANGE_PREFLOP, response.data));
                    break;
                }

                case END_PREFLOP: {
                    dispatch(new MatchServiceEvent(MatchServiceEvent.END_PREFLOP, response.data))
                    break;
                }

                case OPPONENT_PREFLOP_CLICK: {
                    dispatch(new MatchServiceEvent(MatchServiceEvent.OPPONENT_PREFLOP_CLICK, response.data))
                    break;
                }

                case CHANGE_OPPONENT_PREFLOP: {
                    dispatch(new MatchServiceEvent(MatchServiceEvent.CHANGE_OPPONENT_PREFLOP, response.data))
                    break;
                }

                case READY: {
                    dispatch(new MatchServiceEvent(MatchServiceEvent.READY, response.data))
                    break;
                }

                case OPPONENT_STEP: {
                    dispatch(new MatchServiceEvent(MatchServiceEvent.OPPONENT_STEP, response.data))
                    break;
                }





            }





        }

    }
}
