# Cuttlephone
Cuttlephone is phone case generator and gamepad system for 3D printing. This is the source code. [Get premade 3MF files and print tutorials on the website](https://silocitylabs.github.io/Cuttlephone/)


![phone case generator](https://user-images.githubusercontent.com/1850819/206940314-f19951e0-617c-4899-927e-68e9c816ef28.png)


![3D printed phone case, in a 3D printed adapter for Razer Junglecat controllers](https://user-images.githubusercontent.com/1850819/206942057-afb94754-9d87-486d-a1a3-1d513d2f3c8f.png)


# Features
 - hard plastic (PLA+, ABS, PETG) or flexible (TPU)
 - phone case mode
 - universal phone clamp mode
 - Switch Joy-Con rails
 - Razer Junglecat rails
 
 # How to use phone case generator
 - install [OpenSCAD](https://openscad.org/downloads.html) version 2021.01 or greater
 - Download the code and its dependencies using the git command line: `git clone https://github.com/SiloCityLabs/Cuttlephone.git --recurse-submodules`
 - open the file "phone_case.scad" to use the GUI
 
 # Build and publish scripts
 - in bash run `sh build.sh` to create all variants for all phones
 - in bash run `sh publish.sh` to copy the 3MF to the docs directory

# How to run the docs blog locally
 - generate a token at https://github.com/settings/tokens/new
 - select the scope *public_repository*
 - copy the token, save it in a password manager
 - install Ruby, gem, and bundle (or figure out the [Docker image of Github Pages](https://github.com/Starefossen/docker-github-pages))
 - `bundle update`
 - `JEKYLL_GITHUB_TOKEN=tokenGoesHere123456789 bundle exec jekyll serve --incremental`
 - watch the console for something like this: `Server address: http://127.0.0.1:4000/`

# Build logs 

You can follow progress here:
 - [HackADay.io project log](https://hackaday.io/project/165606-cuttlephone-gamepad-phone-case)
 - [SiloCityLabs project blog / newsletter](https://silocitylabs.com/categories/projects/)
 - [SiloCityLabs Twitter](https://twitter.com/silocitylabs)


# Roadmap

...


Licensed under Creative Commons CC-BY-SA 4.0
