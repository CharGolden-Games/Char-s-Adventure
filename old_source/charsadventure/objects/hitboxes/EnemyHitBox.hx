package charsadventure.objects.hitboxes;

import charsadventure.objects.characters.Enemy;

class EnemyHitBox extends FlxSprite
{
	public var name:String;
	public var trackingObject:Enemy;

	var targets:Array<HitBox>;
	var damage:Float = 0;

	public function new(x:Float, y:Float, name:String, objectToTrack:Enemy, targets:Array<HitBox>, alpha:Float = 0.3, damage:Float, ?forceHeight:Int = null,
			?forceWidth:Int = null)
	{
		super(x, y);

		var width:Int = Std.int(objectToTrack.width);
		var height:Int = Std.int(objectToTrack.height);
		this.name = name + '_hitbox';
		trackingObject = objectToTrack;
		this.targets = targets;
		this.damage = damage;

		if (forceHeight != null)
			height = forceHeight;
		if (forceWidth != null)
			width = forceWidth;

		this.alpha = alpha;

		makeGraphic(width, height, 0xFFFFBB00);

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
			if (trackingObject.health <= 0)
			{
				trackingObject.destroy();
				destroy();
			}
			x = trackingObject.x;
			y = trackingObject.y;
		}

		if (targets != null)
		{
			for (target in targets)
			{
				if (target == null)
				{
					targets.remove(target);
					return;
				}
				if (FlxG.overlap(this, target))
					target.trackingObject.doDamage(damage);
			}
		}
	}
}