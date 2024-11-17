# Clickpulp AGS Modules Documentation

*This doc is a work in progress. The modules are currently used for internal development but you are welcome to export and install them on your game as they are free to use.*

## Setup

1. A lot of the modules depend on each other and you may need to install all of them in the exact order in which appear in the example game under the `Clickpulp` folder.

In a `game_start`, you can set your inventory and main menu gui optionally:

```
void game_start() {
  pulpGlobals.MainMenuGUI = gYourMainMenu;
  pulpGlobals.InventoryGUI = gYourInventory;
}
```

## Modules

*NOTE: Not all the modules are documented.*

* `PulpGlobals` - All the global values shared across modules
* [`Pulp_Signal`](./signal.md) - Signals modules that allow you to dispatch and check for messages across scripts.
* [`Pulp_Extenders`](../game/Pulp_Extenders.ash) - Functions that extend existing AGS Objects
* [`Pulp_Rect`](../game/Pulp_Rect.ash) - A typical `Rect` object found in other game engines (x1, y1, x2, y2)
* [`Pulp_IsInBlockingScript`](../game/Pulp_IsInBlockingScript.ash) - Function that checks if the game is running a blocking script.
* [`Pulp_CutsceneHelpers`](./cutscenehelpers.md) - Functions and events that improve cutscene management and skipping.
* `Pulp_Input` - Input mapper that allow setting a generic key to multiple inputs (keyboard, or gamepad)
* [`Pulp_GUIStack`](./guistack.md) - A better way to manage GUIs through a [stack data structure](https://www.thedshandbook.com/stacks/).
* `Pulp_PatchValues` - An extra modules that allows you to set values after the game is released without breaking the saved games
* `Pulp_InputMappings` - Creates and exports all the input mappings objects.
* `Pulp_PlayerDirectControl` - A module that allows the player character to be controlled via keyboard using pathfinding.
* `Pulp_Cursor` - Improved cursor functions that allow it to be controlled from keyboard or controller.
* `Pulp_InputHandling` - Adds interaction to all the mapped input objects.
* `Pulp_RoomMarkers` - Module to draw spatial markers in a room. Used by HintsHighlighter.
* `Pulp_RoomIndex` - Provides a list (index) of all the active characters, objects, hotspots in the room, their size, and their properties.
* `Pulp_HintsHighlighter` - When the player presses a key, they can see all the interactive objects in the room.
* `Pulp_PlayerCollision` - Adds a collision on top of the player character so that interactive objects can be detected while walking around using keyboard or gamepad. (examples doors or characters.)
