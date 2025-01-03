package charsadventure.ui.options.pages;

import flixel.addons.display.FlxBackdrop;

class GraphicsOptionsSubState extends BaseSettingsSubstate
{
	public function new(playState:Bool = false)
	{
		super();

		var bgScroller:FlxBackdrop = new FlxBackdrop(Paths.image('menuBG/char_SettingsBG_Desat'));

		bgScroller.color = 0xFF7B00;

		bgScroller.velocity.set(40, 40);

		add(bgScroller);

		bgScroller.cameras = [camBG];

		OptionsState.blockInput = true;

		camMenu.follow(camFollow, LOCKON, 0.06);

		changeSelection();

		if (playState)
		{
			camBG.tweenAlpha(0.7, 0.5);
		}
	}

	override function createOptions():Void
	{
		super.createOptions();
		createCheckBox('Low Quality', 'Disables Anti-aliasing and some background elements.', get_lowQuality(), function(value:Bool):Bool
		{
			return set_lowQuality(value);
		});
		createCheckBox('Show FPS',
			"Think you're havin' framerate problems? or just making a mod and need to track the framerate? then do i have the option for you!", get_showFPS(),
			function(value:Bool):Bool
			{
				return set_showFPS(value);
			});
		createCheckBox('Borderless Window', 'Removes the border of the window. Duh.', get_borderlessWindow(), function(value:Bool):Bool
		{
			return set_borderlessWindow(value);
		});
		// Gonna make this game have VSync, rendering this option useless.
		/*createNumOption('Framerate', 'How fast the game fuckin RUNS', get_framerate(), 60, 240, 1, 0, function(value:Float):Float
			{
				return set_framerate(Std.int(Math.round(value)));
		});*/
	}
}
