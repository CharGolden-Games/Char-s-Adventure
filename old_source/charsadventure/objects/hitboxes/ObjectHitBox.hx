package charsadventure.objects.hitboxes;

import charsadventure.objects.MapObjectLegacy as MapObject;

class ObjectHitBox extends FlxSprite
{
	public var name:String;
	public var trackingObject:MapObject;

	public function new(x:Float, y:Float, name:String, objectToTrack:MapObject, alpha:Float = 0.3, ?forceHeight:Int = null, ?forceWidth:Int = null)
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
			height = forceHeight;
		if (forceWidth != null)
			width = forceWidth;

		this.alpha = alpha;

		makeGraphic(width, height, 0xFFFFFFFF);

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
			x = trackingObject.x;
			y = trackingObject.y;
		}
	}
}