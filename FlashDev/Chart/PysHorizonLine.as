package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.external.ExternalInterface;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class PysHorizonLine extends Sprite
	{
		private var _parent:Sprite;
		private var _rectangle:Rectangle;
		private var _backgroundColor:uint = 0xFFFFFF;
		private var _lineColor:uint = 0x000000;
		private var _incremental:Number = 5;
		private var _thickness:Number = 2;
		private var _columnIndex:Number;
		
		public function PysHorizonLine(columnIndex:Number, lineColor:uint=0x000000)
		{
			this._columnIndex = columnIndex;
			this._lineColor = lineColor;
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		
		public function resize(rectangle:Rectangle):void
		{
			_rectangle = rectangle;
			drawLine();
		}
		
		private function drawLine():void
		{
			var x:Number = _rectangle.x;
			var y:Number = 0;
			
			this.graphics.clear();
			this.graphics.moveTo(x, y);
			this.graphics.lineStyle(_thickness, _lineColor, 1, false);
			var temp:Number = x;
			while (x < _rectangle.right)
			{
				this.graphics.lineTo(x, y);
				this.graphics.lineStyle(_thickness, x % 2 == 0 ? _lineColor : _backgroundColor, 1, false);
				x += _incremental;
			}
		}
		
		private function mouseOver(event:MouseEvent):void
		{
			event.stopPropagation();
			Mouse.cursor = "button";
			this.callExternalCallback("selectColumn", this._columnIndex);
		}
		
		private function mouseOut(event:Event):void
		{
			event.stopPropagation();
			Mouse.cursor = "arrow";
			this.callExternalCallback("unselectColumn", this._columnIndex);
		
		}
		
		private function mouseDown(event:Event):void
		{
			var rec:Rectangle = new Rectangle(0, 0, 0, 1200);
			this.startDrag(false, rec);
			event.stopPropagation();
		}
		
		private function mouseUp(event:Event):void
		{
			event.target.stopDrag();
			event.stopPropagation();
		}
		
		private function callExternalCallback(functionName:String, ... optionalArgs):*
		{
			// the debug player does not have an external interface because it is NOT embedded in a browser	
			
			if (ExternalInterface.available)
				return ExternalInterface.call(functionName, optionalArgs);
		}
	}
}