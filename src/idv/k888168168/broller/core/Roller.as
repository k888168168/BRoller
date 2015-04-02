package idv.k888168168.broller.core 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import idv.k888168168.broller.blur.RollerBlur;
	import idv.k888168168.broller.utils.RollerConfig;
	import idv.k888168168.broller.utils.RollerMode;
	import idv.k888168168.broller.utils.RollerRenderData;
	import idv.k888168168.broller.utils.RollerRenderDataPool;
	import idv.k888168168.broller.utils.RollerTape;
	import idv.k888168168.broller.utils.RollerUtils;
	import idv.k888168168.broller.utils.RollerVelocity;
	
	/**
	 * @eventType	src.view.component.common.roller.RollerEvent.ROLLER_STOPPED
	 */
	[Event(name = "rollerStopped", type = "src.view.component.common.roller.RollerEvent")]
	
	/**
	 * 負責滾輪顯示,啟動,停止
	 * 
	 * @author gos0495
	 */
	public class Roller extends EventDispatcher
	{
		protected var m_mode:RollerMode;
		public function getMode():RollerMode {	return m_mode; }
		public function setMode(value:RollerMode):void 
		{
			m_mode.setMode(value);
		}
		protected var m_atlas:String;
		public function get atlas():String {	return m_atlas; }
		public function set atlas(value:String):void 
		{
			m_atlas = value;
			m_rollerTape.changeAtlas(m_atlas);
			renderRoller();
		}
		
		protected var m_config:RollerConfig;
		
		protected var m_rollerContainer:DisplayObjectContainer;
		protected var m_rollerTape:RollerTape;
		protected var m_rollerVelocity:RollerVelocity;
		protected var m_rollerBlur:RollerBlur;
		
		protected var m_bitmapData:BitmapData;
		protected var m_bitmap:Bitmap;
		
		/** 當前位置 */
		protected var m_currRollerIndex:Number;
		protected function get currRollerIndex():Number { return m_currRollerIndex;}
		protected function set currRollerIndex(value:Number):void 
		{
			m_currRollerIndex = RollerUtils.fixLength(value, m_rollerTape.length);
		}
		
		protected var m_rollerResult:int;
		
		public function Roller(rollerConfig:RollerConfig) 
		{
			m_config = rollerConfig;
			m_rollerContainer = rollerConfig.getRollerContainer();
			m_rollerTape = rollerConfig.getRollerTape();
			m_rollerBlur = rollerConfig.getRollerBlur();
			m_rollerVelocity = rollerConfig.getRollerVelocity();
			
			m_mode = RollerMode.IDLE.clone();
			
			setup();
		}
		
		/**
		 * 初始c化滾輪
		 * @param	rollerIndex
		 */
		public function initRoller(rollerIndex:int):void 
		{
			setMode(RollerMode.IDLE);
			currRollerIndex = rollerIndex;
			changeRollerResult(currRollerIndex);
			renderRoller();
		}
		
		/**
		 * 開始滾輪
		 * @param	rollerResult 停輪位置，預設值-1為不改變當前設定值
		 */
		public function startRoller(rollerResult:int = -1):void 
		{
			setMode(RollerMode.ROLLING);
			changeRollerResult(rollerResult);
			RollerTick.getInstance().addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		
		/**
		 * 改變結果
		 * @param	rollerResult 停輪位置，預設值-1為不改變當前設定值
		 */
		public function changeRollerResult(rollerResult:int = -1):void 
		{
			if (rollerResult != -1) {
				m_rollerResult = rollerResult;
			}
		}
		
		/**
		 * 暫停滾輪
		 * 滾輪在啟動狀態下才可使用
		 * 
		 * @param isFixed 是否持續轉動直到下一個整數值才停止，預設為true。若為false，則滾輪立即停止。
		 */
		public function pauseRoller(isFixed:Boolean = true):void 
		{
			if(getMode().equalTo(RollerMode.ROLLING)) {
				if(isFixed) {
					setMode(RollerMode.PAUSING);
				}else {
					setMode(RollerMode.PAUSE);
				}
			}
		}
		
		/**
		 * 停止滾輪
		 */
		public function stopRoller():void 
		{
			if(getMode().equalTo(RollerMode.ROLLING)) {
				setMode(RollerMode.STOPPING);
			}
			else if (getMode().equalTo(RollerMode.STOPPING)) {
				
			}
			else {
				setMode(RollerMode.IDLE);
				currRollerIndex = m_rollerResult;
				renderRoller();
			}
		}
		
		/**
		 * 離開，移除監聽
		 */
		public function onExit():void 
		{
			setMode(RollerMode.IDLE);
			RollerTick.getInstance().removeEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * 渲染滾輪
		 */
		protected function renderRoller():void 
		{	
			var arrRenderData:Array = m_rollerTape.getRenderData(currRollerIndex);
			
			m_bitmapData.lock();
			
			for (var i:int = 0; i < arrRenderData.length; i++) 
			{
				var renderData:RollerRenderData = arrRenderData[i] as RollerRenderData;
				
				m_bitmapData.copyPixels(renderData.sourceBitmapData, renderData.sourceRect, renderData.destPoint);
				
				RollerRenderDataPool.getInstance().recycle(renderData);
			}
			m_rollerBlur.applyFilter(m_bitmapData, m_bitmapData);
			
			m_bitmapData.unlock();
		}
		
		private function update(e:Event):void 
		{
			if(getMode().equalTo(RollerMode.ROLLING)) {
				currRollerIndex += -m_rollerVelocity.getCurrentVelocity() * RollerTick.getInstance().step / 33;
				renderRoller();
			}
			else if (getMode().equalTo(RollerMode.PAUSING)) {
				var nextRollerIndex:Number = currRollerIndex - m_rollerVelocity.getCurrentVelocity() * RollerTick.getInstance().step / 33;
				
				if (m_rollerVelocity.getCurrentVelocity() > 0) {
					if (nextRollerIndex <= Math.floor(currRollerIndex)) {
						setMode(RollerMode.PAUSE);
						currRollerIndex = Math.floor(currRollerIndex);
					}else {
						currRollerIndex = nextRollerIndex;
					}
				}else {
					if (nextRollerIndex >= Math.ceil(currRollerIndex)) {
						setMode(RollerMode.PAUSE);
						currRollerIndex = Math.ceil(currRollerIndex);
					}else {
						currRollerIndex = nextRollerIndex;
					}
				}
				renderRoller();
				dispatchEvent(new RollerEvent(RollerEvent.ROLLER_PAUSED));
			}
			else if (getMode().equalTo(RollerMode.STOPPING)) {
				RollerTick.getInstance().removeEventListener(Event.ENTER_FRAME, update);
				currRollerIndex = m_rollerResult;
				renderRoller();
				setMode(RollerMode.IDLE);
				
				dispatchEvent(new RollerEvent(RollerEvent.ROLLER_STOPPED));
			}
		}
		
		private function setup():void 
		{
			m_rollerTape.numOfSymbol = m_config.getNumSymbol();;
			m_rollerTape.upperOffset = m_config.getLowerOffsetPxl();
			m_rollerTape.lowerOffset = m_config.getUpperOffsetPxl();
			m_rollerTape.setMode(m_mode);
			
			m_rollerContainer.mouseChildren = false;
			m_rollerContainer.mouseEnabled = false;
			m_rollerContainer.scrollRect = m_config.getDispRect();
			m_rollerContainer.scaleX = m_rollerContainer.scaleY = 1 / m_config.getSourceSymbolSize();
			
			m_bitmapData = new BitmapData(m_config.getDispRect().width, m_config.getDispRect().height + m_config.getTotalOffsetPxl(), true, 0x00000000);
			m_bitmap = new Bitmap(m_bitmapData, "auto", true);
			m_rollerContainer.addChild(m_bitmap);
			
			m_rollerBlur.setRectangle(0, 0, m_bitmapData.width, m_bitmapData.height);
			m_rollerBlur.setMode(m_mode);
			m_rollerBlur.setRollerVelocity(m_rollerVelocity);
			
			m_rollerVelocity.setMode(m_mode);
		}
		
	}

}