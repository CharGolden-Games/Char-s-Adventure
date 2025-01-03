package charsadventure.objects;

// Most map objects and their references are in this file.
import charsadventure.objects.hitboxes.ObjectHitBox;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class MapObjects extends FlxTypedGroup<MapObject>
{
	public function new(maxSize:Int = 0)
	{
		super(maxSize);
	}

	/**
	 * Best to call this instead of manually making a new object! unless you need it outside of this group type!
	 * @param x 
	 * @param y 
	 * @param id 
	 * @param sprite 
	 * @param isSolid 
	 * @param hitBoxCallback 
	 * @param isDestructable 
	 * @param name 
	 */
	public function add_Object(x:Float, y:Float, id:Int, ?sprite:Null<FlxGraphic>, isSolid:Bool = true, hitBoxCallback:Null<Dynamic->Dynamic>,
			isDestructable:Bool = false, ?name:Null<String>)
	{
		var object:MapObject = new MapObject(x, y, id, sprite, isSolid, hitBoxCallback, isDestructable, name);
		add(object);
		object.post_addedToGroup(this);
	}
}

/**
 * This class handles the creation and hitbox referencing that makes up a dynamic Map Object.
 */
class MapObject extends FlxTypedSpriteGroup<Dynamic>
{
	/**
	 * Controls initial properties by referencing from a list if it exists.
	 */
	public var objectID:Int = 0;

	/**
	 * The actual display object
	 */
	public var sprite:FlxSprite;

	/**
	 * Determines whether to assign a hitbox to this object.
	 */
	public var isSolid:Bool = true;

	/**
	 * Handles a hitbox's callback if specified
	 */
	public var hitBoxCallback:Null<Dynamic->Dynamic /**HitboxCallback->Dynamic**/>;

	/**
	 * Whether to track health for this object.
	 */
	public var isDestructable:Bool = false;

	/**
	 * The hitbox that is used if an object is either solid or destructable.
	 * 
	 * TODO: MAKE A CASE IN THE CLASS TO SIGNIFY THESE OPTIONS.
	 */
	public var hitbox:ObjectHitBox;

	/**
	 * The name of this particular object Usually becomes (friendlyName)\_(ID)-Instance_(instance)
	 */
	public var name:String;

	/**
	 * If part of a group, this gets set!
	 */
	public var parentGroup:MapObjects;

	/**
	 * This specific object's instance number, to keep track of how many there are.
	 */
	public var instanceNum:Int;

	public function new(x:Float, y:Float, id:Int, ?sprite:Null<FlxGraphic>, isSolid:Bool = true, hitBoxCallback:Null<Dynamic->Dynamic>,
			isDestructable:Bool = false, ?name:Null<String>)
	{
		super(x, y);

		this.objectID = id;

		this.sprite = new FlxSprite();
		if (sprite != null)
		{
			this.sprite.loadGraphic(sprite);
		}
		else
		{
			/**
			 * this.sprite.loadGraphic(ObjectID.intToObject[id]);
			 */
			this.sprite.loadGraphic(Paths.image('')); // Purposefully load a placeholder.
		}
		add(sprite);

		this.isSolid = isSolid;

		if (isSolid)
		{
			// TODO: MAKE THIS POINT TO A NAME IF UNSPECIFIED.
			// TODO: Make a new Object Hitbox class.
			/*hitbox = new ObjectHitBox(0, 0, Std.string(this.objectID), this.sprite, 0.3);
				add(hitbox); */
		}

		if (hitBoxCallback != null)
		{
			this.hitBoxCallback = hitBoxCallback;
		}

		this.isDestructable = isDestructable;
	}

	/**
	 * Always run this after adding to a group
	 * @param group 
	**/
	public function post_addedToGroup(group:FlxTypedGroup<Dynamic>)
	{
		instanceNum = group.members.length;
	}
}

/**
 * Template for the starting values of objects.
 */
typedef ObjectParams =
{
	public var isDestructable:Bool;
	public var isSolid:Bool;
	public var name:String;
	public var hitBoxCallback:Null<Dynamic->Dynamic>;
}

/**
 * This class (To be moved elsewhere) handles initialization of object properties.
 */
class DefaultObjectParams
{
	final illegalIDs:Array<Int> = [];

	public function check_params(id:Int):ObjectParams
	{
		if (!illegalIDs.contains(id))
		{
			switch (id)
			{
				case 0:
					return {
						name: 'Basic Wall',
						isSolid: true,
						isDestructable: false,
						hitBoxCallback: null
					}

				case 1:
					return {
						name: 'Breakable Wall',
						isSolid: true,
						isDestructable: true,
						hitBoxCallback: null
					};

				case 2:
					return {
						name: 'Enemy Spawner',
						isSolid: false,
						isDestructable: false,
						hitBoxCallback: null
					};
			}
		}
		return MapObject_References.defaultParams(id);
	}
}

/**
 * This class stores the functionality of Map Objects.
 */
class MapObject_References
{
	public var doorCallback:Door->Dynamic = function(door:Door)
	{
		trace('Area teleport in the works! doorID: ${door.doorID}');
		return '';
	};

	public var spawnerCallback:MapObject->Dynamic;

	public static var objectIDs:Array<String> = ['wall', 'brokenWall', 'spawner'];

	/**
	 * This returns default params if a given object doesn't have default params.
	 * @param id 
	 * @return ObjectParams
	 */
	public static function defaultParams(id:Int):ObjectParams
	{
		return {
			name: objectIDs[id],
			isSolid: false,
			isDestructable: false,
			hitBoxCallback: null
		};
	}
}
