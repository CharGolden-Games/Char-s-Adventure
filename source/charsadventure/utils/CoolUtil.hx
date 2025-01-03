package charsadventure.utils;

import flixel.util.FlxStringUtil;

using StringTools;

/**
 * What? Sounds like a class from Friday Night Funkin's source code? Nahhhhhhhhh that can't be right!
 */
class CoolUtil
{
	public function new() {}

	public static var instance(default, null):CoolUtil = new CoolUtil();

	/**
	 * Splits a file by newline
	 * @param path The path to the file 
	 * @return Array<String>
	 */
	public function splitByNewline(path:String):Array<String>
	{
		var string:String;
		if (FileSystem.exists(path))
		{
			string = File.getContent(path);
		}
		else
		{
			string = 'Could not get file! File is null!\nL';
		}

		return string.split('\n');
	}

	/**
	 * Takes a float and formats it to dollars
	 * @param value The float
	 * @return String
	 */
	public function formatDollars(value:Float):String
	{
		var finalString:String = FlxStringUtil.formatMoney(value);
		if (finalString.endsWith('.00'))
		{
			finalString = finalString.split('.')[0];
		}
		return finalString;
	}

	/**
	 * Auto lowercases, trims, and (optionally) replaces spaces with `-`
	 * @param str The string
	 * @param replaceSpaces whether to replace spaces
	 * @return String
	 */
	public function auto_formatString(str:String, replaceSpaces:Bool = false):String
	{
		str = str.toLowerCase().trim();
		if (replaceSpaces)
		{
			str = str.replace(' ', '-');
		}
		return str;
	}
}
