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
		private var line:PysLine;
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			line = new PysLine();
			this.addChild(line);
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
	
	}

}