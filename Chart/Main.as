package
{
	import charts.series.Element;
	import charts.Factory;
	import charts.ChartSetCollection;
	import elements.menu.Menu;
	import charts.series.has_tooltip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import string.Utils;
	import global.Global;
	// import com.serialization.json.JSON;
	import flash.external.ExternalInterface;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.events.IOErrorEvent;
	import flash.events.ContextMenuEvent;
	import flash.system.System;
	
	import flash.display.LoaderInfo;
	
	// export the chart as an image
	import com.adobe.images.PNGEncoder;
	import com.adobe.images.JPGEncoder;
	import mx.utils.Base64Encoder;
	// import com.dynamicflash.util.Base64;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	import elements.axis.XAxis;
	import elements.axis.XAxisLabels;
	import elements.axis.YAxisBase;
	import elements.axis.YAxisLeft;
	import elements.axis.YAxisRight;
	import elements.axis.RadarAxis;
	import elements.StageBackground;
	import elements.labels.XLegend;
	import elements.labels.Title;
	import elements.labels.Keys;
	import elements.labels.YLegendBase;
	import elements.labels.YLegendLeft;
	import elements.labels.YLegendRight;
	
	import flash.ui.Mouse;
	
	public class Main extends Sprite
	{
		public var VERSION:String = "PYS 1.0";
		private var title:Title = null;
		//private var x_labels:XAxisLabels;
		private var x_axis:XAxis;
		private var radar_axis:RadarAxis;
		private var x_legend:XLegend;
		private var y_axis:YAxisBase;
		private var y_axis_right:YAxisBase;
		private var y_legend_left:YLegendBase;
		private var y_legend_right:YLegendBase;
		private var keys:Keys;
		private var obs:ChartSetCollection;
		public var tool_tip_wrapper:String;
		private var sc:ScreenCoords;
		private var tooltip:Tooltip;
		private var stage_background:StageBackground;
		private var menu:Menu;
		private var ok:Boolean;
		private var URL:String;
		private var id:String;
		private var chart_parameters:Object;
		private var json:String;
		
		public function Main()
		{
			this.chart_parameters = LoaderInfo(this.loaderInfo).parameters;
			if (this.chart_parameters['loading'] == null)
				this.chart_parameters['loading'] = 'Loading data...';
			
			var l:Loading = new Loading(this.chart_parameters['loading']);
			this.addChild(l);
			this.build_right_click_menu();
			this.ok = false;
			
			try
			{
				var file:String = "line.txt";
				this.load_external_file(file);
			}
			catch (e:Error)
			{
				this.show_error('Loading data\n' + file + '\n' + e.message);
			}
			
			// inform javascript that it can call our reload method
			this.addCallback("reload", reload); // mf 18nov08, line 110 of original 'main.as'
			
			// inform javascript that it can call our load method
			this.addCallback("load", load);
			
			// TODO: chanf all external to use this: tell our external interface manager to pass out the chart ID with every external call.
			if (this.chart_parameters['id'])
			{
				var ex:ExternalInterfaceManager = ExternalInterfaceManager.getInstance();
				ex.setUp(this.chart_parameters['id']);
			}
			
			// TODO: move this so it is called after set_the_stage is ready.tell the web page that we are ready
			if (this.chart_parameters['id'])
				this.callExternalCallback("ofc_ready", this.chart_parameters['id']);
			else
				this.callExternalCallback("ofc_ready");
			this.set_the_stage();
		}
		
		private function addCallback(functionName:String, closure:Function):void
		{
			// the debug player does not have an external interface because it is NOT embedded in a browser
			if (ExternalInterface.available)
				ExternalInterface.addCallback(functionName, closure);
		}
		
		private function callExternalCallback(functionName:String, ... optionalArgs):*
		{
			// the debug player does not have an external interface because it is NOT embedded in a browser			
			if (ExternalInterface.available)
				return ExternalInterface.call(functionName, optionalArgs);
		}
		
		private function image_binary():ByteArray
		{
			var pngSource:BitmapData = new BitmapData(this.width, this.height);
			pngSource.draw(this);
			return PNGEncoder.encode(pngSource);
		}
		
		// an external interface, used by javascript to reload JSON from a URL :: mf 18nov08
		public function reload(url:String):void
		{
			var l:Loading = new Loading(this.chart_parameters['loading']);
			this.addChild(l);
			this.load_external_file(url);
		}
		
		private function load_external_file(file:String):void
		{
			this.URL = file;
			// LOAD THE DATA			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
			loader.addEventListener(Event.COMPLETE, jsonFileLoaded);
			var request:URLRequest = new URLRequest(file);
			loader.load(request);
		}
		
		private function ioError(e:IOErrorEvent):void
		{
			// remove the 'loading data...' msg:
			this.removeChildAt(0);
			var msg:ErrorMsg = new ErrorMsg('Open Flash Chart\nIO ERROR\nLoading test data\n' + e.text);
			msg.add_html('This is the URL that I tried to open:<br><a href="' + this.URL + '">' + this.URL + '</a>');
			this.addChild(msg);
		}
		
		private function show_error(msg:String):void
		{
			// remove the 'loading data...' msg:
			this.removeChildAt(0);
			var m:ErrorMsg = new ErrorMsg(msg);
			//m.add_html( 'Click here to open your JSON file: <a href="http://a.com">asd</a>' );
			this.addChild(m);
		}
		
		// JSON is loaded from an external URL		
		private function jsonFileLoaded(event:Event):void
		{
			var loader:URLLoader = URLLoader(event.target);
			this.loadJsonData(loader.data);
		}
		
		// we have data! parse it and make the chart
		private function loadJsonData(json_string:String):void
		{
			var ok:Boolean = false;
			try
			{
				var json:Object = JSON.parse(json_string, null);
				ok = true;
			}
			catch (e:Error)
			{
				// remove the 'loading data...' msg:
				this.removeChildAt(0);
				this.addChild(new JsonErrorMsg(json_string as String, e));
			}
			// don't catch these errors:
			if (ok)
			{
				// remove 'loading data...' msg:
				this.removeChildAt(0);
				// START TO BUILD CHART
				this.build_chart(json);
				// force this to be garbage collected
				json = null;
			}
		}
		
		private function build_chart(json:Object):void
		{
			if (this.obs != null)
				this.die();
			// init singletons:
			NumberFormat.getInstance(json);
			NumberFormat.getInstanceY2(json);
			this.tooltip = new Tooltip(json.tooltip);
			
			var g:Global = Global.getInstance();
			g.set_tooltip_string(this.tooltip.tip_text);
			
			// step 1 these are common to both X Y charts and PIE charts:
			this.stage_background = new StageBackground(json);
			this.addChild(this.stage_background);
			
			// step 2
			this.build_chart_background(json);
			
			// step 3  these are added in the Flash Z Axis order
			this.title = new Title(json.title);
			this.addChild(this.title);
			
			// step 4
			for each (var set:Sprite in this.obs.ChartSets)
				this.addChild(set);
			
			// step 5
			this.addChild(this.tooltip);
			
			if (json['menu'] != null)
			{
				this.menu = new Menu('99', json['menu']);
				this.addChild(this.menu);
			}
			this.ok = true;
			this.resize();
		}
		
		private function resize():void
		{
			// the chart is async, so we may get this event before the chart has loaded, or has partly loaded
			if (!this.ok)
				return; // <-- something is wrong		
			var sc:ScreenCoordsBase = this.resize_chart();
			if (this.menu)
				this.menu.resize();
			// tell the web page that we have resized our content
			if (this.chart_parameters['id'])
				this.callExternalCallback("ofc_resize", sc.left, sc.width, sc.top, sc.height, this.chart_parameters['id']);
			else
				this.callExternalCallback("ofc_resize", sc.left, sc.width, sc.top, sc.height);
			sc = null;
		}
		
		private function resize_chart():ScreenCoordsBase
		{
			// we want to show the tooltip closest to items near the mouse, so hook into the mouse move event:
			this.stage_background.resize();
			this.title.resize();
			var left:Number = this.y_legend_left.get_width() /*+ this.y_labels.get_width()*/ + this.y_axis.get_width();
			this.keys.resize(left, this.title.get_height());
			var top:Number = this.title.get_height() + this.keys.get_height();
			var bottom:Number = this.stage.stageHeight;
			bottom -= (this.x_legend.get_height() + this.x_axis.get_height());
			var right:Number = this.stage.stageWidth;
			right -= this.y_legend_right.get_width();
			trace(this.y_legend_right.get_width());
			//right -= this.y_labels_right.get_width();
			right -= this.y_legend_left.get_width();
			// this object is used in the mouseMove method
			this.sc = new ScreenCoords(top, left, right, bottom, this.y_axis.get_range(), this.y_axis_right.get_range(), this.x_axis.get_range(), this.x_axis.first_label_width(), this.x_axis.last_label_width(), false);
			this.sc.set_bar_groups(this.obs.ChartGroups);
			this.x_axis.resize(sc, 
				// can we remove this:
				this.stage.stageHeight - (this.x_legend.get_height() + this.x_axis.labels.get_height()) // <-- up from the bottom
				);
			this.y_axis.resize(this.y_legend_left.get_width(), sc);
			this.y_axis_right.resize(0, sc);
			this.x_legend.resize(sc);
			this.y_legend_left.resize();
			this.y_legend_right.resize();
			this.obs.resize(sc);
			
			return sc;
		}
		
		private function set_the_stage():void
		{
			// tell flash to align top left, and not to scale anything (we do that in the code)			
			this.stage.align = StageAlign.TOP_LEFT;
			// ----- RESIZE ---- noScale: now we can pick up resize events
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.addEventListener(Event.RESIZE, this.resizeHandler);
			this.stage.addEventListener(Event.MOUSE_LEAVE, this.mouseOut);
			this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseMove);
		}
		
		private function mouseMove(event:Event):void
		{
			if (!this.tooltip)
				return; // <- an error and the JSON was not loaded					
			if (this.tooltip.get_tip_style() == Tooltip.CLOSEST)
			{
				var elements:Array = this.obs.get_closest_elements(this.mouseX, this.mouseY);
				this.tooltip.closest(elements);
			}
			Mouse.cursor = "button";
		}
		
		private function resizeHandler(event:Event):void
		{
			this.resize();
		}
		
		private function mouseOut(event:Event):void
		{
			if (this.tooltip != null)
				this.tooltip.hide();
			
			if (this.obs != null)
				this.obs.mouse_out();
			Mouse.cursor = "arrow";
		}
		
		// an external interface, used by javascript to pass in a JSON string				
		public function load(s:String):void
		{
			this.loadJsonData(s);
		}
		
		// PIE charts don't have this.build grid, axis, legends and key		
		private function build_chart_background(json:Object):void
		{
			// This reads all the 'elements' of the chart.  e.g. bars and lines, then creates them as sprites			
			this.obs = Factory.MakeChart(json);
			this.x_legend = new XLegend(json.x_legend);
			this.y_legend_left = new YLegendLeft(json);
			this.y_legend_right = new YLegendRight(json);
			this.x_axis = new XAxis(json, this.obs.get_min_x(), this.obs.get_max_x());
			this.y_axis = new YAxisLeft();
			this.y_axis_right = new YAxisRight();
			
			// access all our globals through this:
			var g:Global = Global.getInstance();
			// this is needed by all the elements tooltip
			g.x_labels = this.x_axis.labels;
			g.x_legend = this.x_legend;
			// pick up X Axis labels for the tooltips			
			this.obs.tooltip_replace_labels(this.x_axis.labels);
			this.keys = new Keys(this.obs);
			this.addChild(this.x_legend);
			this.addChild(this.y_legend_left);
			this.addChild(this.y_legend_right);
			this.addChild(this.y_axis);
			this.addChild(this.y_axis_right);
			this.addChild(this.x_axis);
			this.addChild(this.keys);
			// now these children have access to the stage, tell them to init			
			this.y_axis.init(json);
			this.y_axis_right.init(json);
		}
		
		// Remove all our referenced objects		
		private function die():void
		{
			this.obs.die();
			this.obs = null;
			
			if (this.tooltip != null)
				this.tooltip.die();
			if (this.x_legend != null)
				this.x_legend.die();
			if (this.y_legend_left != null)
				this.y_legend_left.die();
			if (this.y_legend_right != null)
				this.y_legend_right.die();
			if (this.y_axis != null)
				this.y_axis.die();
			if (this.y_axis_right != null)
				this.y_axis_right.die();
			if (this.x_axis != null)
				this.x_axis.die();
			if (this.keys != null)
				this.keys.die();
			if (this.title != null)
				this.title.die();
			if (this.radar_axis != null)
				this.radar_axis.die();
			if (this.stage_background != null)
				this.stage_background.die();
			
			this.tooltip = null;
			this.x_legend = null;
			this.y_legend_left = null;
			this.y_legend_right = null;
			this.y_axis = null;
			this.y_axis_right = null;
			this.x_axis = null;
			this.keys = null;
			this.title = null;
			this.radar_axis = null;
			this.stage_background = null;
			
			while (this.numChildren > 0)
				this.removeChildAt(0);
			
			if (this.hasEventListener(MouseEvent.MOUSE_MOVE))
				this.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMove);
			// do not force a garbage collection, it is not supported: http://stackoverflow.com/questions/192373/force-garbage-collection-in-as3	 		
		}
		
		private function build_right_click_menu():void
		{
			var cm:ContextMenu = new ContextMenu();
			cm.addEventListener(ContextMenuEvent.MENU_SELECT, onContextMenuHandler);
			cm.hideBuiltInItems();
			// OFC CREDITS
			var fs:ContextMenuItem = new ContextMenuItem("Charts by PYS [Version " + VERSION + "]");
			fs.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function doSomething(e:ContextMenuEvent):void
				{
					var url:String = "http://carterlee3128.herokuapp.com/";
					var request:URLRequest = new URLRequest(url);
					flash.net.navigateToURL(request, '_blank');
				});
			cm.customItems.push(fs);
			this.contextMenu = cm;
		}
		
		private function onContextMenuHandler(event:ContextMenuEvent):void
		{
		}
	}
}
