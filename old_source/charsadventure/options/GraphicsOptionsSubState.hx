package charsadventure.options;

import charsadventure.options.items.*;
import flixel.addons.display.FlxBackdrop;

class GraphicsOptionsSubState extends BaseSettingsSubstate
{
	var grpOptions:FlxTypedGroup<Checkbox>;
	var grpTexts:FlxTypedGroup<FlxText>;
	var BG:FlxSprite;
	var curSelected:Int = 0;
	var camMenu:FlxCamera;
	var camFollow:FlxObject;

	public function new()
	{
		OptionsState.blockInput = true;
		super();
		camMenu = new FlxCamera();
		FlxG.cameras.add(camMenu);

		camFollow = new FlxObject(FlxG.width * 0.5, 0, 10, 10);
		add(camFollow);
		camMenu.follow(camFollow, LOCKON, 0.06);

		BG = new FlxSprite().loadGraphic(Paths.image('menuBG/char_SettingsBG'));
		BG.scrollFactor.set(0, 0);
		var bgScroller:FlxBackdrop = new FlxBackdrop(BG.graphic);
		bgScroller.velocity.set(40, 40);
		add(bgScroller);
		FlxTween.tween(bgScroller, {color: 0xFF7B00}, 1, {ease: FlxEase.quartIn});

		grpOptions = new FlxTypedGroup<Checkbox>();
		grpTexts = new FlxTypedGroup<FlxText>();
		add(grpOptions);
		add(grpTexts);

		createOptions();
		changeSelection();
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
				var referenceMember = grpTexts.members[i];
				referenceMember.color = 0xFFE600;
				camFollow.y = referenceMember.y;
			}
			if (i != curSelected)
				grpTexts.members[i].color = 0xFFFFFF;
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function createOptions()
	{
		createCheckBox('Low Quality', 'Disables Anti-aliasing and some background elements.', Save.data.lowQuality, 'lowQuality');
		createCheckBox('Show FPS',
			"Think you're havin' framerate problems? or just making a mod and need to track the framerate? then do i have the option for you!",
			Save.data.showFPS, 'showFPS');
		createCheckBox('Borderless Window', 'Removes the border of the window. Duh.', Save.data.borderlessWindow, 'borderlessWindow');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.UP || FlxG.keys.justPressed.A || FlxG.keys.justPressed.W)
		{
			changeSelection(-1);
		}
		if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S || FlxG.keys.justPressed.D)
		{
			changeSelection(1);
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.sound.play(Paths.sound('accept'));
			var checkbox = grpOptions.members[curSelected];
			switch (checkbox.setting)
			{
				case 'lowQuality':
					checkbox.set_currentValue(!checkbox.currentValue);
					set_lowQuality(checkbox.currentValue);

				case 'showFPS':
					checkbox.set_currentValue(!checkbox.currentValue);
					set_showFPS(checkbox.currentValue);
				case 'borderlessWindow':
					checkbox.set_currentValue(!checkbox.currentValue);
					set_borderlessWindow(checkbox.currentValue);
			}
		}
		if (FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.ESCAPE)
		{
			camFollow.x = FlxG.width * 0.5;
			camFollow.y = FlxG.height * 0.5;
			close();
		}
	}

	function createCheckBox(name:String, desc:String, defaultValue:Bool, setting:String)
	{
		var checkbox:Checkbox = new Checkbox(20, 150 * grpOptions.length, defaultValue, setting);

		var text:FlxText = new FlxText(150, 150 * grpTexts.length, 0, name, 60);
		grpOptions.add(checkbox);
		grpTexts.add(text);
	}
}