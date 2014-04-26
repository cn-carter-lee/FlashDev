package charts
{
	import charts.series.Element;
	import flash.display.Sprite;
	import charts.Scatter;
	import charts.Line;
	import flash.geom.Point;
	
	public class PysChartSetCollection extends Sprite
	{
		public var text:String;
		public var scatter:Scatter;
		public var listLine:Array;
		
		public function PysChartSetCollection(json:Object)
		{
			this.listLine = new Array();
			var data:Object = json["charts"];
			var lines:Array = data["lines"] as Array;
			this.text = data["text"];
			this.scatter = new Scatter(data["scatter"]);
			for (var i:Number = 0; i < lines.length; i++)
				this.listLine.push(new Line(lines[i]));
		}
		
		public function get_max_x():Number
		{
			var max:Number = Number.MIN_VALUE;
			max = Math.max(this.scatter.get_max_x(), this.listLine[0].get_max_x());
			return max;
		}
		
		public function get_min_x():Number
		{
			var min:Number = Number.MAX_VALUE;
			min = Math.min(this.scatter.get_min_x(), this.listLine[0].get_min_x());
			return min;
		}
		
		public function resize(sc:ScreenCoordsBase):void
		{
			this.scatter.resize(sc);
			for each (var chartSet:ChartSetBase in this.listLine)
				chartSet.resize(sc);
		}
		
		// Usually this will return an Array of one Element to the Tooltip, but some times 2 (or more) Elements will be on top of each other		
		public function get_closest_elements(x:Number, y:Number):Array
		{
			var element:Element;
			var s:ChartSetBase;
			var p:Point;
			// get closest points from each data set
			var closestElements:Array = new Array();
			var tmpElments:Array = scatter.get_closest(x, y);
			for each (element in tmpElments)
				if (element.parent is Scatter)
					closestElements.push(element);
			// find closest point along X axis different sets may return Elements in different X locations
			var min_x:Number = Number.MAX_VALUE;
			for each (element in closestElements)
			{
				p = element.get_mid_point();
				min_x = Math.min(min_x, Math.abs(x - p.x));
			}
			
			// filter out the Elements that are too far away along the X axis
			var good_x:Array = new Array();
			for each (element in closestElements)
			{
				p = element.get_mid_point();
				if (Math.abs(x - p.x) == min_x)
					good_x.push(element);
			}
			
			// now get min_y from filtered array
			var min_y:Number = Number.MAX_VALUE;
			for each (element in good_x)
			{
				p = element.get_mid_point();
				min_y = Math.min(min_y, Math.abs(y - p.y));
			}
			
			// now filter out any that are not min_y
			var good_x_and_y:Array = new Array();
			for each (element in good_x)
			{
				p = element.get_mid_point();
				if (Math.abs(y - p.y) == min_y)
					good_x_and_y.push(element);
			}
			return good_x_and_y;
		}
		
		public function die():void
		{
			this.scatter.die();
			for each (var chartSet:ChartSetBase in this.listLine)
				chartSet.die();
		}
	}
}