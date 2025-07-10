// TERMS OF USE - Layered Character Module
//
// MIT License
//
// Copyright (c) 2025 Clickpulp, LLC
// Portions based on the design by Francisco González at Grundislav Games
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

/*
Example usage: Setting up and using LayeredCharacter for Ego

In a header file:
import LayeredCharacter* lcEgo;

In a script file:

LayeredCharacter* lcEgo; // Declare as global if not already present
export lcEgo;

function game_start() {
  // Create the LayeredCharacter for Ego, passing body and head characters
  lcEgo = LayeredCharacter.Create(cEgo, cEgoHead, false);

  // Add extra layers
  lcEgo.AddLayer("Gesture", cEgoGesture);      // Gesture layer (for arm/hand animations)
  lcEgo.AddLayer("Blink", cEgoBlink);    // Blinking layer (usually overlays the head)

  // Add animations to layers (each animation name must be unique across the layered character)
  lcEgo.AddAnimation("BodyIdle", "Body", 10, 0, eRepeat);         // View 10, loop 0 for idle body
  lcEgo.AddAnimation("HeadIdle", "Head", 11, 0, eRepeat);         // View 11, loop 0 for idle head
  lcEgo.AddAnimation("Blink", "Blink", 12, 0, eOnce);             // View 12, loop 0 for blink
  lcEgo.AddAnimation("Wave", "Gesture", 13, 0, eOnce);            // View 13, loop 0 for waving gesture
  lcEgo.AddAnimation("Point", "Gesture", 14, 0, eOnce);           // View 14, loop 0 for pointing gesture
  
  // Play idle animations at game start
  lcEgo.Animate("BodyIdle");
  lcEgo.Animate("HeadIdle");
}

In room script (e.g., room1.asc):

function room_EnterAfterFadeIn() {
  // Play animations by name only (implementation finds the correct layer)
  lcEgo.Animate("Wave");      // Plays the wave gesture
  lcEgo.Animate("Blink");     // Plays the blink animation
  lcEgo.Animate("Point");     // Plays the point gesture
}
*/

#ifndef __LAYERED_CHARACTER_MODULE__
#define __LAYERED_CHARACTER_MODULE__

#define LayeredCharacterModule_010000

/// Max number of supported characters
#define LC_MAX_CHARACTERS 32

/// Max number of layers per character
#define LC_MAX_LAYERS_PER_CHARACTER 4

/// Max number of animations per layer
#define LC_MAX_ANIMATIONS_PER_LAYER 8

/// Max number of keyframes per layer
#define LC_MAX_KEYFRAMES_PER_LAYER 32

managed struct Keyframe {
  int X;
  int Y; 
  
  import Keyframe*[] List1(int x, int y);
};

managed struct CharacterAnimation {
  protected int nameIndex;

  writeprotected int View;
  writeprotected int Loop;
  writeprotected RepeatStyle RepeatStyle;
  writeprotected bool Headless;
  writeprotected Direction Direction;

  import readonly attribute String Name;

  import String get_Name();
  import static CharacterAnimation* Create(String name, int view, int loop, RepeatStyle repeatStyle, bool headless, Direction direction = eForwards);
  import void Init(String name, int view, int loop, RepeatStyle repeatStyle, bool headless, Direction direction = eForwards);
};

managed struct CharacterLayer {
  protected int keyframeIndices[LC_MAX_KEYFRAMES_PER_LAYER];
  protected int nameIndex;
  protected int characterIndex;
  protected int layeredCharacterIndex;
  protected bool visible;
  protected int currentAnimationIndex;

  writeprotected int AnimationCount;
  writeprotected bool Headless;
  
  import writeprotected attribute String Name;
  import attribute bool Visible;
  import readonly attribute CharacterAnimation* CurrentAnimation;
  
  import String get_Name();
  import void set_Name(String value);
  import bool get_Visible();
  import void set_Visible(bool value);
  import CharacterAnimation* get_CurrentAnimation();
  
  import void Init(String name, Character* c, int layeredCharacterIndex, bool headless = 0);
  import void AddAnimation(String animationName, int view, int loop, RepeatStyle repeatStyle = eOnce, BlockingStyle blockingStyle = eNoBlock, Direction direction = eForwards, bool headless = false);
  import void Animate(String animationName, RepeatStyle repeatStyleOverride = -1, BlockingStyle blockingStyleOverride = -1, Direction directionOverride = -1);
  import void StopAnimating();

  import Character* GetCharacter();
  import CharacterAnimation* GetAnimationByName(String animationName);
};

managed struct LayeredCharacter {
  writeprotected int Index;  
  writeprotected int LayerCount;
  
  import readonly attribute CharacterLayer* Layers[];
  import readonly attribute Character* Body;
  import readonly attribute Character* Head;
  import readonly attribute CharacterAnimation* CurrentAnimation;
  import readonly attribute int Room;
  
  import CharacterLayer* geti_Layers(int index);
  import Character* get_Body();
  import Character* get_Head();
  import CharacterAnimation* get_CurrentAnimation();
  import int get_Room();
  
  import void Init(Character* body, Character* head, bool headlessBody);
  import void AddLayer(String name, Character* c);
  import CharacterLayer* GetLayerByName(String name);
  import CharacterAnimation* GetAnimationByName(String animationName);
  import void AddAnimation(String animationName, String layerName, int view, int loop, RepeatStyle repeatStyle = eOnce, BlockingStyle blockingStyle = eNoBlock, Direction direction = eForwards, bool headless = false);
  import void Say(String message);
  import void SayBackground(String message);
  import void ChangeRoom(int room, int x = SCR_NO_VALUE, int y = SCR_NO_VALUE, CharacterDirection direction = eDirectionNone);
  import void Animate(String animationName, RepeatStyle repeatStyleOverride = -1, BlockingStyle blockingStyle = -1, Direction directionOverride = -1);
  import void StopAnimating(String layerName);
  import void FaceCharacter(Character* toFace, BlockingStyle blockingStyle = eBlock);
  import void FaceLocation(int x, int y, BlockingStyle blockingStyle = eBlock);
  import void FaceObject(Object* toFace, BlockingStyle blockingStyle = eBlock);
  import void FollowCharacter(Character* toFollow, int dist = 10, int eagerness = 97);
  
  import void Update(); // $AUTOCOMPLETESIGNORE$
  
  import static LayeredCharacter* Create(Character* body, Character* head, bool headlessBody);
  
  import static LayeredCharacter* GetAtScreenXY(int x, int y);
};

import LayeredCharacter* GetLayeredCharacter(this CharacterLayer*);

#endif // __LAYERED_CHARACTER_MODULE__