# shape-synthesizer-software
The shape synthesizer is an Arduino powered controller built to modulate a Processing script that generates 3D fractals.

In this repository you can find an Arduino sketch called ``shapesynth_arduino``, which controls a Processing script called ``fractal_tree_shapesynth``. If you don't have the custom Shape Synthesizer controller, you can always run the modified Processing sketch called ``fractal_tree_generator`` that can be completely controlled with the mouse.

The following Processing libraries need to be present on your computer in order to run the software:

* [OBJExport by nervoussystem](https://github.com/nervoussystem/OBJExport);
* [controlP5 by Andreas Schlegel](http://www.sojamo.de/libraries/controlP5/) and [peasycam by Jonathan Feinberg](http://mrfeinberg.com/peasycam/) **only** if you don't have the controller.
