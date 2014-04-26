package
{
	import charts.ChartSetCollection;
	import charts.PysChartSetCollection;
	import elements.labels.ChartSetNames;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class TopNavigation extends Sprite
	{
		[Embed(source="assets/images/screenfull.png")]
		private var ScreenFull:Class;
		private var screenFull:Bitmap = new ScreenFull();
		
		[Embed(source="assets/images/screennormal.png")]
		private var ScreenNormal:Class;
		private var screenNormal:Bitmap = new ScreenNormal();
		
		public var chartSetNames:ChartSetNames;
		private var sizeButton:Sprite;
		
		public function TopNavigation(jsonNav:Object)
		{
			this.die();
			this.chartSetNames = new ChartSetNames(jsonNav);
			this.addChild(chartSetNames);
			sizeButton = new Sprite();
			sizeButton.addChild(screenFull);
			this.addChild(sizeButton);
			
			sizeButton.addEventListener(MouseEvent.MOUSE_OVER, function(event:MouseEvent):void
				{
					Mouse.cursor = "button";
				});
			sizeButton.addEventListener(MouseEvent.MOUSE_OUT, function(event:MouseEvent):void
				{
					Mouse.cursor = "arrow";
				});
			
			sizeButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void
				{
					stage.displayState = stage.displayState == StageDisplayState.FULL_SCREEN ? StageDisplayState.NORMAL : StageDisplayState.FULL_SCREEN;
					sizeButton.removeChildren();
					sizeButton.addChild(stage.displayState == StageDisplayState.FULL_SCREEN ? screenNormal : screenFull);
				});
		}
		
		public function resize():void
		{		
			this.graphics.clear();
			// this.graphics.beginFill(0xebeff9, 1);
			this.graphics.beginFill(0xffffff, 1);
			this.graphics.drawRect(0, 0, stage.stageWidth, 30);
			this.graphics.endFill();
			
			sizeButton.x = stage.stageWidth - 20;
			sizeButton.y = 5;
			this.chartSetNames.resize();
		}
		
		public function die():void
		{
			this.graphics.clear();
			while (this.numChildren > 0)
				this.removeChildAt(0);
		}
	}
}