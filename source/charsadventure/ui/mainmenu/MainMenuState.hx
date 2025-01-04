package charsadventure.ui.mainmenu;

import charsadventure.ui.options.OptionsState;
import charsadventure.ui.mainmenu.components.MenuButton.GrpMenuButton;
import charsadventure.ui.mainmenu.components.RunSaveEditor;
import charsadventure.play.PlayState;

/**
 * the main menu state
 */
class MainMenuState extends BaseState
{
	var grpOptions:GrpMenuButton;
	var buttons:Array<String> = ['start', 'options', 'fun', 'Save Editor', #if desktop 'exit' #end];
	var curSelected:Int = 0;

	/**
	 * The currently selected save.
	 */
	public static var curSave:Int = 0;

	var BG:FlxSprite;

	override function create():Void
	{
		FlxG.mouse.visible = false;
		BG = new FlxSprite().loadGraphic(Paths.image('menuBG/Yellow'));
		BG.screenCenter();
		add(BG);

		grpOptions = new GrpMenuButton();
		add(grpOptions);

		for (i in 0...buttons.length)
		{
			grpOptions.add_menuButton(FlxG.width * 0.1, (FlxG.height * 0.2) + (100 * (i + 1)), buttons[i], switch (buttons[i])
			{
				case 'start':
					'New Game';
				case 'options':
					'Settings';
				case 'fun':
					'Cheats';
				case 'exit':
					'Exit Game';
				default:
					buttons[i];
			}, function(name:String):Void
			{
				switch (name)
				{
					case 'start':
						FlxG.switchState(new PlayState());
					case 'options':
						OptionsState.blockInput = false;
						FlxG.switchState(new OptionsState());
					case 'fun':
						FlxG.switchState(new CheatState());
					case 'Save Editor':
						RunSaveEditor.runSaveEditor();
					case 'exit':
						Save.save_Saves();
						System.exit(0);
				}
			});
		}

		var titleGraphic:FlxSprite = new FlxSprite().loadGraphic(Paths.image('TitleGraphic'));
		titleGraphic.setGraphicSize(500, 250);
		titleGraphic.updateHitbox();
		titleGraphic.x = FlxG.width * 0.4;
		titleGraphic.y = FlxG.height * 0.07;
		add(titleGraphic);

		leftWatermarkText = 'Char\'s Adventure ${Constants.VERSION}';
		rightWatermarkText = 'Char\'s Rhythm Engine ${cre.utils.Constants.VERSION}\nChar\'s Adventure Engine ${Constants.engineVersion}';

		changeSelection();
		super.create();
		playMusic(Paths.music('titlePlaceholder'), volume);
	}

	override function createPost():Void
	{
		super.createPost();
		// CheckForOldSaves.check_playedVSChar();
		openfl.Lib.application.window.title = Constants.TITLE;
	}

	override function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.UP || FlxG.keys.justPressed.A || FlxG.keys.justPressed.W)
		{
			changeSelection(-1);
		}
		if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S || FlxG.keys.justPressed.D)
		{
			changeSelection(1);
		}
		super.update(elapsed);
		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
		{
			grpOptions.do_callback();
		}
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected = grpOptions.change_index(change);

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
