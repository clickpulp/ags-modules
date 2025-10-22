# Clickpulp Input Handling Module

## About

The smart system that automatically handles player input in different situations. When players are in a menu, it does menu things. When they're in a dialog, it does dialog things. When they're playing the game, it does game things.

**What this means:** You don't have to write different input handling for every situation - this module figures out what the player probably wants to do based on what's happening in the game.

## Dependencies

This module requires:

### Required

* [`Pulp_Input`](input.md) - For input mapping system
* [`Pulp_InputMappings`](inputmappings.md) - For pre-configured input mappings
* [`Pulp_Signal`](signal.md) - For dispatching game events
* [`Pulp_GUIStack`](guistack.md) - For GUI management
* [`Pulp_Cursor`](cursor.md) - For cursor control
* [`Pulp_IsInBlockingScript`](isinblockingscript.md) - For game state detection

### Optional

* `PulpGlobals` - For accessing main menu and inventory GUIs
* `arrowselect` - For arrow-based navigation support

## Key Features

* **Context-aware input handling**: Different input behaviors for different game states
* **Automatic input translation**: Converts gamepad/keyboard input to mouse actions
* **Signal-based communication**: Dispatches events for menu actions, inventory, etc.
* **GUI integration**: Works seamlessly with the GUI stack system
* **Dialog support**: Special handling for dialog navigation with per-key debouncing
* **Smart inventory scrolling**: Automatically skips items marked as "InstantUse"
* **Improved debouncing**: Per-key debouncing prevents accidental repeated inputs while allowing different keys to work independently

## How It Works

The module automatically processes input based on the current game state:

1. **GUI State**: When GUIs are visible, handles navigation and actions
2. **Dialog State**: When dialogs are running, provides dialog-specific input
3. **Blocking Script State**: During cutscenes, handles skip functionality
4. **Room State**: Normal room interaction and movement

## Usage

### Automatic Operation

The input handling system works automatically once set up. It monitors the current game state and processes input appropriately:

```c
// No direct API calls needed - the module works automatically
// Input is processed based on current game state:

// In room: inputPrimaryButton becomes left click
// In dialog: inputUp/inputDown navigate options
// In GUI: inputs navigate and activate controls
// During cutscenes: inputSkipOrPauseButton skips
```

### Signal Integration

The module dispatches several signals that your game can listen for:

```c
// Listen for input-generated signals
void repeatedly_execute() {
  if (Signal.WasDispatched("toggle_inv")) {
    ToggleInventoryDisplay();
  }
  
  if (Signal.WasDispatched("show_main_menu")) {
    ShowMainMenu();
  }
  
  if (Signal.WasDispatched("toggle_hints")) {
    ToggleHintsDisplay();
  }
}
```

## Input Mappings Used

The module processes these input mappings from [`Pulp_InputMappings`](inputmappings.md):

### Primary Actions

* `inputPrimaryButton` - Primary action (confirm/interact)
* `inputSecondaryButton` - Secondary action (cancel/back)
* `inputExamineButton` - Examine/look at objects

### Navigation

* `inputUp` - Navigate up in dialogs/menus
* `inputDown` - Navigate down in dialogs/menus
* `inputPrevPage` - Previous inventory item
* `inputNextPage` - Next inventory item

### System Actions

* `inputInvButton` - Toggle inventory
* `inputSkipOrPauseButton` - Skip cutscenes or show main menu

## Context-Specific Behaviors

### GUI State (when GUIs are visible)

* `inputPrimaryButton` → Left mouse click
* `inputSecondaryButton` → Close inventory if it's the top GUI, or pop GUI from stack
* `inputExamineButton` → Right click (in inventory) or left click
* `inputInvButton` → Toggle inventory (if not in main menu)
* `inputSkipOrPauseButton` → Show/hide main menu
* Other inputs → Move cursor

**Note**: Secondary button now checks if inventory is the **top GUI** (using `GUIStack.TopGUI`) rather than just checking if it's visible, preventing conflicts with nested GUIs.

### Dialog State

* `inputPrimaryButton` → Left mouse click
* `inputSecondaryButton` → Left mouse click
* `inputExamineButton` → Left mouse click
* `inputUp/inputDown` → Simulate arrow key presses for dialog navigation (with per-key debouncing)

**Per-Key Debouncing**: Each navigation key (up/down) is tracked separately, so you can press up multiple times without the down key interfering, and vice versa. This provides responsive dialog navigation while preventing accidental double-inputs.

### Blocking Script State (cutscenes, etc.)

* `inputPrimaryButton` → Left mouse click
* `inputSecondaryButton` → Left mouse click
* `inputExamineButton` → Left mouse click
* `inputSkipOrPauseButton` → Skip cutscene (if skippable)

### Room State (normal gameplay)

* `inputPrimaryButton` → Interact with objects/unlock cursor
* `inputSecondaryButton` → Clear inventory selection or context actions
* `inputExamineButton` → Right click or toggle hints
* `inputSkipOrPauseButton` → Show main menu
* `inputInvButton` → Toggle inventory
* `inputPrevPage/inputNextPage` → Scroll through inventory items (skips items with "InstantUse" property set)

**Smart Inventory Scrolling**: When scrolling through inventory with prev/next page buttons, the module automatically skips items that have the "InstantUse" custom property set to true. This is useful for items that are automatically consumed and shouldn't be selectable as active inventory.

## Signals Dispatched

The module dispatches these signals for game systems to handle:

* `"toggle_inv"` - Toggle inventory display
* `"show_main_menu"` - Show the main menu
* `"toggle_hints"` - Toggle hint display

## Integration Example

```c
// The module works automatically, but you need to handle its signals
void game_start() {
  // Set up the GUIs the module will reference
  pulpGlobals.MainMenuGUI = gMainMenu;
  pulpGlobals.InventoryGUI = gInventory;
}

void repeatedly_execute() {
  // Handle signals dispatched by input handling
  if (Signal.WasDispatched("toggle_inv")) {
    if (gInventory.Visible) {
      gInventory.Visible = false;
    } else {
      gInventory.Visible = true;
      // Position cursor on first inventory item
      if (invMain.ItemCount > 0) {
        Point* invPos = Point.Create(invMain.x, invMain.y);
        Cursor.SetClickTarget(invPos);
      }
    }
  }
  
  if (Signal.WasDispatched("show_main_menu")) {
    if (GUIStack.IsGUIInStack(gMainMenu)) {
      GUIStack.PopGUI();
    } else {
      GUIStack.PushGUI(gMainMenu);
    }
  }
  
  if (Signal.WasDispatched("toggle_hints")) {
    if (HintsHighlighter.IsShowingHints()) {
      HintsHighlighter.HideHints();
    } else {
      HintsHighlighter.DisplayHints();
    }
  }
}
```

## Best Practices

1. **Set up PulpGlobals**: Ensure `pulpGlobals.MainMenuGUI` and `pulpGlobals.InventoryGUI` are set
2. **Handle all signals**: Implement handlers for all dispatched signals
3. **Test all states**: Verify input works correctly in all game contexts
4. **Configure input mappings**: Ensure all required input mappings are properly configured
5. **Respect game state**: The module automatically adapts to game state - don't override this behavior

## Technical Notes

* The module automatically detects game state using `IsInBlockingScript()` and other checks
* **Per-key debouncing** (8 frames): Each key is tracked separately to prevent rapid-fire while allowing different keys to work independently
* Mouse position and clicking is handled automatically based on cursor state
* Dialog navigation uses simulated key presses for compatibility with AGS dialog system
* Inventory scrolling respects the "InstantUse" custom property on inventory items
* GUI state checking now uses `GUIStack.TopGUI` for more accurate context detection

## Advanced Features

### Per-Key Debouncing

The module implements sophisticated debouncing that tracks each key separately:

```c
// Traditional debouncing (old approach):
// If ANY button was just pressed, ignore ALL button presses
// Problem: Can't press different buttons in quick succession

// Per-key debouncing (current approach):
// Track each key separately
// You can press Up, then quickly press Down, and both work
// But pressing Up twice rapidly is debounced

// This provides:
// - Responsive input for different actions
// - Prevention of accidental double-presses
// - Better feel for dialog navigation
```

### InstantUse Item Handling

For inventory items that should be automatically consumed:

```c
// In AGS Editor, add a custom property to InventoryItems:
// - Property name: "InstantUse"
// - Property type: Boolean
// - Set to true for items that shouldn't be selectable

// Examples of InstantUse items:
// - Keys that automatically unlock doors
// - Coins that automatically add to wallet
// - Food that's immediately consumed

// When scrolling with inputPrevPage/inputNextPage,
// these items are automatically skipped
```
