# shape-synthesizer-software
The shape synthesizer is an Arduino powered controller built to modulate a Processing script that generates 3D fractals.

*The script does not currently support Processing 3! Please install version 2.2.1 (19 May 2014) in order to run it properly.*

In this repository you can find an Arduino sketch called ``shapesynth_arduino``, which controls a Processing script called ``fractal_tree_shapesynth``. If you don't have the custom Shape Synthesizer controller, you can always run the modified Processing sketch called ``fractal_tree_generator`` that can be completely controlled with the mouse.

The required Processing libraries included in this repository also need to be installed order to run the software. Sources are listed below.

* [OBJExport by nervoussystem](https://github.com/nervoussystem/OBJExport);
* [controlP5 by Andreas Schlegel](http://www.sojamo.de/libraries/controlP5/) and [peasycam by Jonathan Feinberg](http://mrfeinberg.com/peasycam/) **only** if you don't have the controller.
