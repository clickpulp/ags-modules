# Clickpulp Cutscene Helpers Module

## About

This module provides improvements for cut-scene management, particularly when skipping them so they don't take too long to skip.

The problem with the way cut-scenes are skipped by the AGS engine is that they continue to play through the scene in the background without rendering them until it finds the `EndCutscene()` function. This means that for long animations, speech lines, and anything that is blocking, it will run frame by frame.

This module tries to prevent that by providing some ways to skip ahead so that the engine does not play these things frame by frame.

## Dependencies

This module does not depend in other modules.

## Usage

The modules provides a number of functions for animations and audio that can be swapped for their original. These functions enable the animation or audio to be skipped faster during a cut-scene skip.

These animation replacement functions skip playing blocking animation frame by frame and set the view to the last frame when the cut-scene is skipping:

* `Object.Animate -> Object.AnimateDuringCutscene`
* `Button.Animate -> Button.AnimateDuringCutscene`
* Character: TODO (let me know if you need this!)

These audio playback replacement functions will avoid playing sounds if the cut-scene is being skipped:

* `AudioClip.Play -> AudioClip.PlayDuringCutscene`
* `AudioChannel.PlayFrom -> AudioClip.PlayFromDuringCutscene`

The way you would use these functions is to replace the original function. For example, `oBluecup.Animate(...)` will become `oBluecup.AnimatDuringCutscene(...)`

Additionally, when skipping a cut-scene, the module will:

* Remove `Speech.TextOverlay` which removes `Character.Say` line immediately.
* Call `SkipWait()` which fast forwards through any `Wait` call in a cut-scene.

While these functions speed up the cut-scene skip process, there may be some side-effects. It's up to the developer to see any problems and work around them.

## API

* [See Pulp_CutsceneHelpers header file](../game/Pulp_CutsceneHelpers.ash)
