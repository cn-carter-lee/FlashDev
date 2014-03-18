package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class PysBar extends Sprite
	{
		private var line1:PysLine;
		private var line2:PysLine;
		private var title:TextField;
		
		[Embed(source="images/dragbar_top.png")]
		private var DragBar_Top:Class;
		private var dragbar_top:Bitmap = new DragBar_Top();
		
		[Embed(source="images/dragbar_middle.png")]
		private var DragBar_Middle:Class;
		private var dragbar_middle:Bitmap = new DragBar_Middle();
		
		[Embed(source="images/dragbar_bottom.png")]
		private var DragBar_Bottom:Class;
		private var dragbar_bottom:Bitmap = new DragBar_Bottom();
		
		public function PysBar(line1:PysLine, line2:PysLine)
		{
			this.line1 = line1;
			this.line2 = line2;
			
			title = new TextField();
			title.text = "80%";
			title.background = true;
			title.backgroundColor = 0xFFFFFF;
			
			var fmt:TextFormat = new TextFormat();
			fmt.color = 0x000000;
			fmt.font = "Courier";
			fmt.size = 10;
			fmt.align = "left";
			fmt.bold = true;
			
			title.setTextFormat(fmt);
			title.autoSize = "left";
			title.border = false;
		}
		
		public function resize():void
		{
			var x:Number = line1.x + line1.width - 30;
			var y:Number = line1.y + line1.height;
			var w:Number = 16;
			var h:Number = line2.y - line1.y - line1.height;
			
			this.graphics.clear();
			this.graphics.beginBitmapFill(dragbar_middle.bitmapData);
			this.graphics.drawRect(x, y, w, h);
			
			this.graphics.endFill();
			
			title.x = line1.x + line1.width - 40;
			title.y = line1.y + (line2.y - line1.y - line1.height) / 2;
			this.addChild(title);
			
			dragbar_top.x = x - 2;
			dragbar_bottom.x = x - 2;
			dragbar_bottom.y = h;
			this.addChild(dragbar_top);
			this.addChild(dragbar_bottom);
		}
	}

}