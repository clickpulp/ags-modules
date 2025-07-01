# Clickpulp Room Markers Module

## About

Need to put visual indicators in your rooms? This module lets you place markers anywhere - perfect for highlighting important objects, showing quest objectives, or drawing attention to things players should notice.

**Think of it like:** Sticky notes you can place anywhere in a room, except they're visual markers that appear in the game world.

## Dependencies

### Required

* `Tween` - For math utilities

### Used By

* [`Pulp_HintsHighlighter`](hintshighlighter.md) - Uses markers to highlight interactive objects

## Key Features

* **Dynamic marker placement**: Place markers at any room coordinate
* **Unique identification**: Each marker has a unique ID for management
* **State management**: Markers can be active or inactive
* **Batch operations**: Clear individual markers or all markers at once

## Usage

### Basic Marker Placement

```c
// Place a marker at room coordinates (100, 50) with graphic 0
RoomMarkers.Place(1, 100, 50, 0);

// Place an active marker (default state)
RoomMarkers.Place(2, 200, 100, 1, eRoomMarkerStateActive);

// Place an inactive marker
RoomMarkers.Place(3, 150, 75, 2, eRoomMarkerStateInactive);
```

### Managing Markers

```c
// Clear a specific marker by ID
RoomMarkers.Clear(1);

// Clear all markers in the room
RoomMarkers.ClearAll();
```

### Dynamic Marker System

```c
int nextMarkerID = 1;

function PlaceQuestMarker(int x, int y) {
  // Place a quest marker and return its ID
  RoomMarkers.Place(nextMarkerID, x, y, QUEST_MARKER_GRAPHIC);
  nextMarkerID++;
  return nextMarkerID - 1;
}

function RemoveQuestMarker(int markerID) {
  RoomMarkers.Clear(markerID);
}
```

## API Reference

### RoomMarkers Struct

* `Place(int uid, int x, int y, int graphic, RoomMarkerState state)` - Place a marker at room coordinates
* `Clear(int uid)` - Remove a specific marker by ID
* `ClearAll()` - Remove all markers from the room

### RoomMarkerState Enum

* `eRoomMarkerStateInactive` - Marker is placed but not active
* `eRoomMarkerStateActive` - Marker is placed and active (default)

## Common Use Cases

### Highlighting Interactive Objects

```c
function HighlightInteractiveObjects() {
  int markerID = 1;
  
  // Mark all hotspots
  for (int i = 0; i < Room.HotspotCount; i++) {
    if (hotspot[i].Enabled) {
      RoomMarkers.Place(markerID, hotspot[i].x, hotspot[i].y, 
                       HIGHLIGHT_GRAPHIC, eRoomMarkerStateActive);
      markerID++;
    }
  }
  
  // Mark all interactive objects
  for (int i = 0; i < Room.ObjectCount; i++) {
    if (object[i].Visible && object[i].Clickable) {
      RoomMarkers.Place(markerID, object[i].x, object[i].y,
                       HIGHLIGHT_GRAPHIC, eRoomMarkerStateActive);
      markerID++;
    }
  }
}

function ClearHighlights() {
  RoomMarkers.ClearAll();
}
```

### Quest Waypoint System

```c
int[] questMarkerIDs = new int[10];
int questMarkerCount = 0;

function AddQuestWaypoint(int x, int y, int questType) {
  int graphic = GetQuestMarkerGraphic(questType);
  int markerID = GetNextMarkerID();
  
  RoomMarkers.Place(markerID, x, y, graphic);
  
  // Store marker ID for later removal
  questMarkerIDs[questMarkerCount] = markerID;
  questMarkerCount++;
}

function ClearQuestWaypoints() {
  for (int i = 0; i < questMarkerCount; i++) {
    RoomMarkers.Clear(questMarkerIDs[i]);
  }
  questMarkerCount = 0;
}
```

### Temporary Visual Feedback

```c
int feedbackMarkerID = -1;

function ShowTemporaryMarker(int x, int y, int duration) {
  // Clear any existing temporary marker
  if (feedbackMarkerID != -1) {
    RoomMarkers.Clear(feedbackMarkerID);
  }
  
  // Place new temporary marker
  feedbackMarkerID = GetNextMarkerID();
  RoomMarkers.Place(feedbackMarkerID, x, y, FEEDBACK_GRAPHIC);
  
  // Set timer to remove it
  SetTimer(TEMP_MARKER_TIMER, duration);
}

function on_event(EventType event, int data) {
  if (event == eEventGameCyclesLate && data == TEMP_MARKER_TIMER) {
    if (feedbackMarkerID != -1) {
      RoomMarkers.Clear(feedbackMarkerID);
      feedbackMarkerID = -1;
    }
  }
}
```

### Room Transition Markers

```c
function MarkRoomExits() {
  // Mark all room exits with directional indicators
  RoomMarkers.Place(EXIT_NORTH, 160, 50, ARROW_UP_GRAPHIC);
  RoomMarkers.Place(EXIT_SOUTH, 160, 190, ARROW_DOWN_GRAPHIC);
  RoomMarkers.Place(EXIT_EAST, 310, 120, ARROW_RIGHT_GRAPHIC);
  RoomMarkers.Place(EXIT_WEST, 10, 120, ARROW_LEFT_GRAPHIC);
}

function on_event(EventType event, int data) {
  if (event == eEventEnterRoomBeforeFadein) {
    // Clear markers from previous room
    RoomMarkers.ClearAll();
    
    // Set up markers for new room
    MarkRoomExits();
  }
}
```

## Best Practices

1. **Unique IDs**: Always use unique IDs for markers to avoid conflicts
2. **Clean up**: Clear markers when changing rooms or when no longer needed
3. **Performance**: Don't place too many markers simultaneously as it can impact performance
4. **Visual clarity**: Choose graphics that are clearly visible against room backgrounds
5. **State management**: Use marker states appropriately for different visual feedback needs

## Integration with Hints System

```c
// Example: Custom hints implementation using room markers
function ShowCustomHints() {
  int markerID = 100; // Start with high ID to avoid conflicts
  
  // Use RoomIndex to find all interactive objects
  for (int i = 0; i < RoomIndex.EntityCount; i++) {
    if (RoomIndex.IsInitialized(i)) {
      Rect* bounds = RoomIndex.GetBounds(i);
      int centerX = bounds.left + (bounds.Width / 2);
      int centerY = bounds.top + (bounds.Height / 2);
      
      // Place marker at object center
      RoomMarkers.Place(markerID, centerX, centerY, HINT_GRAPHIC);
      markerID++;
    }
  }
}

function HideCustomHints() {
  // Clear all hint markers (assuming they start from ID 100)
  for (int i = 100; i < 200; i++) {
    RoomMarkers.Clear(i);
  }
}
```
