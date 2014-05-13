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
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class Student extends Sprite
	{
		
		[Embed(source="assets/images/user.png")]
		private var StudentIcon:Class;
		private var studentIcon:Bitmap = new StudentIcon();
		
		public var ID:String;
		public var Name:String;
		public var Sort:Number;
		private var textField:TextField;
		private var dragPoint:Point;
		
		public function Student(name:String)
		{
			this.Name = name;
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "宋体,Verdana";
			textFormat.size = 12;
			textFormat.bold = false;
			textFormat.align = "left";
			textFormat.color = 0x555555;
			
			textField = new TextField();
			textField.text = this.Name;
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
		}
		
		private function mouseDown(event:MouseEvent):void
		{
			this.parent.addChild(this);
			Mouse.cursor = "button";
			this.startDrag();
			dragPoint = new Point(this.x, this.y);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoving);
		}
		
		private function mouseMoving(event:MouseEvent):void
		{
			for (var i:Number = 0; i < this.parent.numChildren; i++)
			{
				var obj:Object = this.parent.getChildAt(i);
				if (obj is Student && obj != this)
				{					
					var targetStudent:Student = obj as Student;
					if (this.hitTestObject(targetStudent))
					{
						trace("true");
						return;
					}					
				}
			}
		}
		
		private function mouseUp(event:MouseEvent):void
		{
			this.stopDrag();
			Mouse.cursor = "arrow";
			event.updateAfterEvent();
			Tweener.addTween(this, {x: dragPoint.x, y: dragPoint.y, time: 0.2, transition: "linear"});
		}
		
		private function draw(color:uint, lineThickness:uint):void
		{
			this.graphics.clear();
			this.graphics.beginFill(color, 1);
			if (lineThickness > 0)
				this.graphics.lineStyle(lineThickness, 0x000000);
			var rec:Rectangle = this.getRect(this);
			this.graphics.drawRect(rec.x, rec.y, this.width, this.height);
			this.graphics.endFill();
		}
		
		public function resize():void
		{
		
		}
	}
}