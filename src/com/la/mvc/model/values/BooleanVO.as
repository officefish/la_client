/**
 * Created by root on 10/3/14.
 */
package com.la.mvc.model.values {
public class BooleanVO {

    protected var _value:Boolean;

    public function BooleanVO(value:Boolean) {
        this._value = value;
    }

    public function set value (value:Boolean) :void {
        this._value = value;
    }

    public function get value () :Boolean {
        return _value;
    }
}
}
