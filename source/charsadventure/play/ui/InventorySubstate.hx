package charsadventure.play.ui;

typedef Inventory =
{
	public var inventory:Array<Item>;
}

typedef Item =
{
	public var name:String;
	public var id:Int;
	public var amount:Int;
	@:optional public var durability:Float;
}

class InventorySubstate extends BaseSubState
{
	var inventoryRows:Int = 3;
	var curInventory:Inventory;
}
