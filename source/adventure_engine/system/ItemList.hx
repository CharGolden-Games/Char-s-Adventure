package adventure_engine.system;

private typedef Item =
{
	/**
	 * Used for looking up item properties and images.
	 */
	public var internalName:String;

	/**
	 * Used in the inventory.
	 */
	public var commonName:String;

	/**
	 * The only time a Property is included with the lookup
	 *
	 * Determines whether Char will be able to consume an Item.
	 *
	 * OVERRIDES ALL OTHER USE CHECKS. (I.E this flag is set but (allowedCharacters.all == true), it will still act as if (char == false))
	 */
	@:optional public var charAversion:Bool;

	/**
	 * If you want an item to be extra hardcoded for some reason.
	 */
	@:optional public var itemProperties:ItemProperties;
}

typedef AllowedCharacters =
{
	@:optional public var all:Bool;
	@:optional public var char:Bool;
	@:optional public var trevor:Bool;
	@:optional public var plexi:Bool;
}

private typedef Equippable =
{
	/**
	 * Non-Weapons:
	 * [0] Alt-Hand, [1] Head, [2] Body, [3] Legs, [4] Cape
	 * 
	 * Weapons:
	 * [5] Main Hand, [0] Alt Hand, [6] (Plexi Only) Internal
	 */
	public var slot:Int;

	public var startDurability:Float;
	public var defense:Float;
	public var speed:Int;
	public var hp:Int;
}

typedef ItemProperties =
{
	/**
	 * Whether you can throw it at enemies
	 */
	public var isThrowable:Bool;

	/**
	 * How many uses an item has before it goes bye-bye!
	 * 
	 * -1 = Infinite
	 */
	public var uses:Int;

	/**
	 * Whether an item can't be destroyed/dropped.
	 */
	@:optional public var specialItem:Bool;

	/**
	 * What characters can use/equip the item.
	 */
	public var allowedCharacters:AllowedCharacters;

	@:optional public var equipProperties:Equippable;

	/**
	 * How much it deals to enemies when thrown
	 */
	@:optional public var throwDmg:Float;

	/**
	 * How much a normal attack does. (Stacked with base damage stat)
	 */
	public var dmg:Float;

	@:optional public var hp:Int;
}

class ItemList
{
	private static final itemList:Array<Item> = [
		{
			internalName: 'c_mic',
			commonName: "Char's Microphone"
		},
		{
			internalName: 'mic',
			commonName: "Microphone"
		},
		{
			internalName: 'p_ram',
			commonName: "Plexi Item" // Still haven't decided.
		},
		{
			internalName: 't_trident',
			commonName: "Trevor's Royal Guard Trident"
		},
		{
			internalName: 'trident',
			commonName: "Trident"
		},
		{
			internalName: 'rg_trident',
			commonName: "Royal Guard Trident" // The fancy variant!
		},
		{
			internalName: 'h_smoothie',
			commonName: "Healthy Veggie Smoothie",
			charAversion: true
		},
		{
			internalName: 'p_smoothie',
			commonName: "Power Berry Smoothie"
		},
		{
			internalName: 'd_vMilkshake',
			commonName: "Defensive Vanilla Milkshake"
		},
		{
			internalName: 'nsh_bSmoothie',
			commonName: "Not-So-Healthy Banana Smoothie" // This shit jam packed with sugar actually.
		},
		{
			internalName: 'confuseEveryone', // heh.
			commonName: "Extra Annoying Megaphone",
			itemProperties: {
				isThrowable: true,
				uses: 1,
				allowedCharacters: {
					all: true
				},
				throwDmg: 5,
				dmg: 0.1 // Pitiful lmao.
			}
		},
		{
			internalName: 'megaphone',
			commonName: "Megaphone"
		}
	];

	public static function getItem(ID:Int):Item
	{
		// TODO: Make a class that returns ItemProperties, then make this function use that.
		return itemList[ID];
	}

	public static function getProperties(item:Item):ItemProperties
	{
		return ItemPropertiesClass.itemToProperties[item.internalName];
	}

	public static function charAversion_check(ID:Int):Bool
	{
		try
		{
			var item:Item = itemList[ID];
			var charAversion:Bool = false;

			if (item.charAversion != null)
			{
				charAversion = item.charAversion;
			}

			return charAversion;
		}
		catch (e:Dynamic)
		{
			trace('Oop that check had an error! "$e"');
			return false; // If it errors out, assume false!
		}
	}

	/**
	 * Theoretically you can make a item unuseable by ANY character with this lmao.
	 */
	public static function allowedCharacterCheck(ID:Int, char:String):Bool
	{
		if (charAversion_check(ID) && char.toLowerCase().trim() == 'char')
			return false;

		try
		{
			var item:AllowedCharacters = itemList[ID].itemProperties.allowedCharacters;

			if (item.all != null)
			{
				return item.all;
			}

			switch (char.toLowerCase().trim())
			{
				case 'char':
					if (item.char != null)
					{
						return item.char;
					}
					return false;

				case 'plexi':
					if (item.plexi != null)
					{
						return item.plexi;
					}
					return false;

				case 'trevor':
					if (item.trevor != null)
					{
						return item.trevor;
					}
					return false;

				default:
					return false;
			}
		}
		catch (e:Dynamic)
		{
			trace('Oop that check had an error! "$e"');
			return false; // If it errors out, assume false!
		}
	}
}
