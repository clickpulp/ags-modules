# Clickpulp GUI Stack Module

## About

This module makes nested menus work smoothly, like going from Main Menu → Options → Video Settings → Resolution. It remembers where you came from and handles the "back" button correctly.

**Think of it like a stack of papers:** When you open a new menu, it goes on top of the stack. When you press "back" or "cancel," it removes the top menu and shows the one underneath.

**What this solves:**

* Players expect the back button to work consistently
* You don't have to manually track which menu to return to
* Gamepad users get their cursor positioned correctly when returning to previous menus
* Previous GUIs can stay visible but non-clickable (useful for overlay dialogs)
* Automatic mouse history management when navigating with controller

## Dependencies

This uses functionality from other modules. The modules listed below need to be placed above this module in the list of Modules.

### Required

* [`Pulp_Extenders`](extenders.md)
* [`Pulp_Signal`](signal.md)
* [`Pulp_Input`](input.md)

### Optional

* `arrowselect`
* [`Pulp_Input`](input.md)
* `TwoClickHandler`

## How To Use This

There are two ways to work with menus using this system. Both do the same thing, but the second way (GUI Extender Functions) is usually easier to read and write.

### Static Methods

```c
// Push the main menu into the stack, and place the cursor in the continue button:
GUIStack.PushGUI(gMainMenu, btnContinue);

// Push the save game GUI and place the cursor in the cancel button:
GUIStack.PushGUI(gSave, btnSaveCancel);

// User presses the cancel button: Pop the current gui (save) and now the main menu is shown.
// The cursor will be restored to the save button in the main menu:
GUIStack.PopGUI();

// OR User pressed the save button: Pop all the GUIs.
GUIStack.PopAllGUIs();

// Check if the GUI is in the stack:
if (GUIStack.IsGUIInStack(gMainMenu)) {}

// Check the topmost GUI:
if (GUIStack.TopGUI == gMainMenu) {}

// Check if showing any GUI:
if (GUIStack.ShowingGUI) {}
```

### GUI Extender Functions (Recommended)

The module extends GUI objects with convenient methods that work directly on the GUI:

```c
// Push the main menu and focus on continue button:
gMainMenu.Push(btnContinue);

// Push save game GUI with focus and close previous GUI:
gSave.Push(btnSaveCancel, true);

// Pop the current GUI:
gSave.Pop();

// Check if a specific GUI is in the stack:
if (gMainMenu.IsInStack()) {}
```

## API Reference

### GUIStack Properties

* `TopGUI` (readonly) - Get the GUI currently on top of the stack
* `ShowingGUI` (readonly) - Whether any GUI is currently visible

### GUIStack Static Methods

* `PushGUI(GUI* gui, GUIControl* control)` - Push a GUI onto the stack and optionally position cursor
* `PopGUI()` - Remove the top GUI from the stack and show the previous one
* `PopAllGUIs()` - Remove all GUIs from the stack
* `PopAllGUIs(GUI* stopAtGUI)` - Remove GUIs until reaching the specified GUI
* `IsGUIInStack(GUI* gui)` - Check if a specific GUI is anywhere in the stack

### GUI Extender Functions

* `Push(GUIControl* controlToFocus, bool closePreviousGUI, bool withOverlay)` - Push this GUI onto the stack
  * `controlToFocus` (optional) - Control to position cursor on
  * `closePreviousGUI` (optional, default false) - Whether to hide the previous GUI completely
    * **If false** (default): Previous GUI remains visible but becomes non-clickable (useful for dialogs over menus)
    * **If true**: Previous GUI is completely hidden
  * `withOverlay` (optional, default true) - Whether to show with overlay effect
* `Pop()` - Remove this GUI from the stack if it's currently on top
* `IsInStack()` - Check if this GUI is anywhere in the stack

## Advanced Usage

### Nested Menu System

Using GUI extender functions makes menu navigation more intuitive:

```c
void ShowGameMenu() {
  // Push main menu with cursor on continue button
  gMainMenu.Push(btnContinue);
}

void ShowOptionsMenu() {
  // Push options on top of main menu
  gOptions.Push(btnVideoSettings);
}

void ShowVideoSettings() {
  // Push video settings on top of options
  gVideoSettings.Push(btnResolution);
}

void CloseCurrentMenu() {
  // Pop the current top GUI (whichever it is)
  GUIStack.PopGUI();
}

void CloseSpecificMenu() {
  // Pop a specific GUI if it's on top
  if (GUIStack.TopGUI == gVideoSettings) {
    gVideoSettings.Pop();
  }
}
```

### Game State Management

```c
void ShowInventory() {
  // Always push inventory - stack handles previous GUI automatically
  gInventory.Push(invSlot1);
}

void ShowDialogBox() {
  // Show dialog with overlay, keeping previous GUI visible but non-clickable
  // Perfect for confirmation dialogs over menus
  gDialog.Push(btnDialogOK, false, true);
  // Previous GUI stays visible but can't be clicked until dialog is closed
}

void ShowFullScreenMenu() {
  // Show menu and hide previous GUI completely
  gMainMenu.Push(btnContinue, true);
  // Previous GUI is completely hidden (not just non-clickable)
}

void HandleEscapeKey() {
  if (GUIStack.ShowingGUI) {
    if (GUIStack.TopGUI == gMainMenu) {
      // Close main menu entirely
      GUIStack.PopAllGUIs();
    } else {
      // Go back one level
      GUIStack.PopGUI();
    }
  } else {
    // Show main menu
    gMainMenu.Push(btnContinue);
  }
}

void HandleInventoryToggle() {
  if (gInventory.IsInStack()) {
    // Inventory is showing, close it
    gInventory.Pop();
  } else {
    // Show inventory
    gInventory.Push(invSlot1);
  }
}
```

## Signals

* `gui_pushed` (GUI ID) - Dispatched when a GUI is pushed onto the stack
* `gui_popped` (GUI ID) - Dispatched when a GUI is popped from the stack  
* `guis_popped` - Dispatched when all GUIs have been popped through `PopAllGUIs()`

## Best Practices

1. **Consistent cursor positioning**: Always specify a control when pushing GUIs for better UX
2. **Handle edge cases**: Check `ShowingGUI` before pushing to avoid unexpected behavior
3. **Signal handling**: Listen for GUI stack signals to update game state appropriately
4. **Memory management**: The stack automatically manages GUI visibility and clickability - don't manually modify these
5. **Deep navigation**: Use `PopAllGUIs()` with a target GUI for complex menu hierarchies
6. **Overlay dialogs**: Use `closePreviousGUI=false` for dialog boxes that should appear over the current menu
7. **Mouse history**: The module automatically manages mouse position history for controller users - no manual handling needed

## Integration Example

This example shows a complete implementation using both static methods and GUI extender functions:

```c
void repeatedly_execute() {
  // Handle GUI stack signals
  if (Signal.WasDispatched("gui_pushed")) {
    int guiID = Signal.GetValue("gui_pushed", 0);
    // Pause game when any GUI is shown
    if (guiID == gMainMenu.ID) {
      Game.Paused = true;
    }
  }
  
  if (Signal.WasDispatched("gui_popped")) {
    int guiID = Signal.GetValue("gui_popped", 0);
    // Handle individual GUI being popped
    Display("GUI %d was closed", guiID);
  }
  
  if (Signal.WasDispatched("guis_popped")) {
    // Resume game when all GUIs are closed
    Game.Paused = false;
  }
}

void on_key_press(eKeyCode keycode) {
  if (keycode == eKeyEscape) {
    HandleEscapeKey();
  } else if (keycode == eKeyTab) {
    ToggleInventory();
  } else if (keycode == eKeyF1) {
    ShowHelpDialog();
  }
}

void HandleEscapeKey() {
  if (GUIStack.ShowingGUI) {
    // Pop current GUI or close all if on main menu
    if (GUIStack.TopGUI == gMainMenu) {
      GUIStack.PopAllGUIs();
    } else {
      GUIStack.PopGUI();
    }
  } else {
    // Show main menu using extender function
    gMainMenu.Push(btnContinue);
  }
}

void ToggleInventory() {
  // Use extender function to check and toggle inventory
  if (gInventory.IsInStack()) {
    gInventory.Pop();
  } else {
    gInventory.Push(invSlot1);
  }
}

void ShowHelpDialog() {
  // Show help as overlay without closing previous GUI
  gHelp.Push(btnHelpClose, false, true);
}

// Button event handlers using extender functions
void btnOptions_OnClick(GUIControl *control, MouseButton button) {
  gOptions.Push(btnVideoSettings);
}

void btnSave_OnClick(GUIControl *control, MouseButton button) {
  gSaveGame.Push(btnSaveSlot1, true); // Hide main menu
}

void btnLoad_OnClick(GUIControl *control, MouseButton button) {
  gLoadGame.Push(btnLoadSlot1, true); // Hide main menu
}
```

## Advanced Features

### Automatic Clickability Management

When pushing a new GUI, the previous GUI's clickability is automatically managed:

```c
// When you push a new GUI:
gOptionsMenu.Push(btnVideoSettings, false); // closePreviousGUI = false

// The previous GUI (e.g., Main Menu) will:
// - Remain visible (not hidden)
// - Become non-clickable (Clickable = false)
// - Prevent accidental clicks while the new GUI is active

// When you pop the current GUI:
GUIStack.PopGUI();

// The previous GUI will:
// - Become clickable again (Clickable = true)
// - Be ready for interaction
```

### Mouse History for Controller Users

The module automatically manages mouse position history for controller users:

```c
// When pushing a GUI with a control to focus:
gMainMenu.Push(btnContinue); // Controller connected

// The module automatically:
// 1. Saves current mouse position to history
// 2. Moves mouse to the btnContinue control
// 3. Tracks that history was pushed for this GUI

// When popping the GUI:
GUIStack.PopGUI();

// The module automatically:
// 1. Restores mouse to previous position
// 2. Cleans up history stack
// 3. Only if controller is still connected

// No manual Mouse.PushHistory() or Mouse.PopHistory() needed!
```

### Debug Logging

In DEBUG mode, the module logs all GUI stack operations:

```c
// All operations are logged via PulpLog():
// - "[GUIStack] Opened GUI gMainMenu (5)"
// - "[GUIStack] Closed GUI gOptions (8)"

// This helps debug:
// - GUI stack state issues
// - Mouse history problems
// - Unexpected GUI behavior

// View logs in: $SAVEGAMEDIR$/pulp-<timestamp>.log (Windows only)
```
