package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class PysCursor extends Sprite
	{
		[Embed(source="images/cursor.png")]
		private var layer0Class:Class;
		private var layer0:Bitmap = new layer0Class();
		
		public function PysCursor()
		{
			this.addChild(layer0);
		/*
		   this.graphics.clear();
		   this.graphics.beginFill(0xFF0000, 1);
		   this.graphics.drawRect(0, 0, 10, 10);
		   this.graphics.endFill();
		 */
		}
	}

}