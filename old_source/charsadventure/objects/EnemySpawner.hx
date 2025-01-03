package charsadventure.objects;

/**
 * This Handles Spawning enemies
 */
class EnemySpawner extends FlxSprite
{
	/**
	 * What enemy to spawn
	 * @param enemyTypeInt_To_Enemy [0 = enemyTest] yeah i only have one enemy so far lmao.
	 */
	public var enemyType:Int = 0;

	/**
	 * 
	 * @param x 
	 * @param y 
	 * @param enemyType Determines from a list what enemy gets spawned.
	 */
	public function new(x:Float, y:Float, enemyType:Int)
	{
		super(x, y);

		this.enemyType = enemyType;

		create(enemyType);
	}

	function create(int:Int):Void
	{
		if (int < 0 || int > 0)
		{ // Change when the list increases!
			int = 0;
			trace('Int out of bounds!!! using 0: ' + Constants.intToEnemy[int]);
		}
		loadGraphic(Paths.image('debug/Spawner-Enemy$enemyType'));

		trace('Enemy type is: ' + Constants.intToEnemy[enemyType]);
	}
}