package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class DragCursor extends Sprite
	{
		[Embed(source="images/drag.png")]
		private var layerClass:Class;
		private var layer:Bitmap = new layerClass();
		
		public function DragCursor()
		{
			this.addChild(layer);
		}
	}

}