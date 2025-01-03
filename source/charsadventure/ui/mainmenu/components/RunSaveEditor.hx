package charsadventure.ui.mainmenu.components;

#if sys
import sys.io.Process;
#end

class RunSaveEditor
{
	public static function runSaveEditor():Void
	{
		#if sys
		new Process(Sys.programPath() + ' -save_edit');
		Sys.exit(0);
		#else
		trace('Not able to launch! Build Target does not support Sys!');
		#end
	}

	public static function runMainGame():Void
	{
		#if sys
		new Process(Sys.programPath());
		Sys.exit(0);
		#else
		trace('Not able to launch! Build Target does not support Sys!');
		#end
	}
}
