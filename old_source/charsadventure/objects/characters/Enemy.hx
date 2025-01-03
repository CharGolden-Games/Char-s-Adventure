package charsadventure.objects.characters;

import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import flixel.ui.FlxBar;
import flixel.util.FlxAxes;
import flixel.util.FlxTimer;

class Enemy extends BaseChar
{
	public var name:String;
	public var damage:Float;
	public var speed:Float;

	var ogName:String;

	public var flicker:FlxFlicker;
	public var hitTimer:FlxTimer;
	public var isBoss:Bool = false;
	public var healthBar:FlxBar;
	public var chaseDistance:Float = 0;

	var delayTimer:FlxTimer;

	public var xDistanceCalcP1:Float = 0;
	public var yDistanceCalcP1:Float = 0;
	public var xDistanceCalcP2:Float = 0;
	public var yDistanceCalcP2:Float = 0;
	public var xDistanceCalcP3:Float = 0;
	public var yDistanceCalcP3:Float = 0;
	public var targets(default, set):Array<Player>;

	public function set_targets(value:Array<Player>):Array<Player>
	{
		return targets = value;
	}

	public function setChaseTargets(value:Array<Player>)
	{
		set_targets(value);
	}

	public var zIndex(default, set):Int = 0;

	public function set_zIndex(value:Int):Int
	{
		zIndex = value;
		name = ogName + '_' + zIndex;
		return zIndex = value;
	}

	public function new(x:Float, y:Float, chaseDistance:Float, charImg:String, speed:Float, defense:Float, health:Float, name:String, damage:Float)
	{
		super(x, y, charImg, Constants.enemyToDefaultAnim[charImg], 24, false, health, health);

		ogName = name;
		this.name = name + '_' + zIndex;
		this.damage = damage;
		this.speed = speed;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		for (i in 0...targets.length)
		{
			switch (i)
			{
				case 0:
					xDistanceCalcP1 = this.x - targets[0].x;
					yDistanceCalcP1 = this.y - targets[0].y;

				case 1:
					xDistanceCalcP2 = this.x - targets[1].x;
					yDistanceCalcP2 = this.y - targets[1].y;

				case 2:
					xDistanceCalcP3 = this.x - targets[1].x;
					yDistanceCalcP3 = this.y - targets[1].y;
			}
		}
		// states.PlayState.instance.print('enemy $name speed: $speed');

		if (xDistanceCalcP1 != 0)
		{
			var int = xDistanceCalcP1 < 0 ? 1 : -1;
			this.x += speed * int;
		}
		if (yDistanceCalcP1 != 0)
		{
			var int = yDistanceCalcP1 < 0 ? 1 : -1;
			this.y += speed * int;
		}

		health = curHealth; // For external shiz.
		if (health <= 0)
			visible = false;
		active = false;
	}

	override function doDamage(dmg:Float):Float
	{
		try
		{
			if (delayTimer != null)
				delayTimer.cancel();
			if (flicker != null)
				flicker.stop();
			// PlayState.doDamage(true);

			// health -= dmg;
			animation.play('hit');
			hitTimer = new FlxTimer().start(0.81, function(tmr:FlxTimer)
			{
				try
				{
					animation.play('idle');
				}
				catch (e:Dynamic) {}
				// PlayState.doDamage(false);
			});
			flicker = FlxFlicker.flicker(this, 0.81, 0.04);
			delayTimer = new FlxTimer().start(0.81, function(tmr:FlxTimer)
			{
				delayTimer = null;
				flicker = null;
			});
		}
		catch (e:Dynamic) {}
		return super.doDamage(dmg);
	}

	override function destroy()
	{
		super.destroy();
		if (hitTimer != null)
		{
			hitTimer.cancel();
		}
	}
}