package save_editor.backend;

using StringTools;

class ScriptCallbackHandler
{
	public static inline function script_to_callback(scriptPath:Null<String>, type:String = ''):Dynamic->Dynamic
	{
		trace('TODO: MAKE IT POSSIBLE TO USE SCRIPTS TO MAKE CUSTOM CALLBACKS');
		var callback:Dynamic->Dynamic = function(value:Dynamic):Dynamic
		{
			return value;
		};

		if (StringTools.startsWith(scriptPath.toLowerCase(), 'defaultcallbacks.')) // so you can specify this yourself.
		{
			switch ((scriptPath.toLowerCase()).replace('defaultcallbacks.', ''))
			{
				case 'bool' | 'boolCallback':
					callback = DefaultCallbacks.boolCallback;
				case 'enum' | 'enumCallback':
					callback = DefaultCallbacks.enumCallback;
				case 'float' | 'floatCallback':
					callback = DefaultCallbacks.floatCallback;
			}
		}

		if (scriptPath == null)
		{
			switch (type)
			{
				case 'bool':
					callback = DefaultCallbacks.boolCallback;
				case 'enum':
					callback = DefaultCallbacks.enumCallback;
				case 'float':
					callback = DefaultCallbacks.floatCallback;
			}
		}

		final finalCallback = callback;
		return finalCallback;
	}
}