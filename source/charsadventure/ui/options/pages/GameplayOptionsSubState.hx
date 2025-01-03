package charsadventure.ui.options.pages;

import flixel.addons.display.FlxBackdrop;

class GameplayOptionsSubState extends BaseSettingsSubstate
{
	public function new(playState:Bool = false)
	{
		super();

		var bgScroller:FlxBackdrop = new FlxBackdrop(Paths.image('menuBG/trevor_SettingsBG'));

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
		createNumOption('Difficulty', 'Changes how hard the game is.', get_difficulty(), 1, 3, 1, 0, function(value:Float):Float
		{
			return set_difficulty(Std.int(value));
		}, function(value:Float):String
		{
			var finalString = '';
			switch (value)
			{
				case 1:
					finalString = 'Easy';
				case 2:
					finalString = 'Normal';
				case 3:
					finalString = 'Hard';
			}
			return finalString;
		}, true);

		createCheckBox('Combustible Lemons', Constants.lemonsQuote, get_combustibleLemons(), set_combustibleLemons);

		createCheckBox('Mute Music', 'Mutes the in-game music', get_muteMusic(), set_muteMusic);
	}
}
