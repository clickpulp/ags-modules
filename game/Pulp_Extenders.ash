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

#ifndef __CLICKPULP_EXTENDERS_MODULE__
#define __CLICKPULP_EXTENDERS_MODULE__

#define ClickpulpExtenders 010000

import int GetCenterY(this Character*);

import Point* Create(static Point, int x, int y);
import void SetPosition(this Point*, int x, int y);

import void PushPosition(static Mouse);
import void PopPosition(static Mouse);
import void PlaceOnControl(static Mouse, GUIControl* control);
import Point* GetPosition(this Mouse*);
import void SetRoomPosition(this Mouse*, int x, int y);
import Point* GetRoomPosition(this Mouse*);

/// Starts Dialog, but can be tracked by DidDialogEnd and IsDialogRunning
import void StartCustom(this Dialog*);
/// Returns the id for the first dialog option that is active.
import int FindFirstActiveOption(this Dialog*, bool reverseSearch=false);
import bool DidDialogEnd(static Dialog);
import bool IsDialogRunning(static Dialog);

/// Checks that the game is not paused before pausing the game
import void PauseGameOnce();

#endif // __CLICKPULP_EXTENDERS_MODULE__