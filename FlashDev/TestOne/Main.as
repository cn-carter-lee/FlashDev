package
{
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	public class Main extends Sprite
	{
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
			this.addChild(dragCursor);
			dragCursor.visible = false;
			
			var topNav:TopNavigation = new TopNavigation();
			this.addChild(topNav);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);			
			stage.addEventListener(CustomEvent.EVENT_CUSTOM, customFun);
		}
		
		private function customFun():void
		{
		
		}
		
		private function mouseMove(event:MouseEvent):void
		{
			dragCursor.x = event.stageX;
			dragCursor.y = event.stageY;
		}
	}
}