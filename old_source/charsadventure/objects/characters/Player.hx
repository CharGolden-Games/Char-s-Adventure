package charsadventure.objects.characters;

import charsadventure.states.PlayState;
import flixel.effects.FlxFlicker;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

// TODO: DO THIS BETTER IT SUCKSSSSS.
class Player extends BaseChar
{
	public var zIndex(default, set):Int = 0;
	public var delayTimer:FlxTimer;
	public var flicker:FlxFlicker;
	public var hitTimer:FlxTimer;
	public var name:String;

	var char:String;

	public var player:Int = 1;

	/**
	 * minX, minY, maxX, maxY
	 */
	public var worldBounds:Array<Float> = [-100000, -100000, 100000, 100000];

	var controls(get, never):Controls;

	private function get_controls()
	{
		return Controls.instance;
	}

	var ogColor:Int;

	public function new(char:String, x:Float = 0, y:Float = 0)
	{
		var image:String = switch (char.toLowerCase())
		{
			default:
				'charPlayer';
			case 'plexi':
				'plexiPlayer';
			case 'trevor':
				'trevorPlayer';
		};
		super(x, y, image, 'IdleMic0', 24, false, 5, 5);
		healthPercent = 1;
		animation.addByPrefix('idleRight', 'IdleMicRight', 24, false);
		idleRightFlipX = false;
		animation.addByPrefix('walkLEFT', 'WalkLeftMic', 24, true);
		animation.addByPrefix('walkRIGHT', 'WalkRightMic', 24, true);
		animation.addByPrefix('attackLeft', 'SingLeft', 24, false);
		animation.addByPrefix('attackRight', 'SingRight', 24, false);
		animation.addByPrefix('hit', 'Hurt0', 24, false);
		name = char + zIndex;
		this.char = char;
		ogColor = color;
	}

	public function set_zIndex(value:Int):Int
	{
		zIndex = value;
		name = char + '_' + zIndex;
		return zIndex = value;
	}

	public function pauseTimers(bool:Bool)
	{ // pause screen shit.
		if (delayTimer != null)
			delayTimer.active = !bool;
		if (hitTimer != null)
			hitTimer.active = !bool;
	}

	public function cancelTimers()
	{
		if (delayTimer != null)
			delayTimer.cancel();
		if (hitTimer != null)
			hitTimer.cancel();
		if (flicker != null)
			flicker.stop();
	}

	var up = false;
	var left = false;
	var down = false;
	var right = false;
	var hold = false;
	var attack = false;
	var release = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (curHealth / maxHealth <= 0.3)
		{
			color = 0xFFFFC0C0;
		}
		else
		{
			color = ogColor;
		}
		switch (facingDir)
		{
			case 0:
				offset.x = 60;
			case 1:
				offset.x = 0;
		}

		up = controls.move_up;
		left = controls.move_left;
		down = controls.move_down;
		right = controls.move_right;
		hold = controls.move_hold;
		attack = controls.attack_p;
		release = (controls.move_down_r || controls.move_up_r || controls.move_left_r || controls.move_right_r) ? true : false;

		doMovement();
	}

	public var isEarly:Bool;

	override function doIdle(deny:Bool = false)
	{
		if (up || left || down || right || attack)
		{
			deny = true;
		}

		isEarly = (curFrame % Main.game.framerate - 1 == 0
			|| curFrame % Main.game.framerate - 2 == 0
			|| curFrame % Main.game.framerate - 3 == 0
			|| curFrame % Main.game.framerate - 4 == 0) ? true : false;

		if (release && isEarly)
			deny = true;
		super.doIdle(deny);
	}

	public var blockAnim:Bool = false;

	public function doMovement()
	{
		if (!blockAnim)
		{
			if (release)
			{
				switch (facingDir)
				{
					case 0:
						animation.play('idle');
					case 1:
						animation.play('idleRight');
				}
			}
			if (up)
			{
				if (y >= worldBounds[1])
					y -= 15;
				if (!hold)
				{
					switch (facingDir)
					{
						case 0:
							animation.play('walkLEFT');
						case 1:
							animation.play('walkRIGHT');
					}
				}
			}
			if (down)
			{
				if (y <= worldBounds[3])
					y += 15;
				if (!hold)
				{
					switch (facingDir)
					{
						case 0:
							animation.play('walkLEFT');
						case 1:
							animation.play('walkRIGHT');
					}
				}
			}
			if (left)
			{
				if (x >= worldBounds[0])
					x -= 15;
				facingDir = 0;
				if (!hold)
					animation.play('walkLEFT');
			}
			if (right)
			{
				if (x <= worldBounds[2])
					x += 15;
				facingDir = 1;
				if (!hold)
					animation.play('walkRIGHT');
			}
			if (attack)
			{
				if (PlayState.instance != null)
					PlayState.instance.doHurt(player);
			}
		}
	}

	override function doDamage(dmg:Float):Float
	{
		if (delayTimer != null)
			return curHealth;
		// PlayState.doDamage(true);

		// curHealth -= dmg;
		animation.play('hit');
		hitTimer = new FlxTimer().start(0.81, function(tmr:FlxTimer)
		{
			animation.play('idle');
			// PlayState.doDamage(false);
		});
		flicker = FlxFlicker.flicker(this, 4, 0.04, true, true, function(f:FlxFlicker)
		{
			flicker = null;
		});
		delayTimer = new FlxTimer().start(5, function(tmr:FlxTimer)
		{
			delayTimer = null;
		});
		return super.doDamage(dmg);
	}
}