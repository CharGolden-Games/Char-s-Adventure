package charsadventure.play.ui.shopItems;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

/**
 * Makes a box with an item's description and name over it.
 */
class ItemDescriptionBox extends FlxTypedSpriteGroup<Dynamic>
{
	/**
	 * The current name.
	 */
	public var name:String = '';

	/**
	 * The current description.
	 */
	public var desc:String = '';

	var nameText:FlxText;
	var descText:FlxText;
	var bg:FlxSprite;

	/**
	 * So you can use non static functions and variables statically if needed.
	 */
	public static var instance:ItemDescriptionBox;

	public function new(x:Float = 0, y:Float = 0, name:String, desc:String)
	{
		super(x, y);

		instance = this;

		bg = new FlxSprite().makeGraphic(Std.int(FlxG.width * 0.5), 300, 0xFF000000);
		bg.alpha = 0.6;
		add(bg);

		this.name = name;
		this.desc = name;
		nameText = new FlxText(0, 0, FlxG.width * 0.5, name, 30);
		nameText.setFormat(Paths.font('naname_goma.ttf'), 30, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
		add(nameText);

		descText = new FlxText(0, 50, FlxG.width * 0.5, 16);
		descText.setFormat(Paths.font('naname_goma.ttf'), 16, 0xFFFFFFFF, LEFT, OUTLINE, 0xFF000000);
		add(descText);
	}

	/**
	 * Changes this box's name and description
	 * @param newName The new name
	 * @param newDesc The new description
	 */
	public function setDescText(newName:String, newDesc:String):Void
	{
		name = newName;
		desc = newDesc;
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (nameText.text != name)
		{
			nameText.text = name;
		}
		if (descText.text != desc)
		{
			descText.text = desc;
		}
	}
}
