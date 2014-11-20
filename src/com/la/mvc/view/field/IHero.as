/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
public interface IHero extends IAttackAvailable {
    function set isEnemy (value:Boolean) :void;
    function get isEnemy () :Boolean;
    function hideHealth () :void;
    function showHealth () :void;
    function setType(value:int):void;
    function setHealth(value:int):void;
}
}
