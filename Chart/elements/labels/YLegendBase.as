package elements.labels
{
	import org.flashdevelop.utils.FlashConnect;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.*;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import string.Utils;
	import string.Css;
	
	import flashx.textLayout.formats.VerticalAlign;
	
	public class YLegendBase extends Sprite
	{
		
		public var tf:TextField;
		
		public var text:String;
		public var style:String;
		private var css:Css;
		
//		[Embed(source = "C:\\Windows\\Fonts\\Verdana.ttf", fontFamily = "foo", fontName = '_Verdana')]
//		private static var EMBEDDED_FONT:String;
		
//		[Embed(systemFont='Arial', fontName='spArial', mimeType='application/x-font')]
//		public static var ArialFont:Class;
		
//		[Embed(systemFont='Arial', fontName='spArial', mimeType='application/x-font')]
		public static var ArialFont:Class;
		
		public function YLegendBase(json:Object, name:String)
		{
			
			if (json[name + '_legend'] == undefined)
				return;
			
			if (json[name + '_legend'])
			{
				object_helper.merge_to_default(json[name + '_legend'], this);
			}
			
			this.css = new Css(this.style);
			
			this.build(this.text);
		}
		
		private function build(text:String):void
		{
			var title:TextField = new TextField();
			
			title.x = 0;
			title.y = 0;
			title.text = text;
			title.htmlText = text;
			
			var fmt:TextFormat = new TextFormat();
			fmt.color = this.css.color;
			fmt.font = this.css.font_family ? this.css.font_family : 'Arial, Helvetica, _sans';
			fmt.bold = this.css.font_weight == 'bold' ? true : false;
			fmt.size = this.css.font_size;
			fmt.blockIndent
			
			title.border = true;
			title.setTextFormat(fmt);
			title.autoSize = "left";
			//title.embedFonts = true;
			//title.rotation = -45;
			title.embedFonts = true;
			title.rotation = 0;
			title.height = title.textHeight;
			title.antiAliasType = AntiAliasType.ADVANCED;
			title.autoSize = TextFieldAutoSize.LEFT;
			
			this.addChild(title);
		
		}
		
		public function resize():void
		{
			if (this.text == null)
				return;
		}
		
		public function get_width():Number
		{
			if (this.numChildren == 0)
				return 0;
			else
				return this.getChildAt(0).width;
		}
		
		public function die():void
		{			
			while (this.numChildren > 0)
				this.removeChildAt(0);
		}
	}
}