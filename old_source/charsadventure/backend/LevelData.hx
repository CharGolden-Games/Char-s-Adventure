package charsadventure.backend;

import charsadventure.states.PlayState;

/**
 * map format:
 * [
 *  [`object<Int/String>`, x, y ],
 * ]
 */
typedef LevelDataFile =
{
	var defaultCharacter:String;
	var map:Array<Array<Int>>;
}

class LevelData
{
	static var map:Array<Array<Int>> = [];
	public static var intToObjects:Map<Int, String> = [
		0 => 'ground',
		1 => 'wall', // purely visual, must have a ladder in an adjacent area or an invisible wall on it.
		2 => 'pit',
		3 => 'invisibleWall', // What game wouldnt be complete without these?
		4 => 'spawner',
		5 => 'door' // duhhhh
	];
	public static var objectsToInt:Map<String, Int> = [
		// just in case
		'ground' => 0,
		'wall' => 1,
		'pit' => 2,
		'invisibleWall' => 3,
		'spawner' => 4,
		'door' => 5
	];

	public var objectInts:Array<Int> = [
		// ALWAYS UPDATE THIS WHEN ADDING A NEW OBJECT
		0,
		1,
		2,
		3,
		4,
		5
	];

	public static final intToDefaultPos:Map<Int, Array<Float>> = [
		// FIX WHEN DONE WITH ROOMS.
		// Intro Areas - Char Isle
		0 => [0, 0], // Char's Room
		1 => [105, 75], // 2nd Floor Hallway
		2 => [0, 0], // Main Room
		3 => [0, 0], // Kitchen
		4 => [0, 0], // Bathroom
		5 => [0, 0], // Plexi's Room
		6 => [0, 0], // Trevor's Room
		7 => [0, 0], // 1st Floor Hallway
		8 => [69, 69], // ??? ????? ??? ?????? ??? ?? // (Secret Area)
		9 => [0, 0], // Char Isle
		// Intro Areas - Micheal's Forest
		10 => [0, 0], // Micheal's Forest (Outside)
		11 => [0, 0], // Micheal's Forest (Outside - "Dwellers of the Forest" Camp)
		12 => [0, 0], // Micheal's Forest (Micheal's Hut)
		// Milton's Creaks
		13 => [0, 0], // Milton's Creaks (Outside)
		14 => [0, 0], // Milton's Creaks (Saloon)
		15 => [0, 0], // Milton's Creaks (Jail)
		16 => [0, 0], // Milton's Creaks (Inn)
		// Hope's Bluff
		17 => [0, 0], // Hope's Bluff (Outside)
		18 => [0, 0], // Hope's Bluff (Inn)
		19 => [0, 0], // Hope's Bluff (Bar)
		20 => [0, 0], // Hope's Bluff (Armory)
		21 => [0, 0], // Hope's Bluff (General Store)
		22 => [0, 0], // Hope's Bluff (Bank)
		23 => [69, 69], // Hope's Bluff (??????? ???? ??? ????????? ?? ??) // (Secret Area)
	];

	public static final intToLevel:Map<Int, String> = [
		// FIX WHEN DONE WITH ROOMS.
		// Intro Areas - Char Isle
		0 => 'house_CharRoom', // Char's Room
		1 => 'house_Hallway2', // 2nd Floor Hallway
		2 => 'House', // Main Room
		3 => 'house_Kitchen', // Kitchen
		4 => 'house_Bathroom', // Bathroom
		5 => 'house_PlexiRoom', // Plexi's Room
		6 => 'house_TrevorRoom', // Trevor's Room
		7 => 'house_Hallway', // 1st Floor Hallway
		8 => 'house_Secret', // ??? ????? ??? ?????? ??? ?? // (Secret Area)
		9 => 'CharIsle', // Char Isle
		// Intro Areas - Micheal's Forest
		10 => 'Forest', // Micheal's Forest (Outside)
		11 => 'forest_Camp', // Micheal's Forest (Outside - "Dwellers of the Forest" Camp)
		12 => 'forest_Hut', // Micheal's Forest (Micheal's Hut)
		// Milton's Creaks
		13 => 'MiltonsCreaks', // Milton's Creaks (Outside)
		14 => 'miltonCreaks_Saloon', // Milton's Creaks (Saloon)
		15 => 'miltonCreaks_Jail', // Milton's Creaks (Jail)
		16 => 'miltonCreaks_Jail', // Milton's Creaks (Inn)
		// Hope's Bluff
		17 => 'HopesBluff', // Hope's Bluff (Outside)
		18 => 'hopesBluff_Inn', // Hope's Bluff (Inn)
		19 => 'hopesBluff_Bar', // Hope's Bluff (Bar)
		20 => 'hopesBluff_Armory', // Hope's Bluff (Armory)
		21 => 'hopesBluff_GeneralStore', // Hope's Bluff (General Store)
		22 => 'hopesBluff_Bank', // Hope's Bluff (Bank)
		23 => 'hopesBluff_Secret', // Hope's Bluff (??????? ???? ??? ????????? ?? ??) // (Secret Area)
	];

	public static function loadMapFile():LevelDataFile
	{
		trace('Function not done!');
		return {
			defaultCharacter: null,
			map: null
		};
	}
}