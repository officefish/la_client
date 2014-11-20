/**
 * Created by root on 10/2/14.
 */
package com.la.mvc.model.values
{
public class StringVO
{
    protected var _value:String;

    public function StringVO(text:String)
    {
        _value = text;
    }

    public function toString():String
    {
        return _value;
    }
}
}

