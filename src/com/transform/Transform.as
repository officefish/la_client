/**
 * Created by root on 10/29/14.
 */
package com.transform {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;

public class Transform {
    public function Transform() {
    }

    public static function scale (asset:Bitmap, scale:Number) :Bitmap {
        scale = Math.abs(scale);
        var bitmapData:BitmapData = asset.bitmapData;
        var width:int = (bitmapData.width * scale) || 1;
        var height:int = (bitmapData.height * scale) || 1;
        var transparent:Boolean = bitmapData.transparent;
        var result:BitmapData = new BitmapData(width, height, transparent);
        var matrix:Matrix = new Matrix();
        matrix.scale(scale, scale);
        result.draw(bitmapData, matrix);
        return new Bitmap(result);
    }
}
}
