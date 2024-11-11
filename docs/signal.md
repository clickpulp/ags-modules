# Clickpulp Signal Module

## About

Signals modules that allow you to dispatch and check for messages across scripts, preventing cases where different parts of the code need to know of each other's existence. This is a common feature in other game engines, sometimes called event dispatching.

## Dependencies

* This module does not use any functionality from other modules.

## Usage

```agscript
// Dispatch a Signal:
Signal.Dispatch("dancing_ended");

// From a repeatedly execute call, you can check the signal:

// Check if a Signal was dispatched:
if (Signal.WasDispatched("dancing_ended")) {}

// Send a Signal with values (you can send up to 3 int values):
Signal.Dispatch("room_changed", nextRoom, previousRoom);

// Get Signal values individually:
if (Signal.WasDispatched("room_changed")) {
  int currentRoom = Signal.GetValue("room_changed", 0);
  int previousRoom = Signal.GetValue("room_changed", 1);
}

// Check value of a Signal quickly:
if (Signal.WasDispatchedWithValue("room_changed", 5)) {} // Current room
if (Signal.WasDispatchedWithValue("room_changed", 4, 1)) {} // Previous room (index 1)
```

## API

* [See Pulp_Signal header file](../game/Pulp_Signal.ash)
