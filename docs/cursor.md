# Clickpulp Cursor Module

## About

Enhanced cursor functionality that allows the cursor to be controlled via keyboard or gamepad in addition to mouse input. This module provides intelligent cursor management with automatic locking, controller-aware positioning, and seamless integration with GUI systems.

## Dependencies

This module works with the input system:

### Required

* [`Pulp_Input`](input.md) - For input mapping and controller detection
* [`Pulp_Signal`](signal.md) - For controller connection events
* [`Pulp_GUIStack`](guistack.md) - For GUI state management
* [`Pulp_IsInBlockingScript`](isinblockingscript.md) - For script state detection

### Optional

* `arrowselect` - For arrow-based navigation  
* `Tween` - For math utilities
* Controller plugins - For gamepad support

## What This Does For Your Players

* **Any input moves the cursor**: Players can use keyboard, gamepad, or mouse to control the cursor
* **Smart auto-targeting**: The cursor can automatically move to important objects
* **Works with menus**: Navigate menus smoothly with keyboard or gamepad
* **Automatic cursor management**: Cursor locks and unlocks based on context
* **Controller-optimized**: Automatically adjusts for different controller types
* **Feels responsive**: Advanced analog stick handling with exponential response curves
* **Context-aware visibility**: Mouse cursor shows/hides intelligently based on game state

## Usage

### Basic Cursor Control

```c
// Enable arrow select (keyboard/gamepad cursor control)
Cursor.SetArrowSelectEnabled(true);

// Check if arrow select is enabled
if (Cursor.ArrowSelectEnabled) {
  lblControlHelp.Text = "Use arrows or gamepad to move cursor";
}
```

### Click Targeting

```c
// Set a click target (cursor will move here and click)
Point* target = Point.Create(100, 50);
Cursor.SetClickTarget(target);

// Force move to target immediately
Cursor.SetClickTarget(target, true);

// Check if a click target is set
if (Cursor.HasClickTarget) {
  // Move mouse to the target position
  Cursor.SetMousePositionToClickTarget();
}

// Clear the click target
Cursor.ClearClickTarget();
```

### Cursor Locking

```c
// Lock the cursor (prevent movement)
Cursor.SetLocked(true);

// Check if cursor is locked
if (Cursor.Locked) {
  lblStatus.Text = "Cursor is locked";
}

// Unlock the cursor
Cursor.SetLocked(false);
```

### Cursor Speed Control

```c
// Set cursor speed (10 = slowest, 70 = fastest, default 40)
Cursor.SetSpeed(50);

// Check current speed
int currentSpeed = Cursor.Speed;

// Adjust based on user preference
if (player.HasPreference("FastCursor")) {
  Cursor.SetSpeed(60);
} else {
  Cursor.SetSpeed(40);
}
```

### Input-Based Movement

```c
// Move cursor based on current input state
// This is handled automatically, but can be called manually
Cursor.MoveByInput();
```

## API Reference

### Cursor Struct Properties

* `HasClickTarget` (readonly) - Whether a click target is currently set
* `Locked` (readonly) - Whether the cursor is locked from movement
* `ArrowSelectEnabled` (readonly) - Whether arrow select controls are enabled
* `Speed` (readonly) - Current cursor speed setting (10-70)

### Cursor Methods

* `SetArrowSelectEnabled(bool enabled)` - Enable/disable arrow select controls
* `SetClickTarget(Point* clickTarget, bool force)` - Set target for automatic clicking
* `ClearClickTarget()` - Remove the current click target
* `SetMousePositionToClickTarget()` - Move mouse to the set click target
* `SetLocked(bool locked)` - Lock/unlock cursor movement
* `SetSpeed(int value)` - Set cursor movement speed (10-70, default 40)
* `MoveByInput()` - Move cursor based on current input state

## Automatic Features

### Smart Mouse Visibility

The cursor automatically manages mouse visibility based on game state:

* **Hidden during blocking scripts** - No cursor during cutscenes
* **Hidden when cursor is locked** - Unless inventory is active
* **Shown for GUI elements** - Automatically appears for buttons and sliders
* **Context-aware** - Considers arrow select mode and game state

### Automatic Cursor Locking

The cursor intelligently locks and unlocks based on:

* **Controller connection** - Automatically locks when controller is connected
* **Platform detection** - Locks on Nintendo Switch by default
* **Mouse movement** - Unlocks when mouse is moved manually
* **Walk axis movement** - Locks when using movement controls without cursor input

### Controller Optimization

* **Configurable cursor speed** - Adjust from 10 (slowest) to 70 (fastest), default 40
* **Nintendo controller support** - Automatically reduced to 60% of set speed for better feel
* **Exponential response curves** - More precise control at low inputs with smooth acceleration
* **Adaptive rate scaling** - Adjusts based on screen resolution and controller type
* **Deadzone handling** - Proper analog stick deadzone management
* **Per-direction debouncing** - Prevents rapid repeated inputs in the same direction
* **Automatic room locking** - Cursor locks when entering rooms with controller connected

## Integration Examples

### Game Menu Navigation

```c
void ShowMainMenu() {
  gMainMenu.Visible = true;
  
  // Enable cursor control for menu navigation
  Cursor.SetArrowSelectEnabled(true);
  
  // Set initial cursor position on the first button
  Point* firstButton = Point.Create(btnNewGame.x + btnNewGame.Width/2, 
                                   btnNewGame.y + btnNewGame.Height/2);
  Cursor.SetClickTarget(firstButton, true);
}

void HideMainMenu() {
  gMainMenu.Visible = false;
  
  // Disable arrow select when returning to game
  Cursor.SetArrowSelectEnabled(false);
  Cursor.ClearClickTarget();
}
```

### Cutscene Cursor Management

```c
function StartCutscene() {
  // Lock cursor during cutscenes
  Cursor.SetLocked(true);
  Cursor.SetArrowSelectEnabled(false);
}

function EndCutscene() {
  // Restore cursor control
  Cursor.SetLocked(false);
  Cursor.SetArrowSelectEnabled(true);
}
```

### Inventory Interface

```c
function ShowInventory() {
  gInventory.Visible = true;
  
  // Enable cursor control for inventory
  Cursor.SetArrowSelectEnabled(true);
  
  // Move cursor to first inventory slot
  if (player.ActiveInventory != null) {
    Point* firstSlot = Point.Create(invSlot1.x, invSlot1.y);
    Cursor.SetClickTarget(firstSlot);
  }
}
```

### Advanced Controller Integration

```c
void repeatedly_execute() {
  // The module handles this automatically, but you can customize:
  
  // Check if controller input is being used for movement
  if (axisCursorX.IsMoving() || axisCursorY.IsMoving()) {
    // Cursor will automatically unlock from walk mode
    // and respond to analog stick input with exponential curves
  }
  
  // Monitor walk axis for intelligent cursor positioning
  if (axisLeftHorizontal.IsPressed || axisLeftVertical.IsPressed) {
    // Module automatically positions cursor over player when walking
  }
}
```

### Player Clickability Management

```c
// The module automatically manages player clickability:
// - Player is clickable when using inventory items
// - Player is not clickable during normal gameplay
// This is handled automatically based on ActiveInventory state

void CheckPlayerState() {
  // This is done automatically by the module
  if (player.ActiveInventory != null && !player.Clickable) {
    // Module will automatically make player clickable
  }
  else if (player.ActiveInventory == null && player.Clickable) {
    // Module will automatically make player non-clickable
  }
}
```

## Signal Integration

The cursor module responds to controller connection signals:

```c
void repeatedly_execute() {
  if (Signal.WasDispatched("controller_connected")) {
    // Cursor automatically adjusts rate of motion
    // and enables appropriate locking behavior
  }
}
```

## Constants and Configuration

### Cursor Speed

* **Default speed**: 40 (adjustable from 10-70)
* **Speed calculation**: Uses float precision for smooth movement
* **Nintendo adjustment**: Automatically reduced to 60% of set speed
* **Screen scaling**: Automatically scales with screen width (based on 160px reference)

### Button Press Tracking

* **Press duration**: 8 frames
* **Per-direction debouncing**: Tracks each direction separately to prevent rapid-fire
* **Prevents accidental repeated input** during cursor movement

## Best Practices

1. **Let automation work**: The module handles most cursor management automatically
2. **Use signals**: Monitor controller connection signals for UI updates
3. **Enable for menus**: Use arrow select for GUI navigation
4. **Clear targets**: Always clear click targets when switching contexts
5. **Trust the locking**: The automatic locking system handles most cases
6. **Visual feedback**: Provide visual indicators when cursor targeting is active

## Troubleshooting

### Cursor Not Responding to Controller

* Ensure `Pulp_Input` module is properly initialized
* Check that controller is detected: `Input.ControllerConnected`
* Verify arrow select is enabled: `Cursor.ArrowSelectEnabled`

### Cursor Moving Too Fast/Slow

* Rate automatically adjusts for screen size and controller type
* Nintendo controllers automatically get reduced sensitivity
* Check if custom rate modifications are conflicting

### Mouse Not Hiding

* Module automatically manages visibility based on GUI state
* Ensure `GUIStack` and `IsInBlockingScript` modules are working
* Check if arrow select mode is properly enabled/disabled
