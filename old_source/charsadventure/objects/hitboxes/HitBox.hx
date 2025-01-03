package charsadventure.objects.hitboxes;

import charsadventure.objects.characters.Player;

class HitBox extends FlxSprite
{
	public var name:String;
	public var trackingObject:Player;

	public function new(x:Float, y:Float, name:String, objectToTrack:Player, alpha:Float = 0.3, ?forceHeight:Float = null, ?forceWidth:Float = null)
	{
		super(x, y);

		var width:Int = 1;
		if (objectToTrack != null)
			width = Std.int(objectToTrack.width);
		var height:Int = 1;
		if (objectToTrack != null)
			height = Std.int(objectToTrack.height);
		this.name = name + '_hitbox';
		if (objectToTrack != null)
			trackingObject = objectToTrack;

		if (forceHeight != null)
			height = Std.int(forceHeight);
		if (forceWidth != null)
			width = Std.int(forceWidth);

		this.alpha = alpha;

		makeGraphic(width, height, 0xFFFFFFFF);

		#if !debug
		visible = Save.data.showHitBoxes; // force it invisible if its not debug, and the player hasnt checked the fun option in CheatState.
		#end
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (trackingObject != null)
		{
			x = trackingObject.x;
			y = trackingObject.y;
		}
	}
}