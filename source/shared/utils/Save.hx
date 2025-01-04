package shared.utils;

import charsadventure.play.ui.InventorySubstate.Inventory;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;

using StringTools;

/**
 * This Class stores Progress!
 */
class GameProgress
{
	public var usedEditor:Bool = false; // If yer a stinkin cheater, ill getcha!
	// Positional Data
	public var roomID:Int = 0; // What room of the world the player was in.
	public var worldID:Int = 0; // What world the player was in.
	public var lastPos:Array<Float> = [0, 0]; // tracks where the player last saved, will have bounds checking.

	// Intro Flags
	public var watchedIntro:Bool = false;
	public var hasPassedIntro:Bool = false;

	// Equipment Related shit
	// Intro Flags
	public var hasSword:Bool = false;
	public var hasGun:Bool = false;
	// Upgrades
	public var swordUpgrade:Int = 0; // 0 - Basic | 1 - Basic+ (to be named) | 2 - Expert's (to be named)
	public var curSword:Int = 0; // Same as before | 3 - VS Char Easter Egg (to be named)
	public var gunUpgrade:Int = 0; // 0 - Basic | 1 - Basic+ (to be named) | 2 - Expert's (to be named)
	public var curGun:Int = 0; // Same as before. | 3  - VS Char Easter Egg (to be named)
	public var inventorySlots:Int = 3;

	/**
	 * Your current inventory
	 */
	public var curInventory:Inventory = {
		inventory: [
			{
				name: "Char's Soda Cup",
				id: 2,
				amount: 1
			}
		]
	}

	/**
	 * WHAT DO YOU THINK THIS DOES? make you a nice salad? ... actually that would be cool.
	 */
	public var maxHealth:Int = 5;

	// Easter Egg Upgrades
	public var easterEggSword:Bool = false;
	public var easterEggGun:Bool = false;

	// Drinks (Powerups)
	public var numPower:Int = 0;
	public var numDefense:Int = 0;
	public var numInvul:Int = 0;
	public var numBottomlessLesser:Int = 0; // is the same as bottomless, but just not bottomless, and multiple characters.

	// Story Flags
	// Dear god these names are shitty.
	public var isle:Bool = false;
	public var fishCity:Bool = false;

	/**AKA Micheals dumb fuckin' forest.*/
	public var forestOfIllusion:Bool = false;

	public var westWild:Bool = false;

	/**HAHA FUNNY REFERENCE RIGHT? right?*/
	public var westWildErectRemix:Bool = false;

	public var forestOfIllusionPart2_TheVoidening:Bool = false;
	public var fishCityVoidTheKiler:Bool = false;
	public var theLiteralVoid:Bool = false;

	// Side Shit.

	/**
	 * Whether you saved the Queen of Tridite City (Intro)
	 */
	public var saved_QueenTridite:Bool = false;

	/**
	 * Whether you saved Anny
	 */
	public var saved_Sheriff:Bool = false;

	/**
	 * Whether you saved Blank S. Cheese
	 */
	public var saved_Blank:Bool = false;

	/**
	 * Whether you annoyed the hell outta Blank S. Cheese.
	 */
	public var pushedBlank:Bool = false;

	/**
	 * Required to get a certain gun cause its too damn expensive on purpose. 
	 * You'd have to grind the shit out of optional stuff, or be good at saving your money, or just cheat.
	 */
	public var stoleGun:Bool = false;

	/**
	 * or if you're a PSYCHO you can eventually actually afford it.
	 * to much ridicule. Plexi will be severely dissapointed in you.
	 */
	public var boughtGun:Bool = false;

	/**
	 * Aint you a lucky pickle, starting with $50!
	 */
	public var dollars:Float = 50;

	public var gold:Int = 100;

	public function new(save:Null<Int> = null)
	{
		// Flixel requires a constructer i guess. might as well do a funny!
		var message = '';
		if (save != null)
		{
			message = 'Among you is an impoter. Anyway Game Progress initialized for save$save!';
		}
		else
		{
			message = 'Among you is an impoter. Anyway Game Progress initialized!';
		}
		trace(message);
	}
}

/**
 * This stores shit like unlocked cheats and bgs!
 */
class GlobalProgress
{
	public var bgStyleUnlock:Int = 0; // TBD

	public var unlockedBDCheat:Bool = false; // Bottomless Drink
	public var unlockedRTCheat:Bool = false; // Royal Trident
	public var unlockedRAMCheat:Bool = false; // Download RAM free today!
	public var unlockedBotplay:Bool = false;
	public var unlockedHitboxes:Bool = false;
	public var vsCharSecret:Bool = false;

	public function new(autoUnlock:Bool = false)
	{
		// Flixel requires a constructer i guess. BUT DONT PUT CODE HERE
		trace('Among you is an impoter. Anyway Global Progress initialized!');
		if (autoUnlock)
		{
			// bgStyleUnlock = 10; // NOTE TO SELF set this to maximum num of BGs!
			unlockedBDCheat = true;
			unlockedRTCheat = true;
			unlockedRAMCheat = true;
			unlockedBotplay = true;
			unlockedHitboxes = true;
			save(Constants.GLOBAL_FILE, Constants.SAVE_PATH);
		}
	}

	/**
	 * This function should only be used by this class for forcing cheats to be unlocked upon initialization.
	 * 
	 * Saves the current file to a specified file in a specified path
	 * @param saveFile the file name
	 * @param savePath the actual path.
	 */
	function save(saveFile:String, savePath:String):Void
	{
		var save:FlxSave = new FlxSave();
		save.bind(saveFile, savePath);
		for (key in Reflect.fields(this))
		{
			Reflect.setField(save.data, key, Reflect.field(this, key));
		}
		save.flush();
	}
}

class SaveVariables
{
	// General Preferences
	public var combustibleLemons:Bool = true; // useless toggle lmao
	public var lowQuality:Bool = false; // disables anti-aliasing, and also makes certain things disabled.
	public var framerate:Int = 60;
	public var difficulty:Int = 1; // 1: Easy | 2: Normal | 3: Hard
	public var hasPlayedVSChar:Bool = false; // for some easter eggs :3
	public var showFPS:Bool = false;
	public var muteMusic:Bool = false;
	public var borderlessWindow:Bool = false;

	// Fun Flags
	public var showHitBoxes:Bool = false;
	public var bottomlessDrink:Bool = false; // WILL ONLY WORK WITH CHAR
	public var plexiItem:Bool = false; // TODO: Make up an item for this
	public var royalTrident:Bool = false;
	public var botplay:Bool = false;

	public function new()
	{
		// Flixel requires a constructer i guess. BUT DONT PUT CODE HERE
		trace('Among us is an imposter. Also Preferences initialized!');
	}
}

/**
 *  HELP THIS IS JUST REFERENCED CODE FROM PSYCH ENGINE! ***Ahem.*** 
 * 
 * This class handles the processing of Preferences and Save Data.
 */
class Save
{
	// Prefs
	public static var data:SaveVariables = null;
	public static var defaultData:SaveVariables = null;

	// Saves
	public static var save0:GameProgress = null;
	public static var save1:GameProgress = null;
	public static var save2:GameProgress = null;
	public static var defaultSave:GameProgress = null;
	public static var globalSave:GlobalProgress = null;
	public static var saves:Array<GameProgress> = null;

	// Binds
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		// Movement
		'move_left' => [A, LEFT],
		'move_right' => [D, RIGHT],
		'move_up' => [W, UP],
		'move_down' => [S, DOWN],
		'move_hold' => [Q, Q],
		'jump' => [SPACE, SPACE],
		'attack' => [E, E],
		// UI
		'ui_inv' => [TAB, TAB],
		'ui_left' => [A, LEFT],
		'ui_right' => [D, RIGHT],
		'ui_up' => [W, UP],
		'ui_down' => [S, DOWN],
		'accept' => [ENTER, SPACE],
		'pause' => [ENTER, ESCAPE],
		'back' => [BACKSPACE, ESCAPE],
		// VOLUME SHITS.
		'volume_up' => [PLUS, NUMPADPLUS],
		'volume_down' => [MINUS, NUMPADMINUS],
		'volume_mute' => [ZERO, NUMPADZERO],
		// DIALOGUE
		'skip' => [X, X],
		'advance_text' => [ENTER, SPACE],
		'back_text' => [BACKSPACE, ESCAPE],
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static function resetKeys():Void
	{
		for (key in keyBinds.keys())
		{
			if (defaultKeys.exists(key))
				keyBinds.set(key, defaultKeys.get(key).copy());
		}
	}

	public static function clearInvalidKeys(key:String):Void
	{
		var keyBind:Array<FlxKey> = keyBinds.get(key);
		while (keyBind != null && keyBind.contains(NONE))
			keyBind.remove(NONE);
	}

	public static function saveKeys():Void
	{
		var keys:FlxSave = new FlxSave();
		keys.bind(Constants.KEYBIND_SAVE, Constants.SAVE_PATH);

		keys.data.keys = keyBinds;
		keys.flush();
	}

	public static function loadDefaultKeys()
	{
		defaultKeys = keyBinds.copy();
	}

	static function loadKeys():Void
	{
		var keys = new FlxSave();
		keys.bind(Constants.KEYBIND_SAVE, Constants.SAVE_PATH);

		if (!keys.isEmpty())
		{
			if (keys.data.keys != null)
			{
				var loadedControls:Map<String, Array<FlxKey>> = keys.data.keys;
				for (control => keys in loadedControls)
					if (keyBinds.exists(control))
						keyBinds.set(control, keys);
			}
		}

		if (keyBinds.exists('volume_mute'))
		{
			FlxG.sound.muteKeys = keyBinds['volume_mute'];
		}

		if (keyBinds.exists('volume_down'))
		{
			FlxG.sound.volumeDownKeys = keyBinds['volume_down'];
		}

		if (keyBinds.exists('volume_up'))
		{
			FlxG.sound.volumeUpKeys = keyBinds['volume_up'];
		}
	}

	public static function loadPrefs():Void
	{
		if (data == null)
			data = new SaveVariables();
		if (defaultData == null)
			defaultData = new SaveVariables();

		for (key in Reflect.fields(data))
		{
			if (Reflect.hasField(FlxG.save.data, key))
			{
				// trace('loaded variable: $key');
				Reflect.setField(data, key, Reflect.field(FlxG.save.data, key));
			}
		}

		// flixel automatically saves your volume!
		try
		{
			if (FlxG.save.data.volume != null)
				FlxG.sound.volume = FlxG.save.data.volume;
			if (FlxG.save.data.mute != null)
				FlxG.sound.muted = FlxG.save.data.mute;
		}
		catch (e:Dynamic)
		{
			if (Std.string(e) != 'Null Object Reference')
			{
				trace('Could not load volume or mute status! "$e"');
			}
		}

		loadKeys();
	}

	public static function loadSaves():Void
	{
		if (save0 == null)
			save0 = new GameProgress(0);
		if (save1 == null)
			save1 = new GameProgress(1);
		if (save2 == null)
			save2 = new GameProgress(2);
		if (globalSave == null)
			globalSave = new GlobalProgress(#if FORCE_UNLOCK_CHEATS true #end);

		var saveFile0 = new FlxSave();
		var saveFile1 = new FlxSave();
		var saveFile2 = new FlxSave();
		var globalSaveFile = new FlxSave();
		saveFile0.bind(Constants.SAVE_FILE0, Constants.SAVE_PATH);
		saveFile1.bind(Constants.SAVE_FILE1, Constants.SAVE_PATH);
		saveFile2.bind(Constants.SAVE_FILE2, Constants.SAVE_PATH);
		globalSaveFile.bind(Constants.GLOBAL_FILE, Constants.SAVE_PATH);

		for (key in Reflect.fields(globalSave))
		{
			if (Reflect.hasField(globalSaveFile.data, key))
			{
				Reflect.setField(globalSave, key, Reflect.field(globalSaveFile.data, key));
			}
		}
		for (key in Reflect.fields(save0))
		{
			if (Reflect.hasField(saveFile0.data, key))
			{
				Reflect.setField(save0, key, Reflect.field(saveFile0.data, key));
			}
		}
		for (key in Reflect.fields(save1))
		{
			if (Reflect.hasField(saveFile1.data, key))
			{
				Reflect.setField(save1, key, Reflect.field(saveFile1.data, key));
			}
		}
		for (key in Reflect.fields(save2))
		{
			if (Reflect.hasField(saveFile2.data, key))
			{
				Reflect.setField(save2, key, Reflect.field(saveFile2.data, key));
			}
		}

		saveFile0.close();
		saveFile1.close();
		saveFile2.close();
		globalSaveFile.close();
		saves = [save0, save1, save2];
	}

	public static function savePrefs():Void
	{
		for (key in Reflect.fields(data))
		{
			Reflect.setField(FlxG.save.data, key, Reflect.field(data, key));
		}
		try
		{
			FlxG.save.data.mute = FlxG.sound.muted;
			FlxG.save.data.volume = FlxG.sound.volume;
		}
		catch (e:Dynamic)
		{
			trace('ERROR SAVING VOLUME: $e');
		}
		FlxG.save.flush();
	}

	/**
	 * Redirects to save_Saves() because im fucking dumb and left a typo in.
	 */
	@:deprecated('`save_Save()` is a typo, use `save_Saves()`')
	public static function save_Save():Void
	{
		save_Saves();
	}

	public static function save_Saves():Void
	{
		var saveFile0 = new FlxSave();
		var saveFile1 = new FlxSave();
		var saveFile2 = new FlxSave();
		var globalSaveFile = new FlxSave();
		saveFile0.bind(Constants.SAVE_FILE0, Constants.SAVE_PATH);
		saveFile1.bind(Constants.SAVE_FILE1, Constants.SAVE_PATH);
		saveFile2.bind(Constants.SAVE_FILE2, Constants.SAVE_PATH);
		globalSaveFile.bind(Constants.GLOBAL_FILE, Constants.SAVE_PATH);

		for (key in Reflect.fields(globalSave))
		{
			Reflect.setField(globalSaveFile.data, key, Reflect.field(globalSave, key));
		}
		for (key in Reflect.fields(save0))
		{
			Reflect.setField(saveFile0.data, key, Reflect.field(save0, key));
		}
		for (key in Reflect.fields(save1))
		{
			Reflect.setField(saveFile1.data, key, Reflect.field(save1, key));
		}
		for (key in Reflect.fields(save2))
		{
			Reflect.setField(saveFile2.data, key, Reflect.field(save2, key));
		}

		saveFile0.flush();
		saveFile1.flush();
		saveFile2.flush();
		globalSaveFile.flush();

		saveFile0.close();
		saveFile1.close();
		saveFile2.close();
		globalSaveFile.close();
		// Refresh the array just in case.
		saves = [save0, save1, save2];
	}
}
