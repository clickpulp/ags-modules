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

#ifndef __GUI_STACK_MODULE__
#define __GUI_STACK_MODULE__

#define GUIStackModule 010000

struct GUIStack {
  import static readonly attribute int GUICount;
  import static readonly attribute bool ShowingGUI;
  import static readonly attribute GUI* TopGUI;

  import static void PushGUI(GUI* g, GUIControl* controlToFocus=0, bool closePreviousGUI=false, bool withOverlay=true);
  import static void PopGUI();
  import static void PopAllGUIs(GUI* untilGUI=0);
  import static int GetGUIIndex(GUI* g);
  import static bool IsGUIInStack(GUI* g);
};

// GUI Extenders

import bool IsInStack(this GUI*);
import void Push(this GUI*, GUIControl* controlToFocus=0, bool closePreviousGUI=false, bool withOverlay=true);
import void Pop(this GUI*);

#endif // __GUI_STACK_MODULE__