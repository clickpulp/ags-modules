# Clickpulp Room Index Module

## About

Automatically finds and organizes all the clickable things in each room - characters, objects, hotspots, everything! This makes it easy for other systems (like the hints highlighter) to work with all interactive elements without having to search for them manually.

**What's an Index?** Think of it like your phone's contact list or a menu - instead of scrolling through every single thing to find what you need, you have one organized list where you can quickly find what you're looking for. This module creates that kind of a central list for everything clickable in your room.

**Why this helps:** Instead of having to check every character, every object, and every hotspot separately, you can just ask "what can players interact with in this room?" and get a neat list. It's like having a helpful assistant who already knows where everything is!

## Dependencies

### Required

* `Tween` - For math utilities

### Used By

* [`Pulp_HintsHighlighter`](hintshighlighter.md) - For finding interactive elements to highlight
* Other modules that need to enumerate room clickables

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

These properties are automatically detected and added to the clickable's flags when the room index is built.

## Key Features

* **Unified clickable access**: Access hotspots, characters, and objects through a single index
* **Bounds information**: Get the screen bounds of each interactive element
* **Type checking**: Determine what type of clickable each index represents
* **Flag system**: Check what interactions are available for each clickable

## Customizing Clickable Limits

Think of this module like having three separate boxes (arrays) that store information about your clickables - one box for hotspots, one for characters, and one for objects. Each box has a fixed size that you can adjust. You can customize these box sizes by editing some settings at the top of `Pulp_RoomIndex.asc`:

### Configuration Defines

```c
#define MAX_ROOM_HOTSPOTS_SUPPORTED 50  // Max: 49 (AGS limit)
#define MAX_CHARACTERS_SUPPORTED 32     // Max: Unlimited
#define MAX_ROOM_OBJECTS_SUPPORTED 64   // Max: 256 (AGS limit)
#define TOTAL_HINTS_SUPPORTED 146       // Must equal sum of above three
```

### How to Modify

1. **Count your clickables**: Think about your busiest room - how many hotspots, characters, and objects will players be able to click on?
2. **Change the numbers**: Increase the values to match what you need
3. **Update the total**: Always make sure `TOTAL_HINTS_SUPPORTED` equals the sum of your three box sizes (hotspots + characters + objects)
4. **Test your game**: Bigger boxes use more computer memory, but let you have more clickables

### Examples

**For a large game:**

```c
#define MAX_ROOM_HOTSPOTS_SUPPORTED 49   // Use AGS maximum
#define MAX_CHARACTERS_SUPPORTED 50      // Support crowded scenes
#define MAX_ROOM_OBJECTS_SUPPORTED 100   // Many interactive objects
#define TOTAL_HINTS_SUPPORTED 199        // 49 + 50 + 100
```

**For a minimal game:**

```c
#define MAX_ROOM_HOTSPOTS_SUPPORTED 20   // Fewer hotspots
#define MAX_CHARACTERS_SUPPORTED 10      // Small cast
#define MAX_ROOM_OBJECTS_SUPPORTED 30    // Simple rooms
#define TOTAL_HINTS_SUPPORTED 60         // 20 + 10 + 30
```

### Important Notes

* **AGS Engine Limits**: The game engine itself caps hotspots at 49 and objects at 256 - you can't go higher than these
* **Memory Trade-off**: Bigger boxes use more computer memory, even if you don't fill them completely
* **Performance**: More supported clickables means the game takes slightly longer to scan each room
* **Math Requirement**: Your game will crash if `TOTAL_HINTS_SUPPORTED` doesn't equal the sum of your three box sizes
* **Per-Room Limits**: These limits apply to each individual room, not your entire game

### When to Adjust

**Make your boxes bigger if:**

* You get "Too many character in room" error messages when testing
* Some clickable things in your rooms aren't being detected
* You have rooms with lots of interactive elements (more than the default settings handle)

**Make your boxes smaller if:**

* You want to save computer memory (especially for older computers or mobile games)
* Your game has consistently simple rooms with few clickables and you want slightly better performance

## Usage

### Getting Clickable Count

```c
// Get actual number of clickables in the room
int actualClickables = 0;
for (int i = 0; i < RoomIndex.EntityCount; i++) {
  if (RoomIndex.IsInitialized(i)) {
    actualClickables++;
  }
}

Display("This room has %d clickables", actualClickables);

// Note: RoomIndex.EntityCount is the maximum supported clickables, not the actual count
```

### Iterating Through Clickables

```c
// Loop through all clickables in the room
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

### Checking Clickable Flags

**Understanding the `&` operator:** Think of flags like checkboxes on a form - each one can be checked or unchecked. The single `&` operator (not `&&`) is like asking "Is this specific checkbox checked?" It looks at the flags value and checks if a particular flag is "turned on."

**Note:** Don't confuse `&` (single) with `&&` (double). The single `&` is for checking flags, while `&&` means "AND" in regular conditions (like "if this AND that").

```c
// Check what interactions are available for a clickable
for (int i = 0; i < RoomIndex.EntityCount; i++) {
  int flags = RoomIndex.GetFlags(i);
  
  if (flags & eEntityFlagTalk) {
    // Clickable can be talked to
  }
  if (flags & eEntityFlagInteract) {
    // Clickable can be interacted with
  }
  if (flags & eEntityFlagLookAt) {
    // Clickable can be examined
  }
  if (flags & eEntityFlagUseInv) {
    // Clickable accepts inventory items
  }
}
```

**What's happening:** Each `if (flags & eEntityFlagTalk)` is like asking "Does this clickable have the 'Talk' checkbox checked?" If yes, the code inside runs. Multiple checkboxes can be checked at once - a character might be talkable AND examinable.

### Finding Clickables at Position

```c
// Find what clickable is at a specific position
void CheckClickableAtPosition(int x, int y) {
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

* `RoomIndex.EntityCount` - Total number of clickables in the index
* `IsInitialized(int index)` - Check if the clickable at index is valid
* `GetBounds(int index)` - Get screen bounds rectangle for clickable
* `GetFlags(int index)` - Get interaction flags for clickable

### Type Checking API

* `IsHotspot(int index)` - Check if clickable is a hotspot
* `IsCharacter(int index)` - Check if clickable is a character  
* `IsObject(int index)` - Check if clickable is an object

### Clickable Conversion API

**What this does:** The RoomIndex creates its own unified numbering system (0, 1, 2, 3...) for all clickables in a room. But AGS has separate global arrays: `hotspot[0]`, `character[0]`, `object[0]`, etc. These functions convert from the RoomIndex's number to the specific AGS array index.

* `ToHotspotIndex(int index)` - Convert to hotspot array index (for use with `hotspot[...]`)
* `ToCharacterIndex(int index)` - Convert to character array index (for use with `character[...]`)
* `ToObjectIndex(int index)` - Convert to object array index (for use with `object[...]`)

**Example:** If RoomIndex says clickable #5 is a hotspot, `RoomIndex.ToHotspotIndex(5)` might return `3`, meaning it's `hotspot[3]` in AGS.

### Clickable Retrieval API

* `GetHotspot(int index)` - Get hotspot pointer from index
* `GetCharacter(int index)` - Get character pointer from index
* `GetObject(int index)` - Get object pointer from index

## Entity Flags

The `EntityFlagType` enum defines what interactions are available:

* `eEntityFlagNone` (0) - No interactions
* `eEntityFlagTalk` (1) - Can talk to clickable
* `eEntityFlagInteract` (2) - Can interact with clickable
* `eEntityFlagLookAt` (4) - Can examine clickable
* `eEntityFlagUseInv` (8) - Can use inventory on clickable
* `eEntityFlagExit` (16) - Clickable is an exit
* `eEntityFlagDoor` (32) - Clickable is a door
* `eEntityFlagSign` (64) - Clickable is a sign/readable

Flags can be combined using bitwise OR operations.

## Best Practices

1. **Check initialization**: Always verify `IsInitialized()` before accessing clickables
2. **Cache bounds**: Store bounds rectangles if doing multiple position checks
3. **Type safety**: Always check clickable type before casting/accessing
4. **Performance**: The index is built when the room loads, so accessing it is fast
5. **Flag combinations**: Clickables can have multiple interaction flags simultaneously

## Integration Example

```c
// Example: Find all talkable characters in the room
void FindTalkableCharacters() {
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
