package idv.k888168168.brollerTest {
	import idv.k888168168.broller.utils.RollerMode;
	import idv.k888168168.broller.utils.RollerSymbolAtlas;
	import idv.k888168168.broller.utils.RollerTape;
	/**
	 * 滾輪帶
	 * @author gos0495
	 */
	public final class RollerTapeData 
	{
		private static var rollerTapes:Array;
		
		// 設定滾輪帶
		public static const ALL_ROLLER_TAPE:Array = 
		[
			["5", "4", "0", "1", "6", "5", "4", "6", "5", "4", "2", "7", "6", "5", "4", "3", "6", "5", "4", "1", "6"],
			["4", "5", "7", "1", "0", "4", "5", "3", "6", "6", "4", "5", "7", "4", "5", "2", "6", "2", "4", "5", "7"],
			["5", "4", "3", "1", "0", "5", "4", "2", "5", "4", "3", "7", "6", "5", "4", "7", "6", "5", "4", "7", "6"]
		];
		
		public static function getRollerTape(rollerNum:uint):RollerTape {
			if (!rollerTapes) {
				rollerTapes = [];
				
				for (var i:int = 0; i < ALL_ROLLER_TAPE.length; i++) 
				{
					var rt:RollerTape = new RollerTape(ALL_ROLLER_TAPE[i]);
					var dark:RollerSymbolAtlas = new RollerSymbolAtlas(RollerLighting.DARK)
						.mapCls(RollerMode.IDLE, lnk_AllSymbol_Dark)
						.mapCls(RollerMode.ROLLING, lnk_AllSymbol_Dark)
						.mapCls(RollerMode.STOPPING, lnk_AllSymbol_Dark);
					
					var light:RollerSymbolAtlas = new RollerSymbolAtlas(RollerLighting.BRIGHT)
						.mapCls(RollerMode.IDLE, lnk_AllSymbol_Bright)
						.mapCls(RollerMode.ROLLING, lnk_AllSymbol_Bright)
						.mapCls(RollerMode.STOPPING, lnk_AllSymbol_Bright);
					
					var normal:RollerSymbolAtlas = new RollerSymbolAtlas(RollerLighting.NORMAL)
						.mapCls(RollerMode.IDLE, lnk_AllSymbol_Normal)
						.mapCls(RollerMode.ROLLING, lnk_AllSymbol_Normal)
						.mapCls(RollerMode.STOPPING, lnk_AllSymbol_Normal);
						
					rt.addSymbolAtlas(dark);
					rt.addSymbolAtlas(light);
					rt.addSymbolAtlas(normal);
					
					rollerTapes.push(rt);
				}
			}
			
			if (rollerNum > rollerTapes.length) return null;
			
			return rollerTapes[rollerNum] as RollerTape;
		}		
		
		
		public function RollerTapeData() 
		{
			
		}
		
	}

}