package idv.k888168168.broller.utils 
{
	/**
	 * ...
	 * @author gos0495
	 */
	public class RollerRenderDataPool 
	{
		private static var _instance:RollerRenderDataPool;
		public static function getInstance():RollerRenderDataPool {
			if (!_instance) _instance = new RollerRenderDataPool();
			return _instance;
		}
		
		private var _array:Array;
		private var _position:int;
		
		public function RollerRenderDataPool() 
		{
			_array = [createNewData()];
			_position = 0;
		}
		
		private function createNewData():RollerRenderData 
		{
			return new RollerRenderData()
		}
		
		public final function get():RollerRenderData {
			if (_position == _array.length) {
				_array.length <<= 1;
				
				for (var i:int = _position; i < _array.length; i++) {
					_array[i] = createNewData();
				}
			}
			_position++;
			
			return _array[_position - 1];
		}
		
		public final function recycle(data:RollerRenderData):void {
			if (_position == 0) return;
			_array[_position - 1] = data;
			data.sourceRect.setEmpty();
			if (_position) _position--;
		}
		
	}

}