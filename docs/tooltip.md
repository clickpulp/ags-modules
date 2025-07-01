# Clickpulp Tooltip Module

## About

Easily show helpful text when players hover over things in your game! Perfect for explaining what items do, giving hints, or showing extra information without cluttering your interface.

**Great for:** Item descriptions, control hints, character names, or any time you want to give players more information without opening a whole dialog box.

## Dependencies

### Required

* `Tween` - For math utilities and fade animations

## Usage

### Creating a Tooltip

```c
// Create a tooltip at screen position (100, 50)
Tooltip* myTooltip = Tooltip.Create(100, 50, "This is a helpful tooltip!");

// The tooltip will be displayed automatically when created
```

### Removing a Tooltip

```c
// Remove the tooltip when no longer needed
myTooltip.Remove();
```

### Dynamic Tooltips

```c
// Show tooltips on mouse hover
void on_mouse_move() {
  // Remove any existing tooltip first
  if (currentTooltip != null) {
    currentTooltip.Remove();
    currentTooltip = null;
  }
  
  // Check if mouse is over an interactive object
  if (GetObjectAt(mouse.x, mouse.y) == oImportantItem) {
    currentTooltip = Tooltip.Create(mouse.x + 10, mouse.y - 20, 
                                   "Ancient Key - Opens mysterious doors");
  }
}
```

## API

### Tooltip Struct

* `Tooltip.Create(int screenX, int screenY, const string text)` - Create a new tooltip at screen coordinates
* `Remove()` - Remove the tooltip from display

## Best Practices

1. **Clean up tooltips**: Always call `Remove()` when tooltips are no longer needed
2. **Position carefully**: Consider screen boundaries when positioning tooltips
3. **Keep text concise**: Tooltips work best with short, helpful text
4. **One at a time**: Remove existing tooltips before creating new ones to avoid clutter
