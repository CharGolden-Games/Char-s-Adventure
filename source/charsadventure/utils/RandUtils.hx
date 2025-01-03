package charsadventure.utils;

/**
 * A bunch of utils for randomization.
 */
class RandUtils
{
	/**
	 * Shortcut to FlxG.random.int()
	 * @param min Minimum
	 * @param max Maximum
	 * @param excludes Exclusions
	 * @return Int
	 */
	public static function getRandInt(min:Int, max:Int, ?excludes:Array<Int>):Int
	{
		return FlxG.random.int(min, max, excludes);
	}

	/**
	 * Shortcut to FlxG.random.float()
	 * @param min Minimum
	 * @param max Maximum
	 * @param excludes Exclusions
	 * @return Float
	 */
	public static function getRandFloat(min:Float, max:Float, ?excludes:Array<Float>):Float
	{
		return FlxG.random.float(min, max, excludes);
	}

	/**
	 * Returns a random valid enemy ID
	 * @return Int
	 */
	public static function getRandEnemyID(?validIDs:Array<Int>):Int
	{
		if (validIDs == null)
		{
			validIDs = Constants.validIDs;
		}
		return validIDs[getRandInt(0, validIDs.length)];
	}

	static var keys:Array<String> = [
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
		'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
		'y', 'z', "'", '"', ';', ':', ',', '.', '<', '>', '/', '?', '!', '@', '#', '%', '^', '&', '*', "(", ")"
	];

	/**
	 * Randomly replaces characters in a string.
	 * @param str The string to get the length from
	 * @return String
	 */
	public static function randomText(str:String):String
	{
		var randString:String = '';
		for (i in 0...str.length)
		{
			var random:Int = getRandInt(0, keys.length - 1);
			randString += keys[random];
		};
		return randString;
	}
}
