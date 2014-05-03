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
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			for (var i:Number = 0; i < 8; i++)
			{
				var student:Student = new Student("李雷");				
				this.addChild(student);				
				student.x = i * 35+10;
				student.y = 10;
				student.resize();
			}
		}
		
		private function resize():void
		{

		}
	}

}