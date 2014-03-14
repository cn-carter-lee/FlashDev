package charts.series.dots
{
	
	public class dot_factory
	{		
		public static function make(index:Number, style:Properties):PointDotBase
		{			
			// There are more types from oriongal project
			switch (style.get('type'))
			{
				
				case 'dot': 
					return new Point(index, style);
					break;
				
				case 'solid-dot': 
					return new PointDot(index, style);
					break;
				
				case 'hollow-dot': 
					return new Hollow(index, style);
					break;
				
				default:		
					return new Point(index, style);
					break;
			}
		}
	}
}