# TODO LIST:

### Make it possible to launch the save editor with the commandline argument `--SaveEditor` so I can package it as one EXE.

### Make a working NPC class with dialogue and everything.

### Make some actual objects.

### Make a way to calculate the specific WxH ratio to change the size of the game window properly.

### Implement a fix for the fact that HaxeFlixel by default can't account for disconnected audio sources.

<details>
    <summary><h2>General Idea for final folder structure</h2></summary>
The structure based on (NON-LIBRARY OVERRIDING) folders by the end of development should be something like this!

NOT A STRICT STRUCTURE, JUST AN EXAMPLE

```
buildscripts
|
|____ Prebuild.hx
|
|____ Postbuild.hx

charsadventure
|
|____ api
|     |
|     |____ Discord.hx
|
|____ play
|      |
|      |____ components
|      |
|      |     |
|      |     |____ HealthBar.hx
|      |
|      |____ objects
|      |      |
|      |      |____ Player.hx
|      |      |
|      |      |____ Opponent.hx
|      |      |
|      |      |____ NPC.hx
|      |      |
|      |      |____ hitboxes
|      |              |
|      |              |____ HitBox.hx
|      |              |
|      |              |____ EnemyHitBox.hx
|      |              |
|      |              |____ AttackBox.hx
|      |
|      | ____ stages
|      |      |
|      |      |____ CharsHouse.hx
|      |      |
|      |      |____ CharIsle.hx
|      |      |
|      |      |____ TriditeCity.hx
|      |
|       ____ PlayState.hx
|____ settings
|     |
|     |____ OptionState.hx
|     |
|     |____ GraphicsOptionsSubstate.hx
|     |
|     |____ ControlsSubstate.hx

save_editor
|
|     |____ backend
|     |     |
|     |     |____ Paths.hx
|     |     |
|     |     |____ Prefs.hx
|     |
|     |____ PlayState.hx

shared
|
|     |
|     |____ backend
|     |     |
|     |     |____ Save.hx
|     |     |
|     |     |____ Constants.hx
```
