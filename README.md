# ags-modules

Monorepo for Adventure Game Studio (AGS) modules created by Clickpulp.

## Dependencies

* [AGS 3.6.1](https://adventuregamestudio.co.uk/)
* [Tween module](https://github.com/edmundito/ags-tween-module) (already imported)
* [arrowselect module](https://github.com/ericoporto/arrowselect) (already imported but modified)
* [AGS Controller plugin - Clickpulp Mod](https://github.com/clickpulp/AGS-Controller)

## ArrowSelect Module Modifications

The included arrowselect module has been enhanced beyond the original with several key improvements:

* **Enhanced GUI Control Support**: Better handling of ListBox, Slider, and Inventory Window controls for smoother navigation
* **Interactive Object Enhancements**: Improved ToString() method and better filtering for more intuitive object selection
* **Technical Improvements**: Better coordinate handling and GUI occlusion detection for more reliable interactions
* **Modern Integration Features**: Added gamepad support, smarter cursor positioning, and debugging capabilities

These modifications maintain full API compatibility with the original while adding significant functionality for modern adventure game development.

## Documentation

See [`/docs`](./docs/README.md) for details.

## Credits

* Edmundo Ruiz Ghanem
* strazer and Rui Pires (Pulp_PlayerDirectControl module based on the [KeyboardMovement module](https://www.adventuregamestudio.co.uk/forums/modules-plugins-tools/module-keyboardmovement-v1-02/))
* Artium Nihamkin (Pulp_RoomIndex and Pulp_HintsHighlighter modules are based on [Hint Highlighting module](https://www.adventuregamestudio.co.uk/forums/modules-plugins-tools/module-hint-highlighting))

## License

[MIT](./LICENSE)
