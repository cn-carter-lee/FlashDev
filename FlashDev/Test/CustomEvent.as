package
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class CustomEvent extends Event
	{
		public static const SENDFLOWER:String = "sendFlower";
		
		public static const SENDCAR:String = "sendCar";
		
		public var info:String;
		
		public function CustomEvent(type:String)
		{
			super(type, true, true);			
		}
	}
}