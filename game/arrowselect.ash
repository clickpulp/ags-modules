//Arrow Select Module Header// MIT License
//
// Copyright (c) 2024 Ã‰rico Vieira Porto
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
//
// ## Implementation details
// This is just the detail on how things works on this module
//
// ### Problem
// By using keyboard arrow keys or joystick directional hat, select between
// clickable things on screen.
//
// ### Solution
// When the player press an arrow button do as follow:
//
// 1 .get the x,y position of each thing on screen,
//
// 2 .select only things on arrow button direction (example:at right of current
// cursor position, when player press right arrow button),
//
// 3 .calculate distance from cursor to things there, and get what has the
// smaller distance
//
// This is implemented by `bool moveCursorDirection(CharacterDirection dir)`
//
// Look into module README for more info

#define __ARROWSELECT_MODULE__

#define MAX_HOTSPOTS_PER_ROOM 49
#define MAX_LABELS 70

enum InteractiveFilter{
  eI_FilterOut=0, 
  eI_FilterIn=1
};

enum InteractiveType{
  eInteractiveTypeNothing = eLocationNothing,
  eInteractiveTypeObject = eLocationObject,
  eInteractiveTypeCharacter = eLocationCharacter,
  eInteractiveTypeHotspot = eLocationHotspot,
  eInteractiveTypeGUIControl,
  eInteractiveTypeGUI,
};

managed struct Triangle{
  int a_x;
  int a_y;
  int b_x;
  int b_y;
  int c_x;
  int c_y;
};

managed struct Interactive{
  int x;
  int y;
  int ID;
  int owningGUI_ID;
  InteractiveType type;
};

struct ArrowSelect
{  
  /// Moves cursor to the interactive available at a direction. Returns true if the cursor is successfully moved.
  import static bool moveCursorDirection(CharacterDirection dir);
  
    /// Get interactive available at a direction. Returns null if there is none.
  import static Interactive* getNearestInteractiveAtDirection(CharacterDirection dir);
    
  /// Get point to the interactive available at a direction. Returns null if there is none.
  import static Point* getNearestInteractivePointAtDirection(CharacterDirection dir);
  
  /// Filters or not a interactive type for cursor moveCursorDirection and getNearestInteractivePointAtDirection.
  import static void filterInteractiveType(InteractiveType interactiveType, InteractiveFilter filter=0);
  
  /// Returns a Triangle instance with one point at the origin points and the two other points separated by spreadAngle, and at the direction angle
  import static Triangle* triangleFromOriginAngleAndDirection(Point* origin, int direction, int spreadAngle=90);

  /// Retuns the distance between an interactive and a point.
  import static int distanceInteractivePoint(Interactive* s, Point* a);
  
  /// Returns the closest interactive to a point.
  import static Interactive* closestValidInteractivePoint(Interactive* Interactives[], Point* a);

  /// Get a list of all interactives on screen.
  import static Interactive*[] getInteractives();

  /// Returns true if an interactive is inside a triangle defined by three points.
  import static bool isInteractiveInsideTriangle(Interactive* p, Point* a, Point* b, Point* c);

  /// Returns a list of which triangles are inside a triangle defined by three points.
  import static Interactive*[] whichInteractivesInTriangle(Interactive* Interactives[], Point* a, Point* b, Point* c);

  /// Returns true if regular keyboard arrows are enabled for cursor movements.
  import static bool areKeyboardArrowsEnable();

  /// Enables or disables (by passing `false`) regular keyboard arrows handled by this module.
  import static bool enableKeyboardArrows(bool isKeyboardArrowsEnabled = 1);
  
  /// If true, Mouse position is used as origin in getNearestInteractiveAtDirection and related functions. Default is true.
  import static attribute bool UseMouseAsOrigin;
  import static bool get_UseMouseAsOrigin(); // $AUTOCOMPLETEIGNORE$
  import static void set_UseMouseAsOrigin(bool value); // $AUTOCOMPLETEIGNORE$
  
  /// Point used as origin if UseMouseAsOrigin is false.
  import static attribute Point* Origin;
  import static Point* get_Origin(); // $AUTOCOMPLETEIGNORE$
  import static void set_Origin(Point* value); // $AUTOCOMPLETEIGNORE$
};
