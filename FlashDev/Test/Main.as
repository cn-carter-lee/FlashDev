package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class Main extends Sprite
	{
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.addEventListener(CustomEvent.SENDFLOWER, customFun);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var topNav:TopNavigation = new TopNavigation();
			this.addChild(topNav);
		
		}
		
		private function customFun(event:CustomEvent):void
		{
			trace("Here is the right place!!!!!");
		}
	
	}

}