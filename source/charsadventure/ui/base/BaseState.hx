package charsadventure.ui.base;

import flixel.FlxBasic;
import flixel.sound.FlxSoundGroup;
import flixel.system.FlxAssets.FlxSoundAsset;
import charsadventure.play.components.CustomCam;
import charsadventure.ui.base.components.PrintText.PrintTextGroup;

/**
 * The class all other states extend containing basic functions and setup
 */
class BaseState extends FlxUIState
{
	public var camGame:CustomCam;
	public var camHUD:CustomCam;
	public var camDialogue:CustomCam;
	public var camTrace:CustomCam;
	public var camWatermark:CustomCam;

	var grpPrint:PrintTextGroup;
	var leftWatermark:FlxText;
	var rightWatermark:FlxText;

	public var leftWatermarkText:String;
	public var rightWatermarkText:String;
	public var isDebug:Bool = (Main.isDebug || Main.forceDebug);

	public var controls(get, never):Controls;

	function get_controls():Controls
	{
		return Controls.instance;
	}

	public var volume(get, default):Int;

	function get_volume():Int
	{
		if (Save.data.muteMusic)
		{
			return 0;
		}
		return 1;
	}

	public var lowQuality(get, set):Bool;

	function get_lowQuality():Bool
	{
		return Save.data.lowQuality;
	}

	function set_lowQuality(value:Bool):Bool
	{
		Save.data.lowQuality = value;
		Save.savePrefs();
		return Save.data.lowQuality;
	}

	override function create():Void
	{
		setupCams();
		super.create();

		grpPrint = new PrintTextGroup();
		add(grpPrint);
		grpPrint.cameras = [camTrace];

		createPost();
		FlxG.watch.add(Save.save0, "dollars", "Save0 Dollars:");
		FlxG.watch.add(Save.save1, "dollars", "Save1 Dollars:");
		FlxG.watch.add(Save.save2, "dollars", "Save2 Dollars:");

		FlxG.watch.add(Save.save0, "gold", "Save0 Gold:");
		FlxG.watch.add(Save.save1, "gold", "Save1 Gold:");
		FlxG.watch.add(Save.save2, "gold", "Save2 Gold:");
	}

	/**
	 * Creates the cameras used by the game.
	 */
	public function setupCams():Void
	{
		camGame = new CustomCam(0, 0, 0, 0, 'camGame');
		camHUD = new CustomCam(0, 0, 0, 0, 'camHUD');
		camDialogue = new CustomCam(0, 0, 0, 0, 'camDialogue');
		camTrace = new CustomCam(0, 0, 0, 0, 'camTrace');
		camWatermark = new CustomCam(0, 0, 0, 0, 'camWatermark');

		camHUD.bgColor.alpha = 0;
		camDialogue.bgColor.alpha = 0;
		camTrace.bgColor.alpha = 0;
		camWatermark.bgColor.alpha = 0;

		FlxG.cameras.add(camGame);
		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.add(camDialogue, false);
		FlxG.cameras.add(camTrace, false);
		FlxG.cameras.add(camWatermark, false);
	}

	/**
	 * Put stuff to happen after create here!
	 */
	public function createPost():Void
	{
		if (leftWatermarkText != null)
		{
			leftWatermark = new FlxText(0, 0, FlxG.width, leftWatermarkText, 10);
			leftWatermark.setFormat(Paths.font('naname_goma.ttf'), 10, 0xFFFFFFFF, LEFT, OUTLINE, 0xFF000000);
			leftWatermark.borderSize = 3;
			leftWatermark.cameras = [camWatermark];
			add(leftWatermark);
		}
		if (rightWatermarkText != null)
		{
			rightWatermark = new FlxText(0, 0, FlxG.width, rightWatermarkText, 10);
			rightWatermark.setFormat(Paths.font('naname_goma.ttf'), 10, 0xFFFFFFFF, RIGHT, OUTLINE, 0xFF000000);
			rightWatermark.borderSize = 3;
			rightWatermark.cameras = [camWatermark];
			add(rightWatermark);
		}
		// Put shit to happen post-create here.
	}

	var frameTick:Int = 0;

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		frameTick++;
		if (frameTick % Main.game.framerate == 0)
		{
			frameTick = 0;
			updateOnSeconds(elapsed);
		}
		updatePost(elapsed);
	}

	/**
	 * Put stuff to happen after update here!
	 * @param elapsed How long the state has existed (i think)
	 */
	public function updatePost(elapsed:Float):Void
	{
		// Put shit to happen post-update here.
	}

	/**
	 * Put stuff to happen every second here!
	 * @param elapsed How long the state has existed (i think)
	 */
	public function updateOnSeconds(elapsed:Float):Void
	{
		// Put shit to happen every second here.
	}

	var printTween:FlxTween;

	/**
	 * Trace but better.
	 * @param v What to print
	 * @param pos File info.
	 */
	public function printOut(v:Dynamic, ?pos:Null<haxe.PosInfos>):Void
	{
		var traceString:String = haxe.Log.formatOutput(v, pos);
		Sys.println(traceString);
		grpPrint.addPrintText(traceString);
	}

	/**
	 * Trace but better. (Redirect function for legacy code.)
	 * @param v What to print
	 * @param pos File info.
	 */
	public function print(v:Dynamic, ?pos:Null<haxe.PosInfos>):Void
	{
		printOut(v, pos);
	}

	/**
	 * Shortcut to FlxG.sound.playMusic
	 * @param embeddedSound Sound to play
	 * @param volume How loud it should be
	 * @param looped If it should loop
	 * @param group The group to add the sound to.
	 */
	public function playMusic(embeddedSound:FlxSoundAsset, volume:Float = 1, looped:Bool = true, ?group:FlxSoundGroup):Void
	{
		FlxG.sound.playMusic(embeddedSound, volume, looped, group);
	}
}
