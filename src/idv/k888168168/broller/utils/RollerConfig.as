package idv.k888168168.broller.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import idv.k888168168.broller.blur.RollerBlur;
	/**
	 * ...
	 * @author gos0495
	 */
	public class RollerConfig 
	{
		private var m_ID:uint;
		
		/** 容器 */
		private var m_rollerContainer:DisplayObjectContainer;
		/** 滾輪帶 */
		private var m_rollerTape:RollerTape;
		/** 顯示symbol數量 */
		private var m_numOfSymbol:uint;
		/** 上顯示偏移量（Pixel） */
		private var m_upperOffset:Number;
		/** 下顯示偏移量（Pixel） */
		private var m_lowerOffset:Number;
		/** 滾輪速度 */
		private var m_rollerVelocity:RollerVelocity;
		/** 滾輪模糊 */
		private var m_rollerBlur:RollerBlur;
		/** 顯示區域 */
		private var m_dispRect:Rectangle;
		/** 圖片來源解析度比值 （ 來源/目標 ）*/
		private var m_sourceSizeRatio:Number;
		
		public function RollerConfig(ID:uint) 
		{
			m_ID = ID;
			m_numOfSymbol = 0;
			m_upperOffset = 0;
			m_lowerOffset = 0;
			m_sourceSizeRatio = 1;
			m_rollerVelocity = new RollerVelocity();
			m_rollerBlur = new RollerBlur();
		}
		
		public function clone(ID:uint):RollerConfig
		{
			var rtn:RollerConfig = new RollerConfig(ID)
				.setRollerBlur(getRollerBlur())
				.setDispRect(getDispRect())
				.setNumSymbol(getNumSymbol())
				.setOffset(getUpperOffset(), getLowerOffset())
				.setRollerContainer(getRollerContainer())
				.setRollerTape(getRollerTape())
				.setRollerVelocity(getRollerVelocity());
			
			return rtn;
		}
		
		public function getID():uint 
		{
			return m_ID;
		}
		
		public function getUpperOffset():Number
		{
			return m_upperOffset;
		}
		
		public function getLowerOffset():Number
		{
			return m_lowerOffset;
		}
		
		public function getTotalOffset():Number
		{
			return getLowerOffset() + getUpperOffset();
		}
		
		public function getUpperOffsetPxl():Number
		{
			return getUpperOffset() * getSourceSymbolSize();
		}
		
		public function getLowerOffsetPxl():Number
		{
			return getLowerOffset() * getSourceSymbolSize();
		}
		
		public function getTotalOffsetPxl():Number
		{
			return getTotalOffset() * getSourceSymbolSize();
		}
		
		public function setOffset(upperOffset:Number, lowerOffset:Number):RollerConfig 
		{
			m_upperOffset = upperOffset;
			m_lowerOffset = lowerOffset;
			return this;
		}
		
		public function getNumSymbol():uint 
		{
			return m_numOfSymbol;
		}
		
		public function setNumSymbol(numOfSymbol:uint):RollerConfig 
		{
			m_numOfSymbol = numOfSymbol;
			return this;
		}
		
		public function getRollerTape():RollerTape
		{
			return m_rollerTape;
		}
		
		public function setRollerTape(rollerTape:RollerTape):RollerConfig
		{
			m_rollerTape = rollerTape;
			return this;
		}
		
		public function getRollerContainer():DisplayObjectContainer
		{
			return m_rollerContainer;
		}
		
		public function setRollerContainer(rollerContainer:DisplayObjectContainer):RollerConfig
		{
			m_rollerContainer = rollerContainer;
			return this;
		}
		
		public function getRollerVelocity():RollerVelocity 
		{
			return m_rollerVelocity;
		}
		
		public function setRollerVelocity(value:RollerVelocity):RollerConfig 
		{
			m_rollerVelocity = value;
			return this;
		}
		
		public function getRollerBlur():RollerBlur 
		{
			return m_rollerBlur;
		}
		
		public function setRollerBlur(value:RollerBlur):RollerConfig 
		{
			m_rollerBlur = value;
			return this;
		}
		
		public function getDispRect():Rectangle 
		{
			return new Rectangle(0, 0, m_dispRect.width * getSourceSymbolSize(), m_dispRect.height * getSourceSymbolSize());;
		}
		
		public function setDispRect(value:Rectangle):RollerConfig 
		{
			m_dispRect = value;
			return this;
		}
		
		public function setSourceSymbolSize(value:Number):RollerConfig 
		{
			m_sourceSizeRatio = value;
			return this;
		}
		
		public function getSourceSymbolSize():Number 
		{
			return m_sourceSizeRatio;
		}
		
	}

}