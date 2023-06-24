---
layout: default
title: "Print Guide"
permalink: /guides/print-guide/
---

# Materials

The hard cases can be made using ductile materials like:
 - PLA+
 - PETG
 - ABS/ASA
 - Nylon (probably)
 
Plain PLA is too brittle and it will crack. Any brand of PLA+ (PLA Pro) will work, like Polymaker or eSun or whatever.

The soft cases can be made from TPU with a hardness of 90A or more. Overture High Speed TPU is the perfect stiffness for a phone case. I print on a Prusa i3 which is direct drive and good for printing flexibles, but this "high speed" TPU also works in bowden printers like the Ender 3.

# Slicer settings and tuning

Print quality is essential for Joy-Con and Junglecat rails. Tune the **linear advance setting** to prevent blobbing on the thin edge of the rails. Tune the overhangs to prevent sagging inside the rails.

I use a 0.4mm nozzle. For a quick test fit, set the layer heigh to 0.20-0.30mm. For a quality finish, set the layer height to 0.10mm-0.15mm or try variable layer thickness. Use at least 3 perimeters so that the case walls are solid.

**Variable extrusion width** will make the rails stronger and more accurate. Cura 5.0 and PrusaSlicer 2.5 both have this feature. Some companies reskin Cura as their own slicer - use the latest version of regular Cura instead.

![](/Cuttlephone/images/print-guide/arachne.png)

If you can print a pretty Benchy then you can print this phone case. This example is more than good enough - the corners are sharp and the overhangs barely droop.

![](/Cuttlephone/images/print-guide/benchy.jpg)

# Separate clamps before printing - Junglecat

The clamps are made of two parts. They must be separated before printing.

Import the model into your slicer. Split the model and separate the 2 halves. Enable supports on the build plate. Don't support the inside of the sliding slot.

![](/Cuttlephone/images/print-guide/split1.png)
![](/Cuttlephone/images/print-guide/split2.png)
![](/Cuttlephone/images/print-guide/split3.png)

# Separate clamps before printing - Joycon

The Joy-Con rails have manual supports. In your slicer there should be 4 objects. Move them along with the clamp. 

![](/Cuttlephone/images/print-guide/split4.png)

# Manual horizontal supports 

Manual supports are used for some overhangs to prevent sagging. Cut away with a craft knife or sharp box cutter.

Phone overhang support
![](/Cuttlephone/images/print-guide/manual-phone1.png)
![](/Cuttlephone/images/print-guide/manual-phone2.png)

Junglecat rail support
![](/Cuttlephone/images/print-guide/manual-junglecat.png)

Joycon rail support
![](/Cuttlephone/images/print-guide/manual-joycon.png)

There is a "support airgap" to help separate these rail supports ... but it only works well on the top line. You must cut the Junglecat and Joycon rails by hand. Good luck!

![](/Cuttlephone/images/print-guide/cut-rail.jpg)

...