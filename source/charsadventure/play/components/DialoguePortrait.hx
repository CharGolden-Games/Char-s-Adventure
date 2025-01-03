package charsadventure.play.components;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class DialoguePortrait extends FlxTypedSpriteGroup<Dynamic>
{
	public var portrait:FlxSprite;

	public var portraitMissingText:FlxText;

	/**
	 * Just in case you want to do shit, but only have a static function
	 */
	public static var instance:DialoguePortrait;

	public var side:Int = 0;

	public function new(x:Float, y:Float, image:String, side:Int)
	{
		super(x, y);

		portraitMissingText = new FlxText(0, 0, 0, 'Error:\n$image.png');

		var isMissing:Bool = false;

		if (Paths.dialoguePortrait(image) == null)
		{
			image = 'assets/images/fallback/dialoguePortraits/null.png';
			isMissing = true;
		}
		else
		{
			image = Paths.dialoguePortrait(image);
		}

		portrait = new FlxSprite().loadGraphic(image);
		add(portrait);

		if (isMissing)
		{
			portraitMissingText.x = portrait.getGraphicMidpoint().x - 100;
			portraitMissingText.y = portrait.getGraphicMidpoint().y - 100;
			add(portraitMissingText);
		}

		if (side == 1)
			portrait.flipX = true;
		else
			portrait.flipX = false;
	}
}
