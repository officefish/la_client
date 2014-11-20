package com.ps.popup 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author 
	 */
	public class Popup extends Sprite
	{
		private static var instance:Popup;
		private var label:TextField;
		private var _stage:Stage;
		
		public function Popup() 
		{
			graphics.beginFill (0xFFFFFF, 1);
			graphics.drawRect (0, 0, 400, 150);
			graphics.endFill ();
			
			var labelFormat:TextFormat = new TextFormat ();
			labelFormat.size = 16;
			labelFormat.align = TextFormatAlign.CENTER;
			
			label = new TextField ();
			label.width = 400;
			label.defaultTextFormat = labelFormat;
			label.autoSize = TextFieldAutoSize.CENTER;
			label.y = 50;
			addChild (label);
		}
		
		public static function getInstance () :Popup {
			if (instance == null) {
				instance = new Popup ();
			}
			return instance;
		}
		
		public function warning (str:String) :void {
			label.text = str;
			_stage.addChild (this);
			this.x = (_stage.width - this.width) / 2;
			this.y = (_stage.height - this.height) / 4;
			_stage.addEventListener (MouseEvent.CLICK, onStageClick);
		}
		
		public function onStageClick (event:MouseEvent) :void {
			_stage.removeChild (this);
			_stage.removeEventListener (MouseEvent.CLICK, onStageClick);
			
		}
		
		public function setStage (stage:Stage) :void {
			this._stage = stage;
		}
		
	}

}