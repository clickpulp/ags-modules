# Clickpulp AGS Modules Documentation

*This doc is a work in progress. The modules are currently used for internal development but you are welcome to export and install them on your game as they are free to use.*

## Setup

1. A lot of the modules depend on each other and you may need to install all of them in the exact order in which appear in the example game under the `Clickpulp` folder.

In a `game_start`, you can set your inventory and main menu gui optionally:

```agsscript
void game_start() {
  pulpGlobals.MainMenuGUI = gYourMainMenu;
  pulpGlobals.InventoryGUI = gYourInventory;
}
```

## Modules

### Core Modules

* `PulpGlobals` - All the global values shared across modules
* [`Pulp_Signal`](./signal.md) - Signals modules that allow you to dispatch and check for messages across scripts.
* [`Pulp_Extenders`](./extenders.md) - Functions that extend existing AGS Objects
* [`Pulp_Rect`](./rect.md) - A typical `Rect` object found in other game engines (x1, y1, x2, y2)
* [`Pulp_IsInBlockingScript`](./isinblockingscript.md) - Function that checks if the game is running a blocking script.

### Input & Control Modules

* [`Pulp_Input`](./input.md) - Input mapper that allows setting a generic action to multiple inputs (keyboard, mouse, or gamepad)
* [`Pulp_InputMappings`](./inputmappings.md) - Creates and exports all the input mappings objects.
* [`Pulp_InputHandling`](./inputhandling.md) - Adds interaction to all the mapped input objects.
* [`Pulp_PlayerDirectControl`](./playerdirectcontrol.md) - A module that allows the player character to be controlled via keyboard using pathfinding.
* [`Pulp_Cursor`](./cursor.md) - Improved cursor functions that allow it to be controlled from keyboard or controller.

### GUI & Interface Modules

* [`Pulp_GUIStack`](./guistack.md) - A better way to manage GUIs through a [stack data structure](https://www.thedshandbook.com/stacks/).
* [`Pulp_Tooltip`](./tooltip.md) - Simple tooltip system for displaying contextual text information.

### Cutscene & Audio Modules

* [`Pulp_CutsceneHelpers`](./cutscenehelpers.md) - Functions and events that improve cutscene management and skipping.

### Room & Object Modules

* [`Pulp_RoomIndex`](./roomindex.md) - Provides a list (index) of all the active characters, objects, hotspots in the room, their size, and their properties.
* [`Pulp_RoomMarkers`](./roommarkers.md) - Module to draw spatial markers in a room. Used by HintsHighlighter.
* [`Pulp_HintsHighlighter`](./hintshighlighter.md) - When the player presses a key, they can see all the interactive objects in the room.

### Player & Physics Modules

* [`Pulp_PlayerCollision`](./playercollision.md) - Adds a collision on top of the player character so that interactive objects can be detected while walking around using keyboard or gamepad. (examples doors or characters.)

### Utility Modules

* [`Pulp_PatchValues`](./patchvalues.md) - An extra module that allows you to set values after the game is released without breaking the saved games
