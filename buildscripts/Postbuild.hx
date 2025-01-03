package buildscripts;

import sys.FileSystem;
import sys.io.File;

/**
 * Shit that runs AFTER the build process
 */
class Postbuild
{
	static var lastBuildTime:String;

	static function main()
	{
		if (FileSystem.exists(BuildPaths.lastBuildTimePath))
		{
			lastBuildTime = File.getContent(BuildPaths.lastBuildTimePath);
			FileSystem.deleteFile(BuildPaths.lastBuildTimePath);
		}
		if (FileSystem.exists(BuildPaths.logPath))
		{
			FileSystem.deleteFile(BuildPaths.logPath);
		}

		if (FileSystem.exists(BuildPaths.timeStampPath))
		{
			var now:Float = Sys.time();

			var then:Float = Std.parseFloat(File.getContent(BuildPaths.timeStampPath));

			if (!Math.isNaN(then))
			{
				var buildTime = roundDecimal(now - then, 2);
				trace('Build took \033[0;36m${Std.string(buildTime)}s\033[0m');
				File.saveContent(BuildPaths.lastBuildTimePath, Std.string(buildTime));
				if (lastBuildTime != null)
				{
					var float = Std.parseFloat(lastBuildTime);
					float = buildTime - float;
					var v = '\033[32m';
					if (float > 0)
					{
						if (float >= 10) // 10 seconds is a lot imo
							v = '\033[31m+';
						if (float < 10)
						{
							v = '\033[33m+';
						}
					}
					trace('Last Build took \033[0;36m${lastBuildTime}s\033[0m, with a difference of $v${roundDecimal(float, 2)}s\033[0m');
				}
				return;
			}
			if (Math.isNaN(then))
			{
				trace('Build time is NaN! Double check that the path is correct!');
			}

			FileSystem.deleteFile(BuildPaths.timeStampPath);
			FileSystem.deleteDirectory(BuildPaths.tempPath);
		}
		trace('Error getting build time! Double check that the path is correct!');
	}

	/**
	 * Stolen from FlxMath, purely so i can use it without haxe giving me errors.
	 */
	public static function roundDecimal(Value:Float, Precision:Int):Float
	{
		var mult:Float = 1;
		for (i in 0...Precision)
		{
			mult *= 10;
		}
		return Math.fround(Value * mult) / mult;
	}
}
