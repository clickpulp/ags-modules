// TERMS OF USE - AGS INPUT MAP MODULE (ags-input-map-module)
//
// MIT License
//
// Copyright (c) 2024 Clickpulp, LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#ifndef __INPUT_MAP_MODULE__
#define __INPUT_MAP_MODULE__

#define InputMap_010000

#define MAX_INPUTS 32
#define MAX_MAPPINGS_PER_INPUT 8

enum InputMappingType {
  eInputMappingKey,
  eInputMappingMouseButton,
  eInputMappingControllerButton,
  eInputMappingControllerAxis,
  eInputMappingControllerPOV,
};

enum InputMappingAxisDirection {
  eInputMappingAxisLeftDown, 
  eInputMappingAxisLeftLeft,
  eInputMappingAxisLeftRight,
  eInputMappingAxisLeftUp, 
  eInputMappingAxisRightDown, 
  eInputMappingAxisRightLeft,
  eInputMappingAxisRightRight,
  eInputMappingAxisRightUp, 
  eInputMappingAxisTriggerLeft,
  eInputMappingAxisTriggerRight
};

managed struct InputMapping {
  protected int _index;
  protected int _count;
  protected InputMappingType _types[MAX_MAPPINGS_PER_INPUT];
  protected int _values[MAX_MAPPINGS_PER_INPUT];
  protected int _pressedValue;
  protected bool _wasPressedOnce;
  
  bool Enabled;
  writeprotected MouseButton TriggerMouseClick; // Rename to SimulatedMouseButton
  writeprotected eKeyCode TriggerKeyPress; // Renamed to SimulatedKeyCode
  
  import void Update(); // TODO: remove from autocomplete
  import void Delete();
  
  import void AddMapping(InputMappingType type, int value);
  import void AddKey(eKeyCode keyCode, bool triggerKeyPress = false);
  import void AddMouseButton(MouseButton mouseButton, bool triggerClick = false);
  
  import bool IsPressed(RepeatStyle style = eRepeat);
  
  // TODO: Only enable Controller-specific if controller plugin is enabled
  
  import void AddControllerButton(ControllerButton button);
  import void AddControllerAxis(InputMappingAxisDirection axisDirection);
  import void AddControllerPOV(ControllerPOV pov);
  import int GetAxis();
};

#endif // __INPUT_MAP_MODULE__
