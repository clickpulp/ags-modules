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

#ifndef __SIGNAL_MODULE__
#define __SIGNAL_MODULE__

#define SignalModule_010000

struct Signal {  
  import static void Dispatch(const string name, int value0 = 0, int value1 = 0, int value2 = 0);
  import static bool WasDispatched(const string name);
  import static int GetValue(const string name, int index = 0);
  import static bool WasDispatchedWithValue(const string name, int value, int index = 0);
};

#endif // __SIGNAL_MODULE__
