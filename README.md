# Cuttlephone
Cuttlephone is a adaptable 3D printed phone case and USB-C gamepad. This is the source code

[Get premade 3MF files on the website](https://silocitylabs.github.io/Cuttlephone/)

# Status
A prototype (0.x) is currently in development. Currently supports:
 - phone case
 - Switch Joy-Con rails
 - Razer Junglecat rails
 
 # How to phone case generator
To create your own phone, install OpenSCAD, clone the repo or download the .ZIP, and run "case/phone_case.scad". Run "sh build.sh" to create all 3MF files.

# How to run blog locally
Install Ruby, gem, and bundle. Run `bundle update` and `bundle exec jekyll serve --incremental`. I couldn't get the Docker versions running on Windows, they wouldn't render the website, just show directory

# Build logs 

You can follow progress here:
 - [HackADay.io project log](https://hackaday.io/project/165606-cuttlephone-gamepad-phone-case)
 - [SiloCityLabs project blog / newsletter](https://silocitylabs.com/categories/projects/)
 - [SiloCityLabs Twitter](https://twitter.com/silocitylabs)

[![](https://user-images.githubusercontent.com/1850819/73496293-3f021080-4386-11ea-9fc7-d2fafe343bc1.png)](https://hackaday.io/project/165606-cuttlephone-gamepad-phone-case)

# To-do
 - Make a really good phone case
 - Finish gamepad prototype (write firmware, assemble PCB, 3D print case)
 - Demo and test prototype with friends
 - Community feedback, brainstorm v2

# How it works
The phone case uses OpenSCAD Customizer to support many phone models.

The gamepad uses an ATmega32u4 which has built in USB support. The firmware will use the [LUFA library](https://github.com/abcminiuser/lufa) to implement a USB HID gamepad.

# Roadmap

####  Prototype
 - Be a functional gamepad that works with Android
 - Cases for the team's personal phones
 - Controls for 2D-era emulation: D-Pad, 4 face buttons, 2 shoulder buttons, Start/Select
#### Public project
 - Ensure it's pocket-portable, make it easy to carry on a daily basis
 - Improve the button hardware, case design, etc based on testing
 - Cases for other phones (community help needed)
#### Future goals
 - Controls for 3D-era emulation: 2 joysticks, 2 analog triggers, some kind of L3/R3
 - Charging pass through
 - 3.5mm headphone jack
 - USB-C hub for additional features and DIY
#### Stretch goals
 - Analog face buttons for MGS1-3 compatibility
 - PCB art




Licensed under Creative Commons CC-BY-SA 4.0