package cre.play.components;

import flixel.text.FlxText;
import cre.graphics.CRESprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Rating
{
	public var name:String = '';
	public var image:String = '';
	public var hitWindow:Null<Int> = 0;
	public var ratingMod:Float = 1;
	public var score:Int = 350;
	public var hits:Int = 0;

	public function new(name:String)
	{
		this.name = name;
		this.image = name;
		var window = name + 'Window';
		try
		{
			this.hitWindow = Reflect.field(LocalSettings, window);
		}
		catch (e)
			FlxG.log.error(e);
	}

	/**
	 * Loads default rating data.
	 * @return Array<Rating>
	 */
	public static function loadDefault():Array<Rating>
	{
		var ratingsData:Array<Rating> = [new Rating('perfect')];
		ratingsData[0].score = 500;

		var rating:Rating = new Rating('sick');
		rating.ratingMod = 0.8;
		ratingsData.push(rating);

		var rating:Rating = new Rating('good');
		rating.ratingMod = 0.67;
		rating.score = 200;
		ratingsData.push(rating);

		var rating:Rating = new Rating('bad');
		rating.ratingMod = 0.34;
		rating.score = 100;
		ratingsData.push(rating);

		var rating:Rating = new Rating('shit');
		rating.ratingMod = 0;
		rating.score = 50;
		ratingsData.push(rating);

		return ratingsData;
	}
}

class RatingPopUps extends FlxTypedSpriteGroup<FlxSprite>
{
	// Graphic shits.
	var ratingGraphic:CRESprite;
	var comboSprite:CRESprite;

	// var comboNum:ComboNumSprite;
	// Backup graphic shits.
	var rating_backupText:FlxText;
	var combo_backupText:FlxText;
	var comboNum_backupText:FlxText;

	// Settings
	public var combo_velocity:Int = 0;
	public var direction:Float = 0;
	public var rating:Rating;
	public var combo_graphic:Null<FlxGraphicAsset> = null;

	public function new(rating:Rating, x:Float = 0, y:Float = 0, velocity:Int = 0, direction:Float = 0, ?graphic:FlxGraphicAsset)
	{
		this.rating = rating;
		combo_velocity = velocity;
		this.direction = direction;
		combo_graphic = graphic;
		super(x, y);

		loadRatingPopUp();
	}

	/**
	 * Loads the next rating hit.
	 * @return `RatingPopUps` For being able to do `var rating:RatingPopUps = new RatingPopUps(rating, 0, 0, 10, 90, graphic).loadRatingPopUp();`
	 */
	public function loadRatingPopUp():RatingPopUps
	{
		ratingGraphic = new CRESprite().newSprite(Paths.image(rating.image), null, null, combo_graphic);
		if (ratingGraphic != null)
		{
			add(ratingGraphic);
		}
		else
		{
			rating_backupText = new FlxText(0, 0, 0, rating.name, 40);
			add(rating_backupText);
		}

		// TODO: Make the combo number sprite class.

		comboSprite = new CRESprite(100, 200).newSprite(Paths.image('combo'));
		if (comboSprite != null)
		{
			comboSprite.visible = (PlayState.instance.songCombo >= 10);
			add(comboSprite);
		}
		else
		{
			combo_backupText = new FlxText(100, 200, 0, "COMBO", 40);
			combo_backupText.visible = (PlayState.instance.songCombo >= 10);
			add(combo_backupText);
		}

		return this;
	}

	/**
	 * Actually makes the PopUp jump.
	 */
	public function doPopUp():Void
	{
		// TODO: Make this actually do a little falling anim in the direction defined by direction.
	}
}
