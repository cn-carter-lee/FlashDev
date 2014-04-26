package
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class CustomEvent extends Event
	{
		public static const EVENT_CUSTOM:String = "event2";
		
		public function CustomEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}