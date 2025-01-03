package charsadventure.play.ui;

import charsadventure.ui.options.pages.*;
import charsadventure.play.components.CustomCam;

class PauseSubState extends BaseSubState
{
	var bg:FlxSprite;
	var menuItems:Array<String> = ['Resume', 'Restart Area', 'Manual Save', 'Options >', 'Exit'];
	var optionsItems:Array<String> = ['Graphics Options', 'Controls', 'Gameplay Options', 'Back'];
	var grpTexts:FlxTypedGroup<FlxText>; // TODO: Make a way to make a font out of an image.
	var grpSubTexts:FlxTypedGroup<FlxText>;
	var curSelected:Int = 0;
	var curSubSelected:Int = 0;
	var camPause:CustomCam;
	var selector:FlxSprite;
	var area:FlxText;
	var areaDesc:FlxText;
	var areaCredits:FlxText;
	var isSubMenu:Bool = false;

	override function create():Void
	{
		super.create();

		camPause = new CustomCam(0, 0, 0, 0, 'camPause');
		camPause.bgColor.alpha = 0;
		FlxG.cameras.add(camPause, false);

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		bg.alpha = 0.6;
		add(bg);

		grpTexts = new FlxTypedGroup<FlxText>();
		grpSubTexts = new FlxTypedGroup<FlxText>();

		add(grpTexts);
		add(grpSubTexts);
		grpSubTexts.visible = false;
		selector = new FlxSprite().loadGraphic(Paths.image('arrowRight'));
		selector.setGraphicSize(Std.int(selector.width * 0.5));
		selector.updateHitbox();
		selector.offset.y += 25;
		add(selector);

		var i:Int = -1;
		for (option in menuItems)
		{
			i++;
			var offset:Float = i == 0 ? 20 : 140 * i;
			var text:FlxText = new FlxText(60, offset, 0, option, 30);
			text.setFormat(Paths.font('naname_goma.ttf'), 30, 0xFFFFFFFF, null, OUTLINE, 0xFF000000);
			grpTexts.add(text);
		}

		i = -1;
		for (setting in optionsItems)
		{
			i++;
			var offset:Float = i == 0 ? 20 : 140 * i;
			var text:FlxText = new FlxText(60, offset, 0, setting, 30);
			text.setFormat(Paths.font('naname_goma.ttf'), 30, 0xFFFFFFFF, null, OUTLINE, 0xFF000000);
			grpSubTexts.add(text);
		}

		cameras = [camPause];
		changeSelection(0, false);
		changeSubSelection(0, false);

		var curArea:String = PlayState.instance.currentArea;
		area = new FlxText(0, 0, FlxG.width, 'Current Area: $curArea', 20);
		area.setFormat(Paths.font('naname_goma.ttf'), 30, 0xFFFFFFFF, RIGHT, OUTLINE, 0xFF000000);
		area.alpha = 0;
		area.scrollFactor.set(0, 0);
		add(area);

		if (openfl.Assets.exists('assets/data/areaInfo/${PlayState.instance.currentArea.toLowerCase().trim()}.txt'))
		{
			var descString:String = openfl.Assets.getText('assets/data/areaInfo/${PlayState.instance.currentArea.toLowerCase().trim()}.txt');
			areaDesc = new FlxText(0, area.height + 10, FlxG.width, descString, 16);
			areaDesc.setFormat(Paths.font('naname_goma.ttf'), 16, 0xFFFFFFFF, RIGHT, OUTLINE, 0xFF000000);
			areaDesc.alpha = 0;
			areaDesc.scrollFactor.set(0, 0);
			add(areaDesc);
			FlxTween.tween(areaDesc, {alpha: 1}, 3);
		}

		if (openfl.Assets.exists('assets/data/areaInfo/${PlayState.instance.currentArea.toLowerCase().trim()}-credits.txt'))
		{
			var descString:String = openfl.Assets.getText('assets/data/areaInfo/${PlayState.instance.currentArea.toLowerCase().trim()}-credits.txt');
			areaCredits = new FlxText(0, 0, FlxG.width, 'This Area\'s credits:\n$descString', 20);
			areaCredits.setFormat(Paths.font('naname_goma.ttf'), 20, 0xFFFFFFFF, RIGHT, OUTLINE, 0xFF000000);
			areaCredits.alpha = 0;
			areaCredits.scrollFactor.set(0, 0);
			add(areaCredits);
			areaCredits.y = FlxG.height - (areaCredits.height + 5);
			FlxTween.tween(areaCredits, {alpha: 1}, 3);
		}
		FlxTween.tween(area, {alpha: 1}, 3);
	}

	function changeSelection(change:Int = 0, playSound = true):Void
	{
		curSelected += change;

		if (curSelected < 0)
		{
			curSelected = menuItems.length - 1;
		}
		if (curSelected > menuItems.length - 1)
		{
			curSelected = 0;
		}

		selector.y = grpTexts.members[curSelected].y;

		if (playSound)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (!isSubMenu)
		{
			handleInput();
		}
		else
		{
			handleSubInput();
		}
	}

	function handleInput():Void
	{
		if (controls.ui_down_p)
		{
			changeSelection(1);
		}
		if (controls.ui_up_p)
		{
			changeSelection(-1);
		}
		if (controls.back_p)
		{
			close();
		}
		if (controls.accept_p)
		{
			switch (menuItems[curSelected])
			{
				case 'Resume':
					close();

				case 'Restart Area':
					// PlayState.loadLastArea();
					FlxG.resetState();

				case 'Manual Save':
					Save.save_Saves();

				case 'Options >':
					switchMenus();

				case 'Exit':
					FlxG.switchState(new MainMenuState());
			}
		}
	}

	function handleSubInput():Void
	{
		if (controls.ui_down_p)
		{
			changeSubSelection(1);
		}
		if (controls.ui_up_p)
		{
			changeSubSelection(-1);
		}
		if (controls.back_p)
		{
			switchMenus();
		}
		if (controls.accept_p)
		{
			switch (optionsItems[curSubSelected])
			{
				case 'Graphics Options':
					openSubState(new GraphicsOptionsSubState(true));

				case 'Controls':
					openSubState(new ControlsSubState(true));

				case 'Gameplay Options':
					openSubState(new GameplayOptionsSubState(true));

				case 'Back':
					switchMenus();
			}
		}
	}

	function switchMenus():Void
	{
		if (isSubMenu)
		{
			grpTexts.visible = true;
			grpSubTexts.visible = false;
			curSubSelected = 0;
			changeSelection();
		}
		else
		{
			grpTexts.visible = false;
			grpSubTexts.visible = true;
			curSubSelected = 0;
			changeSubSelection();
		}
		isSubMenu = !isSubMenu;
	}

	function changeSubSelection(change = 0, playSound:Bool = true):Void
	{
		curSubSelected += change;

		if (curSubSelected < 0)
		{
			curSubSelected = optionsItems.length - 1;
		}
		if (curSubSelected > optionsItems.length - 1)
		{
			curSubSelected = 0;
		}

		selector.y = grpSubTexts.members[curSubSelected].y;

		if (playSound)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
	}

	override function close():Void
	{
		super.close();

		FlxG.cameras.remove(camPause);
	}

	override function closeSubState():Void
	{
		super.closeSubState();

		if (isSubMenu)
		{
			Save.savePrefs();
		}
	}
}
