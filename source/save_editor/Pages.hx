package save_editor;

import save_editor.backend.Page;

/**
 * yuh
 */
class Pages
{
	public var mainPage:MainPage;

	public function new()
	{
		mainPage = new MainPage();
	}
}

/**
 * yuh
 */
class MainPage
{
	public var pageOptions:Page;

	public function new()
	{
		pageOptions = new Page();
		pageOptions.loadedSettings = [
			Page.constructSetting('MONEY (Dollars)', 'dollar', 'float', 50, 'dollars', 0, 999999, 0.01),
			Page.constructSetting('MONEY (Gold)', 'gold', 'float', 50, 'gold', 0, 9999, 1),
			// Page.constructSetting('Inventory', 'chest', 'inventory', null, 'curInventory') // Not done yet!
			Page.constructSetting('Max Health', 'plus', 'float', 3, 'maxHealth', 0, 999, 1)
		];
	}
}
