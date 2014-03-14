package data
{
	import adobe.utils.CustomActions;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ...
	 */
	public class JsonFile extends EventDispatcher
	{
		
		public var jsonObject:Object;
		
		public function JsonFile(filePath:String)
		{
			load_external_file(filePath);
		}
		
		private function load_external_file(filePath:String):void
		{			
			var loader:URLLoader = new URLLoader();			
			loader.addEventListener(IOErrorEvent.IO_ERROR, IO_ERROR);
			loader.addEventListener(Event.COMPLETE, jsonLoaded);			
			var request:URLRequest = new URLRequest(filePath);			
			loader.load(request);			
		}
		
		private function IO_ERROR():void
		{
			trace('IO ERROR!');			
		}
		
		private function jsonLoaded(event:Event):void
		{			
			var loader:URLLoader = URLLoader(event.target);			
			jsonObject = JSON.parse(loader.data);
			var e:DataLoadEvent = new DataLoadEvent(DataLoadEvent.ON_LOADED);
			e.dataObject = jsonObject;
			dispatchEvent(e);			
		}	
	}
}

