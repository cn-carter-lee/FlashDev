package
{
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class PysVerticalBar extends Sprite
	{
		
		public var showText:String = "";
		
		public var line1:PysHorizonLine;
		public var line2:PysHorizonLine;
		private var title:TextField;
		
		[Embed(source="assets/images/dragbar_top.png")]
		private var DragBar_Top:Class;
		private var dragbar_top:Bitmap = new DragBar_Top();
		
		[Embed(source="assets/images/dragbar_middle.png")]
		private var DragBar_Middle:Class;
		private var dragbar_middle:Bitmap = new DragBar_Middle();
		
		[Embed(source="assets/images/dragbar_bottom.png")]
		private var DragBar_Bottom:Class;
		private var dragbar_bottom:Bitmap = new DragBar_Bottom();
		
		public function PysVerticalBar(l1:PysHorizonLine, l2:PysHorizonLine)
		{
			line1 = l1;
			line2 = l2;
			
			title = new TextField();
			title.text = showText;
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
			title.border = true;
		}
		
		public function resize():void
		{
			var x:Number = line1.x + line1.width+10;
			dragbar_middle.x = x;
			dragbar_middle.y = line1.y + line1.height;
			dragbar_middle.height = line2.y - line1.y - line1.height;
			this.addChild(dragbar_middle);
			
			dragbar_top.x = x;
			dragbar_top.y = line1.y + line1.height;
			this.addChild(dragbar_top);
			
			dragbar_bottom.x = x;
			dragbar_bottom.y = line2.y - dragbar_bottom.height;
			this.addChild(dragbar_bottom);
			
			title.x = x + dragbar_middle.width / 2 - title.width / 2;
			title.y = line1.y + line1.height + dragbar_middle.height / 2;

			title.text = showText;
			
			this.addChild(title);
		}
	}

}