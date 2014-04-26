package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author PYS
	 */
	public class ChartNavSeparator extends Sprite
	{
		private var textField:TextField = new TextField();
		private var textFormat:TextFormat = new TextFormat();
		
		public function ChartNavSeparator()
		{			
			textFormat.color = 0x000000;
			textFormat.font = "宋体,Verdana";
			textFormat.size = 10;
			textFormat.align = "left";
			textFormat.bold = true;
			textField.text = ">>";
			textField.border = false;
			textField.borderColor = 0xCCCCCC;
			textField.setTextFormat(textFormat);
			
			textField.autoSize = "left";
			textField.x += 10;
			this.addChild(textField);
		}	
	}

}