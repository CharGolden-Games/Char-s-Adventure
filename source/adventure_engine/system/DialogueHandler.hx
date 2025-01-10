package adventure_engine.system;

import tjson.TJSON as Json;
import openfl.Assets as FlAssets;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

typedef DialogueAlt =
{
	public var text:String;
	@:optional public var char:String;
	@:optional public var suffix:String;
}

typedef Dialogue =
{
	@:optional public var text:String;
	@:optional public var char:String;
	@:optional public var suffix:String;
	@:optional public var alt:DialogueAlt;
	@:optional public var options:Array<String>;
}

typedef DialogueFile =
{
	public var name:String;
	public var dialogue:Array<Dialogue>;
}

class DialogueHandler
{
	public function loadDialogueFile(path:String):DialogueFile
	{
		var rawJson:String = null;
		if (#if sys FileSystem.exists(path) || #end FlAssets.exists(path))
		{
			#if sys
			rawJson = cast File.getContent(path);
			if (rawJson == null)
			{
				rawJson = cast FlAssets.getText(path);
			}
			#else
			rawJson = FlAssets.getText(path);
			#end
		}

		return cast Json.parse(rawJson);
	}
}
