package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.external.ExternalInterface;
	
	/**	 
	 * @author PYS
	 */
	public class Main extends Sprite
	{
		private var URL:String;
		private var OK:Boolean;
		private var columnCount:Number = 8;
		
		public function Main():void
		{			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addChild(new Loading("loading..."));
			var filePath:String = this.callExternalCallback("getMyVar");
			if (filePath != null)
			{
				try
				{
					this.load_external_file(filePath);
				}
				catch (e:Error)
				{
					this.show_error('Loading data\n' + filePath + '\n' + e.message);
				}
			}
			else
			{				
				try
				{
					this.load_external_file("student.txt");
				}
				catch (e:Error)
				{
					this.show_error('Loading data\n' + e.message);
				}
			}
		}
		
		private function load_external_file(file:String):void
		{
			// this.URL = file;  LOAD THE DATA 			
			var loader:URLLoader = new URLLoader();			
			loader.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
			loader.addEventListener(Event.COMPLETE, jsonFileLoaded);
			var request:URLRequest = new URLRequest(file);
			loader.load(request);
		}
		
		private function ioError(e:IOErrorEvent):void
		{
			// remove the 'loading data...'
			this.removeChildAt(0);
			var msg:ErrorMsg = new ErrorMsg('Open Flash Chart\nIO ERROR\nLoading test data\n' + e.text);
			msg.add_html('This is the URL that I tried to open:<br><a href="' + this.URL + '">' + this.URL + '</a>');
			this.addChild(msg);
		}
		
		// JSON is loaded from an external URL		
		private function jsonFileLoaded(event:Event):void
		{
			var loader:URLLoader = URLLoader(event.target);
			this.loadJsonData(loader.data);
		}
		
		private function loadJsonData(json_string:String):void
		{
			var ok:Boolean = false;
			var jsonObj:Object;
			try
			{
				jsonObj = JSON.parse(json_string, null);
				OK = true;
			}
			catch (e:Error)
			{
				// remove the 'loading data...' msg
				this.removeChildAt(0);
			}
			// don't catch these errors:
			if (OK)
			{
				// remove 'loading data...' msg
				this.removeChildAt(0);
				this.buildRoom(jsonObj);
			}
		}
		
		private function buildRoom(students:Object):void
		{
			var width1:Number = 60;
			var width2:Number = (stage.stageWidth - width1 * this.columnCount) / columnCount;
			for (var i:Number = 0; i < students.length; i++)
			{
				var student:Student = new Student(students[i].name);
				student.x = (int(i%this.columnCount)) * (width1 + width2);
				student.y = (int(i/this.columnCount))*80 + 10;
				student.resize();
				this.addChild(student);
			}
		}
		
		private function addCallback(functionName:String, closure:Function):void
		{
			if (ExternalInterface.available)
				ExternalInterface.addCallback(functionName, closure);
		}		
		
		private function callExternalCallback(functionName:String, ... optionalArgs):*
		{
			if (ExternalInterface.available)
				return ExternalInterface.call(functionName, optionalArgs);
		}
		
		private function resize():void
		{
		
		}
	}

}