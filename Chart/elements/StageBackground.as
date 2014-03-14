package elements
{
	
	import flash.display.Sprite;
	import string.Utils;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class StageBackground extends Sprite
	{		
		private var colour:Number;
		
		public function StageBackground(json:Object)
		{
			if (json.bg_colour != undefined)
				this.colour = Utils.get_colour(json.bg_colour);
			else
				this.colour = 0xf8f8d8; // <-- default to Ivory		
		}
		
		public function resize():void
		{
			this.graphics.beginFill(this.colour);
			this.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
		}
		
		public function die():void
		{			
			this.graphics.clear();
		}
	}
}