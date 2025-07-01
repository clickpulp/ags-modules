# Clickpulp Cursor Module

## About

Enhanced cursor functionality that allows the cursor to be controlled via keyboard or gamepad in addition to mouse input. This is particularly useful for games that support multiple input methods or need accessibility features.

## Dependencies

This module works with the input system:

### Optional

* `Pulp_Input` - For input mapping
* `arrowselect` - For arrow-based navigation  
* `Tween` - For math utilities
* Controller plugins - For gamepad support

## What This Does For Your Players

* **Any input moves the cursor**: Players can use keyboard, gamepad, or mouse to control the cursor
* **Smart auto-targeting**: The cursor can automatically move to important objects
* **Works with menus**: Navigate menus smoothly with keyboard or gamepad
* **Cursor can be locked**: Prevent cursor movement during cutscenes or special moments
* **Feels responsive**: Cursor movement adapts to whatever input the player prefers

## Usage

### Basic Cursor Control

```agscript
// Enable arrow select (keyboard/gamepad cursor control)
Cursor.SetArrowSelectEnabled(true);

// Check if arrow select is enabled
if (Cursor.ArrowSelectEnabled) {
  lblControlHelp.Text = "Use arrows or gamepad to move cursor";
}
```

### Click Targeting

```agscript
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

```agscript
// Lock the cursor (prevent movement)
Cursor.SetLocked(true);

// Check if cursor is locked
if (Cursor.Locked) {
  lblStatus.Text = "Cursor is locked";
}

// Unlock the cursor
Cursor.SetLocked(false);
```

### Input-Based Movement

```agscript
// Move cursor based on current input state
// This would typically be called in repeatedly_execute
function UpdateCursor() {
  if (Cursor.ArrowSelectEnabled && !Cursor.Locked) {
    Cursor.MoveByInput();
  }
}
```

## API Reference

### Cursor Struct Properties

* `HasClickTarget` (readonly) - Whether a click target is currently set
* `Locked` (readonly) - Whether the cursor is locked from movement
* `ArrowSelectEnabled` (readonly) - Whether arrow select controls are enabled

### Cursor Methods

* `SetArrowSelectEnabled(bool enabled)` - Enable/disable arrow select controls
* `SetClickTarget(Point* clickTarget, bool force)` - Set target for automatic clicking
* `ClearClickTarget()` - Remove the current click target
* `SetMousePositionToClickTarget()` - Move mouse to the set click target
* `SetLocked(bool locked)` - Lock/unlock cursor movement
* `MoveByInput()` - Move cursor based on current input state

## Integration Examples

### Game Menu Navigation

```agscript
function ShowMainMenu() {
  gMainMenu.Visible = true;
  
  // Enable cursor control for menu navigation
  Cursor.SetArrowSelectEnabled(true);
  
  // Set initial cursor position on the first button
  Point* firstButton = Point.Create(btnNewGame.x + btnNewGame.Width/2, 
                                   btnNewGame.y + btnNewGame.Height/2);
  Cursor.SetClickTarget(firstButton, true);
}

function HideMainMenu() {
  gMainMenu.Visible = false;
  
  // Disable arrow select when returning to game
  Cursor.SetArrowSelectEnabled(false);
  Cursor.ClearClickTarget();
}
```

### Cutscene Cursor Management

```agscript
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

```agscript
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

function repeatedly_execute() {
  // Update cursor movement when inventory is open
  if (gInventory.Visible && Cursor.ArrowSelectEnabled) {
    Cursor.MoveByInput();
  }
}
```

### Accessibility Features

```agscript
function EnableAccessibilityMode() {
  // Always enable cursor control for accessibility
  Cursor.SetArrowSelectEnabled(true);
  
  // Provide visual feedback for cursor target
  if (Cursor.HasClickTarget) {
    ShowCursorTarget();
  }
}

function ShowCursorTarget() {
  // Draw a visual indicator at the cursor target
  // This would be implemented with overlays or GUI elements
}
```

### Smart Cursor Positioning

```agscript
function PositionCursorOnObject(Object* obj) {
  // Calculate center point of object
  Point* objCenter = Point.Create(obj.x + obj.Graphic.Width/2,
                                 obj.y + obj.Graphic.Height/2);
  
  // Set as click target
  Cursor.SetClickTarget(objCenter);
  
  // Move immediately if needed
  if (Cursor.ArrowSelectEnabled) {
    Cursor.SetMousePositionToClickTarget();
  }
}
```

## Best Practices

1. **Enable for menus**: Use arrow select for GUI navigation
2. **Lock during cutscenes**: Prevent cursor movement during non-interactive sequences
3. **Clear targets**: Always clear click targets when switching contexts
4. **Visual feedback**: Provide visual indicators when cursor targeting is active
5. **Input integration**: Combine with input system for consistent controls
6. **Accessibility**: Consider enabling cursor control as an accessibility option

## Controller Integration

```agscript
// Example: Set up controller cursor movement
function SetupControllerCursor() {
  if (Input.ControllerConnected) {
    Cursor.SetArrowSelectEnabled(true);
    
    // The input system will handle controller stick input
    // and translate it to cursor movement via MoveByInput()
  }
}

function repeatedly_execute() {
  // Update cursor based on controller input
  if (Input.ControllerConnected && Cursor.ArrowSelectEnabled) {
    Cursor.MoveByInput();
  }
}
```
