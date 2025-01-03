package charsadventure.backend;

import flixel.system.scaleModes.StageSizeScaleMode as ScaleMode;

class SetScaleMode
{
	public static function doScale()
	{
		#if EXPERIMENTAL_SCALING
		FlxG.scaleMode = new ScaleMode(); // So it can change its shitty self to be whatever aspect ratio its in.
		#end
	}
}