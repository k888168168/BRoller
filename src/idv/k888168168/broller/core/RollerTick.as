package idv.k888168168.broller.core 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	/**
	 * 時間計算
	 * @author gos0495
	 */
	public class RollerTick extends EventDispatcher
	{
		RollerTick.getInstance();
		private static var _instance:RollerTick;
		static public function getInstance():RollerTick
		{
			if (!_instance) _instance = new RollerTick();
			return _instance;
		}
		
		private var updateTick:Sprite;
		private var preTimer:int;
		private var _step:int;
		
		public function RollerTick() 
		{
			updateTick = new Sprite();
			updateTick.addEventListener(Event.ENTER_FRAME, onUpdate, false, 1000, true);
			preTimer = getTimer();
		}
		
		private function onUpdate(e:Event):void 
		{
			var time:int = getTimer();
			_step = time - preTimer;
			preTimer = time;
			dispatchEvent(e.clone());
		}
		
		public function get step():int 
		{
			return _step;
		}
		
	}

}