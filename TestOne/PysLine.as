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
			drawLine(0x00FF00);
			this.addEventListener(Event.RESIZE, drawLine);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private function drawLine(color:uint):void
		{
			this.graphics.clear();
			this.graphics.beginFill(color, 1);
			this.graphics.drawRect(0, 0, 1000, 10);
			this.graphics.endFill();
		}
		
		private function mouseOver(event:Event):void
		{
			drawLine(0xFF0000);
			trace(this.width);
			trace(this.height);
		}
		
		private function mouseOut(event:Event):void
		{
			drawLine(0x00FF00);
			Mouse.cursor = "arror";
			trace(this.width);
			trace(this.height);
		
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