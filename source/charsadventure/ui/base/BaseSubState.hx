package charsadventure.ui.base;

/**
 * This class handles all SubState creation
 * this will be changed as i need it to.
 */
class BaseSubState extends FlxSubState
{
	var volume:Int = 1;

	public var isDebug:Bool = (Main.isDebug || Main.forceDebug);
	public var controls(get, never):Controls;

	function get_controls():Controls
	{
		return Controls.instance;
	}

	public function new()
	{
		super();
	}

	override function create():Void
	{
		super.create();
		createPost();
	}

	function createPost():Void
	{
		// Put post create shit here.
	}

	var frameTick:Int = 0;

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		frameTick++;
		if (frameTick % (Main.game.framerate * 0.5) == 0)
		{
			updateOnHalfSeconds(elapsed);
		}
		if (frameTick % Main.game.framerate == 0)
		{
			frameTick = 0;
			updateOnSeconds(elapsed);
		}

		updatePost(elapsed);
	}

	function updateOnHalfSeconds(elapsed:Float):Void
	{
		// Put stuff to happen every half second.
	}

	function updateOnSeconds(elapsed:Float):Void
	{
		// Put stuff to happen every second.
	}

	function updatePost(elapsed:Float):Void
	{
		// put post update shit here.
	}
}
