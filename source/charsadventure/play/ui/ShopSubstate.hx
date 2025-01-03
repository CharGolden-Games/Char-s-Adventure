package charsadventure.play.ui;

import charsadventure.play.ui.shopItems.ItemDescriptionBox;
import charsadventure.play.ui.shopItems.ShopItem.ShopItemGroup;

class ShopSubstate extends BaseSubState
{
	var shopBG:FlxSprite;
	var items:ShopItemGroup;
	var curSelected = 0;
	var arraySize:Int = 4;
	var itemDesc:ItemDescriptionBox;

	override function create():Void
	{
		super.create();

		shopBG = new FlxSprite().makeGraphic(Std.int(FlxG.width * 0.4), FlxG.height, 0xFF000000);
		shopBG.alpha = 0.6;
		add(shopBG);

		shopBG.x = FlxG.width - shopBG.width;

		PlayState.instance.inSubstate = true;

		items = new ShopItemGroup(0, 20);
		items.x = FlxG.width - (items.width + 5);
		add(items);

		itemDesc = new ItemDescriptionBox(0, 0, items.members[curSelected].name, items.members[curSelected].desc);
		itemDesc.y = FlxG.height - itemDesc.height;
		add(itemDesc);

		arraySize = items.curParams[0].length;

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
		nextItem();
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (controls.back)
		{
			PlayState.instance.close_shop();
			close();
		}
		if (controls.accept_p)
		{
			// TODO: Implement the buying system after the inventory System.
			// buyItem();
		}
		if (controls.ui_left_p)
		{
			nextItem(-1);
		}
		if (controls.ui_right_p)
		{
			nextItem(1);
		}
		if (controls.ui_up_p)
		{
			nextItem(-arraySize);
		}
		if (controls.ui_down_p)
		{
			nextItem(arraySize);
		}
	}

	function nextItem(change:Int = 0):Void
	{
		curSelected = items.change_index(change);
		var moneyType:String = '';
		switch (PlayState.instance.moneyType)
		{
			case 'Dollars':
				moneyType = '$' + CoolUtil.instance.formatDollars(items.members[curSelected].price);

			case 'Gold':
				moneyType = Std.string(items.members[curSelected].price) + 'g';
		}
		itemDesc.setDescText(items.members[curSelected].name + ' | $moneyType', items.members[curSelected].desc);

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function close():Void
	{
		super.close();

		PlayState.instance.inSubstate = false;
	}
}
