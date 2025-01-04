package charsadventure.ui.mainmenu;

class CheatState extends FlxState
{
	var cheatsGroup:FlxTypedGroup<FlxText>;
	var cheatsImagesGroup:FlxTypedGroup<FlxSprite>;
	var camBG:FlxCamera;
	var camCheats:FlxCamera;
	var camFollow:FlxObject;
	var cheats = [
		'Bottomless Drink\nNever Runs Out! Defense, Speed (That includes Attack Speed), and Attack Drastically increase! (Char only.)',
		'Royal Trident\nExtra powerful, extra durable! if only durability actually mattered in this game, Gives you better Attack Speed! (Trevor Only)',
		'High Quality RAM\nPLACEHOLDER NAME\nMakes Plexi able to do somersaults or smth idfk lmao. (Plexi Only)',
		'Botplay\nAutoplays certain events for you!',
		'Show Hitboxes\nWanna see the hitboxes of everything? well do i have the option for you!'
	];
	var curSelected:Int = 0;

	public var controls(get, never):Controls;

	private function get_controls()
	{
		return Controls.instance;
	}

	var enabledCheats(get, default):Array<Bool>;

	function get_enabledCheats():Array<Bool>
	{
		var finalArray:Array<Bool> = [];

		finalArray.push(Save.data.bottomlessDrink);
		finalArray.push(Save.data.royalTrident);
		finalArray.push(Save.data.plexiItem);
		finalArray.push(Save.data.botplay);
		finalArray.push(Save.data.showHitBoxes);
		return finalArray;
	}

	function set_enabledCheats(cheat:String):Void
	{
		switch (cheat.toLowerCase())
		{
			case 'cupcheat':
				Save.data.bottomlessDrink = !Save.data.bottomlessDrink;
				cheatsImagesGroup.members[0].alpha = Save.data.bottomlessDrink ? 1 : 0.5;

			case 'pitchforkcheat':
				Save.data.royalTrident = !Save.data.royalTrident;
				cheatsImagesGroup.members[1].alpha = Save.data.royalTrident ? 1 : 0.5;

			case 'ramcheat':
				Save.data.plexiItem = !Save.data.plexiItem;
				cheatsImagesGroup.members[2].alpha = Save.data.plexiItem ? 1 : 0.5;

			case 'showhitboxes':
				Save.data.showHitBoxes = !Save.data.showHitBoxes;
				cheatsImagesGroup.members[3].alpha = Save.data.showHitBoxes ? 1 : 0.5;

			case 'botplay':
				Save.data.botplay = !Save.data.botplay;
				cheatsImagesGroup.members[4].alpha = Save.data.botplay ? 1 : 0.5;
		}
		Save.savePrefs();

		var finalArray:Array<Bool> = [];

		finalArray.push(Save.data.bottomlessDrink);
		finalArray.push(Save.data.royalTrident);
		finalArray.push(Save.data.plexiItem);
		finalArray.push(Save.data.botplay);
		finalArray.push(Save.data.showHitBoxes);
		enabledCheats = finalArray;
	}

	override function create():Void
	{
		super.create();
		camBG = new FlxCamera();
		camCheats = new FlxCamera();
		camFollow = new FlxObject(FlxG.width * 0.7, 0, 10, 10);
		camCheats.bgColor.alpha = 0;
		FlxG.cameras.add(camBG, false);
		FlxG.cameras.add(camCheats);
		camCheats.follow(camFollow, LOCKON, 0.6);

		var BG = new FlxSprite().loadGraphic(Paths.image('menuBG/CheatMenu'));
		BG.cameras = [camBG];
		add(BG);

		cheatsGroup = new FlxTypedGroup<FlxText>();
		cheatsImagesGroup = new FlxTypedGroup<FlxSprite>();
		add(cheatsGroup);
		add(cheatsImagesGroup);

		for (i in 0...cheats.length)
		{
			var cheatText = new FlxText(FlxG.width * 0.4, 190 * i, FlxG.width * 0.5, cheats[i], 20);
			if (i == 0)
				cheatText.y = 20;
			cheatText.setFormat(Paths.font('naname_goma.ttf'), 20, 0xFFFFFFFF, LEFT, OUTLINE, 0xFF000000);
			cheatText.borderSize = 3;
			cheatsGroup.add(cheatText);
			var icon:String = cheats[i].split('\n')[0];
			switch (cheats[i].split('\n')[0])
			{
				case 'Bottomless Drink':
					icon = 'CupCheat';
				case 'Royal Trident':
					icon = 'PitchForkCheat';
				case 'High Quality RAM':
					icon = 'RAMCheat';
			}
			var path = 'assets/images/powers/$icon.png';
			if (!FileSystem.exists(path))
			{
				path = 'assets/images/powers/placeHolders/$icon.png';
				if (!FileSystem.exists(path))
				{
					path = 'assets/images/fallback/powers/placeHolders/CupCheat.png';
				}
			}
			var cheatIcon = new FlxSprite().loadGraphic(path);
			cheatIcon.setGraphicSize(150);
			cheatIcon.updateHitbox();
			cheatIcon.y = 180 * i;
			cheatIcon.x = FlxG.width * 0.2;
			cheatIcon.antialiasing = !Save.data.lowQuality;
			cheatsImagesGroup.add(cheatIcon);

			if (enabledCheats[i] == false)
			{
				cheatIcon.alpha = 0.5;
			}
			else
			{
				cheatIcon.alpha = 1;
			}
		}

		changeSelection();

		openfl.Lib.application.window.title = Constants.TITLE + ' | Cheats Menu';
	}

	override function update(elapsed:Float):Void
	{
		for (i in 0...cheatsGroup.members.length)
		{
			if (curSelected == i)
			{
				cheatsGroup.members[i].color = 0xFFFFFF00;
				camFollow.y = cheatsGroup.members[i].y;
			}
			else if (curSelected != i)
			{
				cheatsGroup.members[i].color = 0xFFFFFFFF;
			}
		}
		super.update(elapsed);

		if (FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MainMenuState());
		}
		if (controls.move_left_p || controls.move_up_p)
		{
			changeSelection(-1);
		}
		if (controls.move_right_p || controls.move_down_p)
		{
			changeSelection(1);
		}
		if (FlxG.keys.justPressed.ENTER)
		{
			set_enabledCheats(switch (curSelected)
			{
				default:
					'cupcheat';
				case 1:
					'pitchforkcheat';
				case 2:
					'ramcheat';
				case 3:
					'showhitboxes';
				case 4:
					'botplay';
			});
		}
	}

	function unlockAllCheats():Void
	{
		Save.globalSave.unlockedBDCheat = true;
		Save.globalSave.unlockedBotplay = true;
		Save.globalSave.unlockedHitboxes = true;
		Save.globalSave.unlockedRTCheat = true;
		Save.globalSave.unlockedRAMCheat = true;

		Save.save_Saves();
	}

	function changeSelection(?change:Int = 0):Void
	{
		curSelected += change;
		if (curSelected < 0)
			curSelected = cheats.length - 1;
		if (curSelected >= cheats.length)
			curSelected = 0;

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
