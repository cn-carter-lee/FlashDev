package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class PysLine extends Sprite
	{
		
		public function PysLine()
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		public function mouseMove(event:MouseEvent):void
		{
			return;
			if (dragging)
			{
				pysCusor.x = event.stageX;
				pysCusor.y = event.stageY;
				pysCusor.visible = true;
			}
			else
				pysCusor.visible = false;
			
			trace(event.stageX);
			trace(event.stageY);
		
		}
		
		public function resize():void
		{
			drawLine(0x00FF00);
		}
		
		private function drawLine(color:uint):void
		{
			this.graphics.clear();
			this.graphics.beginFill(color, 1);
			this.graphics.drawRect(0, 0, stage.stageWidth, 5);
			this.graphics.endFill();
		}
		
		private function mouseOver(event:MouseEvent):void
		{
			drawLine(0xCCCCCC);
			Mouse.hide();
		}
		
		private function mouseOut(event:Event):void
		{
			// pysCusor.visible = false;
			Mouse.show();
			return;
			drawLine(0x00FF00);
			Mouse.cursor = "arrow";
			// trace(this.width);		
		}
		
		private function mouseDown(event:Event):void
		{
			Mouse.cursor = "button";
			var rec:Rectangle = new Rectangle(0, 0, 0, 1200);
			this.startDrag(false, rec);
		}
		
		private function mouseUp(event:Event):void
		{
			Mouse.cursor = "arrow";
			this.stopDrag();
			
			
			
			var s:Shape = new Shape();
			
			
		}
	}
}