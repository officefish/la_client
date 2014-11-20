package com.ps.field 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class PriceToolbar 
	{
		
		private var stepPrice:int;
		private var stepPriceWidget:StepPriceWidget;
		
		public function PriceToolbar(stepPrice:int = 0) 
		{
			this.stepPrice = stepPrice;
			this.stepPriceWidget = new StepPriceWidget ();
		}
		
		public function getWidget () :Sprite {
			return stepPriceWidget as Sprite;
		}
		
		public function getStepPrice () :int {
			return stepPrice;
		}
		
		public function setStepPrice (value:int) :void {
			stepPrice = value;
			stepPriceWidget.setPrice (value);
		}
		
		public function increaseStepPrice () :void {
			if (stepPrice < 10) {
				stepPrice ++;
			}
			stepPriceWidget.setPrice (stepPrice);
		}
		
		
	}

}