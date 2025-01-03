package save_editor.backend;

import flixel.graphics.FlxGraphic;
import flixel.system.FlxAssets.FlxGraphicAsset;
import openfl.Assets as FlAssets;
import openfl.display.BitmapData;

class Paths
{
	public static function image(key:String):String
	{
		return 'assets/save_editor/Resources/images/$key.png';
	}

	public static function image_graphic(key:String):FlxGraphicAsset
	{
		var bitmap:BitmapData = null;
		var file = image(key);

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

	public static function data(key:String):String
	{
		return 'assets/save_editor/Resources/data/$key';
	}
}
