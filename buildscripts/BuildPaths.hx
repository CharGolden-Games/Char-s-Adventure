package buildscripts;

/**
 * This class handles shared paths by both Prebuild.hx and Postbuild.hx.
 */
class BuildPaths
{
	public static final logPath:String = 'buildTime' #if SAVE_EDITOR + '-SaveEditor' #end + '.log';
	public static final timeStampPath:String = 'temp/' + #if SAVE_EDITOR 'SaveEditor' + #end '.buildTimestamp';
	public static final tempPath:String = 'temp/';
	public static final lastBuildTimePath:String = 'lastBuildTimeInSeconds' #if SAVE_EDITOR + '-SaveEditor' #end + '.txt';
	public static final keyPath:String = 'gameKey/CharsAdventure.key';
}
