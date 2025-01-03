package charsadventure.play.character;

import charsadventure.graphics.CABaseSprite;
import tjson.TJSON as Json;
import openfl.Assets;

typedef CustomCharacterParams =
{
	public var name:String;
	public var startHealth:Float;
	public var defense:Float;
	public var icon:String;
	public var image:String;
	public var animations:Array<AnimArray>;
	@:optional public var usesDefaultWeapons:Bool;
	@:optional public var usesDefaultHealthbar:Bool;
	@:optional public var weaponPath:String;
	@:optional public var healthbarPath:String;
	@:optional public var weaponType:String;
	@:optional public var gunType:String;
}

typedef AnimArray =
{
	public var anim:String;
	public var name:String;
	public var fps:Int;
	public var loop:Bool;
	@:optional public var indices:Array<Int>;
	public var offsets:Array<Int>;
}

class BaseCharacter extends CABaseSprite
{
	public static var instance:BaseCharacter;

	public var name:String = 'Char';
	public var startHealth:Float = 5;
	public var defense:Float = 1;
	public var icon:String = 'char';
	public var image:String = 'characters/charPlayer';
	public var usesDefaultWeapons:Bool = true;
	public var usesDefaultHealthbar:Bool = true;
	public var weaponPath:String = '';
	public var healthbarPath:String = '';
	public var weaponType:String;
	public var gunType:String;

	/**
	 * Set this to true to be able to override loadCharacter().
	 */
	var isExtended:Bool = false;

	/**
	 * List of animations and their properties.
	 */
	public var animations:Array<AnimArray> = [
		{
			anim: 'IdleMic0',
			name: 'idle',
			fps: 24,
			loop: true,
			offsets: [0, 0]
		},
		{
			anim: 'IdleMicRight',
			name: 'idle_right',
			fps: 24,
			loop: true,
			offsets: [0, 0]
		},
		{
			anim: 'WalkLeftMic',
			name: 'walk_left',
			fps: 24,
			loop: false,
			offsets: [0, 0]
		},
		{
			anim: 'WalkRightMic',
			name: 'walk_right',
			fps: 24,
			loop: false,
			offsets: [0, 0]
		},
		{
			anim: 'SingLeft0',
			name: 'attack',
			fps: 24,
			loop: false,
			offsets: [0, 0]
		},
		{
			anim: 'SingUp0',
			name: 'jump',
			fps: 24,
			loop: false,
			offsets: [0, 0]
		}
	];

	public var inputHandler:Null<BaseCharacter->Void> = null;
	public var curDirection:Int = 0;

	public function new(x:Float, y:Float, char:String)
	{
		super(x, y);

		antialiasing = !Save.data.lowQuality;
		if (!isExtended)
		{
			loadCharacter(char);
		}
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (inputHandler != null)
		{
			inputHandler(this);
		}
	}

	public function loadCharacter(char:String):Void
	{
		if (!isExtended)
		{
			var character:CustomCharacterParams = loadCharacterFile(char);
			// Because i do NOT want to retype this shit.
			if (character != null)
			{
				for (field in Reflect.fields(character))
				{
					if (Reflect.hasField(this, field))
					{
						Reflect.setField(this, field, Reflect.field(character, field));
					}
				}
			}

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
		}
	}

	/**
	 * Loads a character from `assets/data/characters`
	 * @param char The character to load
	 * @return CustomCharacterParams
	 */
	public function loadCharacterFile(char:String):CustomCharacterParams
	{
		var rawJson:String = null;
		var path = Paths.charData(char);

		if (Assets.exists(path))
			rawJson = Assets.getText(path);
		else
			return null;

		return cast Json.parse(rawJson, path);
	}
}
