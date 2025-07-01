# Clickpulp Input Module

## About

The Input module provides a flexible input mapping system that allows you to map game actions to multiple input sources (keyboard, mouse, and gamepad). Instead of checking for specific keys or buttons throughout your game, you can define generic input actions and map them to various input sources.

## Dependencies

This module does not depend on other modules, but it works best with:

### Optional

* `Pulp_InputMappings` - Provides pre-configured input mappings
* `Pulp_InputHandling` - Handles the actual input processing

## Key Features

* **Multi-input mapping**: Map a single action to multiple input sources (e.g., "jump" can be mapped to Space key, gamepad A button, and mouse click)
* **Controller support**: Supports Xbox, PlayStation, Nintendo, and Steam Deck controllers with automatic detection
* **Axis support**: Handle analog stick and trigger inputs with deadzone support
* **Input repetition**: Control whether inputs repeat when held down

## Usage

### Creating Input Mappings

```agscript
// Create an input mapping for jumping
InputMapping* jumpInput = new InputMapping;

// Add multiple input sources for the same action
jumpInput.AddKey(eKeySpace);           // Spacebar
jumpInput.AddMouseButton(eMouseLeft);  // Left mouse button
jumpInput.AddControllerButton(eControllerA); // A button on controller

// Enable the mapping
jumpInput.Enabled = true;
```

### Checking for Input

```agscript
// In your repeatedly_execute or input handling code:
if (jumpInput.IsPressed()) {
  // Player pressed jump!
  player.Jump();
}

// Check for single press (no repeat)
if (jumpInput.IsPressed(eNoRepeat)) {
  // Only triggers once per press
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
