# Clickpulp Hints Highlighter Module

## About

When players press a designated key, this module highlights all interactive objects in the current room, making it easier to find hotspots, characters, and objects they can interact with. This is especially useful for adventure games where players might miss interactive elements.

## Dependencies

This module uses functionality from other modules:

### Required

* `Pulp_RoomIndex` - For indexing interactive objects in the room
* `Pulp_RoomMarkers` - For drawing the highlight overlays

### Optional  

* `Pulp_Input` - For input handling (hints button)

## Usage

### Basic Setup

```agscript
function game_start() {
  // Calculate hints for the starting room
  HintsHighlighter.CalculateHintsForRoom();
  
  // Enable the hints system
  HintsHighlighter.EnableHints();
}

function on_event(EventType event, int data) {
  if (event == eEventEnterRoomBeforeFadein) {
    // Recalculate hints when entering a new room
    HintsHighlighter.CalculateHintsForRoom();
  }
}
```

### Showing/Hiding Hints

```agscript
// In your input handling (e.g., repeatedly_execute)
if (inputHintsButton.IsPressed(eNoRepeat)) {
  if (HintsHighlighter.IsShowingHints()) {
    HintsHighlighter.HideHints();
  } else {
    HintsHighlighter.DisplayHints();
  }
}

// Or just display hints while key is held
if (inputHintsButton.IsPressed()) {
  HintsHighlighter.DisplayHints();
} else {
  HintsHighlighter.HideHints();
}
```

### Enable/Disable System

```agscript
// Disable hints during cutscenes
function StartCutscene() {
  HintsHighlighter.DisableHints();
}

function EndCutsceneExt() {
  HintsHighlighter.EnableHints();
}
```

### Custom Hint Points

You can customize where hints appear for specific objects:

```agscript
// In room script - customize hint position for a character
function room_RepExec() {
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
4. **Input feedback**: Provide clear indication of which key shows hints
5. **Visual design**: Ensure hint markers are visible but not intrusive

## Integration Example

```agscript
// Complete integration example
function game_start() {
  // Set up hints input
  inputHintsButton.AddKey(eKeyTab);
  inputHintsButton.AddKey(eKeyH);
  inputHintsButton.AddControllerButton(eControllerRightShoulder);
  
  // Initialize hints system
  HintsHighlighter.EnableHints();
  HintsHighlighter.CalculateHintsForRoom();
}

function repeatedly_execute() {
  // Toggle hints on key press
  if (inputHintsButton.IsPressed(eNoRepeat)) {
    if (HintsHighlighter.IsShowingHints()) {
      HintsHighlighter.HideHints();
    } else {
      HintsHighlighter.DisplayHints();
    }
  }
}

function on_event(EventType event, int data) {
  if (event == eEventEnterRoomBeforeFadein) {
    HintsHighlighter.CalculateHintsForRoom();
  }
}
```
