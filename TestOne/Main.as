package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author PYS
	 */
	[Frame(factoryClass="Preloader")]
	
	public class Main extends Sprite
	{
		public function Main():void
		{
			this.addEventListener(Event.ENTER_FRAME, enter);
		}
		
		private function enter(event:Event):void
		{
			var line:PysLine = new PysLine();
			
			this.addChild(line);
			
			line.y = 0;
			
			var line2:PysLine = new PysLine();
			line2.y = 100;
			this.addChild(line2);
			
			var line3:PysLine = new PysLine();
			line3.y = 200;
			this.addChild(line3);
			
			var bar1:PysBar = new PysBar(line, line2);
			this.addChild(bar1);
			line.resize();
			line2.resize();
			line3.resize();
			bar1.resize();
		}
	}
}