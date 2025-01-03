package save_editor.settings;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import save_editor.settings.items.*;

class Setting extends FlxTypedSpriteGroup<Dynamic>
{
	public static var settingOptions_checkbox:Null<Setting_Checkbox>;
	public static var settingOptions_enum:Null<Setting_Enum>;
	public static var settingOptions_number:Null<Setting_Number>;

	public var leftArrow:FlxSprite;
	public var rightArrow:FlxSprite;
	public var icon:FlxSprite;
	public var title:FlxText;
	public var currentValue:Dynamic_SettingValue;
	public var possibleValues:Null<Array<String>>;
	public var type:String;
	public var min:Null<Float>;
	public var max:Null<Float>;
	public var precision:Null<Float>;

	var hasArrows:Bool = false;

	/**
	 * This makes a complete setting from variables.
	 * @param x 
	 * @param y 
	 * @param icon If a setting has an assosciated icon
	 * @param settingType Whether its a bool, enum, or just numbers.
	 * @param settingTitle Name of the setting
	 * @param startingValue Default value
	 * @param callback What to do upon changing the value of this setting.
	 */
	public function new(x:Float, y:Float, icon:Null<String>, settingType:String, settingTitle:String, startingValue:Dynamic, callback:Dynamic->Dynamic,
			?enumValues:Array<String>, ?min:Float, ?max:Float, ?precision:Float)
	{
		super(x, y);

		if (icon != null)
		{
			if (Paths.image_graphic(icon) == null)
				icon = 'bitchAssets/charIcon';

			this.icon = new FlxSprite().loadGraphic(Paths.image(icon));
			this.icon.setGraphicSize(100, 100);
			this.icon.updateHitbox();
			add(this.icon);
		}

		var xPos = this.icon == null ? 0 : this.icon.width + 5;
		type = settingType.toLowerCase();

		if (enumValues != null)
			possibleValues = enumValues;

		if (min != null)
			this.min = min;

		if (max != null)
			this.max = max;

		if (precision != null)
			this.precision = precision;

		switch (settingType.toLowerCase())
		{
			default:
				trace('Invalid or malformed type! got $settingType!');
			case 'bool':
				if (callback == null)
					callback = DefaultCallbacks.boolCallback;
				settingOptions_checkbox = new Setting_Checkbox(xPos, 35, settingTitle, startingValue, callback);
				add(settingOptions_checkbox);
				currentValue = new Dynamic_SettingValue('bool', startingValue);

			case 'enum':
				if (callback == null)
					callback = DefaultCallbacks.enumCallback;
				settingOptions_enum = new Setting_Enum(xPos + 35, 35, settingTitle, possibleValues, startingValue, callback);
				add(settingOptions_enum);
				currentValue = new Dynamic_SettingValue('enum', startingValue);
				hasArrows = true;

			case 'number' | 'int' | 'float':
				if (callback == null)
					callback = DefaultCallbacks.floatCallback;
				settingOptions_number = new Setting_Number(xPos + 35, 35, settingTitle, startingValue, precision, min, max, callback);
				add(settingOptions_number);
				currentValue = new Dynamic_SettingValue('float', startingValue);
				hasArrows = true;
				type = 'number';
		}
		leftArrow = new FlxSprite().loadGraphic(Paths.image('arrow'));
		leftArrow.setGraphicSize(30);
		leftArrow.updateHitbox();
		leftArrow.y = 25;
		leftArrow.x = xPos;
		add(leftArrow);
		leftArrow.visible = hasArrows;

		rightArrow = new FlxSprite().loadGraphic(Paths.image('arrowRight'));
		rightArrow.setGraphicSize(30);
		rightArrow.updateHitbox();
		rightArrow.y = 25;
		rightArrow.x = xPos;
		add(rightArrow);
		rightArrow.visible = hasArrows;

		title = new FlxText(0, 0, 0, settingTitle, 18);
		title.y = -(title.height - 7);
		add(title);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (hasArrows)
		{
			var xPos = this.icon == null ? 0 : this.icon.width + 5;
			var w:Float = 0;
			switch (type)
			{
				case 'number' | 'int' | 'float':
					w = settingOptions_number.width;

				case 'enum':
					w = settingOptions_enum.width;
			}
			rightArrow.x = leftArrow.x + w + 40;
		}
	}

	public function doCallback(value:Dynamic)
	{
		if (Type.typeof(value) == TBool)
		{
			if (type == 'bool')
				currentValue.bool = settingOptions_checkbox.callback(value);
			else
				trace('Invalid value type for bool callback, got ${Type.typeof(value)}!');
		}
		else if (Std.isOfType(value, String))
		{
			if (type == 'enum')
				currentValue.enumValue = settingOptions_enum.callback(value);
			else
				trace('Invalid value type for enum callback, got ${Type.typeof(value)}!');
		}
		else if (Type.typeof(value) == TFloat || Type.typeof(value) == TInt)
		{
			if (type == 'number')
				currentValue.float = settingOptions_number.set_currentValue(value);
			else if (type == 'enum')
				currentValue.enumValue = settingOptions_enum.set_currentValue(value);
			else
				trace('Invalid value type for float or enum(from float) callback, got ${Type.typeof(value)}!');
		}
		else
		{
			trace('Invalid or malformed type! got ${Type.typeof(value)}! valid types are String, Bool, Float, and Int.');
		}
	}
}
