package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class Blackboard extends Sprite
	{
		[Embed(source="assets/images/blackboard.png")]
		private var BlackboardIcon:Class;
		private var blackboardIcon:Bitmap = new BlackboardIcon();
		
		public function Blackboard()
		{
			this.addChild(blackboardIcon);
		}
	
	}

}