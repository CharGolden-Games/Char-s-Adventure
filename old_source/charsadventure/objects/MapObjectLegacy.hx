package charsadventure.objects;

/**
 * The original class that handled Map Objects, superseded by objects > MapObject.
 */
class MapObjectLegacy extends FlxSprite
{
	// TODO MAKE OBJECTS HAVE A DEFAULT LIST FOR FRAMERATE, LOOPING, AND DEFAULT ANIM!
	public var zIndex(default, set):Int = 0; // The game uses this to tell if an object is above or below other objects.
	public var object:String;

	var name:String;

	public function new(x:Float, y:Float, object:String)
	{
		super(x, y);

		spawnObject(object, 24, false, 'idle');

		if (Std.parseInt(object) != null)
			object = LevelData.intToObjects[Std.parseInt(object)]; // cant just have a number be the name now can we?
		name = object;
		this.object = object + zIndex;
		antialiasing = !Save.data.lowQuality;
	}

	public function set_zIndex(value:Int):Int
	{
		zIndex = value;
		object = name + '_' + zIndex;
		return zIndex = value;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function spawnObject(object:String, framerate:Int = 24, isLooped:Bool = false, ?defaultAnim:Null<String> = null)
	{
		var objectInt:Int = 0;
		if (Std.parseInt(object) == null)
			objectInt = LevelData.objectsToInt[object]; // basically this game runs on an int object system, but also allows for direct object calls, this simply converts a String to an Int.
		if (Std.parseInt(object) != null)
			objectInt = Std.parseInt(object);

		switch (objectInt)
		{
			case 0:
				loadGraphic(Paths.image('objects/ground-' + PlayState.curLevelData)); // might change this to not be ground....
			case 1:
				loadGraphic(Paths.image('objects/wall-' + PlayState.curLevelData));
			case 2:
				loadGraphic(Paths.image('objects/pit-' + PlayState.curLevelData));
			case 3:
				makeGraphic(10, 10);
				this.visible = false;
			case 4:
				loadGraphic(Paths.image('objects/spawner')); // for debug view.
				this.visible = false;
		}
	}
}