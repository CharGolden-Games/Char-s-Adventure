# IF YOU'RE HAVING ISSUES COMPILING WITH `discord-rpc` FOLLOW THESE STEPS

Browse to where your haxe libraries are (Default: `C:\HaxeToolkit\lib`) and if `discord-rpc\` does not contain a git folder:

Delete any folders or files in here, and in git bash, browse into the folder (Or just right click the folder and you should see `Open Git Bash here`) and run
```bat
git clone https://github.com/Aidan63/linc_discord-rpc.git git
cd git
git submodule update --init --recursive
```

add a file named `.current` (make sure you have `File name extensions` checked under the `View` tab in File Explorer), add `git` in the file, save and try to compile again.