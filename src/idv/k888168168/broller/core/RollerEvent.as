package idv.k888168168.broller.core 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author gos0495
	 */
	public class RollerEvent extends Event
	{
		public static const ROLLER_STOPPED:String = "rollerStopped";
		static public const ROLLER_PAUSED:String = "rollerPaused";
		public static const ALL_ROLLER_STOPPED:String = "allRollerStopped";
		
		private var m_model:Array;
		
		public function RollerEvent(type:String, model:Array = null) 
		{
			super(type);
			this.m_model = model;
		}
		
		override public function clone():Event 
		{
			return new RollerEvent(type, model);
		}
		
		public function get model():Array { return m_model;}
		
		public function set model(value:Array):void 
		{
			m_model = value;
		}
		
	}

}