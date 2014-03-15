package
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class PysLine extends Sprite
	{
		public function PysLine()
		{
		this.
		}
		
		public function resize():void
		{
			drawLine();
		}
		
		private function drawLine():void
		{
			
			this.graphics.beginFill(0xFF0000, 1);
			this.graphics.drawRect(0, 0, 100, 10);
			this.graphics.endFill();
		}
	}

}