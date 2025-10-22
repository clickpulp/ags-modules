# Clickpulp Is In Blocking Script Module

## About

A handy way to check if the game is busy doing something (like playing a cutscene or showing dialog) so you know when to disable certain player actions.

**Why you need this:** Sometimes you want to prevent players from opening menus or saving during cutscenes. This function tells you when the game is "busy" so you can disable those features temporarily.

## Dependencies

This module does not depend on other modules.

## Usage

### Basic Usage

```c
// Check if a blocking script is running
if (IsInBlockingScript()) {
  // Game is in a blocking state (cutscene, dialog, etc.)
  // Don't allow certain player actions
  return;
}

// Safe to perform normal game actions
ProcessPlayerInput();
```

### Input Handling

```c
void repeatedly_execute() {
  // Only process input when not in a blocking script
  if (!IsInBlockingScript()) {
    if (inputMenuButton.IsPressed()) {
      ShowMainMenu();
    }
    
    if (inputInventoryButton.IsPressed()) {
      ShowInventory();
    }
  }
}
```

### GUI Management

```c
void UpdateGUI() {
  // Disable certain GUI elements during blocking scripts
  bool allowInput = !IsInBlockingScript();
  
  btnInventory.Enabled = allowInput;
  btnMenu.Enabled = allowInput;
  btnSave.Enabled = allowInput;
}
```

## API Reference

### Functions

* `IsInBlockingScript()` - Returns `true` if the game is currently executing a blocking script, `false` otherwise

## What Counts as a Blocking Script?

A blocking script is any script that prevents normal game interaction, including:

* Cutscenes
* Character speech/dialog
* Animation sequences
* Screen transitions
* Modal dialogs
* Game-pausing operations

## Common Use Cases

### Preventing Input During Cutscenes

```c
void on_key_press(eKeyCode keycode) {
  if (IsInBlockingScript()) {
    // Don't process regular input during cutscenes
    return;
  }
  
  // Handle normal key presses
  if (keycode == eKeyEscape) {
    ShowMainMenu();
  }
}
```

### Conditional Save/Load

```c
void AttemptQuickSave() {
  if (IsInBlockingScript()) {
    Display("Cannot save during cutscenes or dialog.");
    return;
  }
  
  // Safe to save
  SaveGameSlot(QUICKSAVE_SLOT, "Quick Save");
}
```

### Dynamic UI Updates

```c
void interface_click(int interface, int button) {
  if (button == btnQuickActions) {
    if (IsInBlockingScript()) {
      // Show limited options during blocking scripts
      ShowLimitedMenu();
    } else {
      // Show full menu when player has control
      ShowFullMenu();
    }
  }
}
```

### Background System Updates

```c
void repeatedly_execute_always() {
  // Some systems should only run when player has control
  if (!IsInBlockingScript()) {
    UpdateAmbientSounds();
    ProcessEnvironmentalEffects();
    CheckPlayerProximityTriggers();
  }
  
  // Other systems always run
  UpdateMusicManager();
  ProcessParticleEffects();
}
```

## Best Practices

1. **Check before user actions**: Always check before allowing save/load, menu access, or inventory
2. **Respect the blocking state**: Don't force actions when the game is in a blocking script
3. **Use in repeatedly_execute**: Check regularly to update UI state appropriately
4. **Combine with other checks**: Often used alongside other state checks like `player.HasInventory`
5. **Performance**: The function is lightweight and safe to call frequently

## Integration Example

```c
// Example: Smart pause system that respects blocking scripts
bool gamePaused = false;

void on_key_press(eKeyCode keycode) {
  if (keycode == eKeySpace) { // Space to pause
    if (IsInBlockingScript()) {
      // Can't pause during cutscenes, but can skip
      if (IsSkippable()) {
        SkipCutscene();
      }
    } else {
      // Toggle normal game pause
      TogglePause();
    }
  }
}

void TogglePause() {
  if (gamePaused) {
    UnPauseGame();
    gamePaused = false;
  } else {
    PauseGameOnce();
    gamePaused = true;
  }
}

void repeatedly_execute() {
  // Update pause button text based on context
  if (IsInBlockingScript()) {
    btnPause.Text = "Skip";
    btnPause.Enabled = IsSkippable();
  } else {
    if (gamePaused) {
      btnPause.Text = "Resume";
    }
    else {
      btnPause.Text = "Pause";
    }
    btnPause.Enabled = true;
  }
}
```
