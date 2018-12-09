# Nautilus STL Thumbnailer

~~This thumbnailer requires [OpenSCAD](https://openscad.org) as backend, once you installed it then~~ 
With newer GNOME "bwrap" (bubblewrap) thumbnail processes, the approach using OpenSCAD to render STL files no longer works. 
As a remedy `stl2pov`, `stl2png.pl` and `povray` are required to do the same.

## Requirements
- install [stl2pov](https://github.com/timschmidt/stl2pov)
- install PovRay `sudo apt install povray` and `(cd ~; ln -s /etc/povray/ .povray)`

## Download
```
% git clone https://github.com/Spiritdude/Nautilus_Thumbnailer_STL
% cd Nautilus_Thumbnailer_STL
```

## Install

```
% sudo make install
```

and restart Nautilus and then your .stl will show up rendered in the preview.

## Acknowledgement

This repo is based on [STL Thumbnailer](https://www.thingiverse.com/thing:258653/) with a few changes to make it easier to use.

