package elements.axis
{
	import flash.display.Sprite;
	
	public class YAxisLeft extends YAxisBase
	{
		
		function YAxisLeft()
		{
		}
		
		public override function init(json:Object):void
		{			
			this.labels = new YAxisLabelsLeft(json);
			this.addChild(this.labels);
			
			// default values for a left axis
			var style:Object = {stroke: 2, 'tick-length': 3, colour: '#000000', offset: false, 'grid-colour': '#CCCCCC', 'grid-visible': true, '3d': 0, steps: 10, visible: true, min: 0, max: 100};
			
			super._init(json, 'y_axis', style);
		}
		
		public override function resize(label_pos:Number, sc:ScreenCoords):void
		{			
			super.resize_helper(label_pos, sc, false);
		}
	}
}