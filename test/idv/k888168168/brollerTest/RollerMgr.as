package idv.k888168168.brollerTest {
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import idv.k888168168.broller.blur.MotionBlur;
	import idv.k888168168.broller.utils.RollerConfig;
	import idv.k888168168.broller.core.RollerEvent;
	import idv.k888168168.broller.core.RollerGroup;
	import idv.k888168168.broller.utils.RollerVelocity;
	
	/**
	 * @eventType	src.view.component.common.roller.RollerEvent.ROLLER_STOPPED
	 */
	[Event(name = "rollerStopped", type = "src.view.component.common.roller.RollerEvent")] 
	
	/**
	 * @eventType	src.view.component.common.roller.RollerEvent.ALL_ROLLER_STOPPED
	 */
	[Event(name = "allRollerStopped", type = "src.view.component.common.roller.RollerEvent")] 
	
	/**
	 * 滾輪管理器
	 * @author gos0495
	 */
	public class RollerMgr extends EventDispatcher 
	{
		/**滾輪群組*/
		private var m_group:RollerGroup;
		private var v1:RollerVelocity;
		private var v2:RollerVelocity;
		private var v3:RollerVelocity;
		private var m1:MotionBlur;
		private var m2:MotionBlur;
		private var m3:MotionBlur;
		
		public function RollerMgr(_container:MovieClip, sp2:MovieClip, sp3:MovieClip) 
		{
			super(this);
			_container.mouseChildren = false;
			_container.mouseEnabled = false;
			
			var dispRect:Rectangle = new Rectangle(0, 0, 152, 240);
			var id:int;
			
			v1 = new RollerVelocity(0.2);
			v2 = new RollerVelocity(0.2);
			v3 = new RollerVelocity(0.2);
			
			m1 = new MotionBlur();
			m2 = new MotionBlur();
			m3 = new MotionBlur();
			
			id = 0;
			var rollerConfig1:RollerConfig = 
				new RollerConfig(id)
				.setRollerContainer(_container)
				.setRollerTape(RollerTapeData.getRollerTape(id))
				.setNumSymbol(3)
				.setOffset(15, 15)
				.setRollerVelocity(v1)
				.setDispRect(dispRect)
				.setSourceSymbolSize(2)
				.setRollerBlur(m1);
				
			id = 1;
			var rollerConfig2:RollerConfig = 
				new RollerConfig(id)
				.setRollerContainer(sp2)
				.setRollerTape(RollerTapeData.getRollerTape(id))
				.setNumSymbol(3)
				.setOffset(15, 15)
				.setRollerVelocity(v2)
				.setDispRect(dispRect)
				.setSourceSymbolSize(2)
				.setRollerBlur(m2);
				
			id = 2;
			var rollerConfig3:RollerConfig = 
				new RollerConfig(id)
				.setRollerContainer(sp3)
				.setRollerTape(RollerTapeData.getRollerTape(id))
				.setNumSymbol(3)
				.setOffset(15, 15)
				.setRollerVelocity(v3)
				.setDispRect(dispRect)
				.setSourceSymbolSize(2)
				.setRollerBlur(m3);
			
			m_group  = new RollerGroup(rollerConfig1, rollerConfig2, rollerConfig3);
			//m_group  = new RollerGroup(rollerConfig1);
		}
		
		public function changeRollerResult(arrRollerResult:Array):void 
		{
			m_group.changeRollerResult(arrRollerResult);
		}
		
		public function initEvt():void 
		{
			m_group.initEvt();
			m_group.addEventListener(RollerEvent.ROLLER_STOPPED, onRollerEvent);
			m_group.addEventListener(RollerEvent.ALL_ROLLER_STOPPED, onRollerEvent);
		}
		
		public function initRoller(arrRollerIndex:Array):void 
		{
			m_group.initRoller(arrRollerIndex);
		}
		
		public function onExit():void 
		{
			m_group.removeEvt();
			m_group.onExit();
		}
		
		public function removeEvt():void 
		{
			m_group.removeEvt();
			m_group.removeEventListener(RollerEvent.ROLLER_STOPPED, onRollerEvent);
			m_group.removeEventListener(RollerEvent.ALL_ROLLER_STOPPED, onRollerEvent);
		}
		
		public function startRoller(arrRollerResult:Array):void 
		{
			m_group.startRoller(arrRollerResult);
		}
		
		public function stopRoller(rollerNo:int):void 
		{
			m_group.stopRoller(rollerNo);
		}	
		
		public function pauseRoller(rollerNo:int, isFixed:Boolean = true):void 
		{
			m_group.pauseRoller(rollerNo, isFixed);
		}
		
		public function changeRollerAtlas(rollerNo:int, atlas:String):void 
		{
			m_group.changeRollerAtlas(rollerNo, atlas);
		}
		
		public function setVel(r1:int, r2:Number):void 
		{
			(this["v" + r1] as RollerVelocity).setMaxVelocity(r2);
		}
		
		public function setBlur(r1:int, r2:Number):void 
		{
			(this["m" + r1] as MotionBlur).setMaxBlurY(r2);
		}
		
		private function onRollerEvent(e:RollerEvent):void 
		{
			dispatchEvent(e.clone());
		}	
		
	}

}