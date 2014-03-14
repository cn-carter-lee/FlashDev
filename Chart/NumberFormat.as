package
{
	import object_helper;
	
	public class NumberFormat
	{
		public static var DEFAULT_NUM_DECIMALS:Number = 2;
		
		public var numDecimals:Number = DEFAULT_NUM_DECIMALS;
		public var isFixedNumDecimalsForced:Boolean = false;
		public var isDecimalSeparatorComma:Boolean = false;
		public var isThousandSeparatorDisabled:Boolean = false;
		
		public function NumberFormat(numDecimals:Number, isFixedNumDecimalsForced:Boolean, isDecimalSeparatorComma:Boolean, isThousandSeparatorDisabled:Boolean)
		{
			this.numDecimals = Parser.getNumberValue(numDecimals, DEFAULT_NUM_DECIMALS, true, false);
			this.isFixedNumDecimalsForced = Parser.getBooleanValue(isFixedNumDecimalsForced, false);
			this.isDecimalSeparatorComma = Parser.getBooleanValue(isDecimalSeparatorComma, false);
			this.isThousandSeparatorDisabled = Parser.getBooleanValue(isThousandSeparatorDisabled, false);
		}
		
		private static var _instance:NumberFormat = null;
		
		public static function getInstance(json:Object):NumberFormat
		{
			if (_instance == null)
			{
				var o:Object = {num_decimals: 2, is_fixed_num_decimals_forced: 0, is_decimal_separator_comma: 0, is_thousand_separator_disabled: 0};
				object_helper.merge_to_default(json, o);
				_instance = new NumberFormat(o.num_decimals, o.is_fixed_num_decimals_forced == 1, o.is_decimal_separator_comma == 1, o.is_thousand_separator_disabled == 1);
			}
			else
			{
			}
			return _instance;
		}
		
		private static var _instanceY2:NumberFormat = null;
		
		public static function getInstanceY2(json:Object):NumberFormat
		{
			if (_instanceY2 == null)
			{
				var o:Object = {num_decimals: 2, is_fixed_num_decimals_forced: 0, is_decimal_separator_comma: 0, is_thousand_separator_disabled: 0};
				object_helper.merge_to_default(json, o);
				_instanceY2 = new NumberFormat(o.num_decimals, o.is_fixed_num_decimals_forced == 1, o.is_decimal_separator_comma == 1, o.is_thousand_separator_disabled == 1);
				
			}
			else
			{
			}
			return _instanceY2;
		}
	}
}