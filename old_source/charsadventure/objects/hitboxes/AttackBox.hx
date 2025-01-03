package charsadventure.objects.hitboxes;

import charsadventure.objects.characters.Enemy;
import charsadventure.objects.characters.Player;
import charsadventure.states.MainMenuState;
import flixel.FlxObject;
import shared.backend.Save.GameProgress;

class AttackBox extends FlxSprite
{
	public var trackingObject:Player;

	var damage:Float = 0;
	var offsetArray:Array<Float>;
	var targets:Array<Player>;
	var targetsEnemy:Array<Enemy>;

	public function new(x:Float, y:Float, objectToTrack:Player, targets:Array<Player> = null, targetsEnemy:Array<Enemy>, alpha:Float = 0.3, height:Int = null,
			width:Int = null, distanceOffset:Array<Float>, damage:Float)
	{
		super(x, y);

		trackingObject = objectToTrack;
		offsetArray = distanceOffset;
		this.damage = damage;
		this.targets = targets;
		this.targetsEnemy = targetsEnemy;

		this.alpha = alpha;

		makeGraphic(width, height, 0xFFFF0000);

		#if !debug
		if (!Save.data.showHitBoxes)
			visible = false; // force it invisible if its not debug, and the player hasnt checked the fun option in CheatState.
		#end
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (trackingObject != null)
		{
			x = trackingObject.x + offsetArray[0];
			y = trackingObject.y + offsetArray[1];
		}

		if (targets != null)
		{
			for (target in targets)
			{
				if (FlxG.overlap(this, target))
					target.doDamage(damage);
			}
		}

		for (target in targetsEnemy)
		{
			if (target == null)
			{
				targetsEnemy.remove(target);
				return;
			}
			if (target != null)
			{
				if (FlxG.overlap(this, target))
					target.doDamage(damage);
			}
		}
	}
}