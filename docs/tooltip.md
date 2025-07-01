# Clickpulp Tooltip Module

## About

A simple tooltip system that allows you to display text tooltips at specific screen coordinates. Useful for showing help text, item descriptions, or contextual information.

## Dependencies

This module does not depend on other modules.

## Usage

### Creating a Tooltip

```agscript
// Create a tooltip at screen position (100, 50)
Tooltip* myTooltip = Tooltip.Create(100, 50, "This is a helpful tooltip!");

// The tooltip will be displayed automatically when created
```

### Removing a Tooltip

```agscript
// Remove the tooltip when no longer needed
myTooltip.Remove();
```

### Dynamic Tooltips

```agscript
// Show tooltips on mouse hover
function on_mouse_move() {
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
