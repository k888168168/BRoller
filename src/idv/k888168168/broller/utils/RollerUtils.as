package idv.k888168168.broller.utils 
{
	/**
	 * ...
	 * @author ...
	 */
	public final class RollerUtils 
	{
		
		/**
		 * 校正curr, 使其範圍落在0~len之間
		 * @param	curr
		 * @param	len
		 * @return
		 */
		static public function fixLength(curr:Number, len:Number):Number 
		{
			curr %= len;
			if (curr < 0) {
				curr += len;
			}
			return curr;
		}
		
		public function RollerUtils() 
		{
			
		}
		
	}

}