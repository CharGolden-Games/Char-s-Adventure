package charsadventure.play.components;

/**
 * Yeah this is based off of Psych Engine what about it?.
 */
class HealthIcon extends FlxSprite
{
	public var zIndex:Int = 0;
	public var sprTracker:FlxSprite;

	var char:String = '';
	var shouldFlip:Bool = false;

	public function new(char:String, shouldFlip:Bool = false)
	{
		super();
		this.shouldFlip = shouldFlip;

		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	private var iconOffsets:Array<Float> = [0, 0, 0];

	function changeIcon(char:String):Void
	{
		if (this.char != char)
		{
			var name = 'icons/$char';
			if (!Paths.fileExists('images/$name.png'))
				name = 'icons/icon-$char';
			if (!Paths.fileExists('images/$name.png'))
				name = 'fallback/icons/default';
			var file:Dynamic = Paths.imageToFlxGraphic(Paths.image(name));

			loadGraphic(file);

			var framesToLoad:Int = Math.round(width / height);
			loadGraphic(file, true, Math.floor(width / framesToLoad), Math.floor(height));
			var framesArray:Array<Int> = [];
			for (i in 0...framesToLoad)
			{
				iconOffsets[i] = (width - 150) / framesToLoad;
				framesArray.insert(Std.int(1 * i), i); // theoretically it'll do this, 1 * 0 = 0, 1 * 1 = 1, etc.
			}
			animation.add(char, framesArray, 0, false, shouldFlip);
			animation.play(char);
			this.char = char;
		}
	}

	override function updateHitbox():Void
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String
	{
		return char;
	}
}
