---
layout: default
title: "Phone Case Customizer"
permalink: /guides/generator-guide/
parent: Guides
---

# Getting the generator

## 1\) Install [OpenSCAD version 2021.01 or greater](https://openscad.org/downloads.html). 

## 2\) Get the code

You need phone_case.scad, phone_case.json, and the BOSL2 library. If you use Git, it will include the libraries.

### Clone with Git command line

Assuming you have the git command line installed:

`git clone https://github.com/SiloCityLabs/Cuttlephone.git --recurse-submodules`

Done

### Download with Github Desktop:

Use GitHub Desktop to automatically include the libraries.

[![Download code](/images/generator-guide/download-code.png)](https://github.com/SiloCityLabs/Cuttlephone)

### Download ZIP

If you choose to download as a ZIP, you will also need BOSL2. Download [BOSL2 from GitHub](https://github.com/BelfrySCAD/BOSL2) and unzip to `Cuttlephone/libraries/BOSL2/`. It should look like this:

![folder structure](/images/generator-guide/unzip-bosl2.png)

# Using the generator

Open `phone_case.scad`

![](/images/generator-guide/openscad-1.png)

Close the code editor on the left. Then get your phone case into view:

 - Left mouse: rotate object
 - Right mouse: pan camera
 - Scroll wheel: zoom

Look at the Customizer on the right side for customization. Click the section title to reveal variables.

![](/images/generator-guide/openscad-2.png)

### Try it yourself

In the "shell" section you can change the type of phone case. The preview area will update each time you make a change.

Try changing the "case type" to Junglecat - rails will get added to the side of the case. Then increase "case thickness" to 2.2 - the case becomes too thick to fit the controllers and so Junglecat wings are added.

![](/images/generator-guide/openscad-3.png)

In the other sections you can change the size and features of the case. All the measurements are in millimeters. Measure a phone with calipers.

# Presets

Custom presets can be saved to phone_case.json. Click the dropdown to view available configurations. Select one as a base config, then click the plus button **+** to make a new config.

![](/images/generator-guide/presets.png)

