package idv.k888168168.broller.utils 
{
	import flash.errors.IllegalOperationError;
	/**
	 * ...
	 * @author gos0495
	 */
	public final class RollerMode 
	{
		static public const IDLE:RollerMode = new RollerMode(1);
		static public const ROLLING:RollerMode = new RollerMode(2);
		static public const STOPPING:RollerMode = new RollerMode(3);
		static public const PAUSING:RollerMode = new RollerMode(4);
		static public const PAUSE:RollerMode = new RollerMode(5);
		
		private var _value:int;
		public function get value():int 
		{
			return _value;
		}
		
		public function RollerMode(value:int) 
		{
			_value = value;
		}
		
		public function setMode(mode:RollerMode):void
		{
			if (this === IDLE || this === ROLLING || this === STOPPING || this === PAUSING || this === PAUSE) {
				throw new IllegalOperationError("RollerMode常數不可改變！");
			}
			_value = mode.value;
		}
		
		public function equalTo(mode:RollerMode):Boolean
		{
			return _value == mode.value;
		}
		
		public function clone():RollerMode 
		{
			return new RollerMode(_value);
		}
		
	}
}