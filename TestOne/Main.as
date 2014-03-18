package
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class Main extends Sprite
	{
		private var line1:PysLine
		private var line2:PysLine;
		private var bar1:PysBar;
		
		private var dragCursor:DragCursor = new DragCursor();
		public var dragging:Boolean = false;
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			line1 = new PysLine();
			this.addChild(line1);
			line1.y = 0;
			
			line2 = new PysLine();
			line2.y = 100;
			this.addChild(line2);
			
			bar1 = new PysBar(line1, line2);
			this.addChild(bar1);
			
			line1.addEventListener(Event.RESIZE, line1resize);
			
			line1.resize();
			line2.resize();
			bar1.resize();
			
			this.addChild(dragCursor);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(Event.RESIZE, resize);
		}
		
		private function resize(event:Event):void
		{
			line1.resize();
			line2.resize();
			bar1.resize();
		}
		
		private function line1resize(event:Event):void
		{
		
		}
		
		private function mouseMove(event:MouseEvent):void
		{
			// Mouse.hide();
			dragCursor.x = event.stageX;
			dragCursor.y = event.stageY;
			bar1.resize();			
		}
	}
}