package;

import lime.app.Application;
import flixel.FlxGame;
import openfl.display.Sprite;

using StringTools;

import charsadventure.ui.TitleState;
import save_editor.PlayState;

/**
 * The class thats used when initializing the game, also contains important referenceable variables
 */
class Main extends Sprite
{
	/**
	 * Tells you how fast the game is goin at the moment.
	 */
	public static var fpsDisplay:FPS;

	/**
	 * Whether to force some debug options to on.
	 */
	public static var forceDebug:Bool = false;

	/**
	 * Whether the game window should have a border
	 */
	public static var isBorderless(default, set):Bool;

	/**
	 * So i can make forceDebug actually do stuff.
	 */
	public static var isDebug(get, default):Bool;

	static function get_isDebug():Bool
	{
		#if debug
		return true;
		#end

		if (forceDebug)
		{
			return true;
		}

		return false;
	}

	static function set_isBorderless(value:Bool):Bool
	{
		Application.current.window.borderless = value;
		isBorderless = value;
		return isBorderless;
	}

	// TODO: ADD AN EVENT THAT KEEPS THE FPS DISPLAY IN THE CENTER.
	public static var game(get, default):GameSetup;

	static var is_saveEditor:Bool = false; // So I can retire the old alt XML method.

	static function get_game():GameSetup
	{
		var gameSetup:GameSetup = new GameSetup(1280, 720, TitleState, false, false, 60, 60);
		if (is_saveEditor)
		{
			gameSetup.initialState = PlayState;
		}

		return gameSetup;
	}

	/**
	 * The actual game.
	 */
	public static var app:FlxGame;

	public function new()
	{
		#if debug isDebug = true; #end
		super();
		#if sys
		trace('Arguments passed: "${Std.string(Sys.args())}"');
		for (argument in Sys.args())
		{
			argument = argument.replace('-', '').trim();
			for (argument2 in ['forcedebug', 'force-debug'])
			{
				if ((argument.toLowerCase()).contains(argument2))
				{
					forceDebug = true;
					trace('Debug functions active!' #if debug + ' (Although it was already a debug build...)' #end);
				}
			}
			if (argument == 'debug')
			{
				forceDebug = true;
				trace('Debug functions active!' #if debug + ' (Although it was already a debug build...)' #end);
			}
			if (argument.contains('test'))
			{
				Application.current.window.alert('FUCK YOU');
			}
			#if debug
			if (argument.contains('livereload'))
			{
				Application.current.window.alert("What the fuck does -livereload even do? you probably used `lime test` didn't you?
				\nBy the way this message is in Main.hx, Line 94-95");
			}
			#end
			if (argument.contains('save_edit'))
			{
				trace('Loading Save Editor!');
				is_saveEditor = true;
			}
		}
		#end
		#if SAVE_EDITOR
		// just force it on.
		is_saveEditor = true;
		#end
		Controls.instance = new Controls();
		app = new FlxGame(game.width, game.height, game.initialState, game.updateFramerate, game.framerate, game.skipSplash, game.startFullscreen);
		addChild(app);
		if (!is_saveEditor)
			setupFPS();
	}

	/**
	 * Shows or hides the game.
	 */
	public static function hide_show_Game():Void
	{
		app.visible = !app.visible;
	}

	#if debug
	/**
	 * Purposefully throws an uncaught error.
	 */
	public static function fauxCrash():Void
	{
		throw 'This is a test crash!';
	}
	#end

	/**
	 * This is my attempt to keep the FPS display visible in all areas.
	 */
	public static var fpsBacker:FPS;

	function setupFPS():Void
	{
		#if !mobile
		// Fun fact idk why this is like this in fnf, but i assume its some sort of incompatibility with mobile platforms :shrug:
		fpsDisplay = new FPS(640 /*Make it center of the screen.*/, 0, 0x000000);
		fpsBacker = new FPS(638, 2, 0x000000, 10);
		fpsBacker.changeColor = false;
		addChild(fpsBacker);
		addChild(fpsDisplay);
		fpsBacker.visible = Save.data.showFPS;
		fpsDisplay.visible = Save.data.showFPS;
		#end
	}
}
