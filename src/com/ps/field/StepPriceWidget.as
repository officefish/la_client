package com.ps.field 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class StepPriceWidget extends Sprite
	{
		
		public function StepPriceWidget() 
		{
			graphics.beginFill (0x777777, 1);
			graphics.drawRect (0, 0, 210, 30);
			graphics.endFill ();
			
			for (var i:int = 0; i < 10; i ++) {
				var lamp:Sprite = new Sprite ();
				lamp.graphics.beginFill (0x555555, 1);
				lamp.graphics.drawRect (0, 0, 16, 16);
				lamp.graphics.endFill ();
				lamp.x = this.numChildren * 13 + (7 * (numChildren + 1));
				lamp.y = 7;
				addChild (lamp);
			}
		}
		
		public function setPrice (value:int) :void {
			for (var i:int = 0; i < value; i ++) {
				var lamp:Sprite = getChildAt (i) as Sprite;
				lamp.graphics.clear ();
				lamp.graphics.beginFill (0x00FFFF, 1);
				lamp.graphics.drawRect (0, 0, 16, 16);
				lamp.graphics.endFill ();
			}
			
			for (var j:int = value; j < 10; j ++) {
				lamp = getChildAt (j) as Sprite;
				lamp.graphics.clear ();
				lamp.graphics.beginFill (0x555555, 1);
				lamp.graphics.drawRect (0, 0, 16, 16);
				lamp.graphics.endFill ();
			}
		}
		
	}

}