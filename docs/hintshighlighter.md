# Clickpulp Hints Highlighter Module

## About

Ever played an adventure game and spent ages clicking everywhere trying to find what you can interact with? This module solves that problem! When players press a button (like Tab or a gamepad button), it highlights everything they can click on in the room.

**Why your players will love this:**

* No more pixel hunting - they can see exactly what's interactive
* Great for accessibility - helps players with visual difficulties
* Makes your game feel modern and player-friendly
* Reduces frustration when players get stuck

## Dependencies

This module uses functionality from other modules:

### Required

* [`Pulp_RoomIndex`](roomindex.md) - For indexing interactive objects in the room
* [`Pulp_RoomMarkers`](roommarkers.md) - For drawing the highlight overlays
* `Tween` - For math utilities and fade animations

### Optional  

* [`Pulp_Input`](input.md) - For input handling (hints button)

## ⚠️ CRITICAL: Required Object Properties Setup

**WARNING: You MUST define these properties in your AGS project BEFORE using this module, or your game will crash!**

This module reads custom properties from your hotspots and objects to customize hint positioning. Follow these steps:

1. **In AGS Editor, go to the Properties section**
2. **Add these custom properties for both Hotspots and Objects:**

**Hint Position Properties:**

* `HintX` (int) - Custom X position for hint display (if not set, uses object center)
* `HintY` (int) - Custom Y position for hint display (if not set, uses object center)

**Important Notes:**

* These properties must exist in your project even if you don't plan to set custom positions
* The module will crash when it tries to read undefined properties
* If these properties are not set (value = 0 or 1), the module automatically calculates the hint position
* **Boundary validation**: Hint points outside room boundaries (negative or beyond room width/height) are automatically skipped to prevent crashes
* **Character positioning**: For characters and talk interactions, hints appear at 1/3 height (chest level) instead of center for better visual appearance

## Usage

### Basic Setup

```c
void game_start() {
  // Calculate hints for the starting room
  HintsHighlighter.CalculateHintsForRoom();
  
  // Enable the hints system
  HintsHighlighter.EnableHints();
}

void on_event(EventType event, int data) {
  if (event == eEventEnterRoomBeforeFadein) {
    // Recalculate hints when entering a new room
    HintsHighlighter.CalculateHintsForRoom();
  }
}
```

### Showing/Hiding Hints

**Important:** The module now uses signals to avoid conflicts with input mappings. Dispatch the `"toggle_hints"` signal instead of checking input directly:

```c
// In your input handling (e.g., in Pulp_InputHandling or custom code)
void repeatedly_execute() {
  // Check for hints button press
  if (inputHintsButton.IsPressed(eOnce)) {
    Signal.Dispatch("toggle_hints");
  }
}

// The module automatically handles the signal
// No need to call DisplayHints() or HideHints() directly
```

You can also toggle hints programmatically:

```c
// Manually show/hide hints
if (HintsHighlighter.IsShowingHints()) {
  HintsHighlighter.HideHints();
} else {
  HintsHighlighter.DisplayHints();
}

// Or use the signal for consistency
Signal.Dispatch("toggle_hints");
```

### Enable/Disable System

```c
// Disable hints during cutscenes
void StartCutscene() {
  HintsHighlighter.DisableHints();
}

void EndCutsceneExt() {
  HintsHighlighter.EnableHints();
}
```

### Custom Hint Points

You can customize where hints appear for specific objects:

```c
// In room script - customize hint position for a character
void room_RepExec() {
  // This would be implemented in your room script
  // The module provides GetHintPoint() extensions for objects
}
```

## API

### HintsHighlighter Struct

* `CalculateHintsForRoom()` - Recalculate hint overlay for current room (expensive operation)
* `DisplayHints()` - Show the hints overlay
* `HideHints()` - Hide the hints overlay  
* `EnableHints()` - Enable the hints system
* `DisableHints()` - Disable hints (DisplayHints() will do nothing)
* `IsShowingHints()` - Check if hints are currently displayed

### Object Extensions

* `GetHintPoint(this Hotspot*)` - Get hint position for hotspot
* `GetHintPoint(this Character*)` - Get hint position for character
* `GetHintPoint(this Object*)` - Get hint position for object

## Performance Notes

* **CalculateHintsForRoom() is expensive**: Only call when entering a room or when interactive objects change
* **Don't call every frame**: The calculation involves analyzing all room objects and should not be done repeatedly
* **Cache the results**: The overlay is pre-calculated and cached for performance

## Best Practices

1. **Room transitions**: Always recalculate hints when entering a new room
2. **Dynamic objects**: Recalculate if objects are added/removed during gameplay
3. **Cutscene management**: Disable hints during cutscenes and dialogue
4. **Use signals**: Dispatch `"toggle_hints"` signal instead of checking input directly to avoid conflicts
5. **Visual design**: Ensure hint markers are visible but not intrusive
6. **Hint positioning**: For character interactions, the module automatically positions hints at chest level (1/3 height)
7. **Boundary safety**: The module automatically skips invalid hint points outside room boundaries

## Integration Example

```c
// Complete integration example with signal-based toggling
void game_start() {
  // Set up hints input
  inputHintsButton.AddKey(eKeyTab);
  inputHintsButton.AddKey(eKeyH);
  inputHintsButton.AddControllerButton(eControllerRightShoulder);

  // Initialize hints system
  HintsHighlighter.EnableHints();
  HintsHighlighter.CalculateHintsForRoom();
}

void repeatedly_execute() {
  // Dispatch signal when hints button is pressed
  // The module automatically handles the toggle
  if (inputHintsButton.IsPressed(eOnce)) {
    Signal.Dispatch("toggle_hints");
  }

  // Or handle the signal yourself for custom behavior
  if (Signal.WasDispatched("toggle_hints")) {
    if (HintsHighlighter.IsShowingHints()) {
      HintsHighlighter.HideHints();
      Display("Hints hidden");
    } else {
      HintsHighlighter.DisplayHints();
      Display("Hints shown");
    }
  }
}

void on_event(EventType event, int data) {
  if (event == eEventEnterRoomBeforeFadein) {
    HintsHighlighter.CalculateHintsForRoom();
  }
}
```

## Advanced Features

### Automatic Boundary Validation

The module automatically validates hint positions to prevent crashes:

```c
// If you set a custom hint point outside the room, it will be skipped
// For example, if room is 320x200 and you set HintX = 400, HintY = 250
// The module will detect this and not draw that hint

// This is especially useful for:
// - Objects that are partially off-screen
// - Dynamic hint positions that might go out of bounds
// - Edge cases in room design
```

### Character-Specific Positioning

For better visual appearance, character hints and talk interactions are positioned differently:

```c
// Regular objects: hint at vertical center
// Characters and talk interactions: hint at 1/3 height (chest level)

// This makes character interaction hints appear more natural
// without any extra configuration needed
```
