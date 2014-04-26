package elements.labels
{
	import charts.ChartSetBase;
	import charts.ChartSetCollection;
	import charts.PysChartSetCollection;
	import charts.series.has_tooltip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.flashdevelop.utils.FlashConnect;
	
	public class ChartSetNames extends Sprite implements IResizableObj
	{
		private var _height:Number = 0;
		public var colours:Array;
		public var selectedIdentifier:Number = -1;
		
		public function ChartSetNames(jsonNav:Object)
		{			
			while (this.numChildren > 0)
				this.removeChildAt(0);
			for (var i:Number = 0; i < jsonNav.length; i++)
			{
				if (i > 0)
					this.addChild(new ChartNavSeparator());
				this.addChild(new ChartSetName(0, 0, jsonNav[i].text, jsonNav[i].type));
			}
		/*
		   this.addChild(new ChartSetName(0, 0, "", ChartNavType.Exams));
		   this.addChild(new ChartNavSeparator());
		   this.addChild(new ChartSetName(0, 0, "", ChartNavType.Exam));
		   this.addChild(new ChartNavSeparator());
		   this.addChild(new ChartSetName(0, 0, "", ChartNavType.ClassScore));
		 */
		}
		
		public function die():void
		{
			this.graphics.clear();
			while (this.numChildren > 0)
				this.removeChildAt(0);
		}
		
		public function resize():void
		{
			var height:Number = 0;
			var x:Number = 0;
			var y:Number = 0;
			this.graphics.clear();
			for (var i:Number = 0; i < this.numChildren; i++)
			{
				var width:Number = this.getChildAt(i).width;
				
				if ((this.x + x + width + 12) > this.stage.stageWidth)
				{
					// it is past the edge of the stage, so move it down a line
					x = 0;
					y += this.getChildAt(i).height;
					height += this.getChildAt(i).height;
				}
				
				this.getChildAt(i).x = x;
				this.getChildAt(i).y = y;
				// move next key to the left + some padding between keys
				x += width + 10;
			}
			// Ugly code:
			height += this.getChildAt(0).height;
			this._height = height;
			
			this.x = 0;
			this.y = 6;
		}
	}
}