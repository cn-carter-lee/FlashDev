package charts
{
	
	public class Factory
	{
		private var attach_right:Array;
		
		public static function MakeChart(json:Object):ObjectCollection
		{
			var collection:ObjectCollection = new ObjectCollection();
			
			// multiple bar charts all have the same X values, so
			// they are grouped around each X value, this tells
			// ScreenCoords how to group them:
			var bar_group:Number = 0;
			var name:String = '';
			var c:Number = 1;
			
			var elements:Array = json['elements'] as Array;
			
			for (var i:Number = 0; i < elements.length; i++)
			{
				// tr.ace( elements[i]['type'] );
				
				if (elements[i]['type'] == 'line')
				{
					collection.add(new Line(elements[i]));
				}
			}
			/*
			
			
			   else if ( lv['candle' + name] != undefined )
			   {
			   ob = new BarCandle(lv, c, bar_group);
			   bar_group++;
			   }
			
			 */
			
			var y2:Boolean = false;
			var y2lines:Array;
			
			//
			// some data sets are attached to the right
			// Y axis (and min max)
			//
//			this.attach_right = new Array();
			
//			if( lv.show_y2 != undefined )
//				if( lv.show_y2 != 'false' )
//					if( lv.y2_lines != undefined )
//					{
//						this.attach_right = lv.y2_lines.split(",");
//					}
			
			collection.groups = bar_group;
			return collection;
		}
	}
}