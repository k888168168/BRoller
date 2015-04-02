package idv.k888168168.broller.blur 
{
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import idv.k888168168.broller.utils.RollerMode;
	import idv.k888168168.broller.utils.RollerVelocity;
	/**
	 * 滾輪模糊濾鏡
	 * @author gos0495
	 */
	public class RollerBlur 
	{
		protected var rectangle:Rectangle;
		protected var point:Point;
		protected var filter:BlurFilter;
		protected var mode:RollerMode;
		protected var rollerVelocity:RollerVelocity;
		
		public function RollerBlur(blurX:Number = 0, blurY:Number = 32, quality:int = 1)
		{
			rectangle = new Rectangle();
			point = new Point();
			filter = new BlurFilter(blurX, blurY, quality);
		}
		
		public function applyFilter(targetBitmapData:BitmapData, sourceBitmapData:BitmapData):void
		{
			if (mode.equalTo(RollerMode.ROLLING)) {
				targetBitmapData.applyFilter(sourceBitmapData, rectangle, point, filter);
			}
		}
		
		public function setRectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0):void
		{
			rectangle.x = x;
			rectangle.y = y;
			rectangle.width = width;
			rectangle.height = height;
		}
		
		public function setPoint(x:Number = 0, y:Number = 0):void
		{
			point.x = x;
			point.y = y;
		}
		
		public function setBlur(blurX:Number = 0, blurY:Number = 32, quality:int = 1):void 
		{
			filter.blurX = blurX;
			filter.blurY = blurY;
			filter.quality = quality;
		}
		
		public function setMode(_mode:RollerMode):void 
		{
			mode = _mode;
		}
		
		public function setRollerVelocity(_rollerVelocity:RollerVelocity):void 
		{
			rollerVelocity = _rollerVelocity;
		}
		
	}

}