@echo off
echo INSTALLING LIBRARIES
@echo on
haxelib install flixel-addons
haxelib install flixel-tools
haxelib install flixel-ui
haxelib install flixel
haxelib install flxanimate
haxelib install haxeui-core
haxelib install haxeui-flixel
haxelib install hxCodec
haxelib install hxcpp-debug-server
haxelib install hxp
haxelib install lime
haxelib install openfl
haxelib install tjson
haxelib install polymod
haxelib install thx.core
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc.git
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit.git
curl -# -L -O "https://github.com/CobaltBar/SScript-Archive/raw/refs/heads/main/archives/SScript-7,7,0.zip"
haxelib install "SScript-7,7,0.zip"
del "SScript-7,7,0.zip"
haxelib run lime setup
@echo off
echo DONE
pause