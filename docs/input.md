# Clickpulp Input Module

## About

This module lets you create controls that work with any input device - keyboard, mouse, or gamepad. Instead of saying "Press Space to jump," you can say "Press the Jump button" and let players use whatever they prefer: Space bar, mouse click, or gamepad A button.

**Why this is helpful:** Modern players expect games to work with their preferred input method. Some use keyboards, others prefer gamepads, and some have accessibility needs requiring specific inputs.

## Dependencies

### Required

* `Tween` - For math utilities

### Optional

* `Pulp_InputMappings` - Provides pre-configured input mappings
* `Pulp_InputHandling` - Handles the actual input processing

## What This Does For Your Players

* **Any input works**: One action (like "jump") can respond to multiple buttons - Space bar, gamepad A button, and mouse click all work
* **All controllers supported**: Works automatically with Xbox, PlayStation, Nintendo, and Steam Deck controllers
* **Smooth analog movement**: Gamepad sticks and triggers work naturally with sensitivity settings
* **Smart button handling**: Choose whether holding a button repeats the action or just triggers once

## Usage

### Setting Up Controls

Here's how to create a "Jump" action that works with any input device:

```agscript
// Create a new action called "jump"
InputMapping* jumpInput = new InputMapping;

// Let players use any of these to jump:
jumpInput.AddKey(eKeySpace);           // Space bar on keyboard
jumpInput.AddMouseButton(eMouseLeft);  // Left click with mouse
jumpInput.AddControllerButton(eControllerA); // A button on gamepad

// Turn on this control setup
jumpInput.Enabled = true;
```

### Using the Controls in Your Game

```agscript
// Check if the player wants to jump (works with any input they mapped):
if (jumpInput.IsPressed()) {
  // Player pressed their jump button!
  player.Jump();
}

// For actions that should only happen once per press:
if (jumpInput.IsPressed(eNoRepeat)) {
  // This only triggers once, even if they hold the button down
}
```

### Controller Support

```agscript
// Check if controller is connected
if (Input.ControllerConnected) {
  // Adjust UI based on controller type
  if (Input.ControllerType == eControllerTypeXbox) {
    lblButtonPrompt.Text = "Press A to continue";
  } else if (Input.ControllerType == eControllerTypePlayStation) {
    lblButtonPrompt.Text = "Press X to continue";
  }
}
```

### Axis Input (Analog Sticks)

```agscript
InputMapping* moveLeftInput = new InputMapping;
InputMapping* moveRightInput = new InputMapping;

// Map to keyboard and controller
moveLeftInput.AddKey(eKeyLeftArrow);
moveLeftInput.AddControllerAxis(eInputMappingAxisLeftLeft);

moveRightInput.AddKey(eKeyRightArrow);  
moveRightInput.AddControllerAxis(eInputMappingAxisLeftRight);

// Use AxisTracker for smooth movement
AxisTracker horizontalAxis;
horizontalAxis.Update(moveLeftInput, moveRightInput);

if (horizontalAxis.IsMoving()) {
  int moveAmount = horizontalAxis.Value; // -100 to 100
  player.x += moveAmount / 10;
}
```

## API

### InputMapping Struct

* `AddMapping(InputMappingType type, int value)` - Add a generic mapping
* `AddKey(eKeyCode keyCode)` - Map to a keyboard key
* `AddMouseButton(MouseButton mouseButton)` - Map to a mouse button
* `AddControllerButton(ControllerButton button)` - Map to a controller button
* `AddControllerAxis(InputMappingAxisDirection axisDirection)` - Map to controller axis
* `AddControllerPOV(ControllerPOV pov)` - Map to controller D-pad
* `IsPressed(RepeatStyle style)` - Check if input is pressed
* `GetMappedKey()` - Get the mapped keyboard key
* `GetAxis()` - Get axis value for analog inputs
* `Delete()` - Clean up the mapping

### Input Struct

* `Input.ControllerConnected` - Whether a controller is connected
* `Input.ControllerType` - Type of connected controller

### AxisTracker Struct

* `Update(InputMapping* negativeInput, InputMapping* positiveInput)` - Update axis state
* `IsMoving(RepeatStyle repeat)` - Check if axis is being moved
* `Value` - Current axis value (-100 to 100)
* `InDeadZone` - Whether the axis is in the deadzone
* `IsPressed` - Whether the axis is pressed beyond deadzone

## Input Types

### InputMappingType Enum

* `eInputMappingKey` - Keyboard key
* `eInputMappingMouseButton` - Mouse button
* `eInputMappingControllerButton` - Controller button
* `eInputMappingControllerAxis` - Controller analog stick/trigger
* `eInputMappingControllerPOV` - Controller D-pad

### InputControllerType Enum

* `eControllerTypeNone` - No controller
* `eControllerTypeXbox` - Xbox controller
* `eControllerTypePlayStation` - PlayStation controller
* `eControllerTypeNintendo` - Nintendo controller
* `eControllerTypeSteamDeck` - Steam Deck controller
* `eControllerTypeUnknown` - Unknown controller type

## Constants

* `MAX_INPUTS` (32) - Maximum number of input mappings
* `MAX_MAPPINGS_PER_INPUT` (8) - Maximum mappings per input action  
* `INPUT_AXIS_DEADZONE` (6554) - Deadzone threshold for analog inputs

## Best Practices

1. **Create mappings once**: Set up your input mappings in `game_start()` or a dedicated initialization function
2. **Check enabled state**: Always set `Enabled = true` on your mappings
3. **Handle controller disconnection**: Check `Input.ControllerConnected` regularly
4. **Use appropriate repeat styles**: Use `eNoRepeat` for actions that should only trigger once per press
5. **Clean up**: Call `Delete()` on mappings when no longer needed
