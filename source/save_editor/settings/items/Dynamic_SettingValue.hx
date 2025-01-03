package save_editor.settings.items;

/**
 *  To solve the issue of the Dynamic type not being able to be used like value(Dynamic typed) = !value; i made a whole class for it that lets the variables be null
 */
class Dynamic_SettingValue
{
	public var bool:Null<Bool> = null;
	public var enumValue:Null<String> = null;
	public var float:Null<Float> = null;

	public function new(valueType:String, defaultValue:Null<Dynamic>)
	{
		switch (valueType)
		{
			case 'bool':
				if (Type.typeof(defaultValue) != TBool)
				{
					trace('Thats not an allowed default value type of "${Type.typeof(defaultValue)}" for bools!, setting as false!');
					bool = false;
				}
				else if (defaultValue != null)
				{
					bool = defaultValue;
				}
				else
				{
					trace('Default Value Null!');
				}

			case 'enum':
				if (!Std.isOfType(defaultValue, String))
				{
					trace('Thats not an allowed default value type of "${Type.typeof(defaultValue)}" for enums(String)! setting as "Null!"');
					enumValue = 'Null!';
				}
				else if (defaultValue != null)
				{
					enumValue = defaultValue;
				}
				else
				{
					trace('Default Value Null!');
				}

			case 'float':
				if (Type.typeof(defaultValue) != TFloat && Type.typeof(defaultValue) != TInt)
				{
					trace('Thats not an allowed default value type of "${Type.typeof(defaultValue)}" for floats! setting the default value to 0.');
					float = 0;
				}
				if (defaultValue != null)
				{
					float = defaultValue;
				}
				else
				{
					trace('Default Value Null! setting the default value to 0.');
					float = 0;
				}
		}
	}
}