# Clickpulp Input Mappings Module

## About

Ready-made control setups so you don't have to wire up all the buttons yourself! This gives you standard controls (like movement, action buttons, menu navigation) that already work with keyboard, mouse, and gamepad.

**Time saver:** Instead of spending time setting up "W/A/S/D + arrow keys + gamepad stick = movement", you just get working controls immediately.

## Dependencies

This module requires:

### Required

* [`Pulp_Input`](input.md) - Provides the InputMapping and AxisTracker structs

## Pre-configured Input Mappings

This module exports the following input mappings that are ready to use:

### Directional Input

* `inputUp` - Move/navigate up
* `inputDown` - Move/navigate down  
* `inputLeft` - Move/navigate left
* `inputRight` - Move/navigate right

### Action Buttons

* `inputPrimaryButton` - Primary action (usually interact/confirm)
* `inputSecondaryButton` - Secondary action (usually cancel/back)
* `inputInvButton` - Inventory access
* `inputExamineButton` - Examine/look at objects
* `inputSkipOrPauseButton` - Skip cutscenes or pause game
* `inputHintsButton` - Show interaction hints

### Page Navigation

* `inputPrevPage` - Previous page/menu
* `inputNextPage` - Next page/menu

## Pre-configured Axis Trackers

For smooth analog movement and cursor control:

* `axisLeftHorizontal` - Left stick horizontal movement
* `axisLeftVertical` - Left stick vertical movement
* `axisCursorX` - Cursor horizontal movement
* `axisCursorY` - Cursor vertical movement

## Usage

### Basic Setup

```c
function game_start() {
  // Configure the pre-made input mappings
  SetupInputMappings();
}

function SetupInputMappings() {
  // Configure movement inputs
  inputUp.AddKey(eKeyUpArrow);
  inputUp.AddKey(eKeyW);
  inputUp.AddControllerAxis(eInputMappingAxisLeftUp);
  inputUp.Enabled = true;
  
  inputDown.AddKey(eKeyDownArrow);
  inputDown.AddKey(eKeyS);
  inputDown.AddControllerAxis(eInputMappingAxisLeftDown);
  inputDown.Enabled = true;
  
  inputLeft.AddKey(eKeyLeftArrow);
  inputLeft.AddKey(eKeyA);
  inputLeft.AddControllerAxis(eInputMappingAxisLeftLeft);
  inputLeft.Enabled = true;
  
  inputRight.AddKey(eKeyRightArrow);
  inputRight.AddKey(eKeyD);
  inputRight.AddControllerAxis(eInputMappingAxisLeftRight);
  inputRight.Enabled = true;
  
  // Configure action buttons
  inputPrimaryButton.AddKey(eKeyEnter);
  inputPrimaryButton.AddKey(eKeySpace);
  inputPrimaryButton.AddMouseButton(eMouseLeft);
  inputPrimaryButton.AddControllerButton(eControllerA);
  inputPrimaryButton.Enabled = true;
  
  inputSecondaryButton.AddKey(eKeyEscape);
  inputSecondaryButton.AddMouseButton(eMouseRight);
  inputSecondaryButton.AddControllerButton(eControllerB);
  inputSecondaryButton.Enabled = true;
}
```

### Using in Game Logic

```c
function repeatedly_execute() {
  // Use the pre-configured mappings directly
  if (inputPrimaryButton.IsPressed(eNoRepeat)) {
    HandlePrimaryAction();
  }
  
  if (inputSecondaryButton.IsPressed(eNoRepeat)) {
    HandleSecondaryAction();
  }
  
  if (inputHintsButton.IsPressed(eNoRepeat)) {
    ToggleHints();
  }
  
  // Update axis trackers for smooth movement
  axisLeftHorizontal.Update(inputLeft, inputRight);
  axisLeftVertical.Update(inputUp, inputDown);
  
  if (axisLeftHorizontal.IsMoving()) {
    // Handle horizontal movement
    int moveAmount = axisLeftHorizontal.Value;
    // Process movement...
  }
}
```

### Menu Navigation

```c
function HandleMenuNavigation() {
  if (inputUp.IsPressed(eNoRepeat)) {
    SelectPreviousMenuItem();
  }
  
  if (inputDown.IsPressed(eNoRepeat)) {
    SelectNextMenuItem();
  }
  
  if (inputPrimaryButton.IsPressed(eNoRepeat)) {
    ActivateCurrentMenuItem();
  }
  
  if (inputSecondaryButton.IsPressed(eNoRepeat)) {
    GoBackInMenu();
  }
}
```

## Customization

You can modify the default mappings to suit your game's needs:

```c
function CustomizeInputs() {
  // Add additional keys to existing mappings
  inputPrimaryButton.AddKey(eKeyReturn);
  inputPrimaryButton.AddKey(eKeySpace);
  
  // Configure inventory access
  inputInvButton.AddKey(eKeyI);
  inputInvButton.AddKey(eKeyTab);
  inputInvButton.AddControllerButton(eControllerY);
  inputInvButton.Enabled = true;
  
  // Set up hints button  
  inputHintsButton.AddKey(eKeyH);
  inputHintsButton.AddControllerButton(eControllerRightShoulder);
  inputHintsButton.Enabled = true;
}
```

## Available Input Mappings

All exported InputMapping objects:

* `inputUp` - Upward movement/navigation
* `inputDown` - Downward movement/navigation
* `inputLeft` - Left movement/navigation  
* `inputRight` - Right movement/navigation
* `inputPrimaryButton` - Main action button
* `inputSecondaryButton` - Cancel/back button
* `inputInvButton` - Access inventory
* `inputExamineButton` - Examine objects
* `inputSkipOrPauseButton` - Skip/pause functionality
* `inputHintsButton` - Show hints/highlights
* `inputPrevPage` - Previous page navigation
* `inputNextPage` - Next page navigation

## Available Axis Trackers

All exported AxisTracker objects:

* `axisLeftHorizontal` - Left analog stick X-axis
* `axisLeftVertical` - Left analog stick Y-axis
* `axisCursorX` - Cursor horizontal movement
* `axisCursorY` - Cursor vertical movement

## Best Practices

1. **Initialize early**: Configure all input mappings in `game_start()`
2. **Enable mappings**: Don't forget to set `Enabled = true` on mappings you configure
3. **Consistent usage**: Use the same input mapping names throughout your game
4. **Multiple inputs**: Add multiple input methods (keyboard, mouse, controller) to each mapping
5. **Test thoroughly**: Verify all configured inputs work as expected

## Integration Example

```c
// Complete setup example
function game_start() {
  SetupAllInputMappings();
}

function SetupAllInputMappings() {
  // Movement
  ConfigureMovementInputs();
  
  // Actions  
  ConfigureActionInputs();
  
  // UI Navigation
  ConfigureUIInputs();
}

function ConfigureMovementInputs() {
  // Up
  inputUp.AddKey(eKeyUpArrow);
  inputUp.AddKey(eKeyW);
  inputUp.AddControllerAxis(eInputMappingAxisLeftUp);
  inputUp.Enabled = true;
  
  // Similar for inputDown, inputLeft, inputRight...
}

function ConfigureActionInputs() {
  // Primary action
  inputPrimaryButton.AddKey(eKeyEnter);
  inputPrimaryButton.AddMouseButton(eMouseLeft);
  inputPrimaryButton.AddControllerButton(eControllerA);
  inputPrimaryButton.Enabled = true;
  
  // Secondary action
  inputSecondaryButton.AddKey(eKeyEscape);
  inputSecondaryButton.AddMouseButton(eMouseRight); 
  inputSecondaryButton.AddControllerButton(eControllerB);
  inputSecondaryButton.Enabled = true;
}

function ConfigureUIInputs() {
  // Inventory
  inputInvButton.AddKey(eKeyI);
  inputInvButton.AddControllerButton(eControllerY);
  inputInvButton.Enabled = true;
  
  // Hints
  inputHintsButton.AddKey(eKeyH);
  inputHintsButton.AddControllerButton(eControllerRightShoulder);
  inputHintsButton.Enabled = true;
}
```
