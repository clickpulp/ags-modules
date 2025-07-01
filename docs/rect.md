# Clickpulp Rect Module

## About

Tools for working with rectangular areas in your game. Whether you need to check if things are colliding, position UI elements, or figure out if the player clicked inside a specific area, this module has you covered.

**Common uses:** Checking if objects overlap, positioning buttons and menus, detecting clicks in specific areas, or keeping characters within certain boundaries.

## Dependencies

This module does not depend on other modules but is used by:

### Used By

* [`Pulp_RoomIndex`](roomindex.md) - For object bounds
* [`Pulp_HintsHighlighter`](hintshighlighter.md) - For highlight positioning
* Other modules that need rectangular bounds

## Usage

### Creating Rectangles

```c
// Create a rectangle at specific coordinates
Rect* bounds = Rect.Create(10, 20, 100, 80); // left, top, right, bottom

// Create from two points
Point* topLeft = Point.Create(10, 20);
Point* bottomRight = Point.Create(100, 80);
Rect* bounds = Rect.FromPoints(topLeft, bottomRight);

// Create from single point (creates 1x1 rectangle)
Rect* singlePoint = Rect.FromPoints(topLeft);
```

### Accessing Rectangle Properties

```c
Rect* rect = Rect.Create(10, 20, 100, 80);

// Direct coordinate access
int leftEdge = rect.left;     // 10
int topEdge = rect.top;       // 20
int rightEdge = rect.right;   // 100
int bottomEdge = rect.bottom; // 80

// Calculated properties
int width = rect.Width;       // 90 (right - left)
int height = rect.Height;     // 60 (bottom - top)
```

### Rectangle Operations

```c
// Copy a rectangle
Rect* original = Rect.Create(0, 0, 50, 50);
Rect* copy = original.Copy();

// Convert between coordinate systems
Rect* screenRect = roomRect.ToScreenRect();  // Room to screen coordinates
Rect* roomRect = screenRect.ToRoomRect();    // Screen to room coordinates

// Get string representation for debugging
String rectInfo = rect.ToString();
Display("Rectangle: %s", rectInfo);
```

## API Reference

### Rect Struct Properties

* `left` - Left edge X coordinate
* `top` - Top edge Y coordinate  
* `right` - Right edge X coordinate
* `bottom` - Bottom edge Y coordinate
* `Width` (readonly) - Width of rectangle (right - left)
* `Height` (readonly) - Height of rectangle (bottom - top)

### Rect Methods

* `Create(int left, int top, int right, int bottom)` - Create new rectangle
* `FromPoints(Point* p0, Point* p1)` - Create rectangle from two points
* `Copy()` - Create a copy of the rectangle
* `ToString()` - Get string representation
* `ToScreenRect()` - Convert from room to screen coordinates
* `ToRoomRect()` - Convert from screen to room coordinates

## Common Use Cases

### Collision Detection

```c
void CheckCollision(Rect* rect1, Rect* rect2) {
  if (rect1.left < rect2.right && rect1.right > rect2.left &&
      rect1.top < rect2.bottom && rect1.bottom > rect2.top) {
    // Rectangles are overlapping
    return true;
  }
  return false;
}
```

### Point-in-Rectangle Testing

```c
void IsPointInRect(int x, int y, Rect* rect) {
  if (x >= rect.left && x <= rect.right &&
      y >= rect.top && y <= rect.bottom) {
    return true;
  }
  return false;
}

// Check if mouse is over an area
if (IsPointInRect(mouse.x, mouse.y, buttonBounds)) {
  // Mouse is over the button
}
```

### UI Layout

```c
void CreateButtonLayout() {
  // Create buttons with consistent spacing
  int buttonWidth = 80;
  int buttonHeight = 30;
  int spacing = 10;
  
  Rect* saveButton = Rect.Create(10, 10, 10 + buttonWidth, 10 + buttonHeight);
  Rect* loadButton = Rect.Create(10, 10 + buttonHeight + spacing, 
                                10 + buttonWidth, 10 + (buttonHeight * 2) + spacing);
  
  // Position GUI controls based on rectangles
  btnSave.SetPosition(saveButton.left, saveButton.top);
  btnLoad.SetPosition(loadButton.left, loadButton.top);
}
```

### Bounds Checking

```c
void KeepCharacterInBounds(Character* character, Rect* bounds) {
  if (character.x < bounds.left) character.x = bounds.left;
  if (character.x > bounds.right) character.x = bounds.right;
  if (character.y < bounds.top) character.y = bounds.top;
  if (character.y > bounds.bottom) character.y = bounds.bottom;
}
```

### Screen and Room Coordinate Conversion

```c
// Convert room rectangle to screen coordinates for GUI positioning
Rect* roomArea = Rect.Create(100, 50, 200, 150);
Rect* screenArea = roomArea.ToScreenRect();

// Position a GUI element based on room coordinates
gTooltip.SetPosition(screenArea.left, screenArea.top);
```

## Best Practices

1. **Coordinate system**: Be aware of whether you're working in room or screen coordinates
2. **Bounds checking**: Always validate rectangle coordinates make sense (left < right, top < bottom)
3. **Memory management**: Remember that Rect objects are managed structs
4. **Reuse rectangles**: Create and reuse rectangle objects for frequently used bounds
5. **Debugging**: Use `ToString()` method to debug rectangle values

## Integration Example

```c
// Example: Create a safe area system for the player
Rect* safeZone;

void room_FirstLoad() {
  // Define a safe zone in the room
  safeZone = Rect.Create(50, 100, 250, 200);
}

void repeatedly_execute() {
  // Check if player is outside safe zone
  Point* playerPos = Point.Create(player.x, player.y);
  if (!IsPointInRect(player.x, player.y, safeZone)) {
    // Player is in danger zone
    player.Tint(255, 100, 100, 50, 100); // Red tint
  } else {
    // Player is safe
    player.RemoveTint();
  }
}
```
