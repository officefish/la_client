package com.la.mvc.model.values
{
    public class uintVO
    {
        protected var _value:uint;

        public function uintVO(value:uint)
        {
            _value = value;
        }

        public function get value():uint
        {
            return _value;
        }

        public function set value(val:uint):void
        {
            _value = val;
        }
    }
}

