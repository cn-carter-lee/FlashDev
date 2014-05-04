package
{
	import flash.display.Bitmap;
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
	public class Student extends Sprite
	{
		
		[Embed(source="assets/images/user.png")]
		private var StudentIcon:Class;
		private var studentIcon:Bitmap = new StudentIcon();
		
		public var no:String;
		public var text:String;
		
		private var textField:TextField;
		
		public function Student(text:String)
		{
			this.text = " " + text;
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "宋体,Verdana";
			textFormat.size = 12;
			textFormat.bold = false;
			textFormat.align = "left";
			textFormat.color = 0x555555;
			
			textField = new TextField();
			textField.text = this.text;
			textField.border = false;
			textField.borderColor = 0xCCCCCC;
			textField.setTextFormat(textFormat);
			
			textField.autoSize = "center";
			//textField.x = 0;
			//textField.y = 40;
			this.addChild(textField);
			
			this.addChild(studentIcon);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, function(event:MouseEvent):void
				{
					draw(0xff0000, 2);
					Mouse.cursor = "button";
				});
			this.addEventListener(MouseEvent.MOUSE_OUT, function(event:MouseEvent):void
				{
					draw(0xffffff, 0);
					Mouse.cursor = "arrow";
				});
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private function mouseDown(event:Event):void
		{
			this.startDrag();
		}
		
		private function mouseUp(event:Event):void
		{
			try
			{
				this.stopDrag();
			}
			catch (error:Error)
			{
			}
		}
		
		private function draw(color:uint, lineThickness:uint):void
		{
			trace(this.width);
			trace(this.height);
			this.graphics.clear();
			this.graphics.beginFill(color, 1);
			if (lineThickness > 0)
				this.graphics.lineStyle(lineThickness, 0x000000);
			this.graphics.drawRect(this.x, this.y, this.width, this.height);
			this.graphics.endFill();
		}
		
		public function resize():void
		{
			studentIcon.x = this.x;
			studentIcon.y = this.y;
			
			textField.x = this.x;
			textField.y = this.y + 40;
		}
	}
}