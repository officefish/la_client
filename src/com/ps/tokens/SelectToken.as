package com.ps.tokens 
{
	import com.ps.field.IAttackAvailable;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class SelectToken extends Sprite
	{
		
		private var bitmap:Bitmap;
		private var token:IAttackAvailable;
		
		public function SelectToken(token:IAttackAvailable, bitmap:Bitmap) 
		{
			this.bitmap = bitmap;
			this.token = token;
			addChild (bitmap);
			buttonMode = true;
		}
		
		public function getToken () :IAttackAvailable {
			return token;
		}
		
	}

}