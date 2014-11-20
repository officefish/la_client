package enumeration
{
	
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author 
	 */
	public class Enumeration
	{
		
		private static var enumerations:Object = {};
		
		public function Enumeration() 
		{
			
			
			// если свойство value не определено 
			if (!hasOwnProperty ('value')) {
				throw new EnumeratonError (EnumeratonError.NO_VALUE_PARAMETER);
			}
			
			// если свойство value не соответсвует типам int, uint либо String
			if ( (!(this['value'] is int)) && (!(this['value'] is uint)) && (!(this['value'] is String))) {
				trace(typeof this['value']);
                throw new EnumeratonError (EnumeratonError.INCORRECT_VALUE_TYPE);
			}
			
			var className:String = getQualifiedClassName (this);
			var enumClass:Object = getDefinitionByName (className);
			
			// если экземпляр создан не через константу
			if (enumClass != null) {
				throw new EnumeratonError (EnumeratonError.ALTERNATIVE_INSTANCE);
			}
			
			if (Enumeration.enumerations[className] == null) {
				Enumeration.enumerations[className] = new Vector.<Enumeration>();
			}
			(Enumeration.enumerations[className] as Vector.<Enumeration>).push (this);
			//trace (Enumiration.enumirations[className]);
		}
		
		public static function getElementsList(enumerationClass:Class):Vector.<Enumeration> {
			var className:String = getQualifiedClassName(enumerationClass);
			return Enumeration.enumerations[className];
		}
		
		public static function getElementByValue(value:*, enumerationClass:Class):Enumeration {
			var className:String = getQualifiedClassName(enumerationClass);
			if (Enumeration.enumerations[className] == null) {
				Enumeration.enumerations[className] = new Vector.<Enumeration>();
			}
			var vector:Vector.<Enumeration> = Enumeration.enumerations[className]
			var length:int = vector.length;
			for(var i:int=0; i < length; i++){
				if(vector[i]['value'] == value){
					return vector[i]
				}
			}
			
			return null;
		}
		
		public function getElementsList ():Vector.<Enumeration> {
			var className:String = getQualifiedClassName(this);
			return Enumeration.enumerations[className];
		}
		
		
		
		
		
	}

}