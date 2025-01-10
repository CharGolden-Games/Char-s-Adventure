package cre.graphics;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * A FlxSprite with some extra shenanigans.
 */
class CRESprite extends FlxSprite
{
	/**
	 * Used for sorting how the sprites are displayed, 
	 * where the higher the zIndex the farther above other sprites it gets rendered
	 */
	public static var zIndex:Int = 0;

	/**
	 * Makes a new CRE Base Sprite
	 * @param path The path to the sprite
	 * @param width How wide the sprite is
	 * @param height How tall the sprite is
	 * @param graphic A FlxGraphicAsset to use instead of the path.
	 * @return CRESprite
	 */
	public function newSprite(path:Null<String>, ?width:Int, ?height:Int, ?graphic:FlxGraphicAsset):CRESprite
	{
		antialiasing = LocalSettings.globalAntialiasing;

		if (path == null && graphic == null)
		{
			trace('Both the path and graphic are null!!');
			return null;
		}

		if (FlxColor.fromString(path) != null)
		{
			makeGraphic(width, height, FlxColor.fromString(path));
		}
		else
		{
			if (graphic != null)
				loadGraphic(graphic);
			else
				loadGraphic(path);
		}

		if (width != null)
		{
			if (height == null)
				setGraphicSize(width);
			else
				setGraphicSize(width, height);
		}
		if (height != null)
		{
			setGraphicSize(this.width, height);
		}

		return this;
	}
}
