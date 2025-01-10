package cre.utils;

/**
 * Contains functions meant to make retrieving file paths easier.
 */
class Paths
{
	/**
	 * Change this if you want to use a different folder for this module
	 */
	public static var module_AssetPath:String = 'assets/cre';

	/**
	 * The current target's sound file extension
	 */
	public static final soundExtension:String = #if desktop 'ogg' #else 'mp3' #end;

	/**
	 * Returns `'$module_AssetPath/data/$key'`.
	 * @param key The file to look for.
	 * @return String
	 */
	public static function data(key:String):String
	{
		return '$module_AssetPath/data/$key';
	}

	/**
	 * Returns the path to a song's highscore data.
	 * @param song The song to look for.
	 * @return String
	 */
	public static function highscoreData(song:String):String
	{
		return data('highscores/$song.json');
	}

	/**
	 * Returns `'$module_AssetPath/images/$key.png'`.
	 * @param key The file to look for.
	 * @return String
	 */
	public static function image(key:String):String
	{
		return '$module_AssetPath/images/$key.png';
	}
}
