package charsadventure.ui.options;

// Tfw I've only ever made Funkin' Psych Engine based States
class OptionsState extends BaseState
{
	var options:Array<String> = ['Graphics', 'Controls', 'Gameplay'];
	var grpOptions:FlxTypedGroup<FlxText>;
	var curSelected:Int = 0;

	public static var isPlaystate:Bool = false;
	public static var blockInput:Bool = false;

	var pauseMusic:FlxSound;

	public function new()
	{
		super();
		persistentUpdate = true;
		persistentDraw = true;
	}

	var bgScroller:FlxBackdrop;

	override function create():Void
	{
		bgScroller = new FlxBackdrop(Paths.image('menuBG/char_SettingsBG_Desat'));
		bgScroller.velocity.set(40, 40);
		bgScroller.color = 0xFFA600;
		add(bgScroller);
		/*if (isPlaystate)
			{
				var oldPauseMusic:FlxSound = charsadventure.substates.PauseSubState.instance.pauseMusic;
				pauseMusic = new FlxSound().loadEmbedded(Paths.music('bgm/underground'), true);
				pauseMusic.play(false, oldPauseMusic.time);
				pauseMusic.volume = oldPauseMusic.volume;

				FlxG.sound.list.add(pauseMusic);
		}*/
		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);
		for (i in 0...options.length)
		{
			var text:FlxText = new FlxText(20, 150 * i, 0, options[i], 30);
			text.setFormat(Paths.font('naname_goma.ttf'), 30, 0xFFFFFFFF, LEFT, OUTLINE, 0xFF000000);
			text.borderSize = 3;
			grpOptions.add(text);
		}

		changeSelection();
	}

	override function createPost():Void
	{
		super.createPost();

		try
		{
			camGame.bgColor = 0xFF000000;
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}

	var timer:FlxTimer;

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (isPlaystate)
			if (pauseMusic.volume < 1)
				pauseMusic.volume += 0.01 * elapsed;

		if (!blockInput)
		{
			if (controls.ui_up_p)
			{
				changeSelection(-1);
			}
			if (controls.ui_down_p)
			{
				changeSelection(1);
			}
			if (controls.back)
			{
				if (!isPlaystate)
					FlxG.switchState(new MainMenuState());
				if (isPlaystate)
				{
					isPlaystate = false;
					pauseMusic.stop();
					FlxG.switchState(new PlayState());
				}
			}
			if (controls.accept)
			{
				FlxG.sound.play(Paths.sound('accept'));
				switch (options[curSelected])
				{
					case 'Graphics':
						openSubState(new GraphicsOptionsSubState());
					case 'Controls':
						openSubState(new ControlsSubState());
					case 'Gameplay':
						openSubState(new GameplayOptionsSubState());
				}
			}
			if (FlxG.keys.justPressed.R)
			{
				timer = new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					if (FlxG.keys.pressed.R)
					{
						Save.loadDefaultKeys();
						Save.resetKeys();
						Application.current.window.alert('Reset all keys!');
						timer = null;
					}
				});
			}
			if (FlxG.keys.justReleased.R)
			{
				if (timer != null)
				{
					timer.cancel();
				}
			}
		}
	}

	override function closeSubState():Void
	{
		super.closeSubState();
		Save.savePrefs();
		if (blockInput)
			blockInput = false;
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = grpOptions.members.length - 1;
		if (curSelected >= grpOptions.members.length)
			curSelected = 0;
		for (i in 0...grpOptions.members.length)
		{
			if (i == curSelected)
			{
				grpOptions.members[i].color = 0xFFE600;
				grpOptions.members[i].alpha = 1;
			}
			if (i != curSelected)
			{
				grpOptions.members[i].color = 0xFFFFFF;
				grpOptions.members[i].alpha = 0.4;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
