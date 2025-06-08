---
layout: default
title: "3D Printing"
permalink: /guides/print-guide/
parent: Guides

---

# Materials

The hard cases can be made using ductile materials like:
 - PLA+
 - PETG
 - ABS/ASA
 - Nylon (probably)
 
Plain PLA is too brittle and it will crack. Any brand of PLA+ (PLA Pro) will work, like Polymaker or eSun or whatever.

The soft cases can be made from TPU with a hardness of 90A or more. Overture High Speed TPU is the perfect stiffness for a phone case. I print on a Prusa i3 which is direct drive and good for printing flexibles, but this "high speed" TPU also works in bowden printers like the Ender 3. 

Dehydrating filament improves print quality for all types of filament.

# Slicer settings and tuning

Print quality is essential for Joy-Con and Junglecat rails. Tune the **linear advance setting** to prevent blobbing on the thin edge of the rails. Tune the overhangs to prevent sagging inside the rails.

I use a 0.4mm nozzle. For a quick test fit, set the layer heigh to 0.20-0.30mm. For a quality finish, set the layer height to 0.10mm-0.15mm or try variable layer thickness. Use at least 3 perimeters so that the case walls are solid.

**Variable extrusion width** will make the rails stronger and more accurate. Cura 5.0 and PrusaSlicer 2.5 both have this feature. Some companies reskin Cura as their own slicer - use the latest version of regular Cura instead.

![Prusa 2.5.0 with thick rails printed as a single extrusion](/images/print-guide/arachne.png)

Increasing the extrusion width a little may help print the thin rails in fewer stronger lines. Maybe. May reduce visual quality.

![extrusion width setting in PrusaSlicer](/images/print-guide/extrusion-width.png)

To reduce blobs on TPU cases, I enable "Avoid Crossing Perimeters" in PrusaSlicer.

![Avoid Crossing Perimeters settings in PrusaSlicer](/images/print-guide/avoid-crossing.png)

If you can print a pretty Benchy then you can print this phone case. This example is more than good enough - the corners are sharp and the overhangs barely droop.

![a crispy benchy](/images/print-guide/benchy.jpg)

# Separate clamps before printing - Junglecat

The clamps are made of two parts. They must be separated before printing.

Import the model into your slicer. Split the model and then move one of them. Then enable supports on the build plate only - don't fill the telescoping slot with supports.

![separating the left half and right half in PrusaSlicer 1](/images/print-guide/split1.png)
![separating the left half and right half in PrusaSlicer 2](/images/print-guide/split2.png)
![separating the left half and right half in PrusaSlicer 3](/images/print-guide/split3.png)

# Separate clamps before printing - Joycon

The Joy-Con rails have manual supports for the locking notch. In your slicer there should be 4 objects. Multi-select (Ctrl+Click) and move the supports in unison with the clamp. Then enable supports on the build plate only - don't fill the telescoping slot.

![separating the left half and right half, including manual supports on joycon rail](/images/print-guide/split4.png)

# Manual horizontal supports 

Manual supports are used for some overhangs to prevent sagging. Cut away with a craft knife or sharp box cutter. Theses are shown as thin translucent walls in OpenSCAD:

Phone overhang support

![orthographic view of phone case](/images/print-guide/manual-phone1.png)

![manual support on the USB port and speaker ports](/images/print-guide/manual-phone2.png)

Junglecat rail support

![manual support on the junglecat rail](/images/print-guide/manual-junglecat.png)

Joycon rail support

![manual support on the joycon rail](/images/print-guide/manual-joycon.png)

There is a "support airgap" to help separate these rail supports ... but it only works well on the top line. You must cut the Junglecat and Joycon rails by hand. Good luck!

![manual support cut away with an exacto blade](/images/print-guide/cut-rail.jpg)

...

### Rail cut tool

Actually there is a tool to help cut the support. This guide slides into the Junglecat rail and has a channel for your blade. You need to print one for each side. 

{: .warning }
This is a work-in-progress. It's rather dangerous to cut this rail while holding the phone case. The tool grip isn't a useful shape. This needs a remake to protect the hand and sit flush on a table.

![cutting guide inserted into rail](/images/print-guide/rail-tool-1.jpg)

![cutting the supports with a snap-off razor](/images/print-guide/rail-tool-2.jpg)
