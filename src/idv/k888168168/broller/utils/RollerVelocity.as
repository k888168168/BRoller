package idv.k888168168.broller.utils 
{
	import idv.k888168168.broller.utils.RollerMode;
	/**
	 * 滾輪速度
	 * @author gos0495
	 */
	public class RollerVelocity 
	{
		protected var _maxVel:Number;
		protected var mode:RollerMode;
		
		public function RollerVelocity(maxVel:Number = 1.2)
		{
			_maxVel = maxVel;
		}
		
		public function getCurrentVelocity():Number 
		{
			if (!mode.equalTo(RollerMode.IDLE) && !mode.equalTo(RollerMode.PAUSE)) {
				return _maxVel;
			}
			return 0;
		}
		
		public function setMode(_mode:RollerMode):void 
		{
			mode = _mode;
		}
		
		public function setMaxVelocity(value:Number):void 
		{
			_maxVel = value;
		}
		
	}

}