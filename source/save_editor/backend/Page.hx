package save_editor.backend;

import sys.io.File;
import tjson.TJSON as Json;

/**
 * A type specifically meant to aid in constructing settings from json files.
 */
typedef SettingFormat =
{
	/**
	 * The name of the setting
	 */
	public var title:String;

	/**
	 * The icon to use
	 */
	public var icon:String;

	/**
	 * The type of setting
	 */
	public var type:String;

	/**
	 * The setting's default value
	 */
	public var defaultValue:Dynamic;

	/**
	 * The variable to affect.
	 */
	public var saveVariable:String;

	/**
	 * List of possible values for this enum, if applicable
	 */
	@:optional public var enumValues:Array<String>;

	/**
	 * If a setting affects/is affected by another option, set that option as its parent.
	 */
	@:optional public var parentOption:String;

	/**
	 * This is specifically for pointing to the script to use as the callback function. 
	 * looks for the function called function ScriptCallback(value:<Value type of the setting>):<Value type of the setting>
	 */
	@:optional public var scriptCallback:String;

	/**
	 * Minimum for float options
	 */
	@:optional public var min:Float;

	/**
	 * Maximum for float options
	 */
	@:optional public var max:Float;

	/**
	 * Precision for float options
	 */
	@:optional public var precision:Float;
}

/**
 * Just cause. needed something that could make a big list of settings, that each have actual settings.
 */
typedef PageList =
{
	public var settings:Array<SettingFormat>;
}

class Page
{
	/**
	 * What settings are currently set.
	 */
	public var loadedSettings:Array<SettingFormat>;

	/**
	 * Used to construct a setting to push to the page list as idk if you can just add it into the settings thing in the `return {settings:[<settings>]}`.
	 * @param title The name of the setting, also what gets displayed above it.
	 * @param icon What image it goes beside
	 * @param type The type of the setting <Bool | (Number | Float | Int) | Enum>
	 * @param defaultValue What do you think? What the value starts as.
	 * @param saveVariable The save variable to affect
	 * @param enumValues List of possible values for this enum, if applicable
	 * @param parentOption If a setting affects/is affected by another option, set that option as its parent.
	 * @param scriptCallback This is specifically for pointing to the script to use as the callback function. 
	 * @param ^Continued looks for the function called `function ScriptCallback(value:<Value type of the setting>):<Value type of the setting>`
	 * @return Setting_Format
	 */
	public static function constructSetting(title:String, icon:String, type:String, defaultValue:Dynamic, saveVariable:String, ?min:Float, ?max:Float,
			?precision:Float, ?enumValues:Null<Array<String>> = null, ?parentOption:Null<String>, ?scriptCallback:Null<String> = null):SettingFormat
	{
		return {
			title: title,
			icon: icon,
			type: type,
			defaultValue: defaultValue,
			saveVariable: saveVariable,
			min: min,
			max: max,
			precision: precision,
			parentOption: parentOption,
			enumValues: enumValues,
			scriptCallback: scriptCallback
		}
	}

	function defaultList():PageList
	{
		return {
			settings: [
				constructSetting('Test Setting Bool', 'bitchAssets/charIcon', 'bool', false, 'none'),
				constructSetting('Test Setting Enum', 'bitchAssets/charIcon', 'Enum', 'Test1', 'none', null, null, null, ['Test1', 'Test2', 'Test3']),
				constructSetting('Test Setting Float', 'bitchAssets/charIcon', 'float', 1, 'none', 0, 1, 0.1)
			]
		};
	}

	function retrieveFromFile(path:String):PageList
	{
		var rawJson = File.getContent(Paths.data(path)); /*Paths.mergeAllTextsNamed(Paths.data(path))*/

		if (rawJson == null)
			return defaultList();

		return cast Json.parse(rawJson, path);
	}

	/**
	 * Initialize a page's settings list with a json's settings array.
	 * @param path Where the json is in the data folder
	 */
	public function new(?path:String)
	{
		if (path != null)
		{
			var settings = retrieveFromFile(path);
			loadedSettings = settings.settings;
		}
		else
		{
			loadedSettings = defaultList().settings;
		}
	}
}
