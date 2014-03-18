package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class PysLine extends Sprite
	{
		
		public function PysLine()
		{
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		public function resize():void
		{
			drawLine(0x00FF00);
		
		}
		
		private function drawLine(color:uint):void
		{
			var width:Number = this.y;
			this.graphics.clear();
			this.graphics.beginFill(color, 1);
			this.graphics.drawRect(0, 0, this.stage.stageWidth, 5);
			this.graphics.endFill();
		}
		
		private function mouseOver(event:Event):void
		{
			drawLine(0xCCCCCC);
		}
		
		private function mouseOut(event:Event):void
		{
			return;
			drawLine(0x00FF00);
			Mouse.cursor = "arrow";
			trace(this.width);
		}
		
		private function mouseDown(event:Event):void
		{
			Mouse.cursor = "button";
			this.startDrag();
		}
		
		private function mouseUp(event:Event):void
		{
			Mouse.cursor = "arrow";
			this.stopDrag();
		}
	}
}