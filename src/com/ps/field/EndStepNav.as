package com.ps.field 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 
	 */
	public class EndStepNav extends Sprite
	{
		private var label:TextField;
		
		public function EndStepNav() 
		{
			graphics.beginFill (0x444444, 1);
			graphics.drawRect (0, 0, 100, 40);
			graphics.endFill()
			
			buttonMode = true;
			
			var format:TextFormat = new TextFormat ();
			format.color = 0xFFFFFF;
			format.size = 15;
			
			label = new TextField ();
			label.defaultTextFormat = format;
			label.text = "Закончить";
			label.autoSize = TextFieldAutoSize.LEFT;
			label.wordWrap = false;
			//label.border = true;
			label.x = (this.width - label.width) / 2
			label.y = 10;
			label.mouseEnabled = false;
			addChild (label);
			
			
		}
		
	}

}