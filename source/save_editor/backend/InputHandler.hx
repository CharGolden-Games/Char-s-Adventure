package save_editor.backend;

import flixel.FlxObject;
import flixel.input.keyboard.FlxKey;

class InputHandler
{
	static var mouseWheelCallback:Int->Int;

	static var mouseWheelDelta(get, null):Int;

	public static var stringToFlxKey:Map<String, FlxKey> = [
		'ENTER' => FlxKey.ENTER,
		'ESCAPE' => FlxKey.ESCAPE,
		'UP' => FlxKey.UP,
		'DOWN' => FlxKey.DOWN,
		'LEFT' => FlxKey.LEFT,
		'RIGHT' => FlxKey.RIGHT,
	];

	public static function handle_MouseWheel():Int
	{
		var delta = get_mouseWheelDelta();
		mouseWheelCallback = function(delta:Int)
		{
			return Std.int(Prefs.data.scrollSpeed * delta);
		};
		return mouseWheelCallback(delta);
	}

	public static function handle_JustReleased_Keys(key:FlxKey):Bool
	{
		return FlxG.keys.anyJustReleased([key]);
	}

	public static function handle_JustPressed_Keys(key:FlxKey):Bool
	{
		return FlxG.keys.anyJustPressed([key]);
	}

	public static function handle_Keys(key:FlxKey):Bool
	{
		return FlxG.keys.anyPressed([key]);
	}

	static function get_mouseWheelDelta():Int
	{
		return FlxG.mouse.wheel;
	}

	/**
	 * Shortcut to FlxG.overlap(O, mouseSquare);
	 * @param O Object to check.
	 * @param mouseSquare The mouse square FlxSprite to check
	 * @return Bool
	 */
	public static function get_mouseOverObject(O:FlxObject, mouseSquare:FlxSprite):Bool
	{
		if (FlxG.overlap(O, mouseSquare))
		{
			return true;
		}
		return false;
	}
}
