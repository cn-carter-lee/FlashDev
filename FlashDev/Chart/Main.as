package
{
	import charts.Line;
	import charts.Scatter;
	import charts.series.Element;
	import charts.Factory;
	import charts.PysChartSetCollection;
	import elements.menu.Menu;
	import charts.series.has_tooltip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import string.Utils;
	import global.Global;
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
	import elements.labels.YLegendBase;
	import elements.labels.YLegendLeft;
	import elements.labels.YLegendRight;
	import elements.labels.ChartSetSelectEvent;
	import flash.ui.Mouse;
	import com.goodinson.snapshot.*;
	
	public class Main extends Sprite
	{
		public var VERSION:String = "PYS 1.0";
		private var topNavigation:TopNavigation;
		private var x_axis:XAxis;
		private var radar_axis:RadarAxis;
		private var x_legend:XLegend;
		private var y_axis:YAxisBase;
		private var y_axis_right:YAxisBase;
		private var y_legend_left:YLegendBase;
		private var y_legend_right:YLegendBase;
		private var pysChartSetCollection:PysChartSetCollection;
		public var tool_tip_wrapper:String;
		private var sc:ScreenCoords;
		private var tooltip:Tooltip;
		private var stage_background:StageBackground;
		private var menu:Menu;
		private var OK:Boolean;
		private var URL:String;
		private var id:String;
		private var chart_parameters:Object;
		
		private var horizonLines:Array;
		private var horizonLine1:PysHorizonLine;
		private var horizonLine2:PysHorizonLine;
		private var horizonLine3:PysHorizonLine;
		
		private var verticalBar1:PysVerticalBar;
		private var verticalBar2:PysVerticalBar;
		
		private var currentNavType:String = ChartNavType.Exams;
		private var urlLoader:URLLoader = new URLLoader();
		
		public function Main()
		{
			horizonLines = new Array();
			
			this.chart_parameters = LoaderInfo(this.loaderInfo).parameters;
			if (this.chart_parameters['loading'] == null)
				this.chart_parameters['loading'] = '拼命加载数据中...';
			
			var l:Loading = new Loading(this.chart_parameters['loading']);
			this.addChild(l);
			this.build_right_click_menu();
			this.OK = false;
			
			this.loadDataFile();
			
			// Inform javascript that it can call our reload method
			this.addCallback("reload", reload);
			
			// inform javascript that it can call our load method
			this.addCallback("load", load);
			this.addCallback("makeLine", makeLineFromPage)
			this.addCallback("exportImage", exportImage)
			
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
			
			// tell flash to align top left, and not to scale anything (we do that in the code)			
			this.stage.align = StageAlign.TOP_LEFT;
			// ----- RESIZE ---- noScale: now we can pick up resize events
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.addEventListener(Event.RESIZE, this.resizeHandler);
			this.stage.addEventListener(Event.MOUSE_LEAVE, this.mouseOut);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMove);
			this.stage.addEventListener(ChartSetSelectEvent.SELECTED, this.chartSetSelect);
			urlLoader.addEventListener(Event.COMPLETE, urlLoader_complete);
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
		
		// An external interface, used by javascript to reload JSON from a URL 
		public function reload(url:String):void
		{
			// var l:Loading = new Loading(this.chart_parameters['loading']);
			// this.addChild(l);			
			// this.load_external_file(url);
		}
		
		private function loadDataFile(filePath:String = null):void
		{
			if (filePath == null)
				filePath = this.callExternalCallback("getDataFilePath", 1);
			if (filePath == null)
				filePath = "exams.txt";
			try
			{
				this.URL = filePath;
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
				loader.addEventListener(Event.COMPLETE, jsonFileLoaded);
				var request:URLRequest = new URLRequest(filePath);
				loader.load(request);
			}
			catch (e:Error)
			{
				this.show_error('Loading data\n' + filePath + '\n' + e.message);
			}
		}
		
		private function ioError(e:IOErrorEvent):void
		{
			// Remove the 'loading data...' msg:
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
			var jsonObj:Object;
			try
			{
				jsonObj = JSON.parse(json_string, null);
				ok = true;
			}
			catch (e:Error)
			{
				// remove the 'loading data...' msg
				this.removeChildAt(0);
				this.addChild(new JsonErrorMsg(json_string as String, e));
			}
			// don't catch these errors:
			if (ok)
			{
				// remove 'loading data...' msg
				this.removeChildAt(0);
				// START TO BUILD CHART
				this.build_chart(jsonObj);
				// force this to be garbage collected
				jsonObj = null;
			}
		}
		
		private function build_chart(json:Object):void
		{
			//if (this.listChartSet != null) this.die();			
			this.tooltip = new Tooltip(json.tooltip);			
			var g:Global = Global.getInstance();
			g.set_tooltip_string(this.tooltip.tip_text);			
			// this.listChartSet = Factory.MakeChart(json);
			this.pysChartSetCollection = Factory.MakePysChart(json);			
			// step 1 these are common to both X Y charts and PIE charts:
			this.stage_background = new StageBackground(json);
			this.addChild(this.stage_background);			
			// step 2
			this.build_chart_background(json);			
			//if (!this.topNavigation)
			this.topNavigation = new TopNavigation(json["nav"]);			
			this.addChild(this.topNavigation);
			// step 4
			this.addChild(this.pysChartSetCollection.scatter);
			for each (var line:Sprite in this.pysChartSetCollection.listLine)
				this.addChild(line);			
			// step 5
			this.addChild(this.tooltip);			
			if (json['menu'] != null)
			{
				this.menu = new Menu('99', json['menu']);
				this.addChild(this.menu);
			}
			this.OK = true;			
			// Add horizonal lines
			horizonLine1 = new PysHorizonLine(1);
			this.addChild(horizonLine1);
			horizonLine1.y = 50;
			horizonLine2 = new PysHorizonLine(2);
			horizonLine2.y = 200;
			this.addChild(horizonLine2);
			verticalBar1 = new PysVerticalBar(horizonLine1, horizonLine2);
			this.addChild(verticalBar1);
			
			horizonLine3 = new PysHorizonLine(3);
			horizonLine3.y = 300;
			this.addChild(horizonLine3);
			verticalBar2 = new PysVerticalBar(horizonLine2, horizonLine3);
			this.addChild(verticalBar2);
			this.resize();
		}
		
		private function resize():void
		{
			// the chart is async, so we may get this event before the chart has loaded, or has partly loaded
			if (!this.OK)
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
			// We want to show the tooltip closest to items near the mouse, so hook into the mouse move event:
			this.stage_background.resize();
			this.topNavigation.resize();
			
			var left:Number = this.y_legend_left.get_width() + this.y_axis.get_width();
			var top:Number = this.topNavigation.height + 5;
			var bottom:Number = this.stage.stageHeight - this.x_legend.get_height() - this.x_axis.get_height();
			var right:Number = this.stage.stageWidth - this.y_legend_right.get_width() - this.y_legend_left.get_width();
			
			// this object is used in the mouseMove method
			this.sc = new ScreenCoords(top, left, right, bottom, this.y_axis.get_range(), this.y_axis_right.get_range(), this.x_axis.get_range(), this.x_axis.first_label_width(), this.x_axis.last_label_width(), false);
			//this.sc.set_bar_groups(this.listChartSet.ChartGroups);
			this.x_axis.resize(sc, 
				// can we remove this:
				this.stage.stageHeight - (this.x_legend.get_height() + this.x_axis.labels.get_height()) // <-- up from the bottom
				);
			this.y_axis.resize(this.y_legend_left.get_width(), sc);
			this.y_axis_right.resize(0, sc);
			this.x_legend.resize(sc);
			this.y_legend_left.resize();
			this.y_legend_right.resize();
			this.pysChartSetCollection.resize(sc);
			
			var rectangle:Rectangle = new Rectangle(left, top, right - left, top - bottom);
			this.resize_dragObjs(rectangle);			
			return sc;
		}
		
		private function resize_dragObjs(rectangle:Rectangle):void
		{
			horizonLine1.resize(rectangle);
			horizonLine2.resize(rectangle);
			horizonLine3.resize(rectangle);
			for (var i:Number = 0; i < this.horizonLines.length; i++)
			{
				horizonLines[i].resize(rectangle);
			}
			
			this.resize_dragbars();
		}
		
		private function resize_dragbars():void
		{
			setVerticalBarText(verticalBar1);
			setVerticalBarText(verticalBar2);
			verticalBar1.resize();
			verticalBar2.resize();
		}
		
		private function setVerticalBarText(verticalBar:PysVerticalBar):void
		{
			var intervalCount:Number = 0;
			var totalCount:Number = 0;
			var tmp:Sprite;
			for (var i:Number = 0; i < this.pysChartSetCollection.scatter.numChildren; i++)
			{
				tmp = this.pysChartSetCollection.scatter.getChildAt(i) as Sprite;
				if (tmp is Element)
				{
					totalCount++;
					var e:Element = tmp as Element;
					if (e.y >= verticalBar.line1.y && e.y < verticalBar.line2.y)
					{
						intervalCount++;
					}
				}
			}
			verticalBar.showText = Math.round(intervalCount / totalCount * 10000) % 100 + '%';
		}
		
		private function mouseMove(event:Event):void
		{
			this.resize_dragbars();
			if (!this.tooltip)
				// <- an error and the JSON was not loaded
				return;
			if (this.tooltip.get_tip_style() == Tooltip.CLOSEST)
			{
				var closestElements:Array = this.pysChartSetCollection.get_closest_elements(this.mouseX, this.mouseY);
				if (closestElements.length == 0)
				{
					this.mouseOut(null);
					return;
				}
				this.tooltip.closest(closestElements);
			}
		}
		
		private function chartSetSelect(event:ChartSetSelectEvent):void
		{
			var tmpIdentifier:Number;
			if (event.chartNavType == ChartNavType.Undefined)
			{
				// triggered from point clicking
				if (this.currentNavType == ChartNavType.ClassScore)
					return; // should redirect to student's page				
				else if (this.currentNavType == ChartNavType.Exams)
					this.currentNavType = ChartNavType.Exam;
				else if (this.currentNavType == ChartNavType.Exam)
					this.currentNavType = ChartNavType.ClassScore;
				tmpIdentifier = pysChartSetCollection.scatter.values[event.identifier].id; // TODO: add point id		
			}
			else
			{
				// triggered from navigation bar
				this.currentNavType = event.chartNavType;
				tmpIdentifier = event.identifier;
			}
			// this.selectedIdentifier = event.identifier;
			var file:String = "exams.txt";
			if (this.currentNavType == ChartNavType.Exams)
				file = "exams.txt";
			if (this.currentNavType == ChartNavType.Exam)
			{
				file = "examclass.txt";
			}
			else if (this.currentNavType == ChartNavType.ClassScore)
			{
				file = "classscore.txt";
			}
			
			try
			{
				this.loadDataFile(file);
			}
			catch (e:Error)
			{
				this.show_error('Loading data\n' + file + '\n' + e.message);
			}
		}
		
		private function resizeHandler(event:Event):void
		{
			this.resize();
		}
		
		private function mouseOut(event:Event):void
		{
			if (this.tooltip != null)
				this.tooltip.hide();
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
			this.x_legend = new XLegend(json.x_legend);
			this.y_legend_left = new YLegendLeft(json);
			this.y_legend_right = new YLegendRight(json);
			this.x_axis = new XAxis(json, this.pysChartSetCollection.get_min_x(), this.pysChartSetCollection.get_max_x());
			//this.x_axis = new XAxis(json, 0, 45);
			this.y_axis = new YAxisLeft();
			this.y_axis_right = new YAxisRight();
			
			// access all our globals through this:
			var g:Global = Global.getInstance();
			// this is needed by all the elements tooltip
			g.x_labels = this.x_axis.labels;
			g.x_legend = this.x_legend;
			// pick up X Axis labels for the tooltips			
			// this.listChartSet.tooltip_replace_labels(this.x_axis.labels);
			// PYS TODO:
			
			// this.chartSetNames = new ChartSetNames(this.listChartSet);
			this.addChild(this.x_legend);
			this.addChild(this.y_legend_left);
			this.addChild(this.y_legend_right);
			this.addChild(this.y_axis);
			this.addChild(this.y_axis_right);
			this.addChild(this.x_axis);
			//this.addChild(this.chartSetNames);
			// now these children have access to the stage, tell them to init			
			this.y_axis.init(json);
			this.y_axis_right.init(json);
		}
		
		// Remove all our referenced objects		
		private function die():void
		{
			this.pysChartSetCollection.die();
			this.pysChartSetCollection = null;
			
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
		
		public function makeLineFromPage():void
		{
			var hl:PysHorizonLine = new PysHorizonLine(4, 0xff0000);
			this.addChild(hl);
			hl.y = 320;
			this.horizonLines.push(hl);
			this.resize();
		}
		
		public function exportImage(url:String):void
		{
			// url = "http://dev.carter.com//capture.aspx";
			Snapshot.gateway = url;
			Snapshot.capture(this, {format: Snapshot.JPG, action: Snapshot.LOAD, loader: urlLoader});
		}
		
		private function urlLoader_complete(evt:Event):void
		{
			this.callExternalCallback("printChart('" + urlLoader.data + "')");
		}
		
		private function onContextMenuHandler(event:ContextMenuEvent):void
		{
			// Triggers when right mouse clicking 		
		}
	}
}