package
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class Boy extends EventDispatcher
	{
		
		public function sendFlower()
		{
			var info:String = "Roses";
			var events = new CustomEvent(CustomEvent.SENDFLOWER, info);
			this.dispatchEvent(events);
		}
		
		public function sendCar()
		{
			var info:String = "Car";
			var events = new CustomEvent(CustomEvent.SENDCAR, info);
			this.dispatchEvent(events);
		}	
	}

}