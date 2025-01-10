package cre.utils;

typedef NoteColors =
{
	public var main:FlxColor;
	public var dark:FlxColor;
	public var white:FlxColor;
}

/**
 * This class contains constant variables
 * 
 * As in they don't change really.
 */
class Constants
{
	/**
	 * The save path
	 */
	public static final SAVE_PATH:String = 'CharGolden/CRE/';

	/**
	 * The actual save file.
	 */
	public static final SAVE_FILE:String = 'CRE_Save';

	/**
	 * The version of this engine.
	 */
	public static final VERSION:String = 'v0.1b-1' #if debug + ' - PROTOTYPE' #end;

	/**
	 * The following is just default colors.
	 */
	/**
	 * The colors for the left note
	 */
	public static final noteColors_Left:NoteColors = {
		main: 0xFFCC88CC,
		dark: 0xFF442266,
		white: 0xFFFFFFFF
	};

	/**
	 * The colors for the up note.
	 */
	public static final noteColors_Up:NoteColors = {
		main: 0xFFFFBBFF,
		dark: 0xFF442266,
		white: 0xFFFFFFFF
	};

	/**
	 * The colors for the down note.
	 */
	public static final noteColors_Down:NoteColors = {
		main: 0xFFFFBBFF,
		dark: 0xFF442266,
		white: 0xFFFFFFFF
	};

	/**
	 * The colors for the right note
	 */
	public static final noteColors_Right:NoteColors = {
		main: 0xFFCC88CC,
		dark: 0xFF442266,
		white: 0xFFFFFFFF
	};
}
