package cre.utils;

import cre.utils.Constants.NoteColors;

/**
 * This class handles actual setting of... settings.
 */
class LocalSettings
{
	public static var defaultSettings:Settings = new Settings();
	public static var data:Settings;

	public function loadDefaults():Settings
	{
		if (data == null)
		{
			data = new Settings();
		}
		for (key in Reflect.fields(defaultSettings))
		{
			Reflect.setField(data, key, Reflect.field(defaultSettings, key));
			Reflect.setField(FlxG.save.data, key, Reflect.field(defaultSettings, key));
		}

		FlxG.save.flush();

		return data;
	}

	/**
	 * Sets a setting to a certain value if it exists.
	 * @param setting The setting to change
	 * @param value The value
	 */
	public function setSetting(setting:String, value:String):Void
	{
		if (Reflect.fields(data).contains(setting))
		{
			try
			{
				Reflect.setField(data, setting, value);
				Reflect.setField(FlxG.save.data, setting, value);
			}
			catch (e:Dynamic)
			{
				trace('SETTING $setting DOES NOT EXIST!');
			}
		}

		FlxG.save.flush();
	}
}

/**
 * This class holds all the settings.
 */
class Settings
{
	/**
	 * Controls whether to use antialiasing for sprites.
	 */
	public static var globalAntialiasing:Bool = true;

	public static var perfectWindow:Int = 15;
	public static var sickWindow:Int = 45;
	public static var goodWindow:Int = 90;
	public static var badWindow:Int = 135;

	public static var noteColors:Array<NoteColors> = [
		Constants.noteColors_Left,
		Constants.noteColors_Down,
		Constants.noteColors_Up,
		Constants.noteColors_Right
	];

	public function new()
	{
		// Flixel requires a constructer.
	}
}
