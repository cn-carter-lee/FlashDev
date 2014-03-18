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
	[Frame(factoryClass="Preloader")]
	
	public class Main extends Sprite
	{
		
		private var pysCursor:PysCursor;
		
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
			
			var line1:PysLine = new PysLine();
			this.addChild(line1);
			line1.y = 0;
			
			var line2:PysLine = new PysLine();
			line2.y = 100;
			this.addChild(line2);
			
			var bar1:PysBar = new PysBar(line1, line2);
			this.addChild(bar1);
			
			line1.addEventListener(Event.RESIZE, line1resize);
			
			line1.resize();
			line2.resize();
			bar1.resize();
			
			pysCursor = new PysCursor();
			this.addChild(pysCursor);
			// pysCursor.visible = false;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		
		}
		
		private function line1resize(event:Event):void
		{
			trace("xxxxx");
		}
		
		private function mouseMove(event:MouseEvent):void
		{
			Mouse.hide();
			pysCursor.x = event.stageX;
			pysCursor.y = event.stageY;
		}
	}
}