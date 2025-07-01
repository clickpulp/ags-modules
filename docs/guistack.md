# Clickpulp GUI Stack Module

## About

This module makes nested menus work smoothly, like going from Main Menu → Options → Video Settings → Resolution. It remembers where you came from and handles the "back" button correctly.

**Think of it like a stack of papers:** When you open a new menu, it goes on top of the stack. When you press "back" or "cancel," it removes the top menu and shows the one underneath.

**What this solves:**

* Players expect the back button to work consistently
* You don't have to manually track which menu to return to
* Gamepad users get their cursor positioned correctly when returning to previous menus

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

```agscript
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

```agscript
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
  * `closePreviousGUI` (optional, default false) - Whether to hide the previous GUI
  * `withOverlay` (optional, default true) - Whether to show with overlay effect
* `Pop()` - Remove this GUI from the stack if it's currently on top
* `IsInStack()` - Check if this GUI is anywhere in the stack

## Advanced Usage

### Nested Menu System

Using GUI extender functions makes menu navigation more intuitive:

```agscript
function ShowGameMenu() {
  // Push main menu with cursor on continue button
  gMainMenu.Push(btnContinue);
}

function ShowOptionsMenu() {
  // Push options on top of main menu
  gOptions.Push(btnVideoSettings);
}

function ShowVideoSettings() {
  // Push video settings on top of options
  gVideoSettings.Push(btnResolution);
}

function CloseCurrentMenu() {
  // Pop the current top GUI (whichever it is)
  GUIStack.PopGUI();
}

function CloseSpecificMenu() {
  // Pop a specific GUI if it's on top
  if (GUIStack.TopGUI == gVideoSettings) {
    gVideoSettings.Pop();
  }
}
```

### Game State Management

```agscript
function ShowInventory() {
  // Always push inventory - stack handles previous GUI automatically
  gInventory.Push(invSlot1);
}

function ShowDialogBox() {
  // Show dialog with overlay, keeping previous GUI visible
  gDialog.Push(btnDialogOK, false, true);
}

function ShowFullScreenMenu() {
  // Show menu and hide previous GUI completely
  gMainMenu.Push(btnContinue, true);
}

function HandleEscapeKey() {
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

function HandleInventoryToggle() {
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
4. **Memory management**: The stack automatically manages GUI visibility - don't manually show/hide
5. **Deep navigation**: Use `PopAllGUIs()` with a target GUI for complex menu hierarchies

## Integration Example

This example shows a complete implementation using both static methods and GUI extender functions:

```agscript
function repeatedly_execute() {
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

function on_key_press(eKeyCode keycode) {
  if (keycode == eKeyEscape) {
    HandleEscapeKey();
  } else if (keycode == eKeyTab) {
    ToggleInventory();
  } else if (keycode == eKeyF1) {
    ShowHelpDialog();
  }
}

function HandleEscapeKey() {
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

function ToggleInventory() {
  // Use extender function to check and toggle inventory
  if (gInventory.IsInStack()) {
    gInventory.Pop();
  } else {
    gInventory.Push(invSlot1);
  }
}

function ShowHelpDialog() {
  // Show help as overlay without closing previous GUI
  gHelp.Push(btnHelpClose, false, true);
}

// Button event handlers using extender functions
function btnOptions_OnClick(GUIControl *control, MouseButton button) {
  gOptions.Push(btnVideoSettings);
}

function btnSave_OnClick(GUIControl *control, MouseButton button) {
  gSaveGame.Push(btnSaveSlot1, true); // Hide main menu
}

function btnLoad_OnClick(GUIControl *control, MouseButton button) {
  gLoadGame.Push(btnLoadSlot1, true); // Hide main menu
}
```
