package save_editor.settings.items;

class Setting_Checkbox extends FlxSprite
{
	public var settingTitle:String;
	public var currentValue:Bool = false;
	public var onChangeCallback:Bool->Bool;

	public function new(x:Float, y:Float, settingTitle:String, startingValue:Bool, onChange:Bool->Bool)
	{
		super(x, y);

		this.settingTitle = settingTitle;
		currentValue = startingValue;
		onChangeCallback = onChange;

		switch (startingValue)
		{
			case false:
				loadGraphic('assets/images/button-unpressed.png');
				setGraphicSize(50, 50);
				updateHitbox();
			case true:
				loadGraphic('assets/images/button-pressed.png');
				setGraphicSize(50, 50);
				updateHitbox();
		}
	}

	public function callback(value:Bool):Bool
	{
		switch (value)
		{
			case false:
				loadGraphic('assets/images/button-unpressed.png');
				setGraphicSize(50, 50);
				updateHitbox();
			case true:
				loadGraphic('assets/images/button-pressed.png');
				setGraphicSize(50, 50);
				updateHitbox();
		}
		return currentValue = onChangeCallback(value);
	}
}