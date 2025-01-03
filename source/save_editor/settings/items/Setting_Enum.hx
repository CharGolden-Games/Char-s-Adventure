package save_editor.settings.items;

class Setting_Enum extends FlxText
{
	public var settingTitle:String;
	public var currentValue:String;
	public var possibleValues:Array<String> = [];
	public var onChangeCallback:String->String;

	public static var curValue:Int = 0;

	public function new(x:Float, y:Float, settingTitle:String, possibleValues:Array<String>, startingValue:String, onChange:String->String)
	{
		super(x, y, 0, startingValue, 18);

		this.settingTitle = settingTitle;
		this.currentValue = startingValue;
		this.onChangeCallback = onChange;
		this.possibleValues = possibleValues;
	}

	function check_if_inBounds(change:Int):Bool
	{
		var isInBounds:Bool = true;
		if (change < 0 && curValue == 0)
		{
			isInBounds = false;
		}
		if (change > 0 && curValue == possibleValues.length - 1)
		{
			isInBounds = false;
		}
		return isInBounds;
	}

	/**
	 * Sets the current value by adding to curValue, then uses it to change the current string value via the current callback function.
	 * @param change Int
	 * @return String
	 */
	public function set_currentValue(change:Int):String
	{
		if (check_if_inBounds(change))
		{
			curValue += change;
			return callback(possibleValues[curValue]);
		}
		return currentValue;
	}

	public function callback(value:String):String
	{
		text = value;
		return currentValue = onChangeCallback(value);
	}
}