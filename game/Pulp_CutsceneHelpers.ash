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

#ifndef __CUTSCENE_HELPERS_MODULE__
#define __CUTSCENE_HELPERS_MODULE__

#define CutsceneHelpers_000100

/// (Cutscene Helpers) Animate Room Object during cutscene. It skips to end frame if cut-scene is skipped.
import void AnimateDuringCutscene(
  this Object*, int loop, int delay,
  RepeatStyle repeatStyle = eOnce,
  BlockingStyle blockingStyle = eBlock,
  Direction direction = eForwards,
  int frame = 0,
  int volume = 100
);

/// (Cutscene Helpers) Animate Button during cutscene. It skips to end frame if cut-scene is skipped.
import void AnimateDuringCutscene(
  this Button*, int loop, int delay,
  RepeatStyle repeatStyle = eOnce,
  BlockingStyle blockingStyle = eBlock,
  Direction direction = eForwards,
  int frame = 0,
  int volume = 100
);

/// (CutsceneHelpers) Play AudioClip during cutscene. It does not play if cut-scene is skipping.
import AudioChannel* PlayDuringCutscene(this AudioClip*, AudioPriority priority = SCR_NO_VALUE, RepeatStyle repeatStyle = SCR_NO_VALUE);

// (CutsceneHelpers) Play AudioClip From position during cutscene. It does not play if cut-scene is skipping.
import AudioChannel* PlayFromDuringCutscene(this AudioClip*, int position, AudioPriority priority = SCR_NO_VALUE, RepeatStyle repeatStyle = SCR_NO_VALUE);

#endif // __CUTSCENE_HELPERS_MODULE__