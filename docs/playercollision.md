# Clickpulp Player Collision Module

## About

This module makes your game much more intuitive for players using keyboards or gamepads. When the player character walks near something they can interact with (like a door, person, or sign), the game automatically highlights it and positions the cursor there.

**Why this makes your game better:**

* Players don't have to hunt around with the cursor - the game helps them
* Perfect for keyboard and gamepad users who can't point precisely
* Makes interactions feel smooth and modern
* Helps players discover interactive objects naturally while exploring

## Dependencies

This module requires:

### Required

* `Pulp_RoomIndex` - For finding interactive objects in the room
* `Pulp_RoomMarkers` - For visual feedback/highlighting
* `Pulp_Cursor` - For automatic cursor targeting
* `Pulp_Rect` - For bounds calculations
* `Tween` - For math utilities and distance calculations

## Key Features

* **Proximity detection**: Automatically detects when player is near interactive objects
* **Smart targeting**: Prioritizes objects based on distance and player facing direction
* **Visual feedback**: Can highlight nearby interactive objects
* **Automatic cursor targeting**: Sets cursor targets for keyboard/gamepad users
* **Object filtering**: Only detects relevant interactive objects (doors, characters, exits, signs)

## How It Works

The collision system continuously monitors the area around the player character and:

1. **Scans for interactive objects** using the Room Index
2. **Calculates distances and angles** to each object
3. **Filters objects** based on type and interaction flags
4. **Prioritizes objects** based on proximity and player direction
5. **Sets cursor targets** or provides visual feedback

## Object Types Detected

The system detects these types of interactive objects:

### Characters

* Only characters with the `eEntityFlagTalk` flag
* Collision detection focuses on the upper portion of the player

### Interactive Objects

* Doors (`eEntityFlagDoor`)
* Exits (`eEntityFlagExit`)
* Signs/readable objects (`eEntityFlagSign`)
* Collision detection focuses on the lower portion of the player

## Usage

### Automatic Operation

The collision system works automatically when the player moves around:

```agscript
// The system runs automatically - no direct API calls needed
// When player walks near interactive objects:
// - Cursor targets are set automatically
// - Visual markers may appear
// - Room markers highlight nearby objects
```

### Integration with Player Control

The collision system works seamlessly with direct player control:

```agscript
function repeatedly_execute() {
  // When using PlayerDirectControl, collision detection
  // automatically activates as the player moves around
  
  // The system will:
  // - Set cursor targets on nearby objects
  // - Clear markers when no objects are near
  // - Prioritize objects based on movement direction
}
```

### Visual Feedback

The system can provide visual feedback through room markers:

```agscript
// Visual indicators are managed automatically
// - Markers appear when objects are in range
// - Markers are cleared when player moves away
// - Multiple objects may be highlighted simultaneously
```

## Collision Detection Logic

### Character Collision

For characters (NPCs you can talk to):

* Collision box: Player's full width × top third of player height
* Triggered when player's upper body overlaps with character bounds

### Object Collision

For objects (doors, exits, signs):

* Collision box: Player's full width × bottom two-thirds of player height
* Triggered when player's lower body overlaps with object bounds

### Distance and Priority Weighting

Objects are prioritized by:

1. **Distance**: Closer objects have higher priority
2. **Direction**: Objects in the player's facing direction are preferred
3. **Interaction type**: Different object types may have different weights

## Integration Example

```agscript
// The collision system works automatically, but you can enhance it:

function room_RepExec() {
  // The collision system runs automatically in the background
  // and will set cursor targets and markers as needed
  
  // You can add custom behavior based on cursor targets:
  if (Cursor.HasClickTarget) {
    // Player is near an interactive object
    lblPrompt.Text = "Press action button to interact";
    lblPrompt.Visible = true;
  } else {
    lblPrompt.Visible = false;
  }
}

// Respond to player interactions with detected objects
function on_mouse_click(MouseButton button) {
  if (button == eMouseLeft && Cursor.HasClickTarget) {
    // Player clicked on automatically targeted object
    // The target was set by the collision system
  }
}
```

## Best Practices

1. **Configure object flags**: Ensure interactive objects have proper `EntityFlagType` flags
2. **Test collision bounds**: Verify collision detection feels natural during movement
3. **Visual feedback**: Provide clear indicators when objects are auto-targeted
4. **Performance consideration**: The system scans objects continuously - optimize room object counts
5. **Player feedback**: Give clear visual/audio cues when objects are detected

## Integration with Other Modules

### With Player Direct Control

```agscript
// When using keyboard/gamepad movement:
// - Collision detection activates automatically
// - Objects are detected as player moves around
// - Cursor targets are set for easy interaction
```

### With Hints Highlighter

```agscript
// The collision system can work alongside hints:
// - Collision shows nearby objects during movement
// - Hints show all interactive objects on key press
// - Both systems use Room Index for object detection
```

### With Input Handling

```agscript
// Input handling automatically responds to collision targets:
// - Primary button interacts with collision-targeted objects
// - Cursor is automatically positioned on detected objects
// - No additional input mapping needed
```

## Technical Details

* **Maximum colliders**: System tracks up to 8 nearby objects simultaneously
* **Collision shapes**: Uses rectangular bounds for efficient detection
* **Real-time updates**: Collision detection runs continuously during gameplay
* **Memory efficient**: Reuses collision data structures and sprites
* **Room coordinate system**: All calculations use room coordinates for accuracy

## Performance Considerations

* Collision detection runs every frame when the player is active
* Only scans objects with relevant interaction flags (optimized)
* Uses efficient rectangular intersection tests
* Limits maximum number of tracked objects to prevent performance issues
* Automatically clears markers and targets when not needed
