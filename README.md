# Cuttlephone
Cuttlephone is phone case generator and gamepad system for 3D printing. This is the source code. [Get premade 3D models and print tutorials on the website](https://cuttlephone.com/)


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
 
 # Build scripts
 - in bash run `sh build.sh` to create all variants for all phones
 - GitHub Actions uploads those files to a [GitHub Release](https://github.com/SiloCityLabs/Cuttlephone/releases)

# How to run the docs blog locally

### With Docker:
 - `cd docs`
 - `docker compose up --build`
 - open http://127.0.0.1:4000/

### With Ruby on the host:
 - install Ruby 3.3 or newer, gem, and bundle
 - `cd docs`
 - `bundle install`
 - `sh run.sh`
 - watch the console for something like this: `Server address: http://127.0.0.1:4000/`

A GitHub token is optional. `jekyll-remote-theme` downloads the theme through the GitHub API, which is rate limited to 60 requests an hour without one. If you hit that limit:
- generate a token at https://github.com/settings/tokens/new with the scope *public_repo*
- copy `docs/.env.example` to `docs/.env`
- add token to `docs/.env`

# Build logs 

You can follow progress here:
 - [HackADay.io project log](https://hackaday.io/project/165606-cuttlephone-gamepad-phone-case)
 - [SiloCityLabs project blog / newsletter](https://silocitylabs.com/categories/projects/)
 - [SiloCityLabs Twitter](https://twitter.com/silocitylabs)


# Roadmap

...


Licensed under Creative Commons CC-BY-SA 4.0
