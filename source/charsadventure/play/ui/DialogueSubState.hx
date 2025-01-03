package charsadventure.play.ui;

import charsadventure.play.components.CustomCam;
import charsadventure.play.components.DialoguePortrait;
import charsadventure.play.PlayState;
import flixel.addons.ui.U as FlxU;
import openfl.utils.Assets;
import tjson.TJSON as Json;

using StringTools;

typedef DialogueFile =
{
	public var name:String;
	public var dialogue:Array<Dialogue>;
}

typedef Dialogue =
{
	public var dialogue:String;
	public var id:Int;
	public var image:String;
	@:optional public var imagePostfix:String;
	@:optional public var options:DialogueOptions;
	@:optional public var name:String;
	@:optional public var previousMessage:Int;
	@:optional public var image2:String;
	@:optional public var image2Postfix:String;
}

typedef DialogueOptions =
{
	public var options:Array<String>;
	public var possibleIDs:Array<Int>;
}

class DialogueSubState extends BaseSubState
{
	var dialogue:Array<Dialogue>;
	var dialogueFile:DialogueFile;
	var portraitLeft:DialoguePortrait;
	var portraitRight:DialoguePortrait;
	var text:FlxText;
	var name:FlxText;
	var bg:FlxSprite;
	var curDialogue:Int = 0;
	var camBox:CustomCam;

	public function new(?dialogue:DialogueFile)
	{
		if (dialogue != null)
		{
			dialogueFile = dialogue;
			this.dialogue = dialogueFile.dialogue;
		}

		super();
	}

	override function create():Void
	{
		super.create();

		if (dialogue == null)
		{
			dialogueFile = loadDialogueFile();
			dialogue = dialogueFile.dialogue;
		}

		camBox = new CustomCam(0, 0, 0, 0, 'camBox');
		camBox.bgColor.alpha = 0;
		FlxG.cameras.add(camBox, false);

		bg = new FlxSprite().loadGraphic(Paths.image('dialogueBox'));
		bg.y = FlxG.height - bg.height;
		add(bg);

		text = new FlxText(0, 0, 766, dialogue[curDialogue].dialogue, 25);
		text.setFormat(Paths.font('naname_goma.ttf'), 25, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
		text.y = bg.y + 10;
		text.x = 508;
		add(text);

		name = new FlxText(0, 0, 333, dialogueFile.name, 25);
		name.setFormat(Paths.font('naname_goma.ttf'), 25, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
		name.y = bg.y + 10;
		name.x = 16;
		add(name);

		var image:String = dialogue[curDialogue].image;
		if (dialogue[curDialogue].imagePostfix != null)
		{
			image += dialogue[curDialogue].imagePostfix;
		}

		portraitLeft = new DialoguePortrait(0, 0, image, 0);
		if (image.endsWith('none'))
		{
			portraitLeft.visible = false;
		}
		add(portraitLeft);

		portraitRight = new DialoguePortrait(0, 0, image, 1);
		portraitRight.x = FlxG.width - (portraitRight.width + 20);
		portraitRight.visible = false;
		add(portraitRight);

		cameras = [camBox];
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (controls.justPressed('skip'))
		{
			// TODO: make this use a callback.
			close();
		}
		if (controls.justPressed('advance_text'))
		{
			changeDialogue(1);
		}
		if (controls.justPressed('back_text'))
		{
			changeDialogue(-1);
		}
	}

	function changeDialogue(change:Int = 0):Void
	{
		curDialogue += change;

		if (curDialogue > dialogue.length - 1)
		{
			// You've reached the end, no need to go further!
			close();
			return;
		}
		if (curDialogue < 0)
		{
			// no need to do anything besides reset to 0 cause this is the FUCKIN START.
			curDialogue = 0;
			return;
		}
		var currentDialogue:Dialogue = dialogue[curDialogue];

		text.text = currentDialogue.dialogue;

		if (currentDialogue.imagePostfix == null)
			currentDialogue.imagePostfix = '';

		portraitLeft.loadGraphic(currentDialogue.image + currentDialogue.imagePostfix);
		if (currentDialogue.image2 != null)
		{
			if (currentDialogue.image2Postfix == null)
				currentDialogue.image2Postfix = '';
			portraitRight.loadGraphic(currentDialogue.image2 + currentDialogue.image2Postfix);
			portraitRight.visible = true;
		}
		else
		{
			if (portraitRight.visible)
				portraitRight.visible = false;
		}

		if (currentDialogue.name != null)
		{
			name.visible = true;
			name.text = currentDialogue.name;
		}
		else
		{
			name.visible = true;
			name.text = currentDialogue.image;
		}

		if (currentDialogue.image.endsWith('none'))
		{
			portraitLeft.visible = false;
			name.visible = false;
		}
	}

	function loadDialogueFile():DialogueFile
	{
		var rawJson:String = null;
		var path = 'assets/data/dialogue/${PlayState.instance.lastNPCTalkedTo}.json';
		if (Assets.exists(path))
		{
			rawJson = Assets.getText(path);
		}
		else
		{
			path = Paths.getFallbackPath('data', 'dialogue/null.json');
			rawJson = Assets.getText(path);
		}

		return cast Json.parse(rawJson);
	}

	function randomText(str:String):String
	{
		return RandUtils.randomText(str);
	}
}
