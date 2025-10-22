# Clickpulp AGS Modules Documentation

*Welcome! These modules are tools to make your Adventure Game Studio game more modern and player-friendly. They're free to use and designed to save you time.*

## Getting Started

**Important:** These modules work together like a team - some need others to work properly. Install them in the same order they appear in the example game's `Clickpulp` folder to avoid issues.

**Optional Setup:** If you want to use the input handling features, you can tell the modules which menus you're using. Add this to your `game_start` function:

```c
void game_start() {
  pulpGlobals.MainMenuGUI = gYourMainMenu;
  pulpGlobals.InventoryGUI = gYourInventory;
  pulpGlobals.OverlayGUI = gYourOverlay;
  pulpGlobals.TooltipFont = eFontForTooltip;
}
```

## ⚠️ CRITICAL: Required Object Properties Setup

**WARNING: These properties MUST be defined in your AGS project BEFORE using the modules, or your game will crash!**

Some modules use custom properties on your game objects. You must add these property definitions to your AGS project first:

1. **Open your AGS Editor**
2. **Go to the Properties section** (usually in the project tree)
3. **Add these custom properties:**

**For Hotspots and Objects (required by `Pulp_RoomIndex`):**

* `Exit` (int) - Set to room number for exits, or any non-zero value to mark as an exit
* `IsDoor` (bool) - Mark hotspots/objects as doors for special handling
* `IsSign` (bool) - Mark hotspots/objects as signs for special handling

**For Hotspots and Objects (required by `Pulp_HintsHighlighter`):**

* `HintX` (int) - Custom X position for hint display (optional - uses object center if not set)
* `HintY` (int) - Custom Y position for hint display (optional - uses object center if not set)

**For Inventory Items (required by `Pulp_InputHandling`):**

* `InstantUse` (bool) - Mark items that are automatically consumed and shouldn't be selectable in inventory scrolling

**Important:** Even if you don't plan to use these features initially, you should add the properties to avoid crashes if you enable the modules later.

## What These Modules Do For Your Game

### Essential Foundation

* [`PulpGlobals`](./pulpglobals.md) - Shared settings that help all modules work together, plus debug logging utilities
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

## AI Assistance Disclosure

The development and documentation of these AGS modules has has used Large Language Models (LLMs) in the following areas:

* **Research**: Exploring game develoment algorithms, math formulas, and best practices
* **Algorithmic Implementation**: Designing and implementing complex game systems, input handling logic, and optimization algorithms
* **Code Cleanup**: Improving code structure, consistency, and maintainability across all modules
* **Documentation Generation**: Creating comprehensive user guides, API documentation, and setup instructions

All LLM-generated content has been thoroughly reviewed, tested, and validated by an experienced AGS developer to ensure accuracy, functionality, and adherence to conventions.
