package charsadventure.utils;

import charsadventure.play.ui.shopItems.ShopItem.ShopParams;
import charsadventure.play.ui.DialogueSubState.DialogueFile;
import openfl.Assets;
import tjson.TJSON as Json;

/**
 * Useful file shenanigans.
 */
class FileUtils
{
	/**
	 * Loads a dialogue file from a path
	 * @param path The full path to the file.
	 * @return DialogueFile
	 */
	public static function loadDialogueFile(path:String):DialogueFile
	{
		var rawJson:String = null;
		if (Assets.exists(path))
		{
			rawJson = Assets.getText(path);
		}
		else
		{
			path = Paths.getFallbackPath('data', 'dialogue/null.json');
			rawJson = Assets.getText(path);
		}

		return cast Json.parse(rawJson);
	}

	/**
	 * Loads a shop parameter file from a path
	 * @param path The full path
	 * @return ShopParams
	 */
	public static function loadShopFile(path:String):ShopParams
	{
		var rawJson:String = null;

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
