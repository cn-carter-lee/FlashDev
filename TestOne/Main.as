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
			line = new PysLine();
			this.addChild(line);
		}
	}
}