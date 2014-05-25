package
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	
	public class Platform extends Sprite
	{
		[Embed(source="assets/images/platform.png")]
		private var PlatformIcon:Class;
		private var platform:Bitmap = new PlatformIcon();
		
		public function Platform()
		{
			this.addChild(platform);
		}
	}
}