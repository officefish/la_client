/**
 * Created by root on 10/3/14.
 */
package com.la.mvc.model.values {
import flash.geom.Point;

public class PointVO {

    private var _point:Point;

    public function PointVO(value:Point) {
        this._point = value;
    }

    public function get point () :Point {
        return _point;
    }

    public function set point (value:Point) {
        this._point = value;
    }
}
}
