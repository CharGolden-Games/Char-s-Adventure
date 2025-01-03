package charsadventure.utils;

import flixel.input.keyboard.FlxKey;

class Controls
{
	public var move_left(get, never):Bool;
	public var move_right(get, never):Bool;
	public var move_up(get, never):Bool;
	public var move_down(get, never):Bool;
	public var move_hold(get, never):Bool;

	public var jump(get, never):Bool;
	public var attack(get, never):Bool;

	public var ui_inv(get, never):Bool;
	public var ui_left(get, never):Bool;
	public var ui_right(get, never):Bool;
	public var ui_up(get, never):Bool;
	public var ui_down(get, never):Bool;
	public var accept(get, never):Bool;
	public var back(get, never):Bool;
	public var pause(get, never):Bool;

	public var move_left_p(get, never):Bool;
	public var move_right_p(get, never):Bool;
	public var move_up_p(get, never):Bool;
	public var move_down_p(get, never):Bool;
	public var move_hold_p(get, never):Bool;

	public var jump_p(get, never):Bool;
	public var attack_p(get, never):Bool;
	public var pause_p(get, never):Bool;

	public var ui_inv_p(get, never):Bool;
	public var ui_left_p(get, never):Bool;
	public var ui_right_p(get, never):Bool;
	public var ui_up_p(get, never):Bool;
	public var ui_down_p(get, never):Bool;
	public var accept_p(get, never):Bool;
	public var back_p(get, never):Bool;

	public var move_left_r(get, never):Bool;
	public var move_right_r(get, never):Bool;
	public var move_up_r(get, never):Bool;
	public var move_down_r(get, never):Bool;
	public var move_hold_r(get, never):Bool;

	public var jump_r(get, never):Bool;
	public var attack_r(get, never):Bool;

	public var ui_inv_r(get, never):Bool;
	public var ui_left_r(get, never):Bool;
	public var ui_right_r(get, never):Bool;
	public var ui_up_r(get, never):Bool;
	public var ui_down_r(get, never):Bool;
	public var accept_r(get, never):Bool;
	public var back_r(get, never):Bool;
	public var pause_r(get, never):Bool;

	private function get_move_left()
		return pressed('move_left');

	private function get_move_right()
		return pressed('move_right');

	private function get_move_up()
		return pressed('move_up');

	private function get_move_down()
		return pressed('move_down');

	private function get_move_hold()
		return pressed('move_hold');

	private function get_jump()
		return pressed('jump');

	private function get_attack()
		return pressed('attack');

	private function get_ui_inv()
		return pressed('ui_inv');

	private function get_ui_left()
		return pressed('ui_left');

	private function get_ui_right()
		return pressed('ui_right');

	private function get_ui_up()
		return pressed('ui_up');

	private function get_ui_down()
		return pressed('ui_down');

	private function get_accept()
		return pressed('accept');

	private function get_back()
		return pressed('back');

	private function get_pause()
		return pressed('pause');

	private function get_move_left_p()
		return justPressed('move_left');

	private function get_move_right_p()
		return justPressed('move_right');

	private function get_move_up_p()
		return justPressed('move_up');

	private function get_move_down_p()
		return justPressed('move_down');

	private function get_move_hold_p()
		return justPressed('move_hold');

	private function get_accept_p()
		return justPressed('accept');

	private function get_pause_p()
		return justPressed('pause');

	private function get_back_p()
		return justPressed('back');

	private function get_jump_p()
		return justPressed('jump');

	private function get_attack_p()
		return justPressed('attack');

	private function get_ui_inv_p()
		return justPressed('ui_inv');

	private function get_ui_left_p()
		return justPressed('ui_left');

	private function get_ui_right_p()
		return justPressed('ui_right');

	private function get_ui_up_p()
		return justPressed('ui_up');

	private function get_ui_down_p()
		return justPressed('ui_down');

	private function get_move_left_r()
		return released('move_left');

	private function get_move_right_r()
		return released('move_right');

	private function get_move_up_r()
		return released('move_up');

	private function get_move_down_r()
		return released('move_down');

	private function get_move_hold_r()
		return released('move_hold');

	private function get_jump_r()
		return released('jump');

	private function get_attack_r()
		return released('attack');

	private function get_ui_inv_r()
		return released('ui_inv');

	private function get_ui_left_r()
		return released('ui_left');

	private function get_ui_right_r()
		return released('ui_right');

	private function get_ui_up_r()
		return released('ui_up');

	private function get_ui_down_r()
		return released('ui_down');

	private function get_accept_r()
		return released('accept');

	private function get_back_r()
		return released('back');

	private function get_pause_r()
		return released('pause');

	public var keyboardBinds:Map<String, Array<FlxKey>>;

	public function released(key:String)
	{
		// trace('trying to get released $key');
		var result:Bool = (FlxG.keys.anyJustReleased(keyboardBinds[key]) == true);
		// trace(result);

		return result;
	}

	public function pressed(key:String)
	{
		// trace('trying to get $key');
		var result:Bool = (FlxG.keys.anyPressed(keyboardBinds[key]) == true);
		// trace(result);

		return result;
	}

	public function justPressed(key:String)
	{
		// trace('trying to get just pressed $key');
		var result:Bool = (FlxG.keys.anyJustPressed(keyboardBinds[key]) == true);
		// trace(result);

		return result;
	}

	public static var instance:Controls;

	public function new()
	{
		keyboardBinds = Save.keyBinds;
	}
}
