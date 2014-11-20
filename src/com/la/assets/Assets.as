/**
 * Created by root on 10/29/14.
 */
package com.la.assets {
import com.la.mvc.view.field.Hero;

import flash.display.Bitmap;

public class Assets {

    [Embed(source ="hunter.jpg")] private static var HunterAsset:Class;
    [Embed(source ="adventurer.jpg")] private static var AdventurerAsset:Class;
    [Embed(source ="monk.jpg")] private static var MonkAsset:Class;



    public function Assets() {
    }

    public static function getHunter () :Bitmap {
        return new HunterAsset as Bitmap;
    }

    public static function getAdventurer () :Bitmap {
        return new AdventurerAsset as Bitmap;
    }

    public static function getMonk () :Bitmap {
        return new MonkAsset as Bitmap;
    }

    public static function getHeroAssetById (id:int) :Bitmap {
        var asset:Bitmap;
        switch (id) {
            case Hero.ADVENTURER: {
                asset = getAdventurer();
                break;
            }
            case Hero.HUNTER: {
                asset = getHunter();
                break;
            }
            case Hero.MONK: {
                asset = getMonk();
                break;
            }
        }
        return asset;
    }
}
}
