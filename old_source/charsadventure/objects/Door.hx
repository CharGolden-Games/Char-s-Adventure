package charsadventure.objects;

import charsadventure.objects.MapObjects.MapObject;

class Door extends MapObject
{
	public var doorID:Float;
	// Currently unused while i finish the new MapObject code.
}

/**
 * Old Door code.
 */
class DoorLegacy extends FlxSprite
{
	public var whereTo:Int; // a door is functionally useless if it goes to ABSOLUTELY FUCKING NOWHERE.
	public var isFakeDoor:Bool; // HAHA DOOR GO *smash, wood breaking sounds*

	public function new(x:Float, y:Float, whereTo:Int, isFakeDoor:Bool, hasGraphic:Bool = false /*if you want a door to dynamically change yknow.*/,
			hasDebugGraphic:Bool = false /*if you dont need a door to dynamically change, but need to see it in debug.*/, ?image:String)
	{
		super(x, y);

		if (hasDebugGraphic && !hasGraphic)
			makeGraphic(10, 10);

		if (hasGraphic)
			loadGraphic(Paths.image(image));

		this.isFakeDoor = isFakeDoor;
		this.whereTo = whereTo;
		antialiasing = !Save.data.lowQuality;
	}

	public function moveRooms()
	{
		// PlayState.reloadRoom(LevelData.intToLevel[whereTo], LevelData.intToDefaultPos[whereTo]);
	}
}