package cre.play;

import flixel.FlxSubState;

typedef RatingCounts =
{
	public var perfects:Int;
	public var sicks:Int;
	public var goods:Int;
	public var bads:Int;
	public var shits:Int;
}

/**
 * Extends a sub state so it can be used as a menu
 * 
 * e.g. Char's Adventure (Working Title) rhythm minigame.
 */
class PlayState extends FlxSubState
{
	/**
	 * The current instance of `this`
	 */
	public static var instance:PlayState;

	/**
	 * The current score
	 */
	public var score:Int = 0;

	/**
	 * The current misses in the song
	 */
	public var songMisses:Int = 0;

	/**
	 * The current count of all the ratings.
	 */
	public var ratingCounts:RatingCounts = {
		perfects: 0,
		sicks: 0,
		goods: 0,
		bads: 0,
		shits: 0
	};

	/**
	 * If you want to load assets not from `assets/cre/`, change this variable and it'll reflect in Paths.hx.
	 */
	public static var overridePath:String = 'assets/cre';

	/**
	 * The current accuracy as notesHit/totalPlayed
	 */
	public var songPercent:Float = 0;

	/**
	 * How many notes have passed the strumline so far.
	 */
	public var totalPlayed:Int = 0;

	/**
	 * The current note combo
	 */
	public var songCombo:Int = 0;

	public function new()
	{
		// TODO: Make this do something.
		super();

		Paths.module_AssetPath = overridePath;
	}

	override function create():Void
	{
		instance = this;
	}
}
