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
	public class PysHorizonLine extends Sprite
	{
		
		private var _parent:Sprite;
		
		public function PysHorizonLine(p:Sprite)
		{
			_parent = p;
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
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
		}
		
		public function resize():void
		{
			drawLine(0x000000);
		}
		
		private function drawLine(color:uint):void
		{
			var x:Number = _parent.x;
			var y:Number = 0;
			var incremental:Number = 5;
			this.graphics.clear();
			this.graphics.moveTo(x, y);
			this.graphics.lineStyle(2, color, 1, false);
			
			while (x < (stage.stageWidth))
			{
				this.graphics.lineTo(x, y);
				x += incremental;
				this.graphics.moveTo(x, y);
				x += incremental;
			}
		}
		
		private function mouseOver(event:MouseEvent):void
		{
			drawLine(0xCCCCCC);
		}
		
		private function mouseOut(event:Event):void
		{
			drawLine(0x000000);
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