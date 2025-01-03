package save_editor.backend;

/**
 * Default callbacks for Options if no script is specified
 * 
 * Mapping variables to be functions is so damn cool.
 */
class DefaultCallbacks
{
	public static final boolCallback:Bool->Bool = function(value:Bool):Bool
	{
		return value;
	};
	public static final enumCallback:String->String = function(value:String):String
	{
		return value;
	};
	public static final floatCallback:Float->Float = function(value:Float):Float
	{
		return value;
	};
}