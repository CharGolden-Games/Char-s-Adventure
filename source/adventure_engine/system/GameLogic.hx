package adventure_engine.system;

class GameLogic
{
	// Keep track of the difference when the game handles it so it gets displayed.
	public static var moneyDifference:Float = 0;

	/**
	 * Calculates the money gained by the enemy.
	 * @param enemyID 
	 * @param chance 
	 * @param min 
	 * @return Float
	 */
	public static function calculate_money(enemyID:Int, chance:Float, min:Float):Float
	{
		var final_total:Float = min;

		moneyDifference = bonusMoney(chance, min);

		final_total += moneyDifference;

		return final_total;
	}

	/**
	 * Determines the extra money you can gain.
	 * @param chance 
	 * @param money 
	 * @return Float
	 */
	public static function bonusMoney(chance:Float, money:Float):Float
	{
		var bonus:Float = 0;

		if (FlxG.random.bool(chance))
		{
			bonus += .25;
			if (FlxG.random.bool(chance))
			{
				bonus += .5;
				if (FlxG.random.bool(chance))
				{
					bonus += 1;
					if (FlxG.random.bool(chance))
					{
						bonus += 1.5;
					}
				}
			}
		}
		else
		{
			bonus += -0.25; // That's right, fuck you LOSE money for being unlucky. lmao get wrecked
		}

		return money * bonus;
	}

	/**
	 * The megaphone has a chance to trigger this effect.
	 * @return String
	 */
	public static function confuseEveryone():String
	{
		/**
		 * for (activeCharacter in BattleHandler.activeCharacters)
		 * {
		 * 		activeCharacter.confusion = true;
		 * }
		 */
		return 'Successfully Confused Everyone!';
	}
}
