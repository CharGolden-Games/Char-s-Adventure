package charsadventure.play.components;

import flixel.ui.FlxBar;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class HealthBar extends FlxTypedSpriteGroup<Dynamic>
{
	// TODO: Make a way to not auto assume getting more max health refills your health.
	public var zIndex:Int = 0;
	public var bar:FlxBar;
	public var bg:FlxSprite;
	public var iconBacker:FlxSprite;
	public var iconFront:FlxSprite;
	public var icon:HealthIcon;
	public var healthText:FlxText;
	public var stamina:FlxText;
	public var value:Float = 0;
	public var curHealth:Int = 0;
	public var maxHealth:Int = 5;
	public var curStamina:Float = 20;

	public static var instance:HealthBar;

	var healthFunction_curHealth:Null<Void->Int>;
	var healthFunction_maxHealth:Null<Void->Int>;

	public var grpHealth:HealthTickGroup;

	final numbers:Array<String> = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

	public function new(x:Float, y:Float, healthbarImage:String = 'assets/images/healthbar_assets/healthBarFront.png', iconBackerImage:String = '0xFF000000',
			iconImage:String = 'char', defaultHealth:Int = 5, maxHealth:Int = 5, healthFunctionCurHealth:Null<Void->Int>,
			healthFunctionMaxHealth:Null<Void->Int>, resizeHealthbar:Bool = false)
	{
		super(x, y);

		curHealth = defaultHealth;
		this.maxHealth = maxHealth;
		healthFunction_curHealth = healthFunctionCurHealth;
		healthFunction_maxHealth = healthFunctionMaxHealth;

		iconBacker = new FlxSprite();
		if (iconBackerImage.startsWith('0x') || iconBackerImage.startsWith('#') || numbers.contains(iconBackerImage.charAt(0)))
		{
			if (!iconBackerImage.startsWith('0x') && !iconBackerImage.startsWith('#'))
				iconBackerImage = '#' + iconBackerImage;
			iconBacker.makeGraphic(200, 200, FlxColor.fromString(iconBackerImage));
		}
		else
		{
			iconBacker.loadGraphic(iconBackerImage);
		}
		icon = new HealthIcon(iconImage);
		iconFront = new FlxSprite().loadGraphic(Paths.image('healthbar_assets/IconFront'));

		iconBacker.y = -iconBacker.height;
		icon.y = iconBacker.y + 25;
		icon.x = 25;

		healthText = new FlxText(0, 0, 0, 'HP: $curHealth', 14);
		healthText.setFormat(Paths.font('naname_goma.ttf'), 14, 0xFFFFFFFF, null, OUTLINE, 0xFF000000);

		stamina = new FlxText(0, 0, 0, 'STAMINA: 0', 14);
		stamina.setFormat(Paths.font('naname_goma.ttf'), 14, 0xFFFFFFFF, null, OUTLINE, 0xFF000000);

		add(iconBacker);
		add(icon);
		add(iconFront);
		add(healthText);
		add(stamina);
		instance = this;
		if (resizeHealthbar)
			this.resizeHealthbar();

		var healthColorArray:Array<FlxColor> = [];
		for (i in 0...maxHealth)
		{
			if (i < curHealth)
				healthColorArray.push(0xFF00AA00);
			else
				healthColorArray.push(0xFF000000);
		}
		grpHealth = new HealthTickGroup(0, 0, maxHealth, maxHealth, healthColorArray);
		add(grpHealth);
		grpHealth.x = 0;
		grpHealth.y = 64;
		trace(grpHealth.length);
	}

	/**
	 * Changes the color of the bar
	 * @param empty What the color of the empty portion is
	 * @param filled What the color of the filled portion is
	 */
	public function changeColors(empty:FlxColor, filled:FlxColor):Void
	{
		// TODO: Finish making a group for health ticks.
	}

	public var blockAnimChange:Bool = false;

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (!(Main.isDebug || Main.forceDebug))
			healthText.visible = false;
		if (healthFunction_curHealth != null)
		{
			var oldHealth = curHealth;
			curHealth = healthFunction_curHealth();
			if (curHealth != oldHealth)
			{
				for (i in 0...maxHealth)
				{
					if (i < curHealth)
						grpHealth.members[i].color = 0xFF00AA00;
					else
						grpHealth.members[i].color = 0xFF000000;
				}
			}
		}
		if (healthFunction_maxHealth != null)
		{
			var oldMaxHealth = maxHealth;
			maxHealth = healthFunction_maxHealth();
			if (maxHealth != oldMaxHealth)
			{
				grpHealth.change_maxSize(maxHealth);
			}
		}
		if (!blockAnimChange)
		{
			if (isLowHealth())
			{
				icon.animation.curAnim.curFrame = 1;
				icon.color = 0xFFFFCC00;
			}
			else
			{
				icon.animation.curAnim.curFrame = 0;
				icon.color = 0xFFFFFFFF;
			}
		}
		value = curHealth / maxHealth;
		// To prevent flickering in the hud.
		var dh = Math.min(curHealth, maxHealth);
		healthText.text = 'HP: $dh';
		stamina.text = 'STAMINA: $curStamina';
	}

	function updateBar():Void
	{
		iconFront.setGraphicSize(iconBacker.width, iconBacker.height);
		iconFront.updateHitbox();
		icon.y = -(icon.height - 17);
		icon.x = -25;
		iconFront.y = icon.y - 25;
		iconFront.x = -50;
		iconBacker.y = icon.y - 25;
		iconBacker.x = -50;
		healthText.x = 25;
		healthText.y = icon.y + 25;
		stamina.x = 25;
		stamina.y = healthText.y + 25;
		updateHitbox();
	}

	/**
	 * Halves the size of the healthbar.
	 */
	public function resizeHealthbar():Void
	{
		iconBacker.setGraphicSize(iconBacker.width * 0.5);
		iconBacker.updateHitbox();
		icon.setGraphicSize(icon.width * 0.5);
		icon.updateHitbox();
		updateBar();
	}

	function isLowHealth():Bool
	{
		return LowHealthCalc.isLowHealth(curHealth, maxHealth);
	}
}

class HealthTickGroup extends FlxTypedSpriteGroup<FlxSprite>
{
	public function new(x:Float, y:Float, maxSize:Int, numOfTicks:Int = 1, startingColors:Array<Null<FlxColor>>)
	{
		super(x, y, maxSize);

		if (startingColors.length < numOfTicks)
		{
			for (i in startingColors.length...(numOfTicks - startingColors.length))
			{
				startingColors.push(null);
			}
		}

		for (i in 0...numOfTicks)
		{
			add_healthTick(startingColors[i]);
		}

		var pos = -1;
		for (tick in members)
		{
			pos++;
			tick.x = 69 /**Heh. nice.**/ * pos;
		}
	}

	/**
	 * Adds a new health tick to `this` and updates the hitbox.
	 * @param startingColor The color it should start as.
	 */
	public function add_healthTick(?startingColor:Null<FlxColor>):Void
	{
		var tick:FlxSprite = new FlxSprite().loadGraphic(Paths.image('healthbar_assets/healthTick'));
		tick.x = 69 /**Heh. nice.**/ * members.length;
		if (startingColor != null)
		{
			tick.color = startingColor;
		}
		else
		{
			tick.color = 0xFF000000;
		}
		add(tick);
	}

	/**
	 * self explanatory
	 * 
	 * Assumes you've fully recovered your health
	 * @param newSize yuh
	 */
	public function change_maxSize(newSize:Int = 0):Void
	{
		var oldMaxSize = maxSize;

		maxSize = newSize;

		if (maxSize > oldMaxSize)
		{
			add_healthTick();
			for (i in 0...members.length)
				members[i].color = 0xFF00AA00;
		}

		var pos = -1;
		for (tick in members)
		{
			pos++;
			tick.x = 69 /**Heh. nice.**/ * pos;
		}
	}
}
