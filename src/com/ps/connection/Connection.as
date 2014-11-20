/**
 * Created by root on 9/21/14.
 */
package com.ps.connection {
import com.log.Logger;
import com.worlize.websocket.WebSocket;
import com.worlize.websocket.WebSocketErrorEvent;
import com.worlize.websocket.WebSocketEvent;
import com.worlize.websocket.WebSocketMessage;

import flash.system.Security;
import flash.utils.ByteArray;


public class Connection {

    private var websocket:WebSocket;

    public function Connection() {
        Logger.log(Security.sandboxType.toString());


        Security.loadPolicyFile("xmlsocket://127.0.0.1:8000/crossdomain.xml");
        var url:String = "ws://127.0.0.1:8003/ws";
        //socket = new CustomSocket("127.0.0.1", 8003);
        websocket = new WebSocket(url, "*");
        websocket.debug = true;
        //websocket.enableDeflateStream = true;
        websocket.addEventListener(WebSocketEvent.CLOSED, handleWebSocketClosed);
        websocket.addEventListener(WebSocketEvent.OPEN, handleWebSocketOpen);
        websocket.addEventListener(WebSocketEvent.MESSAGE, handleWebSocketMessage);
        websocket.addEventListener(WebSocketErrorEvent.CONNECTION_FAIL, handleConnectionFail);
        try {
            trace('helloworld')
            Logger.log('try to connect')
            websocket.connect();
        } catch (e:Error) {
            Logger.log(e.toString())
        }

    }


    private function handleWebSocketOpen(event:WebSocketEvent):void {
        Logger.log("Connected");
        websocket.sendUTF("Hello World!\n");

        var binaryData:ByteArray = new ByteArray();
        binaryData.writeUTF("Hello as Binary Message!");
        websocket.sendBytes(binaryData);
    }

    private function handleWebSocketClosed(event:WebSocketEvent):void {
        Logger.log('Disconnected')
        Logger.log(event.message.type)
        Logger.log(event.message.utf8Data)

        trace("Disconnected");
    }

    private function handleConnectionFail(event:WebSocketErrorEvent):void {
        Logger.log ("Connection Failure: " + event.text)
        trace("Connection Failure: " + event.text);
    }

    private function handleWebSocketMessage(event:WebSocketEvent):void {
        Logger.log ("HandleMessage" )


        if (event.message.type === WebSocketMessage.TYPE_UTF8) {
            trace("Got message: " + event.message.utf8Data);
        }
        else if (event.message.type === WebSocketMessage.TYPE_BINARY) {
            trace("Got binary message of length " + event.message.binaryData.length);
        }
    }

}
}
