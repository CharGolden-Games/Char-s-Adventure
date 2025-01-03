package charsadventure.play.components;

import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 *  If i need a camera to do something custom, i'll add it here!
 */
class CustomCam extends FlxCamera
{
	/**
	 * yuh
	 */
	public var tween:FlxTween;

	var intendedAlpha:Float;
	var curMult:Float;
	var name:String;

	// So you can use non-static functions in static functions.
	public static var instance:CustomCam;

	public function new(x:Float = 0, y:Float = 0, width:Int = 0, height:Int = 0, zoom:Float = 0, ?name:String)
	{
		super(Std.int(x), Std.int(y), width, height, zoom);
		if (name != null)
		{
			this.name = name;
		}
		else
		{
			this.name = 'cam';
		}
		create();
	}

	function create():Void
	{
		instance = this;
		intendedAlpha = alpha;
		curMult = 1;

		FlxG.watch.add(this, "intendedAlpha", 'Next Alpha ($name):');
	}

	/**
	 * Does a funny camera zoom tween.
	 * @param zoom how far inward or outward to go.
	 * @param time how long to tween
	 * @param onComplete what to do when it finishes
	 * @return FlxTween
	 */
	public inline function doZoomTween(zoom:Float, time:Float, ?onComplete:Null<TweenCallback>):Void
	{
		if (tween != null)
		{
			try
			{
				tween.cancel();
			}
			catch (e:Any)
			{
				trace('Could not cancel tween! $e');
			}
		}

		var ease:Null<EaseFunction>;
		if (zoom - this.zoom < 0)
		{
			ease = FlxEase.quartOut;
		}
		else
		{
			ease = FlxEase.quartIn;
		}

		tween = FlxTween.tween(this, {zoom: zoom}, time, {
			ease: ease,
			onComplete: onComplete
		});
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (alpha != intendedAlpha)
		{
			if (alpha < intendedAlpha)
			{
				alpha += 0.1 * curMult;
				alpha = Math.min(alpha, intendedAlpha);
			}
			else
			{
				alpha += -(0.1 * curMult);
				alpha = Math.max(alpha, intendedAlpha);
			}
		}
	}

	/**
	 * Tweens the alpha based on the multiplier
	 * 
	 * 
	 * NOTE: DOES NOT USE AN ACTUAL TWEEN JUST ADDS OR REMOVES ALPHA
	 * @param alpha The alpha to tween it to.
	 * @param mult How much to tween by (As 0.1 * mult)
	 */
	public function tweenAlpha(alpha:Float, mult:Float = 1):Void
	{
		intendedAlpha = alpha;
		curMult = mult;
	}

	override function destroy():Void
	{
		super.destroy();

		FlxG.watch.remove(this, "intendedAlpha");
	}

	/**
	 * Tells this camera object what `FlxObject` to track.
	 * @param target The object you want the camera to track. Set to `null` to not follow anything.
	 * @param style Leverage one of the existing "deadzone" presets. Default is `LOCKON`.
	 * If you use a custom deadzone, ignore this parameter and
	 * manually specify the deadzone after calling `follow()`.
	 * @param lerp How much lag the camera should have (can help smooth out the camera movement).
	 * @param affectBaseCamera Whether FlxG.camera should also be changed. (Useful if you have an object on a seperate camera.)
	 */
	public function setFollow(target:FlxObject, ?style:FlxCameraFollowStyle, ?lerp:Float, affectBaseCamera:Bool = false):Void
	{
		follow(target, style, lerp);
		if (affectBaseCamera)
		{
			FlxG.camera.follow(target, style, lerp);
		}
	}

	/**
	 * Sets this cameras zoom
	 * @param zoom The zoom to set it to
	 * @param affectBaseCamera Whether to affect FlxG.camera (Useful if you have an object on a seperate camera from the default.)
	 */
	public function setZoom(zoom:Float, affectBaseCamera:Bool = false):Void
	{
		this.zoom = zoom;
		if (affectBaseCamera)
		{
			FlxG.camera.zoom = zoom;
		}
	}
}
