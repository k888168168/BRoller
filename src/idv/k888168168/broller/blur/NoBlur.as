package idv.k888168168.broller.blur 
{
	import flash.display.BitmapData;
	/**
	 * 不使用模糊濾鏡
	 * @author gos0495
	 */
	public class NoBlur extends RollerBlur 
	{
		
		public function NoBlur() 
		{
			super();
		}
		
		override public function applyFilter(targetBitmapData:BitmapData, sourceBitmapData:BitmapData):void 
		{
			//Do nothing
		}
		
	}

}