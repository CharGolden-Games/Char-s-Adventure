package;

#if !macro
// flixel
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxUIState;
import flixel.util.FlxTimer;
import flixel.FlxSubState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.sound.FlxSound;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
// Stuff for Char's Adventure
import charsadventure.ui.base.BaseSettingsSubstate;
import charsadventure.ui.base.BaseState;
import charsadventure.ui.base.BaseSubState;
import charsadventure.ui.mainmenu.MainMenuState;
import charsadventure.ui.ErrorSubstate;
import charsadventure.ui.ErrorSubstate as Error;
import charsadventure.utils.*;
import charsadventure.play.ui.*;
// Misc
#if sys
import flash.system.System;
import sys.FileSystem;
import sys.io.File;
#end
import lime.app.Application;
import haxe.PosInfos;

using StringTools;
#end
