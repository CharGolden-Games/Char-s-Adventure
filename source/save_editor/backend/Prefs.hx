package save_editor.backend;

import flixel.util.FlxSave;
import shared.utils.Constants; // For file Paths
import shared.utils.Save.SaveVariables; // For a specific setting in SaveVariables
import shared.utils.Save; // For actually reading and writing to those files.

/**
 * Handles preferences of the save editor
 * 
 * Note to self, when restructuring the folders later, do NOT forget to also change the paths here!
 */
class Preferences
{
	public var antialiasing:Bool = false;
	public var scrollSpeed:Int = 10;
	public var customSettings:Array<CustomSetting> = [new CustomSetting('test', 'test', 'bool', true)]; // Will this work? who the fuck knows!

	public function new() {}
}

class CustomSetting
{
	public var savePath:String;
	public var key:String;
	public var type:String;
	public var value:Dynamic;

	public function new(savePath:String, key:String, type:String, value:Dynamic)
	{
		this.savePath = savePath;
		this.key = key;
		this.type = type;
		this.value = value;
	}
}

/**
 * Aint it so damn cool that because they're essentially the same project, i dont have to update much of the code!
 * 
 * Also yes these are basically just redirects to the original code so i don't have to actually update things lmao.
 */
class Prefs extends Save
{
	public static var data:Preferences;
	public static var gameData:SaveVariables;

	/**
	 * Redirects to shared.backend.Save.loadSaves()
	 */
	public static function loadSaves()
	{
		Save.loadSaves();
	}

	/**
	 * Loads editor Preferences as well as the preferences for the game
	 */
	public static function load_Preferences()
	{
		if (data == null)
			data = new Preferences();
		if (gameData == null)
			gameData = new SaveVariables();

		var gameSave:FlxSave = new FlxSave();
		gameSave.bind(Constants.SAVE_PREFS, Constants.SAVE_PATH);

		var save:FlxSave = new FlxSave();
		save.bind(Constants.EDITOR_PREFS, Constants.EDITOR_SAVE_PATH);

		for (key in Reflect.fields(data))
		{
			if (Reflect.hasField(save.data, key))
			{
				// trace('loaded variable: $key');
				Reflect.setField(data, key, Reflect.field(save.data, key));
			}
		}

		for (key in Reflect.fields(data))
		{
			if (Reflect.hasField(gameSave.data, key))
			{
				// trace('loaded variable: $key');
				Reflect.setField(gameSave, key, Reflect.field(gameSave.data, key));
			}
		}
	}

	public static function save_Preferences()
	{
		trace('Saving Preferences!');

		var gameSave:FlxSave = new FlxSave();
		gameSave.bind(Constants.SAVE_PREFS, Constants.SAVE_PATH);

		for (key in Reflect.fields(data))
		{
			var savedAs = Reflect.field(data, key);
			// trace('saved variable: $key as $savedAs');
			Reflect.setField(FlxG.save.data, key, Reflect.field(data, key));
		}
		for (key in Reflect.fields(gameData))
		{
			var savedAs = Reflect.field(gameData, key);
			// trace('saved variable: $key as $savedAs');
			Reflect.setField(gameSave.data, key, Reflect.field(gameData, key));
		}
		FlxG.save.flush();
		gameSave.flush();
	}

	/**
	 * Redirects to shared.backend.Save.save_Saves()
	 */
	public static function save_Saves()
	{
		Save.save_Saves();
	}
}
