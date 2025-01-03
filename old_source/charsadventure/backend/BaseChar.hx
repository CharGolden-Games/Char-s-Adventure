package charsadventure.backend;

import flixel.FlxSprite;

// TODO: Actually make this useful

/**
 * BaseChar serves as the base set of functions for setting up character functions, starts with a base function to load a character, determine the health value, and other such things.
 */
class BaseChar extends FlxSprite
{
	public var curHealth:Float = 0;
	public var maxHealth:Float = 5;
	public var healthPercent:Float = 0;
	public var facingDir:Int = 0;
	public var idleRightFlipX:Bool = false;

	public function new(x:Float, y:Float, char:String, startingAnim:String, ?fps:Int = 24, ?loop:Bool = true, startingHealth:Float, maxHealth:Float)
	{
		super(x, y);

		loadChar(char, startingAnim, fps, loop);

		// Health Setup.
		this.curHealth = startingHealth;
		this.maxHealth = maxHealth;
		// yuh.
		antialiasing = !Save.data.lowQuality;
	}

	/**
	 * This function loads a characters image, and adds an animation called idle based on the animation supplied by startingAnim
	 * @param char 
	 * @param startingAnim 
	 * @param fps 
	 * @param loop 
	 * @return
	 */
	public function loadChar(char:String, startingAnim:String, ?framerate:Int = 24, ?loop:Bool = true)
	{
		// If you override this option for changing the animation, put super.loadChar BEFORE overwriting the idle animation. else it'll be re overwritten
		loadGraphic(Paths.playerImage(char));

		frames = Paths.playerXML(char);
		animation.addByPrefix('idle', startingAnim, framerate, loop);
		animation.addByPrefix('idleRight', startingAnim + 'Right', framerate, loop);
		if (!animation.exists('idleRight'))
		{
			animation.addByPrefix('idleRight', startingAnim, framerate, loop);
			idleRightFlipX = true;
		}
		animation.play('idle');
	}

	public var curFrame:Int = 0;

	override function update(elapsed:Float)
	{
		curFrame++;
		super.update(elapsed);
		if (curFrame % Main.game.framerate == 0)
		{
			curFrame = 0;
			doIdle();
		}

		healthCalc();
	}

	public function healthCalc():Float
	{
		return healthPercent = curHealth / maxHealth;
	}

	public function addHealth(health:Float):Float
	{
		if (curHealth + health > maxHealth)
		{
			maxHealth += health;
		}
		return curHealth += health;
	}

	public function doDamage(dmg:Float):Float
	{
		return curHealth = curHealth - dmg;
	}

	/**
	 * Plays the idle. duh.
	 * @param deny Whether to actually NOT play the idle lmao
	 */
	public function doIdle(deny:Bool = false)
	{
		if (!deny)
		{
			var curIdle:String = switch (facingDir)
			{
				default:
					'idle';
				case 1:
					'idleRight';
			};
			if (animation.exists(curIdle))
			{
				playAnim(curIdle, true);
				this.flipX = false;
				if (curIdle == 'idleRight' && idleRightFlipX)
				{
					this.flipX = true;
				}
			}
		}
	}

	/**
	 * Taken From Class `FlxAnimationController`, Used as a shortcut to it so i dont have to type out as much 
	 * 
	 * 
	 * Plays an existing animation (e.g. `"run"`).
	 * If you call an animation that is already playing, it will be ignored.
	 *
	 * @param   animName   The string name of the animation you want to play.
	 * @param   force      Whether to force the animation to restart.
	 * @param   reversed   Whether to play animation backwards or not.
	 * @param   frame      The frame number in the animation you want to start from.
	 *                     If a negative value is passed, a random frame is used.
	 */
	public function playAnim(anim:String, force:Bool = false, reversed:Bool = false, frame:Int = 0)
	{
		this.animation.play(anim, force, reversed, frame);
	}
}