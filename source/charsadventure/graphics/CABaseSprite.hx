package charsadventure.graphics;

import flixel.system.FlxAssets.FlxGraphicAsset;
import charsadventure.play.character.BaseCharacter.AnimArray;

/**
 * A FlxSprite with extra functions that are useful for what im doing.
 */
class CABaseSprite extends FlxSprite
{
	/**
	 * Used for sorting display objects
	 */
	public var zIndex:Int = 0;

	/**
	 * Variable for accessing certain non-static functions statically.
	 */
	public static var instance:CABaseSprite;

	public var updateFunction:Null<Float->Void>;

	/**
	 * Array of currently set animations.
	 */
	public var curAnimations:Array<AnimArray> = [];

	/**
	 * Set this if you dont want it to stop updating off screen.
	 */
	public var updateOffscreen:Bool = false;

	public function new(x:Float, y:Float, ?updateFunction:Null<Float->Void>)
	{
		super(x, y);

		instance = this;
		antialiasing = !Save.data.lowQuality;
		this.updateFunction = updateFunction;
	}

	/**
	 * Creates and returns `this`
	 * @param path The path to the image or a FlxColor
	 * @param width If making a graphic, the width of the graphic
	 * @param height If making a graphic, the height of the graphic.
	 * @param animArray An array of animation data (See charsadventure.play.character.BaseCharacter.AnimArray)
	 * @param graphic A FlxGraphicAsset if you want to re use one.
	 * @return BaseGraphic
	 */
	public function create(path:String, width:Int = 0, height:Int = 0, ?animArray:Array<AnimArray>, ?graphic:FlxGraphicAsset):CABaseSprite
	{
		if (instance == null)
		{
			instance = this;
		}

		if (FlxColor.fromString(path) != null)
		{
			makeGraphic(width, height, FlxColor.fromString(path));
			return this;
		}
		if (graphic != null)
		{
			loadGraphic(graphic);
			if (animArray != null)
			{
				curAnimations = animArray;
				frames = Paths.xmlFramesFromPath(path);
				for (animParams in animArray)
				{
					if (animParams.indices == null)
					{
						animation.addByPrefix(animParams.name, animParams.anim, animParams.fps, animParams.loop);
					}
					else
					{
						animation.addByIndices(animParams.name, animParams.anim, animParams.indices, null, animParams.fps, animParams.loop);
					}
				}
			}
		}
		else
		{
			loadGraphic(path);
			if (animArray != null)
			{
				frames = Paths.xmlFramesFromPath(path);
				for (anim in animArray)
				{
					if (anim.indices == null)
					{
						animation.addByPrefix(anim.name, anim.anim, anim.fps, anim.loop);
					}
					else
					{
						animation.addByIndices(anim.name, anim.anim, anim.indices, null, anim.fps, anim.loop);
					}
				}
			}
		}
		return this;
	}

	/**
	 * reloads animations with a given array (OVERWRITES ALL CURRENT ANIMATIONS.)
	 * @param animationsArray An array of animation data (See charsadventure.play.character.BaseCharacter.AnimArray)
	 */
	public function reloadAnims(animationsArray:Array<AnimArray>):Void
	{
		animation.destroyAnimations();
		curAnimations = animationsArray;
		for (anima in animationsArray)
		{
			if (anima.indices == null)
			{
				animation.addByPrefix(anima.name, anima.anim, anima.fps, anima.loop);
			}
			else
			{
				animation.addByIndices(anima.name, anima.anim, anima.indices, null, anima.fps, anima.loop);
			}
		}
	}

	/**
	 * Plays an animation and assigns its offsets
	 * @param name The name of the animation
	 */
	public function playAnim(name:String):Void
	{
		if (animation.exists(name))
		{
			for (anim in curAnimations)
			{
				if (anim.name == animation.curAnim.name)
				{
					if (this.offset.x != anim.offsets[0])
					{
						this.offset.x = anim.offsets[0];
					}
					if (this.offset.y != anim.offsets[1])
					{
						this.offset.y = anim.offsets[1];
					}
				}
			}
			this.animation.play(name);
		}
	}

	override function update(elapsed:Float):Void
	{
		/**
		 * "Lets see if this causes issues!"
		 *                                   - Char
		 */
		if (!isOnScreen(this.camera))
		{
			if (this.visible)
			{
				this.visible = false;
			}
			// Don't do anything else if offscreen.
			return;
		}

		if (isOnScreen(this.camera))
		{
			if (!this.visible)
			{
				this.visible = true;
			}
		}
		if (updateFunction != null)
			updateFunction(elapsed);
		super.update(elapsed);
	}
}
