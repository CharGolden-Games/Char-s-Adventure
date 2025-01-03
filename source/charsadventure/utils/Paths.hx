package charsadventure.utils;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.Assets as FlAssets;
import openfl.display.BitmapData;
#if sys
import sys.FileSystem;
#else
import lime.utils.Assets; // to be used

#end
class Paths
{
	static var extension:String = #if web 'mp3' #else 'ogg' #end;

	public static inline function font(key:String):String
	{
		return 'assets/fonts/$key';
	}

	public static inline function data(key:String):String
	{
		var path = 'assets/data/$key';
		if (!fileExists(path))
		{
			trace('SHIT $path is NULL!');
			return null;
		}
		return path;
	}

	/**
	 * Checks if a file exists embedded or not.
	 * 
	 * This means both embedded and non-embedded files can be used without tripping `if (!FileSystem.exists(<path>))` if its embedded.
	 * 
	 * FileSystem used on supported targets for assets not originally included in the base game.
	 * 
	 * openfl.Assets used for assets in basegame, especially if they're embedded files.
	 * @param file The file to look for. (Paths.<type> reccommended to make this easier.)
	 * @return Bool `#if sys FileSystem.exists(path) #end` or `FlAssets.exists(path)`
	 */
	public static inline function fileExists(file:String):Bool
	{
		var path = 'assets/$file';
		if (file.contains('assets'))
		{
			/*
			 * If you're checking something like `Paths.image('Some_image')` 
			 * it'll already have assets there making it `assets/assets/images/Some_image.png`
			 * So this if statement is for that.
			 */
			path = file;
		}
		return (#if sys FileSystem.exists(path) || #end FlAssets.exists(path));
	}

	/**
	 * Because i keep forgetting where the paths are, and looking in the source assets folder doesn't help due to how its setup.
	 * 
	 * plus i want fallback stuff to be embedded anyway.
	 * @param path Which path to return (default is data, so if you input it wrong, it'll default there). [data / (sound/sounds) / (image/images) / music]
	 * @param key The actual file past the fallback directory.
	 * @return String
	 */
	public static function getFallbackPath(path:String = 'data', key:String = 'null.json'):String
	{
		switch (auto_formatString(path))
		{
			case 'image' | 'images':
				return 'assets/images/fallback/$key';
			case 'sound' | 'sounds':
				return 'assets/sound/fallback/$key';
			case 'music':
				return 'assets/music/fallback/$key';
			default:
				return 'assets/data/fallback/$key';
		}
	}

	/**
	 * Converts a string to `assets/images/key.png`
	 * @param key The asset you want to find
	 * @param library `CURRENTLY UNUSED` what library to look in, e.g. "videos".
	 * @param showIfNull Whether to return the fallback image
	 * @return String
	 */
	public static inline function image(key:String, ?library:Null<String> = null, showIfNull:Bool = true):String
	{
		var fallback:String = 'assets/images/fallback/null.png';
		var path = 'assets/images/$key.png';
		if (!fileExists(path))
		{
			trace('SHIT $path is NULL!');
			if (showIfNull)
			{
				return fallback;
			}
			else
			{
				return null;
			}
		}
		return path;
	}

	/**
	 * takes a character's name and makes it "assets/data/characters/`character`.json"
	 * @param character The name of the character to look for
	 * @return String
	 */
	public static inline function charData(character:String):String
	{
		var path:String = 'assets/data/characters/$character.json';
		if (!fileExists(path))
		{
			trace('SHIT $path IS NULL');
			return 'assets/data/fallback/characters/null.json';
		}
		return path;
	}

	public static inline function playerImage(player:String):String
	{
		var path = 'assets/images/characters/$player.png';
		if (!fileExists(path))
		{
			trace('SHIT $path IS NULL');
			return 'assets/images/fallback/null.png';
		}
		return path;
	}

	/**
	 * REQUIRES FULL PATH.
	 */
	public static function imageToFlxGraphic(img:String):FlxGraphic
	{
		var bitmap:BitmapData = null;
		var file = img;

		if (FlAssets.exists(file, IMAGE))
			bitmap = FlAssets.getBitmapData(file);

		if (bitmap != null)
		{
			var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, file);
			graphic.persist = true;
			graphic.destroyOnNoUse = false;
			return graphic;
		}

		trace('SHIT THATS NULL ($file)');
		return null;
	}

	/**
	 * Returns frames for animation.
	 * @param image The image to load the xml for
	 * @return FlxAtlasFrames
	 */
	public static inline function xmlFrames(image:String):FlxAtlasFrames
	{
		return FlxAtlasFrames.fromSparrow(imageToFlxGraphic(Paths.image(image)), 'assets/images/$image.xml');
	}

	/**
	 * Returns xml frame data for an image from a FULL path (e.g. specify `assets/data/image.png`)
	 * @param path The full path
	 * @return FlxAtlasFrames
	 */
	public static function xmlFramesFromPath(path:String):FlxAtlasFrames
	{
		path = path.replace('.png', '');
		return FlxAtlasFrames.fromSparrow('$path', '$path.xml');
	}

	public static inline function dialoguePortrait(key:String, ?library:String):String
	{
		var path = 'assets/images/dialoguePortraits/$key.png';
		if (!fileExists(path))
		{
			trace(path + ' is NULL!');
			return null;
		}
		return path;
	}

	public static inline function dialogue(key:String, ?library:String):String
	{
		var path = 'assets/data/dialogue/$key.json';
		if (!fileExists(path))
		{
			trace(path + ' is NULL!');
			return 'assets/data/dialogue/fallback/null.json';
		}
		return path;
	}

	public static inline function music(key:String, ?library:String):String
	{
		var path = 'assets/music/$key.$extension';
		if (!fileExists(path))
		{
			trace('SHIT $path IS NULL!');
			return 'assets/music/fallback/null.$extension';
		}
		return path;
	}

	public static inline function sound(key:String, ?library:String):String
	{
		var path = 'assets/sounds/$key.$extension';
		if (!fileExists(path))
		{
			trace('SHIT $path is NULL!');
			return 'assets/sounds/fallback/null.$extension';
		}
		return path;
	}

	/**
	 * Static shortcut function to `CoolUtil.auto_formatString()`
	 * 
	 * "Auto lowercases, trims, and (optionally) replaces spaces with `-`"
	 * @param str The string
	 * @param replaceSpaces whether to replace spaces
	 * @return String
	 */
	public static function auto_formatString(str:String, replaceSpaces:Bool = false):String
	{
		return CoolUtil.instance.auto_formatString(str, replaceSpaces);
	}
}
