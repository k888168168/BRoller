package idv.k888168168.broller.utils 
{
	import flash.display.BitmapData;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import idv.k888168168.broller.utils.RollerMode;
	/**
	 * ...
	 * @author ...
	 */
	public class RollerSymbolAtlas 
	{
		static public const NORMAL:String = "normal";
		static public const DARK:String = "dark";
		static public const LIGHT:String = "light";
		
		private var m_name:String;
		private var m_mode:RollerMode;
		private var m_sources:Object;
		private var m_symbolBuffers:Object;
		private var m_tapeBuffer:Object;
		private var m_width:Number = 304;
		private var m_height:Number = 140;
		
		public function RollerSymbolAtlas(name:String) 
		{
			m_name = name;
			m_sources = { };
			m_symbolBuffers = { };
			m_tapeBuffer = { };
		}
		
		public function getName():String 
		{
			return m_name;
		}
		
		public function getWidth():Number 
		{
			return m_width;
		}
		
		public function getHeight():Number 
		{
			return m_height;
		}
		
		public function getCls(mode:RollerMode):Class 
		{
			return m_sources[mode.value];
		}
		
		/**
		 * 建立滾輪模式與Symbol類的關聯, 並buffer點陣圖
		 * @param	mode	滾輪模式
		 * @param	cls		Symbol類
		 * @return
		 */
		public function mapCls(mode:RollerMode, cls:Class):RollerSymbolAtlas 
		{
			if(cls) {
				
				// check buffer already draw.
				for (var name:String in m_sources) 
				{
					// If already have buffer, use this.
					if (m_sources[name] === cls) {
						
						m_sources[mode.value] = cls;
						m_symbolBuffers[mode.value] = m_symbolBuffers[name];
						return this;
					}
				}
				
				// draw buffer
				m_sources[mode.value] = cls;
				m_symbolBuffers[mode.value] = { };
				
				var temp:MovieClip = new cls();
				//m_width = temp.width;
				//m_height = temp.height;
				var labels:Array = temp.currentLabels;
				for (var i:int = 0; i < labels.length; i++) 
				{
					var frameLabel:FrameLabel = labels[i];
					var buffer:BitmapData = new BitmapData(m_width, m_height, true , 0x00000000);
					temp.gotoAndStop(frameLabel.frame);
					var mtx:Matrix = new Matrix();
					mtx.translate((m_width - temp.width) / 2, (m_height - temp.height) / 2);
					buffer.draw(temp, mtx, null, null, null, true);
					m_symbolBuffers[mode.value][frameLabel.name.slice(1)] = buffer;
				}
			}
			return this;
		}
		
		public function getCurrentBuffer():BitmapData 
		{
			return m_tapeBuffer[m_mode.value] || m_tapeBuffer[RollerMode.IDLE.value];
		}
		
		public function getTotalHeight():Number 
		{
			return getCurrentBuffer().height;
		}
		
		public function setMode(mode:RollerMode):void 
		{
			m_mode = mode;
		}
		
		internal function createTapeBuffer(tapeIndex:Array):void 
		{
			var cls:Class;
			
			for (var mode:String in m_sources) 
			{
				cls = m_sources[mode];
				
				// check buffer already draw.
				for (var name:String in m_sources) 
				{
					// If already have buffer, use this.
					if (m_sources[name] === cls) {
						
						if(m_tapeBuffer[name]) { 
							m_tapeBuffer[mode] = m_tapeBuffer[name];
							break;
						}
					}
				}
				
				if (m_tapeBuffer[mode]) 
					continue;
				else {
					var buffer:BitmapData = new BitmapData(getWidth(), getHeight() * tapeIndex.length, true, 0x00000000);
					m_tapeBuffer[mode] = buffer;
				}
					
				
				var destY:Number = 0;
				for (var i:int = 0; i < tapeIndex.length; i++) 
				{
					var idx:int = tapeIndex[i];
					var symbolBuffer:BitmapData = m_symbolBuffers[mode][idx];
					
					buffer.copyPixels(symbolBuffer, symbolBuffer.rect, new Point(0, destY));
					
					destY += symbolBuffer.height;
				}
				
			}
			
		}
		
	}

}