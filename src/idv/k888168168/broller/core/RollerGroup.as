package idv.k888168168.broller.core
{
	import flash.events.EventDispatcher;
	import idv.k888168168.broller.core.Roller;
	import idv.k888168168.broller.core.RollerEvent;
	import idv.k888168168.broller.utils.RollerConfig;
	
	/**
	 * @eventType	src.view.component.common.roller.RollerEvent.ROLLER_STOPPED
	 */
	[Event(name = "rollerStopped", type = "src.view.component.common.roller.RollerEvent")] 
	
	/**
	 * @eventType	src.view.component.common.roller.RollerEvent.ALL_ROLLER_STOPPED
	 */
	[Event(name = "allRollerStopped", type = "src.view.component.common.roller.RollerEvent")] 
	
	
	/**
	 * 滾輪群組
	 * 負責建立Roller 及 Roller事件傳遞
	 * 
	 * Usage:
		 * 
			var dispRect:Rectangle = new Rectangle(0, 0, 152, 240);
			var id:int;
			
			id = 0;
			var rollerConfig1:RollerConfig = 
				new RollerConfig(id)
				.setRollerContainer(_container.mcRoller0)
				.setRollerTape(RollerTapeData.getRollerTape(id))
				.setNumSymbol(3)
				.setOffset(15, 15)
				.setVelocity(1.2)
				.setDispRect(dispRect);
				
			id = 1;
			var rollerConfig2:RollerConfig = 
				new RollerConfig(id)
				.setRollerContainer(_container.mcRoller1)
				.setRollerTape(RollerTapeData.getRollerTape(id))
				.setNumSymbol(3)
				.setOffset(15, 15)
				.setVelocity(1.2)
				.setDispRect(dispRect);
				
			id = 2;
			var rollerConfig3:RollerConfig = 
				new RollerConfig(id)
				.setRollerContainer(_container.mcRoller2)
				.setRollerTape(RollerTapeData.getRollerTape(id))
				.setNumSymbol(3)
				.setOffset(15, 15)
				.setVelocity(1.2)
				.setDispRect(dispRect);
			
			m_group  = new RollerGroup(rollerConfig1, rollerConfig2, rollerConfig3);
			
		 * 
	 *
	 * 
	 * @author gos0495
	 */
	public class RollerGroup extends EventDispatcher
	{
		private var m_configs:Array;
		private var m_rollers:Array;
		private var m_stopCount:int;
		
		/**
		 * 
		 * @param	...rest 輸入個數不定的 RollerConfig 來初始化滾輪
		 */
		public function RollerGroup(...rest) 
		{
			m_configs = rest.concat();
			
			setup();
		}
		
		public function initEvt():void
		{
			for (var i:int = 0; i < m_rollers.length; i++) 
			{
				var roller:Roller = m_rollers[i] as Roller;
				roller.addEventListener(RollerEvent.ROLLER_STOPPED, onRollerStop);
			}
		}
		
		public function removeEvt():void
		{
			for (var i:int = 0; i < m_rollers.length; i++) 
			{
				var roller:Roller = m_rollers[i] as Roller;
				roller.removeEventListener(RollerEvent.ROLLER_STOPPED, onRollerStop);
			}
		}
		
		private function onRollerStop(e:RollerEvent):void 
		{
			var index:int = m_rollers.indexOf(e.currentTarget);
			e.model = [index];
			dispatchEvent(e);
			
			m_stopCount++;
			if (m_stopCount % 3 == 0) {
				dispatchEvent(new RollerEvent(RollerEvent.ALL_ROLLER_STOPPED));
			}
		}
		
		public function initRoller(arrRollerIndex:Array):void 
		{
			for (var i:int = 0; i < m_rollers.length; i++) 
			{
				var roller:Roller = m_rollers[i] as Roller;
				var rollerIndex:int = arrRollerIndex[i];					
				roller.initRoller(rollerIndex);
			}
		}
		
		public function startRoller(arrRollerResult:Array):void 
		{
			for (var i:int = 0; i < m_rollers.length; i++) 
			{
				var roller:Roller = m_rollers[i] as Roller;
				var rollerResult:int = arrRollerResult[i];				
				roller.startRoller(rollerResult);
			}
			m_stopCount = 0;
		}
		
		public function changeRollerResult(arrRollerResult:Array):void 
		{
			for (var i:int = 0; i < m_rollers.length; i++) 
			{
				var roller:Roller = m_rollers[i] as Roller;
				var rollerResult:int = arrRollerResult[i];
				roller.changeRollerResult(rollerResult);
			}
		}
		
		public function onExit():void 
		{
			for (var i:int = 0; i < m_rollers.length; i++) 
			{
				var roller:Roller = m_rollers[i] as Roller;
				roller.onExit();
			}
		}
		
		public function stopRoller(rollerNum:int):void 
		{
			var roller:Roller = m_rollers[rollerNum] as Roller;			
			if (roller) {
				roller.stopRoller();
			}
		}
		
		public function pauseRoller(rollerNum:int, isFixed:Boolean = true):void 
		{
			var roller:Roller = m_rollers[rollerNum] as Roller;			
			if (roller) {
				roller.pauseRoller(isFixed);
			}
		}
		
		public function changeRollerAtlas(rollerNum:int, atlas:String):void 
		{
			var roller:Roller = m_rollers[rollerNum] as Roller;			
			if (roller) {
				roller.atlas = atlas;
			}
		}
		
		private function setup():void 
		{
			m_rollers = [];
			for (var i:int = 0; i < m_configs.length; i++) 
			{
				var rollerConfig:RollerConfig = m_configs[i] as RollerConfig;	
				var roller:Roller = new Roller(rollerConfig);
				m_rollers[rollerConfig.getID()] = roller;
			}
			
		}
		
	}

}