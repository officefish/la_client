/**
 * Created by root on 10/2/14.
 */
package com.la.socket {
import com.worlize.websocket.WebSocket;
import com.worlize.websocket.WebSocketErrorEvent;
import com.worlize.websocket.WebSocketEvent;

public class WebSocketWrapper implements IWebSocketWrapper{

    private var url:String;
    private var onMessage:Function;
    private var onOpen:Function;
    private var onClose:Function;
    private var onFail:Function;

    private var webSocket:WebSocket;


    public function WebSocketWrapper() {

    }

    public function  configure (host:String, port:uint, path:String = '') :IWebSocketWrapper {
        url = 'ws://' + host + ':' + port;
        if (path.length) url += '/' + path;
        webSocket = new WebSocket(url, '*')
        //webSocket.debug = true;
        return this;
    }

    public function configureListeners (onOpen:Function, onClose:Function, onMessage:Function, onFail:Function) :IWebSocketWrapper {

        this.onOpen = onOpen;
        this.onClose = onClose;
        this.onMessage = onMessage;
        this.onFail = onFail;

        if (webSocket == null) {
            throw new Error('WebSocket not initalised, use wrapper.configure() before configure handlers')
        }

        webSocket.addEventListener(WebSocketEvent.OPEN, onOpen);
        webSocket.addEventListener(WebSocketEvent.CLOSED, onClose);
        webSocket.addEventListener(WebSocketEvent.MESSAGE, onMessage);
        webSocket.addEventListener(WebSocketErrorEvent.CONNECTION_FAIL, onFail);
        return this;
    }

    public function get readyState() :int {
        return webSocket.readyState;
    }

    public function reconnect () :void {

    }

    public function connect () :IWebSocketWrapper {
        webSocket.connect();
        return this;
    }

    public function close () :IWebSocketWrapper {
        webSocket.close();
        return this;
    }

    public function destroy () :IWebSocketWrapper {
        webSocket = null;
        return this;
    }

    public function destroyListeners () :IWebSocketWrapper {
        if (!webSocket) return this;

        if (webSocket.hasEventListener(WebSocketEvent.OPEN)) {
            webSocket.removeEventListener(WebSocketEvent.OPEN, onOpen);
        }
        if (webSocket.hasEventListener(WebSocketEvent.CLOSED)) {
            webSocket.removeEventListener(WebSocketEvent.OPEN, onClose);
        }
        if (webSocket.hasEventListener(WebSocketEvent.MESSAGE)) {
            webSocket.removeEventListener(WebSocketEvent.OPEN, onMessage);
        }
        if (webSocket.hasEventListener(WebSocketErrorEvent.CONNECTION_FAIL)) {
            webSocket.removeEventListener(WebSocketErrorEvent.CONNECTION_FAIL, onFail);
        }
        onOpen = null;
        onClose = null;
        onMessage = null;
        onFail = null;

        return this;
    }

    public function send (message:String) :IWebSocketWrapper {
        webSocket.sendUTF(message);
        return this;
    }



}
}
