package com.ps.trajectory 
{
	import com.ps.field.IAttackAvailable;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class TraectoryContainerEvent extends Event 
	{
		
		public static const SELECT:String = 'selectTokenInContainer';
		private var token:IAttackAvailable;
		
		public function TraectoryContainerEvent(type:String, token:IAttackAvailable, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.token = token;
			
		} 
		
		public override function clone():Event 
		{ 
			return new TraectoryContainerEvent(type, token, bubbles, cancelable);
		} 
		
		public function getToken () :IAttackAvailable {
			return token;
		}
		
		public override function toString():String 
		{ 
			return formatToString("TraectoryContainer", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}