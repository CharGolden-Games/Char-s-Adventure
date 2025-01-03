package charsadventure.play.components;

import charsadventure.play.ui.DialogueSubState;
import charsadventure.play.character.BaseCharacter;

/**
 *  Handles inputs for the `BaseCharacter` class.
 */
class InputHandler extends Controls
{
	var delayTimer:FlxTimer;

	public var lock:Bool;

	public static var instance:InputHandler;

	public static function initialize_inputHandler():InputHandler
	{
		trace('Initializng Input Handler!');
		instance = new InputHandler();
		return instance;
	}

	public function handle_Inputs(char:BaseCharacter):Void
	{
		if (!lock)
		{
			if (delayTimer == null)
			{
				doMove(char);
			}
			inputCheck2(char);
		}
		// PlayState.callOnScripts('handleInputs', [char]);
	}

	function inputCheck2(char:BaseCharacter):Void
	{
		if (attack_p)
		{
			char.playAnim('attack');
			char.flipX = (char.curDirection == 1);
		}
		if (jump_p)
		{
			char.playAnim('jump');
			char.flipX = (char.curDirection == 1);
		}
		if (char.animation.curAnim.finished)
		{
			char.playAnim(determineIdleAnim(char));
			char.flipX = false;
		}
	}

	function determineWalkAnim(char:BaseCharacter):String
	{
		if (char.curDirection == 0)
		{
			return 'walk_left';
		}
		return 'walk_right';
	}

	function determineIdleAnim(char:BaseCharacter):String
	{
		if (char.curDirection == 0)
		{
			return 'idle';
		}
		return 'idle_right';
	}

	function doMove(char:BaseCharacter):Void
	{
		var release:Bool = (move_left_r || move_right_r || move_up_r || move_down_r);
		if (release)
		{
			char.flipX = false;
			char.playAnim(determineIdleAnim(char));
		}
		if (move_left)
		{
			char.curDirection = 0;
			delayTimer = new FlxTimer();
			char.x += -15;
			char.playAnim('walk_left');
			delayTimer.start(0.01, function(tmr:FlxTimer)
			{
				delayTimer = null;
			});
		}
		if (move_right)
		{
			char.curDirection = 1;
			delayTimer = new FlxTimer();
			char.x += 15;
			char.playAnim('walk_right');
			delayTimer.start(0.01, function(tmr:FlxTimer)
			{
				delayTimer = null;
			});
		}
		if (move_up)
		{
			delayTimer = new FlxTimer();
			char.y += -15;
			char.playAnim(determineWalkAnim(char));
			delayTimer.start(0.01, function(tmr:FlxTimer)
			{
				delayTimer = null;
			});
		}
		if (move_down)
		{
			delayTimer = new FlxTimer();
			char.y += 15;
			char.playAnim(determineWalkAnim(char));
			delayTimer.start(0.01, function(tmr:FlxTimer)
			{
				delayTimer = null;
			});
		}
		if (FlxG.keys.pressed.F1)
		{
			PlayState.instance.camGame.zoom += 0.1;
		}
		if (FlxG.keys.pressed.F2)
		{
			PlayState.instance.camGame.zoom -= 0.1;
		}
	}
}

class DebugInputHandler extends Controls
{
	public var lock:Bool = false;

	public static var instance:DebugInputHandler;

	public static var playStateInstance:PlayState;

	public static function initialize_inputHandler(?playState:PlayState):DebugInputHandler
	{
		trace('Initializng Input Handler!');
		playStateInstance = playState;
		if (playStateInstance == null)
			playStateInstance = new PlayState();
		instance = new DebugInputHandler();
		return instance;
	}

	public function handle_DebugInputs():Void
	{
		if (Main.isDebug)
		{
			if (FlxG.keys.justPressed.END)
			{
				playStateInstance.curHealth += -1;
				playStateInstance.print(playStateInstance.curHealth);
			}
			if (FlxG.keys.justPressed.DELETE)
			{
				playStateInstance.curHealth++;
				playStateInstance.print(playStateInstance.curHealth);
			}
			if (FlxG.keys.justPressed.HOME)
			{
				trace('TESTING SHOPUI');
				playStateInstance.show_moneyShop();
			}
			if (FlxG.keys.justPressed.P)
			{
				playStateInstance.maxHealth++;
				playStateInstance.curHealth = playStateInstance.maxHealth;
			}
			if (FlxG.keys.justPressed.M)
			{
				playStateInstance.maxHealth--;
			}
			if (FlxG.keys.justPressed.NUMPADPLUS)
			{
				playStateInstance.addDollars(10.5);
				playStateInstance.addGold(10);
				playStateInstance.show_money();
			}
			if (FlxG.keys.justPressed.NUMPADMINUS)
			{
				playStateInstance.addDollars(-10.5);
				playStateInstance.addGold(-10);
				playStateInstance.show_money();
			}
			if (FlxG.keys.justPressed.NUMPADMULTIPLY)
			{
				if (playStateInstance.moneyType == 'Dollars')
				{
					playStateInstance.isOverworld = false;
				}
				if (playStateInstance.moneyType == 'Gold')
				{
					playStateInstance.isOverworld = true;
				}
			}
			if (FlxG.keys.justPressed.B)
			{
				playStateInstance.print('TESTING DIALOGUE SYSTEM');
				playStateInstance.openSubState(new DialogueSubState(FileUtils.loadDialogueFile(Paths.data('dialogue/charsadventure_IntroNEW.json'))));
			}
			/*if (FlxG.keys.justPressed.Y)
				{
					playStateInstance.print('Spawning several enemies!');
					for (i in 0...20)
					{
						var enemy:Enemy = new Enemy(playStateInstance.getAllowedEnemyLocations().x, playStateInstance.getAllowedEnemyLocations().y, RandUtils.getRandEnemyID());
						playStateInstance.add(enemy);
					}
			}*/
		}
	}
}
