sudo apt install haxe # This makes sure you actually have haxe installed on your system

haxelib setup

haxelib install hxcpp-debug-server
haxelib install hxp
haxelib install lime
haxelib install openfl
haxelib install flixel-addons
haxelib install flixel-tools
haxelib install flixel-ui
haxelib install flixel
haxelib run flixel setup # This is here so you can make template projects
haxelib install flxanimate
haxelib install haxeui-core
haxelib install haxeui-flixel
haxelib install hxCodec
haxelib install tjson
haxelib install polymod # For moddable modules.
haxelib install thx.core
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc.git
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit.git # For lua modding yknow.
curl -# -L -O "https://github.com/CobaltBar/SScript-Archive/raw/refs/heads/main/archives/SScript-7,7,0.zip" # SScript has been completely de-listed from haxelib essentially as all packages now say it is no longer available
haxelib install "SScript-7,7,0.zip"
rm "SScript-7,7,0.zip" # Downloaded file has no purpose now.
haxelib run lime setup # So you can install the lime command.