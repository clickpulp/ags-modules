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

managed struct CharacterLayerAnimation {
  protected int nameIndex;

  writeprotected int View;
  writeprotected int Loop;
  writeprotected RepeatStyle RepeatStyle;
  writeprotected bool Headless;

  import readonly attribute String Name;

  import String get_Name();
  import static CharacterLayerAnimation* Create(String name, int view, int loop, RepeatStyle repeatStyle, bool headless);
  import void Init(String name, int view, int loop, RepeatStyle repeatStyle, bool headless);
};

managed struct CharacterLayer {
  protected int keyframeIndices[LC_MAX_KEYFRAMES_PER_LAYER];
  protected int nameIndex;
  protected int characterIndex;
  protected int layeredCharacterIndex;
  protected bool visible;

  writeprotected int AnimationCount;
  writeprotected bool Headless;
  
  import writeprotected attribute String Name;
  import attribute bool Visible;
  
  import String get_Name();
  import bool get_Visible();
  import void set_Visible(bool value);
  
  import void Init(String name, Character* c, int layeredCharacterIndex, bool headless = 0);
  import void AddAnimation(String animationName, int view, int loop, RepeatStyle repeatStyle, bool headless);
  import void Animate(String animationName, BlockingStyle blockingStyleOverride = -1, RepeatStyle repeatStyleOverride = -1);
  import void StopAnimating();

  import Character* GetCharacter();
  import CharacterLayerAnimation* GetAnimationByName(String animationName);
};

managed struct LayeredCharacter {
  protected int currentAnimationIndex;

  writeprotected int Index;  
  writeprotected int LayerCount;
  
  import readonly attribute CharacterLayer* Layers[];
  import readonly attribute Character* Body;
  import readonly attribute Character* Head;
  
  import CharacterLayer* geti_Layers(int index);
  import Character* get_Body();
  import Character* get_Head();
  
  import void Init(Character* body, Character* head, bool headlessBody);
  import void AddLayer(String name, Character* c);
  import CharacterLayer* GetLayerByName(String name);
  import void AddAnimation(String animationName, String layerName, int view, int loop, RepeatStyle repeatStyle, bool headless);
  import void Say(String message);
  import void SayBackground(String message);
  import void Animate(String layerName, String animationName, BlockingStyle blockingStyle, RepeatStyle repeatStyleOverride = -1);
  import void StopAnimating(String layerName);
  import void Update();
  
  import static LayeredCharacter* Create(Character* body, Character* head, bool headlessBody);
};

import LayeredCharacter* GetLayeredCharacter(this CharacterLayer*);

managed struct LayeredCharacterModule {
  import static void Init();
};

#endif // __LAYERED_CHARACTER_MODULE__