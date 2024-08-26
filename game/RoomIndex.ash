// TERMS OF USE - ROOM INDEX MODULE (ags-room-index-module)
//
// MIT License
//
// Copyright (c) 2024 Clickpulp, LLC
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

managed struct Rect {
  int top;
  int bottom;
  int left;
  int right;
  
  import readonly attribute int Width;
  import readonly attribute int Height;
  
  import static Rect* Create(int left, int top, int right, int bottom);
  
  import int get_Width();
  import int get_Height();
};


struct RoomEntity {  
  bool initialised;
  Rect* bounds;
  
  import void Update(int x, int y);
  import void Clear();
};

struct RoomIndex {
  import static readonly attribute int EntityCount;
  //import static readonly attribute RoomEntity Entities[];
};

/*
RoomIndex.Entities[i].IsCharacter();
RoomIndex.GetCharacter(c.id).Bounds
*/

#endif // __ROOM_INDEX_MODULE__