package idv.k888168168.broller.blur 
{
	import flash.display.BitmapData;
	import idv.k888168168.broller.utils.RollerMode;
	/**
	 * 模糊程度隨著速度改變
	 * @author gos0495
	 */
	public class MotionBlur extends RollerBlur 
	{
		private var maxBlurY:Number;
		private var maxVelocity:Number;
		
		public function MotionBlur(maxBlurY:Number=64, maxVelocity:Number = 0.6) 
		{
			this.maxBlurY = maxBlurY;
			this.maxVelocity = maxVelocity;
			super(0, maxBlurY, 1);
			
		}
		
		override public function applyFilter(targetBitmapData:BitmapData, sourceBitmapData:BitmapData):void 
		{
			if (mode.equalTo(RollerMode.ROLLING)) {
				var ratio:Number = Math.abs(rollerVelocity.getCurrentVelocity() / maxVelocity);
				ratio = ratio > 1 ? 1 :ratio;
				filter.blurY = int(ratio * maxBlurY);
				targetBitmapData.applyFilter(sourceBitmapData, rectangle, point, filter);
			}
		}
		
		public function setMaxBlurY(value:Number):void 
		{
			maxBlurY = value;
		}
		
	}

}