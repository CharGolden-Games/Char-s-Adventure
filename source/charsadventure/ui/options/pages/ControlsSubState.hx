package charsadventure.ui.options.pages;

import charsadventure.play.components.CustomCam;

class ControlsSubState extends BaseSubState
{
	var grpOptions:ControlGroup;

	var curSelected:Int = 0;
	var curKey:Int = 0;

	var bgScroller:FlxBackdrop;
	var camFollow:FlxObject;
	var camBG:CustomCam;
	var camMenu:FlxCamera;
	var camTitle:FlxCamera;
	var up:Bool = false;
	var down:Bool = false;
	var left_p:Bool = false;
	var right_p:Bool = false;
	var accept:Bool = false;
	var exit:Bool = false;

	// SHIT RELATED TO THE REBIND MENU.
	var camRebind:FlxCamera;
	var rebind_backBG:FlxSprite;
	var rebind_bg:FlxSprite;
	var rebind_text:FlxText;
	var anyPressed:Int;
	var text:String = 'Rebinding DEFAULT!\n\n\n. Time left to press a key:';
	var time:String = '10';
	var rebind_timer:FlxTimer;
	var isPlayState:Bool = false;

	public function new(playState:Bool = false)
	{
		super();

		FlxG.keys.reset();

		setupCams();
		setupMenu();
		createOptions();

		changeSelection();
		changeIndex();

		if (playState)
		{
			isPlayState = true;
			camBG.tweenAlpha(0.7, 0.5);
		}
	}

	function setupCams():Void
	{
		// trace('Setting Up Cameras');
		if (!isPlayState)
			OptionsState.blockInput = true;
		camBG = new CustomCam(0, 0, 0, 0, 'camBG');
		camMenu = new FlxCamera();
		camTitle = new FlxCamera();

		camMenu.bgColor.alpha = 0;
		camTitle.bgColor.alpha = 0;

		FlxG.cameras.add(camBG, false);
		FlxG.cameras.add(camMenu, false);
		FlxG.cameras.add(camTitle, false);

		camFollow = new FlxObject(250, 0, 10, 10);
		camMenu.follow(camFollow, LOCKON, 0.06);
		camMenu.zoom = 1.5;
	}

	function setupMenu():Void
	{
		// trace('Setting Up Menu');
		bgScroller = new FlxBackdrop(Paths.image('menuBG/plexi_SettingsBG'));
		bgScroller.velocity.set(40, 40);
		bgScroller.cameras = [camBG];

		grpOptions = new ControlGroup();
		grpOptions.cameras = [camMenu];

		add(bgScroller);
		add(grpOptions);

		var title:FlxText = new FlxText(0, 0, FlxG.width, 'CONTROLS (ENTER to select, ESCAPE to exit)', 30);
		title.setFormat(Paths.font('naname_goma.ttf'), 30, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
		title.cameras = [camTitle];
		add(title);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		up = controls.ui_up_p;
		down = controls.ui_down_p;

		left_p = controls.ui_left_p;
		right_p = controls.ui_right_p;

		accept = (FlxG.keys.justPressed.ENTER);
		exit = (FlxG.keys.justPressed.ESCAPE);

		anyPressed = FlxG.keys.firstPressed();

		checkInput();
	}

	var blockInput:Bool = false;
	var is_rebindMenu:Bool = false;

	function checkInput():Void
	{
		doInputUpdate(is_rebindMenu);
		if (!blockInput)
		{
			if (exit)
				close();

			if (up)
				changeSelection(-1);

			if (down)
				changeSelection(1);

			if (left_p)
				changeIndex(-1);

			if (right_p)
				changeIndex(1);

			if (accept)
				rebind_Key();
		}
	}

	function doInputUpdate(doUpdate:Bool):Void
	{
		if (doUpdate)
		{
			if (rebind_timer != null)
			{
				text = 'Rebinding ${grpOptions.members[curSelected].controlName.text}!\n\n\nTime left to press a key: ';
				time = Std.string(Math.round(rebind_timer.timeLeft));
				rebind_text.text = text + time;
			}

			if (anyPressed != -1)
				close_rebindMenu(anyPressed);
		}
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected = grpOptions.change_index(change, camFollow);
		for (i in 0...grpOptions.members.length)
		{
			if (i == curSelected)
			{
				grpOptions.members[i].alpha = 1;
				grpOptions.members[i].selected.alpha = 1;
			}
			else
			{
				grpOptions.members[i].alpha = 0.4;
				grpOptions.members[i].selected.alpha = 0.00000001;
			}
			if (!grpOptions.members[i].controlGroup.visible)
			{
				grpOptions.members[i].alpha = 1;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function changeIndex(change:Int = 0):Void
	{
		curKey = grpOptions.change_keyIndex(change);
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function createOptions():Void
	{
		// trace('Setting Up Options');
		// Movement
		new_Header('Movement');
		new_ControlOption('Move Up', Save.keyBinds['move_up'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('move_up', value);
			Save.saveKeys();
			return Save.keyBinds['move_up'];
		});
		new_ControlOption('Move Left', Save.keyBinds['move_left'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('move_left', value);
			Save.saveKeys();
			return Save.keyBinds['move_left'];
		});
		new_ControlOption('Move Down', Save.keyBinds['move_down'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('move_down', value);
			Save.saveKeys();
			return Save.keyBinds['move_down'];
		});
		new_ControlOption('Move Right', Save.keyBinds['move_right'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('move_right', value);
			Save.saveKeys();
			return Save.keyBinds['move_right'];
		});
		new_ControlOption('Halt Movement', Save.keyBinds['move_hold'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('move_hold', value);
			Save.saveKeys();
			return Save.keyBinds['move_hold'];
		});
		new_ControlOption('Jump', Save.keyBinds['jump'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('jump', value);
			Save.saveKeys();
			return Save.keyBinds['jump'];
		});
		new_ControlOption('Attack', Save.keyBinds['attack'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('attack', value);
			Save.saveKeys();
			return Save.keyBinds['attack'];
		});

		// UI
		new_Header('UI');
		new_ControlOption('UI Up', Save.keyBinds['ui_up'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('ui_up', value);
			Save.saveKeys();
			return Save.keyBinds['ui_up'];
		});
		new_ControlOption('UI Left', Save.keyBinds['ui_left'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('ui_left', value);
			Save.saveKeys();
			return Save.keyBinds['ui_left'];
		});
		new_ControlOption('UI Down', Save.keyBinds['ui_down'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('ui_down', value);
			Save.saveKeys();
			return Save.keyBinds['ui_down'];
		});
		new_ControlOption('UI Right', Save.keyBinds['ui_right'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('ui_right', value);
			Save.saveKeys();
			return Save.keyBinds['ui_right'];
		});
		new_ControlOption('Inventory', Save.keyBinds['ui_inv'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('ui_inv', value);
			Save.saveKeys();
			return Save.keyBinds['ui_inv'];
		});
		new_ControlOption('Accept', Save.keyBinds['accept'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('accept', value);
			Save.saveKeys();
			return Save.keyBinds['accept'];
		});
		new_ControlOption('Back', Save.keyBinds['back'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('back', value);
			Save.saveKeys();
			return Save.keyBinds['back'];
		});
		new_ControlOption('Pause', Save.keyBinds['pause'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('pause', value);
			Save.saveKeys();
			return Save.keyBinds['pause'];
		});
		new_Header('System');
		new_ControlOption('Mute Volume', Save.keyBinds['volume_mute'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('volume_mute', value);
			Save.saveKeys();
			FlxG.sound.muteKeys = value;
			return Save.keyBinds['volume_mute'];
		});
		new_ControlOption('Volume Down', Save.keyBinds['volume_down'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('volume_down', value);
			Save.saveKeys();
			FlxG.sound.volumeDownKeys = value;
			return Save.keyBinds['volume_down'];
		});
		new_ControlOption('Volume Up', Save.keyBinds['volume_up'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('volume_up', value);
			Save.saveKeys();
			FlxG.sound.volumeUpKeys = value;
			return Save.keyBinds['volume_up'];
		});
		new_Header('Dialogue');
		new_ControlOption('Dialogue Advance', Save.keyBinds['advance_text'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('advance_text', value);
			Save.saveKeys();
			return Save.keyBinds['advance_text'];
		});
		new_ControlOption('Dialogue Back', Save.keyBinds['back_text'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('back_text', value);
			Save.saveKeys();
			return Save.keyBinds['back_text'];
		});
		new_ControlOption('Skip Dialogue', Save.keyBinds['skip'], function(value:Array<FlxKey>):Array<FlxKey>
		{
			Save.keyBinds.set('skip', value);
			Save.saveKeys();
			return Save.keyBinds['skip'];
		});
	}

	function new_ControlOption(name:String, defaultValues:Array<FlxKey>, onChange:Null<Array<FlxKey>->Array<FlxKey>> = null):Void
	{
		grpOptions.new_controlOption(0, 30 * grpOptions.length, name, defaultValues, onChange);
	}

	function new_Header(name:String):Void
	{
		var str:String = '';
		var pos:Int = 0;
		for (i in 0...name.length)
		{
			str += '_';
		}
		if (name.length > 2)
		{
			for (i in 0...name.length)
			{
				str += '_';
			}
			pos = -10;
		}
		grpOptions.new_headerOption(pos, 30 * grpOptions.length, str);
		grpOptions.new_headerOption(0, 30 * grpOptions.length, name);
		grpOptions.new_headerOption(pos, 30 * grpOptions.length, str);
	}

	override function close():Void
	{
		super.close();

		FlxG.cameras.remove(camBG);
		FlxG.cameras.remove(camMenu);
	}

	function rebind_Key():Void
	{
		FlxG.keys.reset();
		camRebind = new FlxCamera();
		camRebind.bgColor.alpha = 0;
		FlxG.cameras.add(camRebind, false);

		rebind_backBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		rebind_backBG.alpha = 0.6;
		rebind_backBG.cameras = [camRebind];

		rebind_bg = new FlxSprite().makeGraphic(500, 200, 0xFFFE9292);
		rebind_bg.screenCenter();
		rebind_bg.cameras = [camRebind];

		rebind_text = new FlxText(rebind_bg.x, rebind_bg.y, rebind_bg.width, text + time, 30);
		rebind_text.setFormat(Paths.font('naname_goma.ttf'), 30, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
		rebind_text.borderSize = 3;
		rebind_text.cameras = [camRebind];

		blockInput = true;
		is_rebindMenu = true;
		rebind_timer = new FlxTimer().start(10, function(tmr:FlxTimer)
		{
			close_rebindMenu();
		});

		add(rebind_backBG);
		add(rebind_bg);
		add(rebind_text);
	}

	function close_rebindMenu(key:Null<FlxKey> = null):Void
	{
		if (key != null)
			grpOptions.members[curSelected].set_key(key);

		rebind_backBG.destroy();
		rebind_bg.destroy();
		rebind_text.destroy();

		if (rebind_timer != null)
			rebind_timer.cancel();

		FlxG.cameras.remove(camRebind);
		is_rebindMenu = false;
		var timer = new FlxTimer().start(0.2, function(tmr:FlxTimer)
		{
			blockInput = false;
		});
	}
}
