// TERMS OF USE - HINTS HIGHLIGHTER MODULE (hints-highlighter-module)
//
// MIT License
//
// Copyright (c) 2024 Clickpulp, LLC
// Portions copyright (c) 2018 Artium Nihamkin (artium@nihamkin.com)
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

#ifndef __HINTS_HIGHLIGHTER_MODULE__
#define __HINTS_HIGHLIGHTER_MODULE__

#define HintsHighlighterModule 010000

struct HintsHighlighter {  
  /**
    * This function will recalculate the overlay that contains all the hints.
    * Do not run it every frame, it will cripple game's frame rate.
    */
	import static function CalculateHintsForRoom();
  
  /**
   * Display the overlay that contains the hints.
   */
  import static function DisplayHints();
  
  /**
   * Hide the overlay that contains the hints.
   */
  import static function HideHints();
  
  /**
   * Enable the displaying of the hints.
   */
  import static function EnableHints();
  
  /**
   * Disable the displaying of the hints. Calling DisplayHints will
   * do nothing.
   */
  import static function DisableHints();
};

import Point* GetHintPoint(this Hotspot*);
import Point* GetHintPoint(this Character*);
import Point* GetHintPoint(this Object*);

#endif // __HINTS_HIGHLIGHTER_MODULE__
