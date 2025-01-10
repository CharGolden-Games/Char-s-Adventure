package adventure_engine.system;

import adventure_engine.system.ItemList.ItemProperties; // Kinda need it here

class ItemPropertiesClass
{
	public static var itemToProperties:Map<String, ItemProperties> = [
		'c_mic' => {
			isThrowable: true,
			uses: -1,
			specialItem: true,
			allowedCharacters: {
				char: true
			},
			equipProperties: {
				slot: 5,
				startDurability: -1,
				defense: 0,
				speed: 0,
				hp: 2
			},
			throwDmg: 5,
			dmg: 2
		},
		'mic' => {
			isThrowable: true,
			uses: 5,
			allowedCharacters: {
				all: true
			},
			throwDmg: 5,
			dmg: 1
		},
		'p_ram' => {
			isThrowable: false,
			uses: -1,
			allowedCharacters: {
				plexi: true
			},
			equipProperties: {
				slot: 6,
				startDurability: -1,
				defense: 0,
				speed: 5,
				hp: 12
			},
			dmg: 1
		},
		't_trident' => {
			isThrowable: true,
			uses: -1,
			allowedCharacters: {
				trevor: true
			},
			equipProperties: {
				slot: 5,
				startDurability: -1,
				defense: 0,
				speed: 5,
				hp: 0
			},
			dmg: 5
		},
	];
}
