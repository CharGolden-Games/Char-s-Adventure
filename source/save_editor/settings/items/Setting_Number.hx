package save_editor.settings.items;

using StringTools;

class Setting_Number extends FlxText
{
	public var settingTitle:String;
	public var currentValue:Float = 0;
	public var onChangeCallback:Float->Float;

	var precision:Float = 1;
	var min:Float = 0;
	var max:Float = 1;

	public function new(x:Float, y:Float, settingTitle:String, defaultValue:Float, precision:Float = 1, min:Float = 0, max:Float = 1, onChange:Float->Float)
	{
		super(x, y, 0, Std.string(defaultValue), 18);

		this.settingTitle = settingTitle;
		this.currentValue = defaultValue;
		this.precision = precision;
		this.min = min;
		this.max = max;
		onChangeCallback = onChange;
	}

	function check_if_inBounds(change:Float):Bool
	{
		var isInBounds:Bool = true;
		if (change < 0 && currentValue <= min)
		{
			isInBounds = false;
		}
		if (change > 0 && currentValue == max || change > 0 && currentValue > max)
		{
			isInBounds = false;
		}
		return isInBounds;
	}

	public function set_currentValue(change:Float):Float // THE FUCKING ERROR CORRECTION I HAD TO DO FOR THIS.
	{
		if (check_if_inBounds(change * precision))
		{
			currentValue += (change * precision);

			if (currentValue < min)
			{
				currentValue = 0;
			}
			if (change < 0 && currentValue > max)
			{
				currentValue = 0;
			}
			if (change > 0 && currentValue > max)
			{
				currentValue = max;
			}
			if (Std.string(currentValue).contains('e-'))
			{
				currentValue = 0;
			}

			return callback(change * precision);
		}
		return currentValue;
	}

	public function callback(value:Float):Float
	{
		text = Std.string(currentValue);
		return currentValue = onChangeCallback(currentValue);
	}
}