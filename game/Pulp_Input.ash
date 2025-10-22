// TERMS OF USE - CLICKPULP AGS MODULES (clickpulp-ags-modules)
//
// MIT License
//
// Copyright (c) 2024-2025 Clickpulp, LLC
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

#ifndef __INPUT_MODULE__
#define __INPUT_MODULE__

#define Input_010000

#define MAX_INPUTS 32
#define MAX_MAPPINGS_PER_INPUT 8
#define INPUT_AXIS_DEADZONE 6554 // 32768 * 0.2

#ifndef eOSNintendo
#define eOSNintendo (eOSFreeBSD + 1)
#endif

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

enum InputControllerType {
  eControllerTypeNone,
  eControllerTypeUnknown, 
  eControllerTypeNintendo, 
  eControllerTypePlayStation,
  eControllerTypeSteamDeck,
  eControllerTypeXbox
};

struct Input {
  import static readonly attribute bool ControllerConnected;
  import static readonly attribute InputControllerType ControllerType;
};

managed struct InputMapping {
  protected int _index;
  protected int _count;
  protected InputMappingType _types[MAX_MAPPINGS_PER_INPUT];
  protected int _values[MAX_MAPPINGS_PER_INPUT];
  protected int _rawPressedValue;
  protected int _pressedValue;
  protected bool _wasPressedOnce;
  
  bool Enabled;
  writeprotected bool HasAxisMapping;
  writeprotected bool MappedKeyPressed;
  
  import void Update(); // $AUTOCOMPLETEIGNORE$
  import void Delete();
  
  import void ClearMappings();
  import void AddMapping(InputMappingType type, int value);
  import void AddKey(eKeyCode keyCode);
  import void AddMouseButton(MouseButton mouseButton);
  
  import eKeyCode GetMappedKey();
  
  import bool IsPressed(RepeatStyle style = eRepeat);
  
  // TODO: Only enable Controller-specific if controller plugin is enabled
  
  import void AddControllerButton(ControllerButton button);
  import void AddControllerAxis(InputMappingAxisDirection axisDirection);
  import void AddControllerPOV(ControllerPOV pov);
  import int GetAxis();
};

struct AxisTracker {
  protected bool _moving;
  
  writeprotected int Value;
  writeprotected bool InDeadZone;
  writeprotected bool IsPressed;
  writeprotected bool IsMovingByAxis;
  
  import void Update(InputMapping* negativeInput, InputMapping* positiveInput);
  import bool IsMoving(RepeatStyle repeat = eRepeat);
};

#endif // __INPUT_MODULE__
