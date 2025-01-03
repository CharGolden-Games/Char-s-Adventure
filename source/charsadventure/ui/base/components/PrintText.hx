package charsadventure.ui.base.components;

/**
 * Flxtext that auto tweens itself out.
 */
class PrintText extends FlxText
{
	/**
	 * Whether the tween has finished.
	 */
	public var doDestroy:Bool = false;

	public function new(text:String)
	{
		super(0, 0, 0, text, 20);

		setFormat(Paths.font('naname_goma.ttf'), 10, 0xFFFFFFFF, null, OUTLINE, 0xFF000000);
		borderSize = 3;

		FlxTween.tween(this, {alpha: 0}, 5, {
			onComplete: function(twn:FlxTween)
			{
				doDestroy = true;
			}
		});
	}
}

/**
 * Handles managing print text shenanigans.
 */
class PrintTextGroup extends FlxTypedGroup<PrintText>
{
	/**
	 * Creates a new PrintText object and moves all others downward.
	 * @param text What to put in the print text.
	 */
	public function addPrintText(text:String):Void
	{
		if (members.length != 0)
		{
			for (i in 0...members.length)
			{
				members[i].y += 15;
			}
		}

		var text:PrintText = new PrintText(text);
		add(text);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		for (i in 0...members.length)
		{
			try
			{
				if (members[i].doDestroy)
				{
					members[i].destroy();
					remove(members[i], true);
				}
			}
			catch (e:Dynamic)
			{
				remove(members[i], true);
			}
		}
	}
}
