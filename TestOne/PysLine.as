package
{
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
		private var pysCusor:PysCursor = new PysCursor();
		public var dragging:Boolean = false;
		
		public function PysLine()
		{
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
			pysCusor.visible = true;
			this.addChild(pysCusor);
			
			dragging = true;
		}
		
		public function mouseMove(event:MouseEvent):void
		{
			if (dragging)
			{
				pysCusor.x = event.stageX;
				pysCusor.y = event.stageY;
				pysCusor.visible = true;				
			}
			else
				pysCusor.visible = false;
		
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
		
		private function mouseOver(event:MouseEvent):void
		{
			//pysCusor.visible = true;
			
			//pysCusor.x = event.stageX;
			//pysCusor.y = event.stageY;
			
			drawLine(0xCCCCCC);
			Mouse.hide();
		
		}
		
		private function mouseOut(event:Event):void
		{
			pysCusor.visible = false;
			Mouse.show();
			return;
			drawLine(0x00FF00);
			Mouse.cursor = "arrow";
			trace(this.width);
		
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
		}
	}
}