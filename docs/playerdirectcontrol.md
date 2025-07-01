# Clickpulp Player Direct Control Module

## About

Let players move the character with arrow keys or a gamepad instead of clicking everywhere! This makes your adventure game feel more like modern games where you can just walk around directly.

**Why players love this:**

* Feels natural for players used to modern games
* Great for people who prefer keyboards or gamepads over mouse
* Still uses AGS pathfinding, so characters walk around obstacles properly
* Can be turned on/off, so you can offer both control styles

## Dependencies

This module works with the input system and requires:

### Required

* [`Pulp_Input`](input.md) - For input mapping and handling
* [`Pulp_InputMappings`](inputmappings.md) - For pre-configured movement controls
* `Tween` - For math utilities

## Usage

### Enabling Direct Control

```c
// Enable direct control in game_start() or when needed
PlayerDirectControl.Enabled = true;

// Disable direct control (return to point-and-click)
PlayerDirectControl.Enabled = false;
```

### Checking Control State

```c
// Check if direct control is currently enabled
if (PlayerDirectControl.Enabled) {
  // Player is using keyboard/gamepad controls
  lblControlPrompt.Text = "Use arrow keys to move";
} else {
  // Player is using point-and-click
  lblControlPrompt.Text = "Click to move";
}
```

### Integration with Input System

The module automatically uses the input mappings from [`Pulp_InputMappings`](inputmappings.md):

* `inputUp` - Move character up
* `inputDown` - Move character down  
* `inputLeft` - Move character left
* `inputRight` - Move character right

### Example Setup

```c
function game_start() {
  // Set up input mappings (if using Pulp_InputMappings)
  inputUp.AddKey(eKeyUpArrow);
  inputUp.AddKey(eKeyW);
  inputUp.AddControllerAxis(eInputMappingAxisLeftUp);
  
  inputDown.AddKey(eKeyDownArrow);
  inputDown.AddKey(eKeyS);
  inputDown.AddControllerAxis(eInputMappingAxisLeftDown);
  
  inputLeft.AddKey(eKeyLeftArrow);
  inputLeft.AddKey(eKeyA);
  inputLeft.AddControllerAxis(eInputMappingAxisLeftLeft);
  
  inputRight.AddKey(eKeyRightArrow);
  inputRight.AddKey(eKeyD);
  inputRight.AddControllerAxis(eInputMappingAxisLeftRight);
  
  // Enable direct control
  PlayerDirectControl.Enabled = true;
}
```

## API

### PlayerDirectControl Struct

* `PlayerDirectControl.Enabled` - Get/set whether direct control is enabled

## Features

* **Pathfinding integration**: Uses AGS pathfinding so the character navigates around obstacles
* **Smooth movement**: Supports both digital (keyboard) and analog (gamepad) input
* **Automatic character direction**: Character sprite faces the direction of movement
* **Compatible with existing code**: Can be toggled on/off without breaking point-and-click functionality

## Best Practices

1. **Clear UI feedback**: Show players which control method is active
2. **Toggle appropriately**: Disable during cutscenes or dialogue
3. **Test both modes**: Ensure your game works with both direct control and point-and-click
4. **Configure input mappings**: Set up comfortable key bindings for your players
