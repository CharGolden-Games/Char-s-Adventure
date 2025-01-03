package charsadventure.ui.mainmenu.components;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * This class handles making a button for menus.
 */
class MenuButton extends FlxTypedSpriteGroup<Dynamic>
{
	var button:FlxSprite;

	var buttonText:FlxText;

	var image:String;

	/**
	 * The sprite that higlights the button if currently selected.
	 */
	public var selectedOverlay:FlxSprite;

	var callback:Null<String->Void>;

	/**
	 * Changes the current callback
	 * @param newCallback What to do instead.
	 * @return Null<Void->Dynamic>
	 */
	public function change_callback(newCallback:Null<String->Void>):Null<String->Void>
	{
		return callback = newCallback;
	}

	/**
	 * Does the callback with the button's image name.
	 */
	public function do_callback():Void
	{
		callback(image);
	}

	/**
	 * Spawns a new Menu Button with the given params.
	 * @param x 
	 * @param y 
	 * @param image DO NOT USE "Paths.image" IT IS ALREADY USED!
	 * @param text  What the button should say.
	 */
	public function new(x:Float, y:Float, image:String, text:String, onPress:Null<String->Void>)
	{
		super(x, y);

		callback = onPress;
		this.image = image;
		spawnButton(image, text);
	}

	function spawnButton(image:String, text:String):Void
	{
		button = new FlxSprite(0, 0).loadGraphic(Paths.image(image));
		button.setGraphicSize(300, 50);
		button.updateHitbox();

		add(button);

		buttonText = new FlxText(button.width * 0.35, button.height * 0.25, button.width, text, 20);
		buttonText.setFormat(Paths.font('naname_goma.ttf'), 20, 0xFFFFFFFF, null, OUTLINE, 0xFF000000);
		buttonText.visible = (Paths.image(image) == 'assets/images/fallback/null.png');
		add(buttonText);

		selectedOverlay = new FlxSprite().makeGraphic(300, 50, 0xFFFFFFFF);
		selectedOverlay.alpha = 0.6;
		add(selectedOverlay);
		selectedOverlay.visible = false;
	}
}

/**
 * A group specifically for MenuButton instances.
 */
class GrpMenuButton extends FlxTypedGroup<MenuButton>
{
	var index(default, null):Int = 0;

	// So you can use non static functions statically.
	public static var instance:GrpMenuButton;

	public function new()
	{
		instance = this;
		super(0);
	}

	/**
	 * Changes the current index and makes the selected button highlighted by showing its selected overlay.
	 * @param change how much to change it by
	 * @return Int
	 */
	public function change_index(change:Int = 0):Int
	{
		index += change;

		if (index > members.length - 1)
			index = 0;
		if (index < 0)
			index = members.length - 1;

		for (i in 0...members.length)
		{
			if (i == index)
				members[i].selectedOverlay.visible = true;
			else
				members[i].selectedOverlay.visible = false;
		}

		return index;
	}

	/**
	 * Adds a menu button, what do you think it does?
	 * @param x The X position
	 * @param y The Y position
	 * @param image The image to use (points to assets/images/`image`.png)
	 * @param name The label of the button
	 * @param onChange What to do upon clicking this button?
	 */
	public function add_menuButton(x:Float, y:Float, image:String, name:String, onChange:Null<String->Void>):Void
	{
		var button:MenuButton = new MenuButton(x, y, image, name, onChange);
		add(button);
	}

	/**
	 * Does the currently selected button's callback
	 */
	public function do_callback():Void
	{
		members[index].do_callback();
	}
}
