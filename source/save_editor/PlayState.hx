package save_editor;

import charsadventure.ui.mainmenu.components.RunSaveEditor;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import save_editor.backend.Page;
import save_editor.settings.Setting;

using StringTools;

/**
 * yuh.
 */
class PlayState extends FlxState
{
	var cam:FlxCamera;
	var grpOptions:FlxTypedGroup<Setting>;
	var scrollSpeed(get, default):Int;
	var curSelected:Int = 0;
	var pageOptions:Page;
	var pages:Pages;
	var mouseSquare:FlxSprite;

	var scroll_Up(get, default):Int;

	function get_scroll_Up():Int
	{
		return
			FlxG.mouse.wheel == 1 ? InputHandler.handle_MouseWheel() : InputHandler.handle_JustPressed_Keys(InputHandler.stringToFlxKey['UP']) != false ? scrollSpeed : 0;
	}

	var scroll_Down(get, default):Int;

	function get_scroll_Down():Int
	{
		return FlxG.mouse.wheel == -1 ? InputHandler.handle_MouseWheel() : InputHandler.handle_JustPressed_Keys(InputHandler.stringToFlxKey['DOWN']) != false ?
			-scrollSpeed : 0;
	}

	var enter:Bool = false;
	var exit:Bool = false;
	var left:Bool = false;
	var right:Bool = false;

	function checkKeys():Void
	{
		enter = InputHandler.handle_JustPressed_Keys(InputHandler.stringToFlxKey['ENTER']);
		exit = InputHandler.handle_JustPressed_Keys(InputHandler.stringToFlxKey['ESCAPE']);
		left = InputHandler.handle_JustPressed_Keys(InputHandler.stringToFlxKey['LEFT']);
		right = InputHandler.handle_JustPressed_Keys(InputHandler.stringToFlxKey['RIGHT']);
		// get_scroll_Down();
		// get_scroll_Up();
	}

	function get_scrollSpeed():Int
	{
		return Prefs.data.scrollSpeed;
	}

	override function create():Void
	{
		super.create();

		pages = new Pages();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF880088);
		add(bg);

		trace('This project is not finished!');
		FlxG.log.add('This project is not finished!');

		grpOptions = new FlxTypedGroup<Setting>();
		add(grpOptions);

		pageOptions = pages.mainPage.pageOptions;
		for (settingOptions in pageOptions.loadedSettings)
		{
			var setting:Setting = new Setting(0, (120 * grpOptions.members.length + 15), settingOptions.icon, settingOptions.type, settingOptions.title,
				settingOptions.defaultValue, ScriptCallbackHandler.script_to_callback(settingOptions.scriptCallback, settingOptions.type),
				settingOptions.enumValues, settingOptions.min, settingOptions.max, settingOptions.precision);
			grpOptions.add(setting);
		}

		mouseSquare = new FlxSprite().makeGraphic(10, 20, 0xFFFFFFFF);
		add(mouseSquare);
		FlxG.watch.add(this, 'curSelected', 'Current Option: ');
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		checkKeys();

		mouseSquare.x = FlxG.mouse.x;
		mouseSquare.y = FlxG.mouse.y;

		if (enter && grpOptions.members[curSelected].type == 'bool')
		{
			grpOptions.members[curSelected].doCallback(!grpOptions.members[curSelected].currentValue.bool);
		}
		for (i in 0...grpOptions.members.length)
		{
			if (FlxG.overlap(grpOptions.members[i], mouseSquare))
			{
				curSelected = i;
			}
		}

		if (FlxG.keys.justPressed.BACKSPACE)
		{
			RunSaveEditor.runMainGame();
		}

		if (FlxG.mouse.justPressed)
		{
			var option:Setting = grpOptions.members[curSelected];
			if (option.type == 'bool')
			{
				if (InputHandler.get_mouseOverObject(option, mouseSquare))
				{
					option.doCallback(!option.currentValue.bool);
				}
			}
			if (option.type == 'number' || option.type == 'enum')
			{
				if (InputHandler.get_mouseOverObject(option.leftArrow, mouseSquare))
				{
					option.doCallback(-1);
				}
				if (InputHandler.get_mouseOverObject(option.rightArrow, mouseSquare))
				{
					option.doCallback(1);
				}
			}
		}
	}
}
