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

#ifndef __PATCH_VALUES_MODULE__
#define __PATCH_VALUES_MODULE__

#define PatchValues_010000

struct PatchValues {
  /// Removes stored value
  import static void Remove(String key);
  
  /// Removes all stored values
  import static void RemoveAll();
  
  /// Returns String value if it exists, otherwise the defaultValue, or null
  import static String GetString(String key, String defaultValue = 0);
  /// Sets the String value to string or null
  import static void SetString(String key, String value);

  /// Returns int value if it exists, otherwise the defaultValue, or 0
  import static int GetInt(String key, int defaultValue = 0);
  /// Sets the int value
  import static void SetInt(String key, int value);

  /// Returns float value if it exists, otherwise the defaultValue, or 0
  import static float GetFloat(String key, float defaultValue = 0);
  /// Sets the float value
  import static void SetFloat(String key, float value);
};

#endif
