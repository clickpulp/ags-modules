# Clickpulp Cutscene Helpers Module

## About

Makes your cutscenes skip much faster when players want to skip them. Nobody likes waiting 30 seconds for a cutscene to finish skipping!

**The problem this solves:** Normally when players skip a cutscene in AGS, the game still plays through everything in the background - every animation, every voice line, every pause - just without showing it. This means skipping can take forever.

**What this does:** Makes cutscenes actually skip instantly by jumping straight to the end instead of playing everything invisibly.

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

The way you would use these functions is to replace the original function. For example, `oBluecup.Animate(...)` will become `oBluecup.AnimateDuringCutscene(...)`

Additionally, when skipping a cut-scene, the module will:

* Remove `Speech.TextOverlay` which removes `Character.Say` line immediately.
* Call `SkipWait()` which fast forwards through any `Wait` call in a cut-scene.

While these functions speed up the cut-scene skip process, there may be some side-effects. It's up to the developer to see any problems and work around them.

## API Reference

### Object Animation Functions

* `Object.AnimateDuringCutscene(...)` - Cutscene-aware version of `Object.Animate()`
* `Button.AnimateDuringCutscene(...)` - Cutscene-aware version of `Button.Animate()`

### Audio Functions

* `AudioClip.PlayDuringCutscene(...)` - Cutscene-aware version of `AudioClip.Play()`
* `AudioClip.PlayFromDuringCutscene(...)` - Cutscene-aware version of `AudioChannel.PlayFrom()`

## Integration Examples

### Basic Cutscene Setup

```c
function StartCutscene() {
  StartCutscene();
  
  // Use cutscene-aware functions
  player.Say("Let me show you something...");
  oDoor.AnimateDuringCutscene(0, 3, eOnce, eBlock);
  aOpenDoor.PlayDuringCutscene();
  
  Wait(60);
  player.Walk(100, 100, eBlock);
  
  EndCutscene();
}
```

### Complex Animation Sequence

```c
function ComplexCutscene() {
  StartCutscene();
  
  // Multiple objects animating - will skip properly
  oGears.AnimateDuringCutscene(0, 5, eRepeat, eNoBlock);
  oLever.AnimateDuringCutscene(0, 2, eOnce, eBlock);
  
  player.Say("The machine is starting up!");
  aMachineHum.PlayDuringCutscene();
  
  // Long wait that can be skipped instantly
  Wait(300);
  
  btnPowerButton.AnimateDuringCutscene(0, 1, eOnce, eBlock);
  player.Say("There we go!");
  
  EndCutscene();
}
```

## Best Practices

1. **Replace all blocking animations**: Use the cutscene-aware versions for any animations in cutscenes
2. **Audio management**: Use audio cutscene functions to prevent sound overlap during skips
3. **Wait optimization**: The module automatically handles `Wait()` calls, but keep them reasonable
4. **Test skip behavior**: Always test that cutscenes skip properly and don't leave objects in wrong states
5. **Side effects**: Be aware that rapid skipping might cause timing issues with complex sequences

## Technical Details

* Functions detect if a cutscene is being skipped using AGS's built-in cutscene state
* Animations jump to their final frame instead of playing through when skipped
* Audio is completely bypassed during skip to prevent audio buildup
* `Wait()` calls are automatically fast-forwarded by the engine integration
