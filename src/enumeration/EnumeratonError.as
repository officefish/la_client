package enumeration
{
	/**
	 * ...
	 * @author 
	 */
	public class EnumeratonError extends Error 
	{
		public static const NO_VALUE_PARAMETER:String = "Переменная value не определена. Вы должны переопределить класс Enumiration и создать в нем свойство 'value'"
		public static const INCORRECT_VALUE_TYPE:String = "Переменная 'value' должна быть типа uint, int либо String"
		public static const ALTERNATIVE_INSTANCE:String = "Экземпляры Перечисления (Enumiration) могут быть созданы исключительно как значения их статических констант"
		
		public function EnumeratonError(message:*='',id:*=0) 
		{
			super (message, id);
		}
		
	}

}