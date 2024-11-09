# Clickpulp GUI Stack Module

## About

A better way to manage GUIs through a [stack data structure](https://www.thedshandbook.com/stacks/). This eases the use of not remembering the previous GUI and makes features like page flipping or deep menu navigation a lot easier to manage.

It enables a game developer to "push" GUIs into a stack:

* When a GUI is pushed, the previous GUI is hidden (optionally) and the new GUI is placed on top.
* When the user "pops" out of the stack, the topmost GUI in the stack is hidden, and the previous GUI is shown.
* If the player has a gamepad attached, it will restore the cursor to the previous position.

## Usage

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

## API

* [See Pulp_GUIStack header file](../game/Pulp_GUIStack.ash)
  