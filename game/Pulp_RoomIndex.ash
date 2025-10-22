// TERMS OF USE - ROOM INDEX MODULE (ags-room-index-module)
//
// MIT License
//
// Copyright (c) 2024-2025 Clickpulp, LLC
// Portions (c) 2018 Artium Nihamkin, artium@nihamkin.com
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

#ifndef __ROOM_INDEX_MODULE__
#define __ROOM_INDEX_MODULE__

#define RoomIndexModule 010000

enum EntityFlagType {
  eEntityFlagNone = 0, 
  eEntityFlagTalk = 1, 
  eEntityFlagInteract = 2,
  eEntityFlagLookAt = 4,
  eEntityFlagUseInv = 8,
  eEntityFlagExit = 16,
  eEntityFlagDoor = 32, 
  eEntityFlagSign = 64
};

struct RoomIndex {
  import static readonly attribute int EntityCount;
  
  import static bool IsInitialized(int index);
  import static Rect* GetBounds(int index);
  import static int GetFlags(int index);
  
  import static bool IsHotspot(int index);
  import static bool IsCharacter(int index);
  import static bool IsObject(int index);
  
  import static int ToHotspotIndex(int index);
  import static int ToCharacterIndex(int index);
  import static int ToObjectIndex(int index);
  
  import static Hotspot* GetHotspot(int index);
  import static Character* GetCharacter(int index);
  import static Object* GetObject(int index);
};

#endif // __ROOM_INDEX_MODULE__