# Clickpulp Patch Values Module

## About

Need to change something in your game after you've already released it? This module lets you update settings, fix balance issues, or add new features without breaking anyone's saved games.

**Perfect for:** Fixing difficulty issues, adding new options, tweaking game balance, or changing values that you realize need adjustment after players have been playing your game.

## Dependencies

This module does not depend on other modules.

## Key Features

* **Save-game safe**: Values can be added or modified without breaking existing saves
* **Multiple data types**: Supports strings, integers, and floats
* **Persistent storage**: Values are saved with the game state
* **Default values**: Can specify fallback values if keys don't exist

## Usage

### String Values

```c
// Set a string value
PatchValues.SetString("game_version", "1.2.0");
PatchValues.SetString("player_name_override", "Hero");

// Get string value with default
String version = PatchValues.GetString("game_version", "1.0.0");
String playerName = PatchValues.GetString("player_name_override");

// Check if value exists
if (PatchValues.GetString("special_mode") != null) {
  // Special mode is enabled
}
```

### Integer Values

```c
// Set integer values
PatchValues.SetInt("max_health", 150);
PatchValues.SetInt("difficulty_modifier", 2);

// Get integer value with default
int maxHealth = PatchValues.GetInt("max_health", 100);
int difficulty = PatchValues.GetInt("difficulty_modifier", 1);

// Use in game logic
player.SetMaxHealth(maxHealth);
```

### Float Values

```c
// Set float values  
PatchValues.SetFloat("movement_speed", 1.5);
PatchValues.SetFloat("damage_multiplier", 0.8);

// Get float value with default
float moveSpeed = PatchValues.GetFloat("movement_speed", 1.0);
float damageMultiplier = PatchValues.GetFloat("damage_multiplier", 1.0);

// Apply to game mechanics
player.WalkSpeed = FloatToInt(moveSpeed * 100);
```

### Managing Values

```c
// Remove specific value
PatchValues.Remove("old_setting");

// Clear all patch values (use with caution!)
PatchValues.RemoveAll();
```

## API

### PatchValues Struct

#### String Methods

* `SetString(String key, String value)` - Store a string value
* `GetString(String key, String defaultValue)` - Retrieve string value with optional default

#### Integer Methods

* `SetInt(String key, int value)` - Store an integer value
* `GetInt(String key, int defaultValue)` - Retrieve integer value with optional default

#### Float Methods

* `SetFloat(String key, float value)` - Store a float value  
* `GetFloat(String key, float defaultValue)` - Retrieve float value with optional default

#### Management Methods

* `Remove(String key)` - Remove a specific key-value pair
* `RemoveAll()` - Remove all stored values

## Use Cases

### Post-Release Balancing

```c
// In game_start() - apply balance patches
function ApplyBalancePatches() {
  // These values can be changed in updates without breaking saves
  int newMaxAmmo = PatchValues.GetInt("max_ammo_patch", 30);
  float newJumpHeight = PatchValues.GetFloat("jump_height_patch", 1.0);
  
  player.MaxAmmo = newMaxAmmo;
  player.JumpHeight = newJumpHeight;
}
```

### Feature Flags

```c
// Enable/disable features post-release
function CheckFeatureFlags() {
  String newFeature = PatchValues.GetString("enable_special_mode");
  if (newFeature == "enabled") {
    // Activate special game mode
    SpecialMode.Enabled = true;
  }
}
```

### Configuration Overrides

```c
// Override default settings
function ApplyConfigOverrides() {
  int customFPS = PatchValues.GetInt("target_fps", 60);
  SetGameSpeed(customFPS);
  
  String customFont = PatchValues.GetString("ui_font");
  if (customFont != null) {
    // Switch to custom font
  }
}
```

### Version-Specific Fixes

```c
// Apply fixes based on save game version
function ApplyVersionFixes() {
  String saveVersion = PatchValues.GetString("save_version");
  
  if (saveVersion == null || saveVersion == "1.0") {
    // Apply fixes for old saves
    PatchValues.SetInt("inventory_slots", 20); // Increased from 15
    PatchValues.SetString("save_version", "1.1");
  }
}
```

## Best Practices

1. **Use descriptive keys**: Choose clear, unique key names that won't conflict
2. **Provide defaults**: Always specify sensible default values
3. **Document changes**: Keep track of what patch values you've added
4. **Test thoroughly**: Verify behavior with both old and new save games
5. **Version tracking**: Consider storing version information to manage migrations
6. **Careful with RemoveAll()**: Only clear all values if absolutely necessary

## Integration Example

```c
// Complete example: Game difficulty adjustment system
function game_start() {
  ApplyDifficultyPatches();
}

function ApplyDifficultyPatches() {
  // These can be adjusted post-release for balancing
  float healthMultiplier = PatchValues.GetFloat("health_multiplier", 1.0);
  float damageMultiplier = PatchValues.GetFloat("damage_multiplier", 1.0);
  int extraLives = PatchValues.GetInt("bonus_lives", 0);
  
  // Apply to player
  player.MaxHealth = FloatToInt(player.MaxHealth * healthMultiplier);
  
  // Store for use in combat system
  PatchValues.SetFloat("current_damage_mod", damageMultiplier);
  
  // Add bonus lives
  if (extraLives > 0) {
    player.Lives += extraLives;
  }
}
```
