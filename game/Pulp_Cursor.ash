// TERMS OF USE - CLICKPULP AGS MODULES (clickpulp-ags-modules)
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

#ifndef __CURSOR_MODULE__
#define __CURSOR_MODULE__

#define Cursor_010000

struct Cursor {
  /// Does it have a click target set?
  import static readonly attribute bool HasClickTarget;
  
  /// Is it locked?
  import static readonly attribute bool Locked;
  
  /// Sets the target for when to fire a mouse click and updates the Mouse position
  import static void SetClickTarget(Point* clickTarget, bool force=false);
  
  /// Clears the Click Target
  import static void ClearClickTarget();
  
  /// Sets the Mouse position to the click target set
  import static void SetMousePositionToClickTarget();
  
  // Locks/unlocks the cursor
  import static void SetLocked(bool locked);
};

#endif // __CURSOR_MODULE__
