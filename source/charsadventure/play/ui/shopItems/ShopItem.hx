package charsadventure.play.ui.shopItems;

import charsadventure.play.ui.DialogueSubState.DialogueOptions;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import tjson.TJSON as Json;
import openfl.Assets;

typedef ShopParams =
{
	@:optional public var dialogue:Array<ShopDialogue>;
	@:optional public var char:String;
	public var shopRows:Array<Array<ShopItem_Params>>;
}

typedef ShopDialogue =
{
	public var dialogue:String;
	public var id:Int;
	@:optional public var options:DialogueOptions;
	@:optional public var name:String;
	@:optional public var imagePostfix:String;
	@:optional public var itemSpecific:Int;
	@:optional public var isSelectionMessage:Bool;
}

typedef ShopItem_Params =
{
	public var image:String;
	public var name:String;
	public var price:Float;
	public var desc:String;
	@:optional public var quantity:Int;
	@:optional public var id:Int;
}

class ShopItem extends FlxTypedSpriteGroup<Dynamic>
{
	public var item:FlxSprite;
	public var priceText:FlxText;

	public var name:String = 'null';
	public var price:Float = 0;
	public var desc:String = 'Char please add details.';
	public var quantity:Int = 1;

	public function new(x:Float, y:Float, name:String, price:Float, desc:String, image:String, ?quantity:Int)
	{
		super(x, y);

		this.name = name;
		this.price = price;
		this.desc = desc;
		if (quantity != null)
		{
			this.quantity = quantity;
		}
		else
		{
			this.quantity = 1;
			quantity = 1;
		}
		item = new FlxSprite().loadGraphic(Paths.image(image));
		item.antialiasing = !Save.data.lowQuality;
		item.setGraphicSize(80, 80);
		item.updateHitbox();
		add(item);

		priceText = new FlxText(0, 0, 80, 'x$quantity', 20);
		priceText.setFormat(Paths.font('naname_goma.ttf'), 20, 0xFFFFFFFF, RIGHT, OUTLINE, 0xFF000000);
		priceText.y = 80;
		add(priceText);
	}
}

class ShopItemGroup extends FlxTypedSpriteGroup<ShopItem>
{
	public static var instance:ShopItemGroup;

	public var curParams:Array<Array<ShopItem_Params>>;

	public var curDialogue:Null<Array<ShopDialogue>>;
	public var shopParams:ShopParams;

	public function new(x:Float = 0, y:Float = 0, maxSize:Int = 0)
	{
		super(x, y, maxSize);

		instance = this;
		generateShopItems();
	}

	/**
	 * The current selected index.
	 */
	public var index(default, null):Int = 0;

	function set_index(value:Int):Int
	{
		index = value;

		if (index > members.length - 1)
		{
			index = 0;
		}
		if (index < 0)
		{
			index = members.length - 1;
		}
		for (i in 0...members.length)
		{
			if (i == index)
			{
				members[i].color = 0xFFFFFF00;
			}
			if (i != index)
			{
				members[i].color = 0xFFFFFFFF;
			}
		}

		return index;
	}

	/**
	 * Changes the index.
	 * @param change How much to change it by
	 * @return Int
	 */
	public function change_index(change:Int = 0):Int
	{
		return set_index(index + change);
	}

	/**
	 * Generates the array of Shop Items from a file.
	 * @param overridePath What path to look in if not the current area's path. (must be a valid path in assets/data/shop)
	 */
	public function generateShopItems(?overridePath:String):Void
	{
		shopParams = loadShopFile(overridePath);
		curParams = shopParams.shopRows;
		curDialogue = shopParams.dialogue;

		for (i in 0...shopParams.shopRows.length)
		{
			for (iTwo in 0...shopParams.shopRows[i].length)
			{
				var shopItemParams:ShopItem_Params = shopParams.shopRows[i][iTwo];

				var shopItem:ShopItem = new ShopItem(100 * iTwo, 130 * i, shopItemParams.name, shopItemParams.price, shopItemParams.desc,
					shopItemParams.image, shopItemParams.quantity);
				add(shopItem);
			}
		}
	}

	/**
	 * Loads a shop file from the current areas shop.json unless overridePath is given
	 * @param overridePath A different shop file to load (in assets/data/shop).
	 * @return ShopParams
	 */
	public function loadShopFile(?overridePath:String):ShopParams
	{
		var rawJson:String = null;
		var path:String = 'assets/data/shop/${PlayState.instance.currentArea}.json';
		trace(path);
		if (overridePath != null)
		{
			path = 'assets/data/shop/$overridePath.json';
		}

		if (Paths.fileExists(path))
		{
			rawJson = Assets.getText(path);
		}
		else
		{
			return null;
		}

		return cast Json.parse(rawJson);
	}
}
