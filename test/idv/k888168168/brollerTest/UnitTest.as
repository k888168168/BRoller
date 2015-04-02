package idv.k888168168.brollerTest 
{
	import com.bit101.components.ComboBox;
	import com.bit101.components.HRangeSlider;
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author gos0495
	 */
	
	[SWF(width=600, height=450, backgroundColor=0xEFEFEF, frameRate=30)]	
	public class UnitTest extends Sprite
	{
		private var roller:RollerMgr;
		private var inputVel:HUISlider;
		private var inputBlur:HUISlider;
		private var selectBulr:ComboBox;
		private var copyBtn:PushButton;
		private var msg:Label;
		private var pauseBtn:PushButton;
		private var startBtn:PushButton;
		
		public function UnitTest() 
		{
			var mc:MovieClip = addChild(new MovieClip()) as MovieClip;
			var sp1:MovieClip = new MovieClip();
			sp1.name = "mcRoller0";
			sp1.x = 0;
			var sp2:MovieClip = new MovieClip();
			sp2.name = "mcRoller1";
			sp2.x = 150;
			var sp3:MovieClip = new MovieClip();
			sp3.name = "mcRoller2";
			sp3.x = 300;
			
			mc.x = 80;
			mc.y = 50;
			mc.addChild(sp1);
			mc.addChild(sp2);
			mc.addChild(sp3);
			
			roller = new RollerMgr(sp1, sp2, sp3);
			
			roller.initEvt();
			roller.initRoller([0, 0, 0]);
			roller.startRoller([3, 3, 3]);
			
			this.graphics.lineStyle(2, 0);
			this.graphics.drawRect(80, 50, mc.width, mc.height - 30);
			
			Style.embedFonts = false;
			Style.fontName = null;
			Style.fontSize = 14;
			
			inputVel = new HUISlider();
			addChild(inputVel);
			inputVel.addEventListener(Event.CHANGE, onVelChange);
			inputVel.label = "速度";
			inputVel.value = 0.6;
			inputVel.minimum = -1.5;
			inputVel.maximum = 1.5;
			inputVel.labelPrecision = 2;
			inputVel.tick = 0.01;
			inputVel.height = 20;
			inputVel.width = 400;
			inputVel.x = 100;
			inputVel.y = 330;
			
			inputBlur = new HUISlider();
			inputBlur.addEventListener(Event.CHANGE, onBlurChange);
			addChild(inputBlur);
			inputBlur.label = "模糊";
			inputBlur.value = 64;
			inputBlur.minimum = 0;
			inputBlur.maximum = 128;
			inputBlur.labelPrecision = 0;
			inputBlur.tick = 1;
			inputBlur.height = 20;
			inputBlur.width = 400;
			inputBlur.x = 100;
			inputBlur.y = 360;
			
			startBtn = new PushButton();
			addChild(startBtn);
			startBtn.addEventListener(MouseEvent.CLICK, onStartClick);
			startBtn.label = "滾輪啟動";
			startBtn.x = 300 - startBtn.width / 2 - 80;
			startBtn.y = 300;
			
			pauseBtn = new PushButton();
			addChild(pauseBtn);
			pauseBtn.addEventListener(MouseEvent.CLICK, onPauseClick);
			pauseBtn.label = "滾輪暫停";
			pauseBtn.x = 300 - pauseBtn.width / 2 + 80;
			pauseBtn.y = 300;
			
			copyBtn = new PushButton();
			addChild(copyBtn);
			copyBtn.addEventListener(MouseEvent.CLICK, onCopyClick);
			copyBtn.label = "複製設定";
			copyBtn.x = 300 - copyBtn.width / 2;
			copyBtn.y = 400;
			
			msg = new Label();
			addChild(msg);
			msg.text = "已複製!";
			msg.autoSize = true;
			msg.x = copyBtn.getRect(this).right + 10;
			msg.y = 400;
			msg.visible = false;
			
			init();
		}
		
		private function onStartClick(e:MouseEvent):void 
		{
			roller.startRoller([-1,-1,-1]);
		}
		
		private function onPauseClick(e:MouseEvent):void 
		{
			roller.pauseRoller(0, true);
			roller.pauseRoller(1, true);
			roller.pauseRoller(2, true);
		}
		
		private function onCopyClick(e:MouseEvent):void 
		{
			var value:String = "";
			value += "Velocity=" + inputVel.value;
			value += ", ";
			value += "Blur=" + inputBlur.value;
			value += "";
			
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, value);
			
			msg.visible = true;
			var t:int = setTimeout(function():void
			{
				clearTimeout(t);
				msg.visible = false;
			}, 3000);
			
		}
		
		private function onBlurChange(e:Event = null):void 
		{
			roller.setBlur(1, inputBlur.value);
			roller.setBlur(2, inputBlur.value);
			roller.setBlur(3, inputBlur.value);
		}
		
		private function onVelChange(e:Event = null):void 
		{
			roller.setVel(1, inputVel.value);
			roller.setVel(2, inputVel.value);
			roller.setVel(3, inputVel.value);
		}
		
		private function init():void 
		{
			onVelChange();
			onBlurChange();
		}
		
		private function createFixBlur():void 
		{
			
		}
		
		private function createMotionBlur():void 
		{
			
		}
		
	}

}