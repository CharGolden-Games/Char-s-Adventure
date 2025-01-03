package charsadventure.play.components;

class LowHealthCalc
{
	/**
	 * Determines based on maxHealth whether the current health is low.
	 * @param curHealth Current Health
	 * @param maxHealth Max Health
	 * @return Bool
	 */
	public static function isLowHealth(curHealth:Int, maxHealth:Int):Bool
	{
		if (maxHealth < 5)
		{
			if (maxHealth == 1)
				return true;

			return (curHealth / maxHealth <= 0.5);
		}
		if (maxHealth == 5)
		{
			return (curHealth / maxHealth <= 0.4);
		}
		return (curHealth <= 3);
	}
}
