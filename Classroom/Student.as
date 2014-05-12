package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
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
		private var is_draging:Boolean;
		
		public function Student(text:String)
		{
			this.is_draging = false;
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
			this.addChild(textField);
			this.addChild(studentIcon);
			
			studentIcon.x = 0;
			studentIcon.y = 0;
			textField.x = 0;
			textField.y = 40;
			
			/* */
			this.addEventListener(MouseEvent.MOUSE_OVER, function(event:MouseEvent):void
				{
					draw(0xCCCCCC, 2);
				
				});
			this.addEventListener(MouseEvent.MOUSE_OUT, function(event:MouseEvent):void
				{
					draw(0xffffff, 0);
				
				});
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		}
		
		private function mouseDown(event:MouseEvent):void
		{
			this.parent.addChild(this);
			Mouse.cursor = "button";
			this.startDrag();
			this.is_draging = true;
		}
		
		private function mouseMove(event:MouseEvent):void
		{
		
		}
		
		private function mouseUp(event:MouseEvent):void
		{
			this.stopDrag();
			Mouse.cursor = "arrow";
			this.is_draging = false;
			
			event.updateAfterEvent();
			// this.resize();
		}
		
		private function draw(color:uint, lineThickness:uint):void
		{
			var targetPoint:Point = this.parent.localToGlobal(new Point(0, 0));
			
			trace("this:x=" + this.x.toString() + ",y=" + this.y);
			trace("targetPoint:x=" + targetPoint.x.toString() + ",y=" + targetPoint.y);
			
			trace("student:x=" + studentIcon.x.toString() + ",y=" + studentIcon.y);
			trace("parent:x=" + this.parent.x.toString() + ",y=" + this.parent.y);
			trace("........................................");
			this.graphics.clear();
			this.graphics.beginFill(color, 1);
			//if (lineThickness > 0)
			//this.graphics.lineStyle(lineThickness, 0x000000);
			//this.graphics.drawRect(topLeftStage.x, topLeftStage.y, this.width, this.height);
			// this.graphics.drawRect(targetPoint.x+this.x, targetPoint.y+this.y, this.width, this.height);
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