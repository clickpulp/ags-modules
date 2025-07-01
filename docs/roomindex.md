# Clickpulp Room Index Module

## About

Automatically finds and organizes all the clickable things in each room - characters, objects, hotspots, everything! This makes it easy for other systems (like the hints highlighter) to work with all interactive elements without having to search for them manually.

**Why this helps:** Instead of having to check every character, every object, and every hotspot separately, you can just ask "what can players interact with in this room?" and get a neat list.

## Dependencies

This module does not depend on other modules but is used by:

### Used By

* `Pulp_HintsHighlighter` - For finding interactive objects to highlight
* Other modules that need to enumerate room objects

## ⚠️ CRITICAL: Required Object Properties Setup

**WARNING: You MUST define these properties in your AGS project BEFORE using this module, or your game will crash!**

This module reads custom properties from your hotspots and objects to determine their behavior. Follow these steps:

1. **In AGS Editor, go to the Properties section**
2. **Add these custom properties for both Hotspots and Objects:**

**Flag Properties:**

* `Exit` (int) - Set to room number for exits, or any non-zero value to mark as an exit (adds `eEntityFlagExit`)
* `IsDoor` (bool) - Mark hotspots/objects as doors (adds `eEntityFlagDoor`)
* `IsSign` (bool) - Mark hotspots/objects as signs/readable items (adds `eEntityFlagSign`)

**Important:** These properties must exist in your project even if you don't plan to use them immediately. The module will crash when it tries to read undefined properties.

These properties are automatically detected and added to the object's flags when the room index is built.

## Key Features

* **Unified object access**: Access hotspots, characters, and objects through a single index
* **Bounds information**: Get the screen bounds of each interactive element
* **Type checking**: Determine what type of object each index represents
* **Flag system**: Check what interactions are available for each object

## Usage

### Getting Object Count

```agscript
// Get total number of interactive objects in the room
int totalObjects = RoomIndex.EntityCount;

Display("This room has %d interactive objects", totalObjects);
```

### Iterating Through Objects

```agscript
// Loop through all interactive objects in the room
for (int i = 0; i < RoomIndex.EntityCount; i++) {
  if (RoomIndex.IsInitialized(i)) {
    Rect* bounds = RoomIndex.GetBounds(i);
    
    if (RoomIndex.IsHotspot(i)) {
      Hotspot* hotspot = RoomIndex.GetHotspot(i);
      Display("Found hotspot: %s", hotspot.Name);
    }
    else if (RoomIndex.IsCharacter(i)) {
      Character* character = RoomIndex.GetCharacter(i);
      Display("Found character: %s", character.Name);  
    }
    else if (RoomIndex.IsObject(i)) {
      Object* object = RoomIndex.GetObject(i);
      Display("Found object: %s", object.Name);
    }
  }
}
```

### Checking Object Flags

```agscript
// Check what interactions are available for an object
for (int i = 0; i < RoomIndex.EntityCount; i++) {
  int flags = RoomIndex.GetFlags(i);
  
  if (flags & eEntityFlagTalk) {
    // Object can be talked to
  }
  if (flags & eEntityFlagInteract) {
    // Object can be interacted with
  }
  if (flags & eEntityFlagLookAt) {
    // Object can be examined
  }
  if (flags & eEntityFlagUseInv) {
    // Object accepts inventory items
  }
}
```

### Finding Objects at Position

```agscript
// Find what interactive object is at a specific position
function CheckObjectAtPosition(int x, int y) {
  for (int i = 0; i < RoomIndex.EntityCount; i++) {
    if (RoomIndex.IsInitialized(i)) {
      Rect* bounds = RoomIndex.GetBounds(i);
      
      if (x >= bounds.Left && x <= bounds.Right && 
          y >= bounds.Top && y <= bounds.Bottom) {
        
        if (RoomIndex.IsHotspot(i)) {
          return RoomIndex.GetHotspot(i);
        }
        // ... check other types
      }
    }
  }
  return null;
}
```

## API

### RoomIndex Struct

* `RoomIndex.EntityCount` - Total number of entities in the index
* `IsInitialized(int index)` - Check if the entity at index is valid
* `GetBounds(int index)` - Get screen bounds rectangle for entity
* `GetFlags(int index)` - Get interaction flags for entity

### Type Checking API

* `IsHotspot(int index)` - Check if entity is a hotspot
* `IsCharacter(int index)` - Check if entity is a character  
* `IsObject(int index)` - Check if entity is an object

### Object Conversion API

* `ToHotspotIndex(int index)` - Convert to hotspot array index
* `ToCharacterIndex(int index)` - Convert to character array index
* `ToObjectIndex(int index)` - Convert to object array index

### Object Retrieval API

* `GetHotspot(int index)` - Get hotspot pointer from index
* `GetCharacter(int index)` - Get character pointer from index
* `GetObject(int index)` - Get object pointer from index

## Entity Flags

The `EntityFlagType` enum defines what interactions are available:

* `eEntityFlagNone` (0) - No interactions
* `eEntityFlagTalk` (1) - Can talk to object
* `eEntityFlagInteract` (2) - Can interact with object
* `eEntityFlagLookAt` (4) - Can examine object
* `eEntityFlagUseInv` (8) - Can use inventory on object
* `eEntityFlagExit` (16) - Object is an exit
* `eEntityFlagDoor` (32) - Object is a door
* `eEntityFlagSign` (64) - Object is a sign/readable

Flags can be combined using bitwise OR operations.

## Best Practices

1. **Check initialization**: Always verify `IsInitialized()` before accessing objects
2. **Cache bounds**: Store bounds rectangles if doing multiple position checks
3. **Type safety**: Always check object type before casting/accessing
4. **Performance**: The index is built when the room loads, so accessing it is fast
5. **Flag combinations**: Objects can have multiple interaction flags simultaneously

## Integration Example

```agscript
// Example: Find all talkable characters in the room
function FindTalkableCharacters() {
  for (int i = 0; i < RoomIndex.EntityCount; i++) {
    if (RoomIndex.IsInitialized(i) && RoomIndex.IsCharacter(i)) {
      int flags = RoomIndex.GetFlags(i);
      
      if (flags & eEntityFlagTalk) {
        Character* character = RoomIndex.GetCharacter(i);
        Display("You can talk to %s", character.Name);
      }
    }
  }
}
```
