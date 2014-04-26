package elements.labels
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
	public class ChartSetName extends Sprite implements IResizableObj
	{
		private var textField:TextField = new TextField();
		private var textFormat:TextFormat = new TextFormat();
		
		public var identifier:Number;
		public var chartNavType:String = "";
		
		public function ChartSetName(x:Number, y:Number, text:String, chartNavType:String)
		{
			this.chartNavType = chartNavType;
			textFormat.color = 0x000000;
			textFormat.font = "宋体,Verdana";
			textFormat.size = 12;
			textFormat.bold = true;
			textFormat.align = "left";
			
			textField.text = text;
			textField.border = false;
			textField.borderColor = 0xCCCCCC;
			textField.setTextFormat(textFormat);
			
			textField.autoSize = "left";
			textField.x += 10;
			this.addChild(textField);
			
			this.addEventListener(MouseEvent.CLICK, mouseClick);
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		
		private function mouseClick(event:MouseEvent):void
		{
			this.dispatchEvent(new ChartSetSelectEvent(ChartSetSelectEvent.SELECTED, this.chartNavType, this.identifier));
		}
		
		private function mouseOver(event:MouseEvent):void
		{
			textFormat.underline = true;
			textFormat.color = 0x555555;
			textField.setTextFormat(textFormat);
			Mouse.cursor = "button";
		}
		
		private function mouseOut(event:MouseEvent):void
		{
			textFormat.underline = false;
			textFormat.color = 0x000000;
			textField.setTextFormat(textFormat);
			Mouse.cursor = "arrow";
		}
		
		public function resize():void
		{
		
		}
	}
}