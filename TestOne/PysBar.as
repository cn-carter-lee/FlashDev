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
	public class PysBar extends Sprite
	{
		private var line1:PysLine;
		private var line2:PysLine;
		
		public function PysBar(line1:PysLine, line2:PysLine)
		{
			this.line1 = line1;
			this.line2 = line2;
		}
		
		public function resize():void
		{
			var x:Number = line1.x + line1.width - 30;
			var y:Number = line1.y + line1.height;
			var w:Number = 10;
			var h:Number = line2.y - line1.y;
			
			this.graphics.clear();
			this.graphics.beginFill(0x0000FF, 1);
			this.graphics.drawRect(x, y, w, h);
			this.graphics.endFill();
		}
	}

}