package charsadventure.ui.options.items;

class Checkbox extends FlxSprite
{
	public var currentValue(default, set):Bool;
	public var onChange:Null<Bool->Bool>;

	public function new(x:Float, y:Float, defaultValue:Bool = false, onChange:Null<Bool->Bool>)
	{
		super(x, y);

		this.onChange = onChange;
		this.currentValue = defaultValue;
		makeGraphic(100, 100, 0xFFFFFFFF);

		/*frames = Paths.xmlFrames('images/options/checkbox');
			animation.addByPrefix('unchecked', 'Checkbox Unchecked', 24, false);
			animation.addByPrefix('checked', 'Checkbox Checked', 24, false);

			setGraphicSize(Std.int(width * 0.7));
			updateHitbox(); */ // uncomment when done!
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		/*switch (animation.curAnim.name) {
			case 'checked':
				offset.set();
			case 'unchecked':
				offset.set(-17, 70)
		}*/ // uncomment and fix offsets when done!
	}

	public function set_currentValue(value:Bool):Bool
	{
		if (value)
		{
			// animation.play('checked');
			color = 0xFFFFFF00;
		}
		else
		{
			// animation.play('unchecked');
			color = 0xFFFFFFFF;
		}

		if (onChange != null)
		{
			onChange(value);
		}

		return currentValue = value;
	}
}
