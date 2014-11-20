/**
 * Created by root on 10/2/14.
 */
package com.la.socket {
public class SocketFactory {

    public static function newSocketService () :IWebSocketWrapper {
        return new WebSocketWrapper();
    }
}
}
