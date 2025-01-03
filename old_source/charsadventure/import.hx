package;

#if !macro
import charsadventure.backend.*;
import charsadventure.states.*;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.*; // Bad idea? probably.
import flixel.util.FlxColor;
import lime.app.Application;
#if sys
import flash.system.System;
import sys.FileSystem;
import sys.io.File;
#end
#end