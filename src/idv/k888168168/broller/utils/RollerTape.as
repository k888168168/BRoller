package idv.k888168168.broller.utils {
	import flash.geom.Rectangle;
	import idv.k888168168.broller.utils.RollerMode;
	import idv.k888168168.broller.utils.RollerRenderData;
	/**
	 * 輪號帶
	 * @author gos0495
	 */
	public class RollerTape 
	{
		private var m_symbolIndex:Array;
		private var m_symbolCls:Class;
		private var m_numOfSymbol:uint;
		private var m_upperOffset:Number;
		private var m_lowerOffset:Number;
		private var m_mode:RollerMode;
		
		private var m_objSymbolAtlas:Object;
		private var m_currentSymbolAtlas:RollerSymbolAtlas;
		private var m_nodes:Array;
		
		/**
		 * @param	symbolIndex	輪號帶陣列, 0BASE
		 */
		public function RollerTape(symbolIndex:Array) 
		{
			m_symbolIndex = symbolIndex;
			m_objSymbolAtlas = { };
		}
		
		/**
		 * 取得渲染的點陣圖
		 * @param	rollerIndex
		 * @return
		 */
		public function getRenderData(rollerIndex:Number):Array 
		{
			var rtn:Array = [];
			
			var width:Number = m_currentSymbolAtlas.getWidth();
			var height:Number = m_currentSymbolAtlas.getHeight();
			var totalHeight:Number = m_currentSymbolAtlas.getTotalHeight();
			
			var upperBoundPxl:Number = rollerIndex * height - m_upperOffset;
			var lowerBoundPxl:Number = (rollerIndex + m_numOfSymbol) * height + m_lowerOffset;
			
			var renderData:RollerRenderData;
			
			//create render data
			//lower超過totalHeight，建立兩段
			if (totalHeight > upperBoundPxl && totalHeight < lowerBoundPxl) {
				
				//上半段
				renderData = RollerRenderDataPool.getInstance().get();
				renderData.sourceBitmapData = m_currentSymbolAtlas.getCurrentBuffer();
				renderData.sourceRect.x = 0;
				renderData.sourceRect.y = upperBoundPxl;
				renderData.sourceRect.width = width;
				renderData.sourceRect.height = totalHeight - upperBoundPxl;
				renderData.destPoint.x = 0;
				renderData.destPoint.y = 0;
				rtn.push(renderData);
				
				//下半段
				renderData = RollerRenderDataPool.getInstance().get();
				renderData.sourceBitmapData = m_currentSymbolAtlas.getCurrentBuffer();
				renderData.sourceRect.x = 0;
				renderData.sourceRect.y = 0;
				renderData.sourceRect.width = width;
				renderData.sourceRect.height = lowerBoundPxl - totalHeight;
				renderData.destPoint.x = 0;
				renderData.destPoint.y = totalHeight - upperBoundPxl;
				rtn.push(renderData);
			} 
			//lower不超過totalHeight，建立兩段
			else if(0 > upperBoundPxl && 0 < lowerBoundPxl) {
				
				//上半段
				renderData = RollerRenderDataPool.getInstance().get();
				renderData.sourceBitmapData = m_currentSymbolAtlas.getCurrentBuffer();
				renderData.sourceRect.x = 0;
				renderData.sourceRect.y = totalHeight + upperBoundPxl;
				renderData.sourceRect.width = width;
				renderData.sourceRect.height = 0 - upperBoundPxl;
				renderData.destPoint.x = 0;
				renderData.destPoint.y = 0;
				rtn.push(renderData);
				
				//下半段
				renderData = RollerRenderDataPool.getInstance().get();
				renderData.sourceBitmapData = m_currentSymbolAtlas.getCurrentBuffer();
				renderData.sourceRect.x = 0;
				renderData.sourceRect.y = 0;
				renderData.sourceRect.width = width;
				renderData.sourceRect.height = lowerBoundPxl;
				renderData.destPoint.x = 0;
				renderData.destPoint.y = 0 - upperBoundPxl;;
				rtn.push(renderData);
			}
			//lower不超過totalHeight，建立一段
			else {
				
				renderData = RollerRenderDataPool.getInstance().get();
				renderData.sourceBitmapData = m_currentSymbolAtlas.getCurrentBuffer();
				renderData.sourceRect.x = 0;
				renderData.sourceRect.y = upperBoundPxl;
				renderData.sourceRect.width = width;
				renderData.sourceRect.height = lowerBoundPxl - upperBoundPxl;
				renderData.destPoint.x = 0;
				renderData.destPoint.y = 0;
				rtn.push(renderData);
			}
			
			return rtn;
		}
		
		public function get length():int
		{
			return m_symbolIndex.length;
		}
		
		public function set numOfSymbol(value:uint):void 
		{
			m_numOfSymbol = value;
		}
		
		public function set upperOffset(value:Number):void 
		{
			m_upperOffset = value;
		}
		
		public function set lowerOffset(value:Number):void 
		{
			m_lowerOffset = value;
		}
		
		/**
		 * 取得symbol index
		 * @param	rollerNum	起始輪號(0-Base)
		 * @param	len			長度,由輪號開始計算
		 * @param	offset		偏移起始輪號
		 * @return
		 */
		public function getSymbolIndex(rollerNum:int, len:int = 1, offset:int = 0):Array 
		{
			//if (rollerNum < 0 || rollerNum >= m_symbolIndex.length) throw new IllegalOperationError("輪號超出範圍! rollerNum="+rollerNum);
			//if (rollerNum < 0 || rollerNum >= m_symbolIndex.length) trace("輪號超出範圍! rollerNum="+rollerNum);
			
			rollerNum += offset;
			
			rollerNum = RollerUtils.fixLength(rollerNum, m_symbolIndex.length);
			
			var index:int = rollerNum;
			var rtn:Array = [];
			
			for (var i:int = 0; i < len; i++) 
			{
				rtn.push(m_symbolIndex[index++]);
				if (index >= m_symbolIndex.length) {
					index = 0;
				}
			}
			
			return rtn;
		}
		
		public function addSymbolAtlas(sa:RollerSymbolAtlas):RollerSymbolAtlas 
		{
			m_objSymbolAtlas[sa.getName()] = sa;
			m_currentSymbolAtlas = sa;
			sa.createTapeBuffer(m_symbolIndex);
			
			return sa;
		}
		
		public function setMode(mode:RollerMode):void 
		{
			m_mode = mode;
			m_currentSymbolAtlas.setMode(m_mode);
		}
		
		public function changeAtlas(name:String):void 
		{
			if(m_objSymbolAtlas[name]) { 
				m_currentSymbolAtlas = m_objSymbolAtlas[name];
				m_currentSymbolAtlas.setMode(m_mode);
			}
		}
		
	}

}