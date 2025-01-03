package charsadventure.ui.options.items;

/**
 * There is like 4 layers here to make 1 FUCKING OBJECT.
 * FINAL layer, actually handles the backend part. FUCKING HELL.
 * 
 * i have typed "currentValues" a lot.
 */
class ControlGroup extends FlxTypedGroup<ControlDisplayObject>
{
	private var index:Int = 0;

	public var keyIndex(default, set):Int = 0;

	public function new(MaxSize:Int = 0)
	{
		super(MaxSize);
	}

	private function set_index(value:Int):Int
	{
		index = value;
		if (index < 0)
			index = members.length - 1;
		if (index > members.length - 1)
			index = 0;

		keyIndex = 0; // set it to 0 because yuh.

		for (i in 0...members.length)
		{
			if (index == i)
			{
				members[i].controlName.color = 0xFFE600;
			}
			if (index != i)
			{
				members[i].controlName.color = 0xFFFFFF;
			}
		}
		return index;
	}

	public function change_index(change:Int, camFollow:Null<FlxObject> = null):Int
	{
		index = set_index(index + change);
		if (!members[index].controlGroup.visible)
		{
			if (index != 0)
			{
				change_index(change);
			}
			else
			{
				if (index == 0 && change == -1)
					change_index(change);
				else
					change_index(1);
			}
		}
		if (camFollow != null)
		{
			camFollow.y = members[index].y;
		}
		return index;
	}

	function set_keyIndex(value:Int):Int
	{
		var curMember = members[index].controlGroup;
		keyIndex = value;

		if (keyIndex > curMember.currentValues.length - 1)
			keyIndex = 0;
		if (keyIndex < 0)
			keyIndex = curMember.currentValues.length - 1;

		return members[index].keyIndex = keyIndex;
	}

	public function change_keyIndex(change:Int = 0, camFollow:Null<FlxObject> = null):Int
	{
		return set_keyIndex(keyIndex + change);
	}

	public function new_controlOption(x:Float, y:Float, name:String, defaultValues:Array<FlxKey>, onChange:Null<Array<FlxKey>->Array<FlxKey>> = null):Void
	{
		// trace('Making new control option!');
		var option = new ControlDisplayObject(x, y, name, defaultValues, onChange);
		// trace('Adding control option!');
		add(option);
	}

	public function new_headerOption(x:Float, y:Float, name:String):Void
	{
		var header = new ControlDisplayObject(x + 200, y, name, [NONE, NONE], null);
		header.controlGroup.visible = false;
		header.selected.visible = false;
		add(header);
	}

	public function set_key(value:FlxKey):Array<FlxKey>
	{
		return members[keyIndex].set_key(value);
	}

	public function get_key():FlxKey
	{
		return members[keyIndex].get_key();
	}

	public function get_keys():Array<FlxKey>
	{
		return members[keyIndex].get_keys();
	}
}

/**
 * This is what ACTUALLY handles displaying the full group with the ability to fuck with its values.
 * Layer 2
 */
class ControlDisplayObject extends FlxTypedSpriteGroup<Dynamic>
{
	public var controlGroup:ControlsGroup;
	public var controlName:FlxText;
	public var selected:FlxSprite;

	/**
	 * Gets set by ControlOption.
	 */
	public var keyIndex:Int = 0;

	public function new(x:Float, y:Float, name:String, defaultValues:Array<FlxKey>, onChange:Null<Array<FlxKey>->Array<FlxKey>> = null)
	{
		super(x, y);

		controlName = new FlxText(0, 0, 250, name, 20);
		controlName.setFormat(Paths.font('naname_goma.ttf'), 20, 0xFFFFFFFF, LEFT, OUTLINE, 0xFF000000);
		controlName.borderSize = 3;
		add(controlName);

		controlGroup = new ControlsGroup(250, 0, defaultValues, onChange);
		add(controlGroup);

		selected = new FlxSprite().loadGraphic(Paths.image('Option_Selector'));
		selected.color = 0xFFAA00;
		add(selected);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		selected.x = controlGroup.members[keyIndex].x;
	}

	public function set_key(value:FlxKey):Array<FlxKey>
	{
		return controlGroup.set_currentValues(value, keyIndex);
	}

	public function get_key():FlxKey
	{
		return controlGroup.currentValues[keyIndex];
	}

	public function get_keys():Array<FlxKey>
	{
		return controlGroup.currentValues;
	}
}

/**
 * This makes a dynamic sprite out of a group of Control objects.
 * Layer 3
 */
class ControlsGroup extends FlxTypedSpriteGroup<Control>
{
	public var currentValues:Array<FlxKey>;

	public function set_currentValues(value:FlxKey, index:Int):Array<FlxKey>
	{
		currentValues[index] = members[index].set_currentValue(value);
		if (callback != null)
			callback(currentValues);
		return currentValues;
	}

	public var callback:Null<Array<FlxKey>->Array<FlxKey>>;

	public function new(x:Float, y:Float, defaultValues:Array<FlxKey>, onChange:Null<Array<FlxKey>->Array<FlxKey>> = null)
	{
		super(x, y);

		callback = onChange;
		currentValues = defaultValues;

		for (i in 0...defaultValues.length)
		{
			// trace('Making control$i');
			// trace(Std.string(defaultValues[i]));
			var option:Control = new Control(150 * i, 0, defaultValues[i]);
			// trace('Adding control$i');
			add(option);
		}
	}
}

/**
 * THIS IS WHERE THE DISPLAY PROCESSING SHIT GOES.
 * Layer 4, the bottom.
 */
class Control extends FlxTypedSpriteGroup<FlxSprite>
{
	public var currentValue(default, set):FlxKey;

	public function set_currentValue(value:FlxKey):FlxKey
	{
		if (key != null)
			key.text = FlxKey.toStringMap.get(value);

		return currentValue = value;
	}

	private var key:FlxText;
	private var bg:FlxSprite;

	public function new(x:Float, y:Float, defaultValue:FlxKey)
	{
		// trace('New Control');
		super(x, y);

		// trace('curValue will be $defaultValue');
		currentValue = defaultValue;

		// trace('Making BG');
		bg = new FlxSprite().makeGraphic(150, 30, 0xFF000000);
		bg.alpha = 0.6;
		// trace('Adding BG');
		add(bg);

		// trace('Making key text!');
		key = new FlxText(0, 0, bg.width, FlxKey.toStringMap.get(currentValue), 20);
		key.setFormat(Paths.font('naname_goma.ttf'), 20, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
		// trace('Adding key text!');
		add(key);
	}
}
