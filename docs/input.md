# Clickpulp Input Module

## About

This module lets you create controls that work with any input device - keyboard, mouse, or gamepad. Instead of saying "Press Space to jump," you can say "Press the Jump button" and let players use whatever they prefer: Space bar, mouse click, or gamepad A button. The module includes automatic controller detection, intelligent axis handling, and signal dispatching for controller events.

**Why this is helpful:** Modern players expect games to work with their preferred input method. Some use keyboards, others prefer gamepads, and some have accessibility needs requiring specific inputs.

## Dependencies

### Required

* `Tween` - For math utilities
* [`Pulp_Signal`](signal.md) - For controller connection events

### Optional

* [`Pulp_InputMappings`](inputmappings.md) - Provides pre-configured input mappings
* [`Pulp_InputHandling`](inputhandling.md) - Handles the actual input processing

## What This Does For Your Players

* **Any input works**: One action (like "jump") can respond to multiple buttons - Space bar, gamepad A button, and mouse click all work
* **All controllers supported**: Automatically detects Xbox, PlayStation, Nintendo, and Steam Deck controllers
* **Smart controller detection**: Automatically connects and disconnects controllers with event notifications
* **Smooth analog movement**: Gamepad sticks and triggers work naturally with proper deadzone handling
* **Smart button handling**: Choose whether holding a button repeats the action or just triggers once
* **Modifier key protection**: Prevents accidental input when modifier keys (Ctrl, Alt) are pressed

## Usage

### Setting Up Controls

Here's how to create a "Jump" action that works with any input device:

```c
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

```c
// Check if the player wants to jump (works with any input they mapped):
if (jumpInput.IsPressed()) {
  // Player pressed their jump button!
  player.Jump();
}

// For actions that should only happen once per press:
if (jumpInput.IsPressed(eOnce)) {
  // This only triggers once, even if they hold the button down
}
```

### Controller Support and Detection

```c
// Check if controller is connected
if (Input.ControllerConnected) {
  // Adjust UI based on controller type
  if (Input.ControllerType == eControllerTypeXbox) {
    lblButtonPrompt.Text = "Press A to continue";
  } 
  else if (Input.ControllerType == eControllerTypePlayStation) {
    lblButtonPrompt.Text = "Press X to continue";
  } 
  else if (Input.ControllerType == eControllerTypeNintendo) {
    lblButtonPrompt.Text = "Press B to continue";
  }
}

// Listen for controller connection events
void repeatedly_execute() {
  if (Signal.WasDispatched("controller_connected")) {
    Display("Controller connected!");
    UpdateUIForController();
  }
  else if (Signal.WasDispatched("controller_disconnected")) {
    Display("Controller disconnected!");
    UpdateUIForKeyboard();
  }
}
```

### Enhanced Axis Input (Analog Sticks)

```c
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
  int moveAmount = horizontalAxis.Value; // Raw axis value
  if (!horizontalAxis.InDeadZone) {
    player.x += moveAmount / 1000; // Scale as needed
  }
}

// Check for one-time axis movement
if (horizontalAxis.IsMoving(eOnce)) {
  // Only triggers once per axis movement
}
```

### Advanced Axis Handling

```c
// Get raw axis values for custom processing
InputMapping* triggerInput = new InputMapping;
triggerInput.AddControllerAxis(eInputMappingAxisTriggerRight);

// Get raw axis value (includes deadzone handling)
int triggerValue = triggerInput.GetAxis();
if (triggerValue > 0) {
  // Process trigger input (0 to CONTROLLER_AXIS_RANGE_MAX)
  float triggerPercent = IntToFloat(triggerValue) / IntToFloat(CONTROLLER_AXIS_RANGE_MAX);
  ProcessTriggerInput(triggerPercent);
}
```

## API

### InputMapping Struct

#### Core Methods

* `AddMapping(InputMappingType type, int value)` - Add a generic mapping
* `AddKey(eKeyCode keyCode)` - Map to a keyboard key
* `AddMouseButton(MouseButton mouseButton)` - Map to a mouse button
* `AddControllerButton(ControllerButton button)` - Map to a controller button
* `AddControllerAxis(InputMappingAxisDirection axisDirection)` - Map to controller axis
* `AddControllerPOV(ControllerPOV pov)` - Map to controller D-pad

#### Input Checking

* `IsPressed(RepeatStyle style)` - Check if input is pressed
* `GetMappedKey()` - Get the mapped keyboard key
* `GetAxis()` - Get raw axis value for analog inputs
* `Update()` - Update input state (called automatically)

#### Management

* `Delete()` - Clean up the mapping

#### Properties

* `Enabled` - Whether this mapping is active
* `HasAxisMapping` - Whether this mapping includes axis input
* `MappedKeyPressed` - Whether the mapped key is currently pressed (ignores modifiers)

### Input Struct

* `Input.ControllerConnected` - Whether a controller is connected
* `Input.ControllerType` - Type of connected controller (see InputControllerType enum)

### AxisTracker Struct

#### Methods

* `Update(InputMapping* negativeInput, InputMapping* positiveInput)` - Update axis state
* `IsMoving(RepeatStyle repeat)` - Check if axis is being moved

#### Properties

* `Value` - Current combined axis value
* `InDeadZone` - Whether the axis is in the deadzone
* `IsPressed` - Whether either input is pressed
* `IsMovingByAxis` - Whether movement is from analog input (not digital)

## Input Types

### InputMappingType Enum

* `eInputMappingKey` - Keyboard key
* `eInputMappingMouseButton` - Mouse button
* `eInputMappingControllerButton` - Controller button
* `eInputMappingControllerAxis` - Controller analog stick/trigger
* `eInputMappingControllerPOV` - Controller D-pad

### InputControllerType Enum

* `eControllerTypeNone` - No controller
* `eControllerTypeXbox` - Xbox controller (starts with "Xbox")
* `eControllerTypePlayStation` - PlayStation controller (starts with "PS" or "DualSense")
* `eControllerTypeNintendo` - Nintendo controller (starts with "Nintendo")
* `eControllerTypeUnknown` - Unknown/unrecognized controller type

### InputMappingAxisDirection Enum

* `eInputMappingAxisLeftUp` / `eInputMappingAxisLeftDown` - Left stick vertical
* `eInputMappingAxisLeftLeft` / `eInputMappingAxisLeftRight` - Left stick horizontal
* `eInputMappingAxisRightUp` / `eInputMappingAxisRightDown` - Right stick vertical
* `eInputMappingAxisRightLeft` / `eInputMappingAxisRightRight` - Right stick horizontal
* `eInputMappingAxisTriggerLeft` / `eInputMappingAxisTriggerRight` - Triggers

### RepeatStyle Enum

* `eRepeat` - Default, allows continuous input while held
* `eOnce` - Only triggers once per press, prevents repeat

## Constants

* `MAX_INPUTS` (32) - Maximum number of input mappings
* `MAX_MAPPINGS_PER_INPUT` (8) - Maximum mappings per input action  
* `INPUT_AXIS_DEADZONE` (6554) - Deadzone threshold for analog inputs (20% of max range)
* `CONTROLLER_AXIS_RANGE_MAX` / `CONTROLLER_AXIS_RANGE_MIN` - Controller axis value ranges

## Signal Events

The module dispatches these signals automatically:

* `"controller_connected"` - When a controller is plugged in
* `"controller_disconnected"` - When a controller is unplugged

```c
void repeatedly_execute() {
  if (Signal.WasDispatched("controller_connected")) {
    // Update UI, enable controller-specific features
    SetupControllerUI();
  }
  else if (Signal.WasDispatched("controller_disconnected")) {
    // Fall back to keyboard/mouse UI
    SetupKeyboardUI();
  }
}
```

## Advanced Features

### Modifier Key Protection

The module automatically prevents input when modifier keys are pressed:

```c
// This won't trigger if Ctrl+Space is pressed (prevents conflicts with shortcuts)
if (jumpInput.IsPressed()) {
  // Only triggers for Space alone, not Ctrl+Space
}

// But you can still check if the key itself is pressed
if (jumpInput.MappedKeyPressed) {
  // This will be true even with modifiers
}
```

### Raw Axis Values

```c
InputMapping* stickInput = new InputMapping;
stickInput.AddControllerAxis(eInputMappingAxisLeftRight);

// Get the raw axis value (before deadzone processing)
int rawValue = stickInput.GetAxis();

// The axis tracker applies deadzone automatically
AxisTracker horizontalAxis;
horizontalAxis.Update(moveLeft, moveRight);
// horizontalAxis.Value has deadzone applied
// horizontalAxis.InDeadZone tells you if it's in deadzone
```

### Controller Information

```c
void LogControllerInfo() {
  if (Input.ControllerConnected) {
    String controllerName = _controller0.GetName(); // Internal access
    int buttonCount = _controller0.ButtonCount;
    
    Display.WriteLine("Controller: %s (%d buttons)", controllerName, buttonCount);
    Display.WriteLine("Type: %d", Input.ControllerType);
  }
}
```

## Best Practices

1. **Create mappings once**: Set up your input mappings in `game_start()` or a dedicated initialization function
2. **Check enabled state**: Always set `Enabled = true` on your mappings
3. **Handle controller events**: Listen for connection/disconnection signals to update UI
4. **Use appropriate repeat styles**: Use `eOnce` for actions that should only trigger once per press
5. **Respect deadzone**: Use AxisTracker for analog input to get proper deadzone handling
6. **Clean up**: Call `Delete()` on mappings when no longer needed
7. **Check axis properties**: Use `InDeadZone` and `IsMovingByAxis` for better analog handling
8. **Test controller types**: Different controllers may need different UI prompts

## Integration Examples

### Complete Input Setup

```c
InputMapping* jumpInput;
InputMapping* moveLeftInput;
InputMapping* moveRightInput;
AxisTracker horizontalMovement;

void game_start() {
  // Set up jump input
  jumpInput = new InputMapping;
  jumpInput.AddKey(eKeySpace);
  jumpInput.AddControllerButton(eControllerA);
  jumpInput.Enabled = true;
  
  // Set up movement
  moveLeftInput = new InputMapping;
  moveLeftInput.AddKey(eKeyLeftArrow);
  moveLeftInput.AddControllerAxis(eInputMappingAxisLeftLeft);
  moveLeftInput.Enabled = true;
  
  moveRightInput = new InputMapping;
  moveRightInput.AddKey(eKeyRightArrow);
  moveRightInput.AddControllerAxis(eInputMappingAxisLeftRight);
  moveRightInput.Enabled = true;
}

void repeatedly_execute() {
  // Handle jumping
  if (jumpInput.IsPressed(eOnce)) {
    player.Jump();
  }
  
  // Handle movement
  horizontalMovement.Update(moveLeftInput, moveRightInput);
  if (horizontalMovement.IsMoving()) {
    if (!horizontalMovement.InDeadZone) {
      player.x += horizontalMovement.Value / 1000;
    }
  }
}
```
