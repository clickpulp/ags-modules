# Clickpulp Extenders Module

## About

Adds handy new abilities to AGS objects that you probably wish were already there! Things like better mouse handling, smarter character functions, and improved dialog management.

**What this gives you:** All those little utility functions you end up writing in every project - but already done and tested. Saves you time and makes your code cleaner.

## Dependencies

This module does not depend on other modules but is used by many other Clickpulp modules.

## Extensions

### Character Extensions

```c
// Get character dimensions and properties
int centerY = player.GetCenterY();
int width = player.GetWidth();
int height = player.GetHeight();
bool enabled = player.IsEnabled();

// Useful for positioning and collision detection
if (player.x + player.GetWidth() > Screen.Width) {
  // Character is going off screen
}
```

### Point Extensions

```c
// Create points more easily
Point* position = Point.Create(100, 50);

// Update point position
position.SetPosition(200, 75);
```

### Mouse Extensions

Enhanced mouse functionality with history tracking and positioning:

```c
// Track mouse position history
Mouse.PushHistory();        // Save current position
mouse.x = 100;
mouse.y = 50;
Mouse.PopHistory();         // Restore previous position

// Clear mouse history
Mouse.ClearHistory();
Mouse.ForgetLastHistory();  // Remove last saved position

// Position mouse on GUI controls
Mouse.PlaceOnControl(btnSave);

// Get mouse positions as Point objects
Point* screenPos = Mouse.GetPosition();
Point* roomPos = Mouse.GetRoomPosition();

// Set room position directly
Mouse.SetRoomPosition(player.x, player.y - 50);
```

### Dialog Extensions

Improved dialog management with tracking:

```c
// Start dialog with tracking capability
dTestDialog.StartCustom();

// Check dialog state
if (Dialog.IsDialogRunning()) {
  // Dialog is currently active
}

if (Dialog.DidDialogEnd()) {
  // Dialog just finished
}

// Find first available dialog option
int firstOption = dTestDialog.FindFirstActiveOption();
int lastOption = dTestDialog.FindFirstActiveOption(true); // reverse search
```

### Global Game Extensions

```c
// Pause game only if not already paused
PauseGameOnce();
```

## API Reference

### Character API

* `GetCenterY()` - Get the Y coordinate of the character's center
* `GetWidth()` - Get the character's width in pixels
* `GetHeight()` - Get the character's height in pixels  
* `IsEnabled()` - Check if the character is enabled

### Point API

* `Point.Create(int x, int y)` - Create a new Point object
* `SetPosition(int x, int y)` - Update the point's coordinates

### Mouse API

* `PushHistory()` - Save current mouse position to history stack
* `PopHistory()` - Restore mouse to last saved position
* `ForgetLastHistory()` - Remove the last saved position without restoring
* `ClearHistory()` - Clear all saved mouse positions
* `PlaceOnControl(GUIControl* control)` - Position mouse over a GUI control
* `GetPosition()` - Get current screen position as Point
* `GetRoomPosition()` - Get current room position as Point
* `SetRoomPosition(int x, int y)` - Set mouse position in room coordinates

### Dialog API

* `StartCustom()` - Start dialog with tracking enabled
* `FindFirstActiveOption(bool reverseSearch)` - Find first available dialog option
* `Dialog.DidDialogEnd()` - Check if a dialog just ended
* `Dialog.IsDialogRunning()` - Check if any dialog is currently running

### Global API

* `PauseGameOnce()` - Pause the game only if it's not already paused

## Usage Examples

### Character Collision Detection

```c
void CheckCharacterCollision(Character* char1, Character* char2) {
  int char1Right = char1.x + char1.GetWidth();
  int char1Bottom = char1.y + char1.GetHeight();
  int char2Right = char2.x + char2.GetWidth();
  int char2Bottom = char2.y + char2.GetHeight();
  
  if (char1.x < char2Right && char1Right > char2.x &&
      char1.y < char2Bottom && char1Bottom > char2.y) {
    // Characters are colliding
    return true;
  }
  return false;
}
```

### Smart Mouse Management

```c
void ShowInventory() {
  // Save mouse position before showing inventory
  Mouse.PushHistory();
  
  // Position mouse on inventory GUI
  Mouse.PlaceOnControl(gInventory.Controls[0]);
  
  gInventory.Visible = true;
}

void HideInventory() {
  gInventory.Visible = false;
  
  // Restore mouse to previous position
  Mouse.PopHistory();
}
```

### Dialog Flow Control

```c
void ManageDialog() {
  if (!Dialog.IsDialogRunning()) {
    // Start a new dialog
    dMainDialog.StartCustom();
  }
  
  // Check when dialog ends to trigger next event
  if (Dialog.DidDialogEnd()) {
    // Dialog just finished, do something
    player.Say("That was an interesting conversation!");
  }
}
```

## Best Practices

1. **Mouse history**: Use `PushHistory()` and `PopHistory()` when temporarily moving the mouse
2. **Character dimensions**: Cache width/height values if using them frequently
3. **Dialog tracking**: Use `StartCustom()` instead of `Start()` when you need to track dialog state
4. **Safe pausing**: Use `PauseGameOnce()` to avoid double-pausing issues
5. **Point creation**: Create Point objects for positions you'll reuse multiple times
