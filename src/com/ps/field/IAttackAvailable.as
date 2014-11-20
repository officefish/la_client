package com.ps.field 
{
	import com.ps.cards.eptitude.CardEptitude;

import flash.events.IEventDispatcher;

/**
	 * ...
	 * @author 
	 */
	public interface IAttackAvailable extends IEventDispatcher
	{
		function isEnemy () :Boolean;
		function getHealth () :int;
		function getAttack() :int;
		function setHealth (value:int) :void;
		function isProvocator () :Boolean;
		function configure (eptitude:CardEptitude, callback:Function) :void;
		function freeze ():void;
        function hasShield () :Boolean;
        function destroyShield ():void;
        function getTotalAttack():int;
        function completeConfigure () :void;
        function cancelSelect ():void;
        function getTotalHealth():int;
        function getHealthBob():int;
	}
	
}