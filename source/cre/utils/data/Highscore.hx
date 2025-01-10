package cre.utils.data;

import flixel.util.FlxSave;
import cre.play.PlayState.RatingCounts;
import openfl.Assets;
import tjson.TJSON as Json;
#if sys
import sys.io.File;
#end

/**
 * idk
 */
typedef HighscoreData =
{
	public var totalNotes:Int;
	public var notesHit:Int;
	public var accuracy:Float;
	public var ratingCounts:RatingCounts;
	public var misses:Int;
	public var score:Int;
}

/**
 * idk 2
 */
typedef HighscoreFile =
{
	/**
	 * Among us.. are all the currently saved high scores!
	 */
	public var highscoresList:Array<HighscoreData>;
}

/**
 * Handles functions for saving stuff like score.
 */
class Highscore
{
	/**
	 * The list of highscores for this song.
	 */
	public static var highscoresList:Array<HighscoreData>;

	/**
	 * The tallies of perfects, sicks, goods, etc.
	 */
	public static var tallies:RatingCounts;

	public static var trueRands:Array<Bool> = [];

	/**
	 * Load the scores for this song
	 * @param song The song to load
	 * @return Array<HighscoreData>
	 */
	public function loadScores(song:String):Array<HighscoreData>
	{
		var rawJson:String = null;
		var path:String = Paths.highscoreData(song);
		if (Assets.exists(path))
		{
			rawJson = Assets.getText(path);
		}
		else
		{
			return null;
		}
		var json:HighscoreFile = cast Json.parse(rawJson);
		highscoresList = json.highscoresList;
		return highscoresList;
	}

	/**
	 * Saves a new score
	 * @param song The song to save it for
	 * @param data The actual highscore data to save
	 * @return HighscoreData
	 */
	public function saveScore(song:String, data:HighscoreData):HighscoreData
	{
		var previousScores:Array<HighscoreData> = loadScores(song);
		if (previousScores != null)
		{
			highscoresList.push(data);
		}
		else
		{
			highscoresList = [data];
		}

		var file:HighscoreFile = {
			highscoresList: highscoresList
		};

		#if sys
		File.saveContent(Paths.highscoreData(song), Std.string(file));
		#end

		for (i in 0...100)
		{
			var rand:Bool = FlxG.random.bool(30);
			if (rand)
			{
				// TODO: Make this a validity checker.
				trace('RAND$i IS TRUE!');
				trueRands.push(true);
			}
			else
			{
				trueRands.push(false);
			}
		}

		var gameSave:FlxSave = new FlxSave();
		gameSave.bind(Constants.SAVE_FILE, Constants.SAVE_PATH);
		Reflect.setField(gameSave.data, 'highscoresList-$song', Reflect.field(this, 'highscoresList'));
		gameSave.flush();

		return data;
	}
}
