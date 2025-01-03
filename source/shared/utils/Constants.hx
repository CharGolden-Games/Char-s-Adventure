package shared.utils;

import charsadventure.play.ui.DialogueSubState.Dialogue;

typedef SecretNames =
{
	public var name:String;
	public var dialogue:Array<Dialogue>;
}

/**
 * A class that keeps track of variables that don't typically change too much.
 */
class Constants
{
	// Save Files For Char's Adventure (Working Name)

	/**
	 * The path the game saves to.
	 */
	public static final SAVE_PATH:String = 'CharGolden/Chars_Adventure/';

	/**
	 * The path the editor saves prefs to
	 */
	public static final EDITOR_SAVE_PATH:String = 'CharGolden_Tools/Chars_AdventureSE/';

	/**
	 * Save File 1
	 */
	public static final SAVE_FILE0:String = 'CharsAdventure-Save_Slot-0';

	/**
	 * Save File global
	 */
	public static final GLOBAL_FILE:String = 'CharsAdventure-Save_Global';

	/**
	 * Save File 2
	 */
	public static final SAVE_FILE1:String = 'CharsAdventure-Save_Slot-1';

	/**
	 * Save File 3
	 */
	public static final SAVE_FILE2:String = 'CharsAdventure-Save_Slot-2';

	/**
	 * Prefs Save
	 */
	public static final SAVE_PREFS:String = 'CharsAdventure-Prefs';

	/**
	 * Basically where the Save Editor saves prefs.
	 */
	public static final EDITOR_PREFS:String = 'CharsAdventure_SaveEditor_Prefs';

	/**
	 * Where the game saves keybinds
	 */
	public static final KEYBIND_SAVE:String = 'CharsAdventure_KeyBinds';

	/**
	 * The version in project.xml
	 */
	public static var VERSION(get, never):String;

	static function get_VERSION():String
	{
		return 'v${Application.current.meta.get('version')}' #if debug + ' - PROTOTYPE' #end;
	}

	/**
	 * The version of the main engine.
	 */
	public static var engineVersion:String = "v0.2b-1";

	/**
	 *  For Crash logs. and resetting the title
	 */
	public static var TITLE(get, never):String;

	static function get_TITLE():String
	{
		return '(Working Title) Char\'s Adventure v${Application.current.meta.get('version')}' #if debug + ' - PROTOTYPE' #end#if IS_DEVBRANCH +
		' | Developer Branch' #end#if BETA_BUILD + ' | Beta Build' #end;
	}

	/**
	 *  For unlocking things based on if you've played VS Char before.
	 * 
	 * I only now realize that some of these are probably only paths you'd have if you knew how to compile these older versions. (or even had access to them)
	 */
	public static final VSCHAR_SAVEPATHS:Array<String> = [
		'CharGCheese/Char/',
		'CharGolden/VSCharlol/',
		'CharGolden/VS-Char-REVITALIZED/',
		'CharGolden/VS-Char-REVITALIZED/Psych1_0_PreRelease_move/',
		'char/SchoolShowdown/ninjamuffin99', // Old as fuck build lmao
	];

	/**
	 * Converts a given int to an enemy's internal name.
	 */
	public static final intToEnemy:Map<Int, String> = [0 => 'enemyTest',];

	public static final validIDs:Array<Int> = [0];

	/**
	 * Converts a given int to an player's internal name.
	 */
	public static final intToPlayer:Map<Int, String> = [0 => 'char', 1 => 'plexi', 2 => 'trevor'];

	/**
	 * Converts an enemy's internal name to their specific default idle anim.
	 */
	public static final enemyToDefaultAnim:Map<String, String> = ['enemyTest' => 'IdleMic0',];

	/**
	 * Yeth
	 */
	public static final lemonsQuote:String = "When life gives you lemons, "
		+ "don't make lemonade. Make life take the lemons back! Get mad! I don't want your damn lemons, "
		+ "what the hell am I supposed to do with these? Demand to see life's manager! Make life rue the day "
		+ "it thought it could give Cave Johnson lemons! Do you know who I am? I'm the man who's gonna burn your house down! "
		+ "With the lemons! I'm gonna get my engineers to invent a combustible lemon that burns your house down! ";

	/**
	 * Names that trigger special dialogue lmao
	 */
	public static final easterEggNames:Array<SecretNames> = [
		{
			name: 'manlybadasshero',
			dialogue: [
				{
					dialogue: '...',
					id: 0,
					image: 'char-think'
				},
				{
					dialogue: '{NAME} huh? That sounds familiar.',
					id: 1,
					image: 'char-think'
				},
				{
					dialogue: "You wouldn't happen to have an empty",
					id: 2,
					image: 'char-cheeky'
				},
				{
					dialogue: "Like your soul",
					id: 3,
					image: 'char-cheeky'
				},
				{
					dialogue: 'Trash can nearby, would you?',
					id: 4,
					image: 'char-cheeky'
				},
				{
					dialogue: '...',
					id: 5,
					image: 'char-cheeky',
					options: {
						options: ['Yes', 'No'],
						possibleIDs: [7, 6]
					}
				},
				{
					dialogue: 'No? Well then. Probably got the wrong guy.',
					id: 6,
					image: 'char-huh2',
					previousMessage: 3
				},
				{
					dialogue: 'Well then, good to see you playing this game.',
					id: 7,
					image: 'char-excite',
					previousMessage: 3
				},
				{
					dialogue: "Alright that's enough 4th wall breaki-",
					id: 8,
					image: 'char-calm',
				},
				{
					dialogue: "*The literal 4th wall breaks*",
					id: 9,
					image: 'char-surprise'
				}
			]
		}
	];
}
