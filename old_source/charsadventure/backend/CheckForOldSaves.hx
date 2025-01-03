package charsadventure.backend;

import flixel.util.FlxSave;
import shared.backend.Save.GameProgress;
import shared.backend.Save.SaveVariables;

class CheckForOldSaves
{
	static var oldData:SaveVariables;
	static var oldSave0:GameProgress;
	static var oldSave1:GameProgress;
	static var oldSave2:GameProgress;
	static var VSCharSave:FlxSave = new FlxSave(); // for easter egg purposes :3.

	public static function checkSaves():Array<Int> // Leaving this in, in case i decide to use it later.
	{
		var finalArray:Array<Int> = [];
		#if SHOW_TESTINGSAVES
		var saveFileOld0:FlxSave = new FlxSave();
		saveFileOld0.bind(Constants.SAVE_FILE0, Constants.SAVE_PATH);
		var saveFileOld2:FlxSave = new FlxSave();
		saveFileOld2.bind(Constants.SAVE_FILE1, Constants.SAVE_PATH);
		var saveFileOld1:FlxSave = new FlxSave();
		saveFileOld1.bind(Constants.SAVE_FILE1, Constants.SAVE_PATH);
		var oldPrefs:FlxSave = new FlxSave();
		oldPrefs.bind(Constants.SAVE_PREFS, Constants.SAVE_PATH);

		oldSave0Exists = saveFileOld0.status != EMPTY;
		oldSave1Exists = saveFileOld1.status != EMPTY;
		oldSave2Exists = saveFileOld2.status != EMPTY;
		oldPrefsExists = oldPrefs.status != EMPTY;

		if (oldSave0Exists)
			finalArray.push(0);
		if (oldSave1Exists)
			finalArray.push(1);
		if (oldSave2Exists)
			finalArray.push(2);
		if (oldPrefsExists)
			finalArray.push(3);
		#end
		return finalArray;
	}

	public static function check_playedVSChar()
	{
		if (Save.data == null)
		{
			Save.loadPrefs();
		}
		if (!Save.data.hasPlayedVSChar)
		{ // Only do if false, so rewards dont disappear yknow.
			var hasPlayed:Bool = false;
			if (!hasPlayed)
			{
				for (path in Constants.VSCHAR_SAVEPATHS)
				{
					switch (path)
					{
						case 'char/SchoolShowdown/ninjamuffin99':
							VSCharSave.bind('funkin', path);
							Save.data.hasPlayedVSChar = VSCharSave.status != EMPTY;
							hasPlayed = VSCharSave.status != EMPTY;
						case 'CharGCheese/Char/':
							VSCharSave.bind('funkin_vschar_revitalized', path);
							Save.data.hasPlayedVSChar = VSCharSave.status != EMPTY;
							hasPlayed = VSCharSave.status != EMPTY;
						case 'CharGolden/VSCharlol/':
							VSCharSave.bind('funkin', path);
							Save.data.hasPlayedVSChar = VSCharSave.status != EMPTY;
							hasPlayed = VSCharSave.status != EMPTY;
						case 'CharGolden/VS-Char-REVITALIZED/' | 'CharGolden/VS-Char-REVITALIZED/Psych1_0_PreRelease_move/':
							VSCharSave.bind('VS-Char-Revitalized', path);
							Save.data.hasPlayedVSChar = VSCharSave.status != EMPTY;
							hasPlayed = VSCharSave.status != EMPTY;
					}
				}
			}
			if (hasPlayed)
				Save.savePrefs();
		}
	}

	public static function importSave(save:Int):Bool
	{
		#if SHOW_TESTINGSAVES
		switch (save)
		{
			case 0:
				var saveFileOld0:FlxSave = new FlxSave();
				saveFileOld0.bind(Constants.SAVE_FILE0, Constants.SAVE_PATH);

				oldSave0Exists = saveFileOld0.status != EMPTY;

				if (oldSave0Exists)
				{
					if (Save.save0 == null)
						Save.save0 = new GameProgress();
					if (oldSave0 == null)
						oldSave0 = new GameProgress();

					for (key in Reflect.fields(oldSave0))
					{
						if (Reflect.hasField(saveFileOld0.data, key))
						{
							trace('loaded variable: $key from old save0!');
							try
							{
								Reflect.setField(oldSave0, key, Reflect.field(saveFileOld0.data, key));
							}
							catch (e:Any)
							{
								trace('Error loading! $e');
							}
						}
					}
					return true;
				}
				if (!oldSave0Exists)
				{
					trace('Old Save 0 doesn\'t exist!');
				}
			case 1:
				var saveFileOld1:FlxSave = new FlxSave();
				saveFileOld1.bind(Constants.SAVE_FILE1, Constants.SAVE_PATH);

				oldSave1Exists = saveFileOld1.status != EMPTY;

				if (oldSave1Exists)
				{
					if (Save.save1 == null)
						Save.save1 = new GameProgress();
					if (oldSave1 == null)
						oldSave1 = new GameProgress();

					for (key in Reflect.fields(oldSave1))
					{
						if (Reflect.hasField(Save.save1, key))
						{
							trace('loaded variable: $key from old save1!');
							try
							{
								trace('setting $key for save1');
								Reflect.setField(oldSave1, key, Reflect.field(saveFileOld1.data, key));
							}
							catch (e:Any)
							{
								trace('Error loading! $e');
							}
						}
					}
					return true;
				}
				if (!oldSave1Exists)
				{
					trace('Old Save 1 doesn\'t exist!');
				}
			case 2:
				var saveFileOld2:FlxSave = new FlxSave();
				saveFileOld2.bind(Constants.SAVE_FILE2, Constants.SAVE_PATH);

				oldSave2Exists = saveFileOld2.status != EMPTY;

				if (oldSave2Exists)
				{
					if (Save.save2 == null)
						Save.save2 = new GameProgress();
					if (oldSave2 == null)
						oldSave2 = new GameProgress();

					for (key in Reflect.fields(oldSave2))
					{
						if (Reflect.hasField(saveFileOld2.data, key))
						{
							trace('loaded variable: $key from old save2!');
							try
							{
								Reflect.setField(oldSave2, key, Reflect.field(saveFileOld2.data, key));
							}
							catch (e:Any)
							{
								trace('Error loading! $e');
							}
						}
					}
					return true;
				}
				if (!oldSave2Exists)
				{
					trace('Old Save 2 doesn\'t exist!');
				}
			case 3:
				var oldPrefs:FlxSave = new FlxSave();
				oldPrefs.bind(Constants.SAVE_PREFS, Constants.SAVE_PATH);

				oldPrefsExists = oldPrefs.status != EMPTY;

				if (oldPrefsExists)
				{
					if (Save.data == null)
						Save.data = new SaveVariables();
					if (oldData == null)
						oldData = new SaveVariables();

					for (key in Reflect.fields(oldData))
					{
						if (Reflect.hasField(oldPrefs.data, key))
						{
							trace('loaded variable: $key from oldPrefs!');
							try
							{
								Reflect.setField(oldData, key, Reflect.field(oldPrefs.data, key));
							}
							catch (e:Any)
							{
								trace('Error loading! $e');
							}
						}
					}
					return true;
				}
				if (!oldPrefsExists)
				{
					trace('Old Prefs doesn\'t exist!');
				}
		}
		#end
		return false;
	}
}