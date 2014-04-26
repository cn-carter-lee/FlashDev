package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class ChartTitle extends Sprite
	{
		public function ChartTitle()
		{
			this.graphics.clear();
			this.graphics.beginFill(0x0000FF, 1);
			this.graphics.drawRect(0, 0, 50, 50);
			this.graphics.endFill();
			
			this.addEventListener(MouseEvent.CLICK, clickFun);
		}
		
		private function clickFun(event:MouseEvent):void
		{
			trace("GGGGG!!!!!");
		}
	}

}