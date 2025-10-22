# Clickpulp PulpGlobals Module

## About

PulpGlobals is the foundation module that provides shared configuration and utilities used by all other Clickpulp modules. It acts as a central configuration point and provides essential debugging utilities.

**Why this module exists:**

* Provides a single place to configure global settings like which GUIs are used for menus and inventory
* Offers debugging utilities that work consistently across all modules
* Prevents duplicate code across modules

## Dependencies

### Required

None - this is the foundation module that other modules depend on.

## What This Provides

* **Global configuration** - Central settings for main menu, inventory, and overlay GUIs
* **Debug logging** - Enhanced logging with file output for debugging
* **Shared state** - Common data structure accessible to all modules

## Usage

### Basic Setup

The most important part of using Clickpulp modules is configuring PulpGlobals in your `game_start()` function:

```c
void game_start() {
  // Tell the modules which GUIs you're using
  pulpGlobals.MainMenuGUI = gMainMenu;
  pulpGlobals.InventoryGUI = gInventory;
  pulpGlobals.OverlayGUI = gOverlay;
  pulpGlobals.TooltipFont = eFontTooltip;
}
```

### Debug Logging

The module provides an enhanced logging function that writes to both the AGS log and a file:

```c
// Basic logging
PulpLog(eLogInfo, "Player entered room 5");
PulpLog(eLogDebug, "Cursor speed changed to 50");
PulpLog(eLogWarn, "Controller disconnected unexpectedly");
PulpLog(eLogError, "Failed to load save game");

// Formatted logging with String.Format
PulpLog(eLogDebug, String.Format("Player position: %d, %d", player.x, player.y));
PulpLog(eLogInfo, String.Format("Picked up item: %s", inventory[0].Name));
```

## API Reference

### PulpGlobals Struct

#### Properties

* `MainMenuGUI` - Reference to your main menu GUI
* `InventoryGUI` - Reference to your inventory GUI
* `OverlayGUI` - Reference to any overlay GUI used for screen effects
* `TooltipFont` - Font to use for tooltips

### Global Functions

* `PulpLog(LogLevel level, const string message)` - Enhanced logging with file output

## Debug Logging Details

### Log File Location

When running in DEBUG mode on Windows, logs are written to:
```
$SAVEGAMEDIR$/pulp-<timestamp>.log
```

Where `<timestamp>` is the raw time value when the game started, ensuring each play session gets its own log file.

### Log Format

Each log entry includes:
* Room number where the log was generated
* The log message you provided

Example log file contents:
```
[Room 1] Player entered room 5
[Room 5] Cursor speed changed to 50
[Room 5] Player position: 100, 200
```

### When Logs Are Written

* **All platforms**: Messages are always sent to AGS's standard logging system
* **Windows + DEBUG mode**: Messages are also written to the log file
* **Other platforms or Release builds**: Only standard AGS logging is used

### Best Practices for Logging

```c
// Good: Informative messages with context
PulpLog(eLogDebug, String.Format("[Cursor] Set speed to %d", newSpeed));
PulpLog(eLogInfo, String.Format("[Input] Controller connected: %s", controllerName));

// Good: Use appropriate log levels
PulpLog(eLogError, "Critical failure in GUI stack"); // Errors
PulpLog(eLogWarn, "Unexpected controller disconnect"); // Warnings
PulpLog(eLogInfo, "Player completed puzzle"); // Important info
PulpLog(eLogDebug, "Mouse moved to 100, 200"); // Detailed debugging

// Avoid: Logging in tight loops (performance impact)
void repeatedly_execute() {
  // Don't do this - logs every frame!
  // PulpLog(eLogDebug, "Frame update");

  // Do this instead - log only on state changes
  if (player.Room != previousRoom) {
    PulpLog(eLogInfo, String.Format("Room changed: %d -> %d", previousRoom, player.Room));
    previousRoom = player.Room;
  }
}
```

## Integration Example

```c
// Global variables for your game
GUI* gMainMenu;
GUI* gInventory;
GUI* gOverlay;

void game_start() {
  // Configure PulpGlobals first thing
  pulpGlobals.MainMenuGUI = gMainMenu;
  pulpGlobals.InventoryGUI = gInventory;
  pulpGlobals.OverlayGUI = gOverlay;
  pulpGlobals.TooltipFont = eFontNormal;

  // Now other modules can reference these settings
  PulpLog(eLogInfo, "Game started, modules initialized");
}

void room_AfterFadeIn() {
  PulpLog(eLogInfo, String.Format("Entered room %d: %s", player.Room, Game.GetRoomName(player.Room)));
}

void on_mouse_click(MouseButton button) {
  if (button == eMouseLeft) {
    PulpLog(eLogDebug, String.Format("Left click at %d, %d", mouse.x, mouse.y));
  }
}

void on_event(EventType event, int data) {
  if (event == eEventGotScore) {
    PulpLog(eLogInfo, String.Format("Score increased by %d (total: %d)", data, player.Score));
  }
  else if (event == eEventGUIMouseDown) {
    GUI* clickedGUI = gui[data];
    PulpLog(eLogDebug, String.Format("Clicked on GUI: %s", clickedGUI.ScriptName));
  }
}
```

## Module Configuration Reference

Different modules use PulpGlobals settings in different ways:

### Input Handling

Uses `MainMenuGUI` and `InventoryGUI` to determine game state and dispatch appropriate signals.

### GUI Stack

References these GUIs to manage the menu stack properly.

### Cursor

Uses GUI references to determine when to show/hide cursor and manage cursor locking.

### Tooltips

Uses `TooltipFont` for rendering tooltip text.

## Technical Notes

* The global `pulpGlobals` instance is automatically created and exported
* Log files are created with a timestamp from `game_start()` to avoid overwrites
* File logging only occurs in DEBUG builds on Windows to avoid performance impact in release builds
* The module initializes logging infrastructure in `game_start()`

## Best Practices

1. **Configure early**: Set all PulpGlobals properties in `game_start()` before other module initialization
2. **Be consistent**: Always use the same GUIs for the same purposes throughout your game
3. **Use appropriate log levels**: Reserve `eLogError` for actual errors, use `eLogDebug` for verbose info
4. **Include context in logs**: Prefix messages with module name or system (e.g., "[Cursor]", "[Input]")
5. **Avoid excessive logging**: Don't log in tight loops or every frame
6. **Check log files**: Review `pulp-*.log` files when debugging issues on Windows

## Troubleshooting

### GUI-related modules not working

Make sure you've set the GUI references in `game_start()`:
```c
pulpGlobals.MainMenuGUI = gMainMenu;
pulpGlobals.InventoryGUI = gInventory;
```

### Log files not being created

* Log files are only created in DEBUG mode on Windows
* Check that `#define DEBUG` is set in your project
* Verify the game has write access to `$SAVEGAMEDIR$`

### Can't find log files

Log files are created in AGS's save game directory:
* Windows: Usually in `%USERPROFILE%\Saved Games\<YourGameName>\`
* Files are named `pulp-<timestamp>.log`
