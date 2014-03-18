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
		[Embed(source="images/cursor_resize.png")]
		private var layer0Class:Class;
		private var layer0:Bitmap = new layer0Class();
		
		public function PysCursor()
		{
			this.addChild(layer0);
		}
	}

}