package data
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DataLoadEvent extends Event
	{
		public static const ON_LOADED:String = "onLoaded";
		
		public var dataObject:Object;
		
		public function DataLoadEvent(type:String):void
		{
			super(type);
		}
	}
}