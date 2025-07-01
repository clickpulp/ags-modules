# Clickpulp AGS Modules Documentation

*Welcome! These modules are tools to make your Adventure Game Studio game more modern and player-friendly. They're free to use and designed to save you time.*

## Getting Started

**Important:** These modules work together like a team - some need others to work properly. Install them in the same order they appear in the example game's `Clickpulp` folder to avoid issues.

**Optional Setup:** If you want to use the input handling features, you can tell the modules which menus you're using. Add this to your `game_start` function:

```agsscript
void game_start() {
  pulpGlobals.MainMenuGUI = gYourMainMenu;
  pulpGlobals.InventoryGUI = gYourInventory;
  pulpGlobals.OverlayGUI = gYourOverlay;
  pulpGlobals.TooltipFont = eFontForTooltip;
}
```

## What These Modules Do For Your Game

### Essential Foundation

* `PulpGlobals` - Shared settings that help all modules work together
* [`Pulp_Signal`](./signal.md) - Lets different parts of your game talk to each other easily
* [`Pulp_Extenders`](./extenders.md) - Adds useful new abilities to AGS objects (like better mouse handling)
* [`Pulp_Rect`](./rect.md) - Tools for working with rectangular areas (collision detection, UI layout)
* [`Pulp_IsInBlockingScript`](./isinblockingscript.md) - Tells you when the game is busy (during cutscenes, etc.)

### Modern Controls & Input

* [`Pulp_Input`](./input.md) - Let players use keyboard, mouse, or gamepad for the same actions
* [`Pulp_InputMappings`](./inputmappings.md) - Pre-made control schemes that work with all input types
* [`Pulp_InputHandling`](./inputhandling.md) - Automatically handles player input in different game situations
* [`Pulp_PlayerDirectControl`](./playerdirectcontrol.md) - Let players move the character with arrow keys (like modern games)
* [`Pulp_Cursor`](./cursor.md) - Smart cursor that works with keyboard and gamepad, not just mouse

### Better Menus & Interface

* [`Pulp_GUIStack`](./guistack.md) - Makes nested menus work smoothly (like Options → Video → Resolution)
* [`Pulp_Tooltip`](./tooltip.md) - Easy way to show helpful text when hovering over things

### Smoother Cutscenes

* [`Pulp_CutsceneHelpers`](./cutscenehelpers.md) - Makes cutscenes skip faster and more reliably

### Smart Room Features

* [`Pulp_RoomIndex`](./roomindex.md) - Automatically finds all the clickable things in each room
* [`Pulp_RoomMarkers`](./roommarkers.md) - Places visual indicators in rooms (like highlighting important objects)
* [`Pulp_HintsHighlighter`](./hintshighlighter.md) - Shows players what they can interact with (great for accessibility)

### Intelligent Movement

* [`Pulp_PlayerCollision`](./playercollision.md) - Automatically highlights objects when the player gets close (perfect for keyboard/gamepad users)

### Post-Release Support

* [`Pulp_PatchValues`](./patchvalues.md) - Change game settings after release without breaking saved games
