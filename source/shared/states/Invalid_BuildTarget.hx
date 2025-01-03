package shared;

import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxState;
import charsadventure.utils.Paths;

class Invalid_BuildTarget extends FlxState
{
	override function create():Void
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF9A0000);
		add(bg);

		var text:FlxText = new FlxText(0, 0, FlxG.width,
			'THIS GAME DOES NOT SUPPORT 32 BIT SYSTEMS AS THE LIBRARIES REQUIRED FOR SOME SCENES DO NOT WORK WITH 32 BIT SYSTEMS', 40);
		text.setFormat(Paths.font('naname_goma.ttf'), 40, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
		add(text);
		text.y = (FlxG.height * 0.5) - (text.height + 5);
	}
}
