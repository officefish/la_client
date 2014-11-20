/**
 * Created by root on 10/2/14.
 */
package com.la.socket {
public interface IWebSocketWrapper {

    function configure (host:String, port:uint, path:String = '') :IWebSocketWrapper
    function configureListeners (onOpen:Function, onClose:Function, onFail:Function, onMessage:Function) :IWebSocketWrapper;
    function connect () :IWebSocketWrapper;
    function close () :IWebSocketWrapper;
    function destroyListeners () :IWebSocketWrapper;
    function destroy () :IWebSocketWrapper;
    function send (message:String) :IWebSocketWrapper;
    function get readyState () :int;
}
}
