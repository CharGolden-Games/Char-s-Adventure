package buildscripts;

import haxe.io.Encoding;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

using Date;

/*
 * This is ran BEFORE building the game.
 * 
 * TODO: MAKE THIS DO SOMETHING.
 */
class Prebuild
{
	static function main()
	{
		trace('Building!');
		FileSystem.createDirectory(BuildPaths.tempPath);

		File.saveContent(BuildPaths.logPath, Date.now().toString());
		File.saveContent(BuildPaths.timeStampPath, Std.string(Sys.time()));

		#if !SAVE_EDITOR
		if (FileSystem.exists(BuildPaths.keyPath))
		{
			File.getContent(BuildPaths.keyPath);
		}
		else
		{
			File.saveContent(BuildPaths.keyPath, '<Key.Here>\n\nThis should be replaced with your actual game key!');
			trace('Dont forget to replace the key in ${BuildPaths.keyPath} with your real gamekey that should have been sent to you!');
		}
		#end
	}
}
