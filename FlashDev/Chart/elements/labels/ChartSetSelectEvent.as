package elements.labels
{
	import flash.events.Event;	
	
	/**
	 * ...
	 * @author PYS
	 */
	public class ChartSetSelectEvent extends Event
	{
		public static const SELECTED:String = "select";		
		public var identifier:Number;
		public var chartNavType:String;
		
		public function ChartSetSelectEvent(type:String, chartNavType:String,identifier:Number)
		{
			this.identifier = identifier;
			this.chartNavType = chartNavType;
			super(type, true, true);
		}
	}
}