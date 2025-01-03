package shared.utils;

import flixel.FlxState;

/**
 * This class handles variables used to setup a new FlxGame.
 */
class GameSetup
{
	public var width:Int = 0;
	public var height:Int = 0;
	public var initialState:Class<FlxState>;
	public var skipSplash:Bool = false;
	public var startFullscreen:Bool = false;
	public var framerate:Int = 60;
	public var updateFramerate:Int = 60;

	/**
	 * @param w Width
	 * @param h Height
	 * @param initialState What state to start in
	 * @param skipSplash Whether to skip the "Powered by HaxeFlixel" screen.
	 * @param startFullscreen Whether to start fullscreen
	 * @param updateFramerate How fast to update objects
	 * @param framerate How fast to actually draw objects.
	 */
	public function new(w:Int = 0, h:Int = 0, initialState:Class<FlxState>, skipSplash:Bool = false, startFullscreen:Bool = false, updateFramerate,
			framerate:Int = 60, borderless:Bool = false)
	{
		width = w;
		height = h;
		this.initialState = initialState;
		this.skipSplash = skipSplash;
		this.startFullscreen = startFullscreen;
		this.framerate = framerate;
		this.updateFramerate = updateFramerate;
		Main.isBorderless = borderless;
	}
}
