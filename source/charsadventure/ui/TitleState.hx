package charsadventure.ui;

class TitleState extends FlxState
{
	function setupPrefs():Void
	{
		/**
		 * ALWAYS load the save file BEFORE trying to load prefs.
		 */
		FlxG.save.bind(Constants.SAVE_PREFS, Constants.SAVE_PATH);
		Save.loadDefaultKeys();
		Save.loadPrefs();
		Main.game.framerate = Save.data.framerate;
		Save.loadSaves();
		if (Main.isDebug)
		{
			Save.data.showFPS = true; // force it to start as on, on debug builds
			Save.savePrefs();
		}
		#if MUTE_BGM
		Save.data.muteMusic = true; // yuh
		Save.savePrefs();
		#end
		#if RESET_KEYS
		Save.loadDefaultKeys();
		Save.savePrefs();
		#end
	}

	override function create():Void
	{
		super.create();

		setupPrefs();

		var timer:FlxTimer = new FlxTimer();
		timer.start(1, function(tmr:FlxTimer)
		{
			FlxG.switchState(new MainMenuState());
		});
	}
}
