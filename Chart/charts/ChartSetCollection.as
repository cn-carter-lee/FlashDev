package charts
{
	import charts.series.Element;
	import flash.geom.Point;
	import elements.axis.XAxisLabels;
	
	public class ChartSetCollection
	{
		public var sets:Array;
		public var groups:Number;
		
		public function ChartSetCollection()
		{
			this.sets = new Array();
		}
		
		public function add(chartSet:ChartSetBase):void
		{
			this.sets.push(chartSet);
		}
		
		public function get_max_x():Number
		{
			var max:Number = Number.MIN_VALUE;
			for each (var chartSet:ChartSetBase in this.sets)
				max = Math.max(max, chartSet.get_max_x());
			return max;
		}
		
		public function get_min_x():Number
		{
			var min:Number = Number.MAX_VALUE;
			for each (var chartSet:ChartSetBase in this.sets)
				min = Math.min(min, chartSet.get_min_x());
			return min;
		}
		
		// get x, y co-ords of vals
		public function resize(sc:ScreenCoordsBase):void
		{
			for each (var chartSet:ChartSetBase in this.sets)
				chartSet.resize(sc);
		}
		
		// Tell each set to update the tooltip string and replace all #x_label# with the label,@param labels		
		public function tooltip_replace_labels(labels:XAxisLabels):void
		{
			for each (var chartSet:ChartSetBase in this.sets)
				chartSet.tooltip_replace_labels(labels);
		}
		
		public function mouse_out():void
		{
			for each (var chartSet:ChartSetBase in this.sets)
				chartSet.mouse_out();
		}
		
		// Usually this will return an Array of one Element to
		// the Tooltip, but some times 2 (or more) Elements will
		// be on top of each other		
		public function get_closest_elements(x:Number, y:Number):Array
		{
			var e:Element;
			var s:ChartSetBase;
			var p:flash.geom.Point;
			// get closest points from each data set
			var closest:Array = new Array();
			for each (s in this.sets)
			{
				var tmp:Array = s.closest_2(x, y);
				for each (e in tmp)
					closest.push(e);
			}
			
			// find closest point along X axis different sets may return Elements in different X locations
			var min_x:Number = Number.MAX_VALUE;
			for each (e in closest)
			{
				p = e.get_mid_point();
				min_x = Math.min(min_x, Math.abs(x - p.x));
			}
			
			// filter out the Elements that are too far away along the X axis
			var good_x:Array = new Array();
			for each (e in closest)
			{
				
				p = e.get_mid_point();
				if (Math.abs(x - p.x) == min_x)
					good_x.push(e);
			}
			
			// now get min_y from filtered array
			var min_y:Number = Number.MAX_VALUE;
			for each (e in good_x)
			{
				
				p = e.get_mid_point();
				min_y = Math.min(min_y, Math.abs(y - p.y));
			}
			
			// now filter out any that are not min_y
			var good_x_and_y:Array = new Array();
			for each (e in good_x)
			{				
				p = e.get_mid_point();
				if (Math.abs(y - p.y) == min_y)
					good_x_and_y.push(e);
			}			
			return good_x_and_y;
		}		
		
		// To stop memory leaks we explicitly kill all our children			
		public function die():void
		{
			for each (var chartSet:ChartSetBase in this.sets)
				chartSet.die();
		}
	}
}