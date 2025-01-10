package cre.graphics;

class Note extends FlxSprite
{
	public var noteData:Int = 0;
	public var noteType:String = '';
	public var texture:String = 'default';
	public var note_folder:String = 'shark'; // Affected by noteskin choice.
	public var isBotplay:Bool = false; // Determines whether to use the alternate botplay texture.
	public var noRGB:Bool = false; // Whether to disable RGB or not.
}
