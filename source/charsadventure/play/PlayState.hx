package charsadventure.play;

import charsadventure.graphics.CABaseSprite;
import shared.utils.Save.GameProgress;
import charsadventure.play.components.LowHealthCalc;
import charsadventure.play.components.InputHandler;
import charsadventure.play.character.BaseCharacter;
import charsadventure.play.components.HealthBar;
import charsadventure.play.components.HealthIcon;
import charsadventure.play.character.BaseNPC.NPCGroup;

/**
 * PlayState moment
 */
class PlayState extends BaseState
{
	/**
	 * Basically a way to let you access non static functions and variables statically.
	 */
	public static var instance:PlayState;

	/**
	 * This represents the seconds you have to live!
	 */
	public var curHealth:Int = 3;

	/**
	 * This represents the max seconds you have to live!
	 */
	public var maxHealth:Int = 3;

	var healthPercent:Float = 1;
	var healthbar:HealthBar;
	var player:BaseCharacter;
	var grpNPCs:NPCGroup;
	var inputHandler:InputHandler;
	var debugInputs:DebugInputHandler;

	/**
	 * yuh.
	 */
	public var inSubstate:Bool = false;

	/**
	 * yuh.
	 */
	public var isOverworld:Bool = true;

	/**
	 * yuh.
	 */
	public var lastNPCTalkedTo:String = 'testNpc-1';

	/**
	 * MONEY!
	 */
	public var money:Float = 50;

	/**
	 * MONEY!
	 */
	public var moneyType:String = 'Dollars';

	/**
	 * Used specifically for the pause screen to determine the current description and credits.
	 */
	public var currentArea:String = 'testmap-1';

	var moneyText:FlxText;

	override function create():Void
	{
		maxHealth++;
		instance = this;
		super.create();

		inputHandler = InputHandler.initialize_inputHandler();
		debugInputs = DebugInputHandler.initialize_inputHandler(instance);

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBG/char_SettingsBG_Desat'));
		bg.color = 0xFF880055;
		bg.scrollFactor.set(0.3, 0.3);
		bg.setGraphicSize(bg.width * 5);
		bg.updateHitbox();
		bg.antialiasing = !lowQuality;
		add(bg);

		healthbar = new HealthBar(-225, 0, Paths.image('healthbar_assets/healthBarFront'), Paths.image('healthbar_assets/iconBacker'), 'char', curHealth,
			maxHealth, function() return curHealth, function() return maxHealth, true);
		healthbar.iconBacker.color = 0xFFFF5500;
		healthbar.iconFront.color = 0xFFFF8500;
		add(healthbar);
		healthbar.cameras = [camHUD];
		healthbar.y = FlxG.height - 100;

		grpNPCs = new NPCGroup();
		add(grpNPCs);

		player = new BaseCharacter(0, 0, 'char');
		player.inputHandler = inputHandler.handle_Inputs;
		bg.screenCenter();
		add(player);
		camGame.setFollow(player, LOCKON, 0.04, true);
		camGame.setZoom(0.5, true);
		persistentDraw = true;

		playMusic(Paths.music('bgm/dungeon'), volume);

		moneyText = new FlxText(0, 0, FlxG.width, '$moneyType: $money', 20);
		moneyText.setFormat(Paths.font('naname_goma.ttf'), 20, 0xFFFFFFFF, RIGHT, OUTLINE, 0xFF000000);
		moneyText.y = -(moneyText.height * 2);
		add(moneyText);
		moneyText.cameras = [camHUD];

		// SHOW ME THE MONEY
		show_money();

		grpNPCs.addNPC(100, 300, 'smith-tridite');

		var testSprite:CABaseSprite = new CABaseSprite(0, 0).create('0xFF00FF', 100, 100);
		add(testSprite);
		testSprite.updateFunction = function(elapsed:Float)
		{
			testSprite.x += 1;
			testSprite.y += 0.1;
		}
	}

	override function createPost():Void
	{
		super.createPost();
		maxHealth += -1;

		camHUD.tweenAlpha(0.5, 0.05);
	}

	var mainMult:Float = 1;

	function checkMoney():Float
	{
		var curSave:GameProgress = Save.saves[MainMenuState.curSave];
		if (isOverworld)
		{
			return curSave.dollars;
		}
		return curSave.gold;
	}

	/**
	 * Adds `add` to the current dollars count.
	 * @param add the amount to add
	 * @return Null<Float>
	 */
	public function addDollars(add:Float = 0):Null<Float>
	{
		var curSave:Int = MainMenuState.curSave;
		switch (curSave)
		{
			case 1:
				Save.save1.dollars += Save.save1.dollars + add;
				Save.save_Save();
				return Save.save1.dollars;

			case 2:
				Save.save2.dollars += Save.save2.dollars + add;
				Save.save_Save();
				return Save.save2.dollars;

			default:
				Save.save0.dollars = Save.save0.dollars + add;
				Save.save_Save();
				return Save.save0.dollars;
		}
	}

	/**
	 * adds `add` to the current gold amount
	 * @param add the amount to add
	 * @return Int
	 */
	public function addGold(add:Int):Int
	{
		var curSave:Int = MainMenuState.curSave;
		switch (curSave)
		{
			case 0:
				Save.save0.gold = Save.save0.gold + add;
				Save.save_Save();
				return Save.save0.gold;

			case 1:
				Save.save1.gold = Save.save1.gold + add;
				Save.save_Save();
				return Save.save1.gold;

			case 2:
				Save.save2.gold = Save.save2.gold + add;
				Save.save_Save();
				return Save.save2.gold;
		}

		Save.save0.gold = Save.save0.gold + add;
		Save.save_Save();
		return Save.save0.gold;
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (!isOverworld && moneyType == 'Dollars')
		{
			moneyType = 'Gold';
		}
		else if (isOverworld && moneyType == 'Gold')
		{
			moneyType = 'Dollars';
		}

		money = checkMoney();

		if (curHealth <= 0)
		{
			FlxG.resetState();
		}

		if (curHealth > maxHealth)
		{
			curHealth = maxHealth;
		}

		if (controls.pause_p)
		{
			openSubState(new PauseSubState());
		}

		do_iconBop(elapsed);

		healthPercent = curHealth / maxHealth;

		if (LowHealthCalc.isLowHealth(curHealth, maxHealth))
		{
			mainMult = 2;
		}
		else
		{
			mainMult = 1;
		}

		if (frameTick % (Main.game.framerate * 0.5) == 0)
		{
			updateOnHalfSeconds();
		}

		moneyText.text = '$moneyType: ${CoolUtil.instance.formatDollars(money)}';
		debugInputs.handle_DebugInputs();
	}

	var showTimer:FlxTimer;
	var showTween:FlxTween;

	/**
	 * Shows the money, then hides it after 3 seconds.
	 */
	public function show_money():Void
	{
		if (!inSubstate)
		{
			moneyText.alignment = RIGHT;
			if (showTimer != null)
			{
				showTimer.cancel();
			}
			if (showTween != null)
			{
				showTween.cancel();
			}

			showTween = FlxTween.tween(moneyText, {y: 0}, 0.7, {ease: FlxEase.quartIn});
			showTimer = new FlxTimer().start(3, function(tmr:FlxTimer)
			{
				showTween = FlxTween.tween(moneyText, {y: -(moneyText.height * 2)}, 3, {ease: FlxEase.quartOut});
			});
		}
	}

	/**
	 * Shows the money, but does NOT hide it again.
	 */
	public function show_moneyShop():Void
	{
		persistentUpdate = true;
		camHUD.tweenAlpha(1);
		openSubState(new ShopSubstate());
		if (showTimer != null)
		{
			showTimer.cancel();
		}
		if (showTween != null)
		{
			showTween.cancel();
		}

		moneyText.alignment = LEFT;
		showTween = FlxTween.tween(moneyText, {y: 0}, 0.2, {ease: FlxEase.quartIn});
	}

	/**
	 * Closes the shop. What did you think it did?
	 */
	public function close_shop():Void
	{
		camHUD.tweenAlpha(0.5, 0.1);
		showTween = FlxTween.tween(moneyText, {y: -(moneyText.height * 2)}, 3, {
			ease: FlxEase.quartOut,
			onComplete: function(twn:FlxTween)
			{
				moneyText.alignment = RIGHT;
			}
		});
	}

	override function openSubState(subState:FlxSubState):Void
	{
		super.openSubState(subState);

		inputHandler.lock = true;
	}

	override function closeSubState():Void
	{
		super.closeSubState();

		persistentUpdate = false;
		inputHandler.lock = false;
	}

	#if (flixel < "5.3.0")
	override function switchTo(nextState:FlxState):Bool
	{
		instance = null;
		return super.switchTo(nextState);
	}
	#else
	override function startOutro(onOutroComplete:() -> Void):Void
	{
		instance = null;
		super.startOutro(onOutroComplete);
	}
	#end

	function updateOnHalfSeconds():Void
	{
		if (LowHealthCalc.isLowHealth(curHealth, maxHealth))
		{
			healthbar.icon.scale.set(0.7, 0.7);
			healthbar.icon.updateHitbox();
		}
	}

	override function updateOnSeconds(elapsed:Float):Void
	{
		super.updateOnSeconds(elapsed);

		if (!LowHealthCalc.isLowHealth(curHealth, maxHealth))
		{
			healthbar.icon.scale.set(0.8, 0.8);
			healthbar.icon.updateHitbox();
		}
	}

	function do_iconBop(elapsed:Float):Void
	{
		var icon:HealthIcon = healthbar.icon;
		var mult:Float = FlxMath.lerp(0.5, icon.scale.x, Math.exp(-elapsed * 9 * mainMult));
		icon.scale.set(mult, mult);
		icon.updateHitbox();
	}
}
