package charsadventure.play.character;

import haxe.ui.containers.TagList;
import charsadventure.play.ui.DialogueSubState;
import charsadventure.play.ui.shopItems.ShopItem.ShopItemGroup;
import charsadventure.play.ui.shopItems.ShopItem.ShopParams;
import charsadventure.play.ui.shopItems.ShopItem.ShopDialogue;
import charsadventure.play.character.BaseCharacter.AnimArray;
import openfl.Assets;
import tjson.TJSON as Json;

abstract NPCType(Int) from Int to Int
{
	public static inline final NORMAL:NPCType = 0;
	public static inline final SHOP:NPCType = 1;
	public static inline final DIALOGUE_WITH_CHOICE:NPCType = 2;
	public static inline final CUTSCENE:NPCType = 3;

	public static function fromString(str:String):Null<Int>
	{
		switch (str.toLowerCase().trim())
		{
			case 'default' | 'normal' | 'basic':
				return NORMAL;

			case 'shop' | 'merchant':
				return SHOP;

			case 'multiple' | 'dialogueWithChoice':
				return DIALOGUE_WITH_CHOICE;

			case 'cutscene' | 'movie':
				return CUTSCENE;
		}
		return null;
	}
}

typedef NPCParams =
{
	public var dialogue:Array<ShopDialogue>;
	@:optional public var shopFile:String;
}

typedef NPCFile =
{
	public var name:String;
	public var image:String;
	public var animations:Array<AnimArray>;
	public var type:NPCType;
	public var npcParams:NPCParams;
}

class BaseNPC extends BaseCharacter
{
	var npcFile:NPCFile;
	var type:NPCType;
	var npcParams:NPCParams;
	var shopFile:ShopParams;
	var allowInput:Bool = false;

	public function new(x:Float = 0, y:Float = 0, ?char:String)
	{
		isExtended = true;
		super(x, y, char);

		if (char != null)
		{
			loadCharacter(char);
		}
	}

	override function loadCharacter(char:String):Void
	{
		isExtended = true;
		super.loadCharacter(char);
		npcFile = loadNPCFile(char);

		name = npcFile.name;
		animations = npcFile.animations;
		image = npcFile.image;
		type = npcFile.type;
		npcParams = npcFile.npcParams;

		loadGraphic(Paths.image(image));
		frames = Paths.xmlFrames(image);
		for (anim in animations)
		{
			if (anim.indices == null)
				animation.addByPrefix(anim.name, anim.anim, anim.fps, anim.loop);
			else
				animation.addByIndices(anim.name, anim.anim, anim.indices, null, anim.fps, anim.loop);
		}

		if (animation.exists('idle'))
		{
			animation.play('idle');
		}
		shopFile = FileUtils.loadShopFile(npcParams.shopFile);
	}

	override function playAnim(name:String):Void
	{
		super.playAnim(name);
	}

	public function openDialogue():Void
	{
		// PlayState.instance.openSubState(new DialogueSubState());
	}

	override function update(elapsed:Float):Void
	{
		// Because this is an NPC, don't wanna accidentally let people control it. BUUUT i might wanna do a thing where you can control NPC's
		if (inputHandler != null && !allowInput)
			inputHandler == null;

		super.update(elapsed);
	}

	public function loadNPCFile(file:String):NPCFile
	{
		var rawJson:String = null;
		var path = Paths.charData('npcs/$file');

		if (Assets.exists(path))
			rawJson = Assets.getText(path);
		else
			return null;

		return cast Json.parse(rawJson, path);
	}
}

class NPCGroup extends FlxTypedGroup<BaseNPC>
{
	public static var instance:NPCGroup;

	public function new(maxSize:Int = 0)
	{
		super(maxSize);

		instance = this;
	}

	/**
	 * Adds a new NPC to the group
	 * @param x The X position
	 * @param y The Y position
	 * @param char The characters filename
	 */
	public function addNPC(x:Float, y:Float, char:String):Void
	{
		var npc:BaseNPC = new BaseNPC(x, y, char);
		add(npc);
	}
}
