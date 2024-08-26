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

import void PlaceOnControl(static Mouse, GUIControl* control);
import Point* GetPosition(this Mouse*);

#endif // __CLICKPULP_EXTENDERS_MODULE__