package charsadventure.ui;

class ErrorSubstate extends BaseSubState
{
	var bg:FlxSprite;
	var errTxt:FlxText;
	var fadeTime:Float = 0;
	var lastState:FlxState;

	public function new(t:String, fadeTime:Float = 5, lastState:Null<FlxState> = null)
	{
		super();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
		var cameraPos = [cameras[0].x, cameras[0].y];
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		bg.x = cameraPos[0];
		bg.y = cameraPos[1];
		add(bg);
		errTxt = new FlxText(bg.getGraphicMidpoint().x, bg.getGraphicMidpoint().y, FlxG.width, 'Error!\n"$t"', 20);
		errTxt.setFormat(null, 20, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
		errTxt.x = errTxt.x - (errTxt.width / 2);
		add(errTxt);

		this.fadeTime = fadeTime;

		FlxTween.tween(bg, {alpha: 0}, fadeTime, {ease: FlxEase.quartOut});
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (fadeTime > 1)
		{
			// 1 second and below is far too fast to close it early.
			// However, it should close earlier if its slower due to it looking like you can move when you cant.
			if (bg.alpha < 0.2)
			{ // Practically invisible.
				close();
			}
		}

		if (lastState != null)
		{
			if (FlxG.keys.justPressed.ENTER)
			{ // somethin' to dismiss the thing.
				close();
			}
		}
	}
}
