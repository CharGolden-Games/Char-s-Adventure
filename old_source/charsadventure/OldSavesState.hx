package charsadventure.states;

import shared.backend.CheckForOldSaves;
import shared.backend.Save.SaveVariables;

/**
 * This is useless for now.
 */
class OldSavesState extends BaseState
{
	var validSaves:Array<Int> = [];
	var grpOptions:FlxTypedGroup<FlxText>;
	var curSelected:Int = 0;

	public function new()
	{
		validSaves = CheckForOldSaves.checkSaves();
		super();
	}

	override function create()
	{
		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);
		for (validSave in validSaves)
		{
			var saveString:String = 'Old Save $validSave';
			if (validSave == 3)
			{
				saveString = 'Old Preferences';
			}

			var text:FlxText = new FlxText(20, 150 * grpOptions.members.length, 0, saveString, 60);
			grpOptions.add(text);
		}

		changeSelection();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.move_up_p)
		{
			changeSelection(-1);
		}
		if (controls.move_down_p)
		{
			changeSelection(1);
		}
		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
		{
			CheckForOldSaves.importSave(validSaves[curSelected]);
		}
		if (FlxG.keys.justPressed.BACKSPACE)
		{
			FlxG.switchState(new MainMenuState());
		}
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
				grpOptions.members[i].color = 0xFFE600;
			if (i != curSelected)
				grpOptions.members[i].color = 0xFFFFFF;
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}