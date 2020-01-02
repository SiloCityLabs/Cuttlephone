# USB-C Gamepad
USB-C gamepad is a portable gamepad for smartphones. The shell of the gamepad is 3d printed so that the electronics can be used on multiple phones. 3d print a new shell when you buy a new phone.

# Status
A prototype (0.x) is currently in development. You can follow progress here:
 - [HackADay.io project log](https://hackaday.io/project/165606-usb-c-gamepad-phone-case)
 - [SiloCityLabs project blog / newsletter](https://silocitylabs.com/categories/projects/)
 - [SiloCityLabs Twitter](https://twitter.com/silocitylabs)
 - Coming soon: "usb-c-gamepad" blog category so you can subscribe to only gamepad updates without the side projects

[![](https://i.imgur.com/jmLhCeil.png)](https://hackaday.io/project/165606-usb-c-gamepad-phone-case)

# To-do
 - Finish prototype (write firmware, assemble PCB, 3D print case)
 - Demo and test prototype with friends
 - Post on a community like SudoMod or BitBuilt
 - Brainstorm v2 with the community

# How it works
v0.2 PCB is in progress. The heart is an ATmega32u4 which has built in USB support. The firmware will use the [LUFA library](https://github.com/abcminiuser/lufa) to implement USB HID. The case will be 3d printed to fit my personal phone and it will use buttons from an SNES controller. The two halves will connect with an 0.5mm pitch FFC.

# How can I help?
Stick around until the prototype is finished! Follow the project with the links above. I'm open to suggestions.

# Roadmap

####  Prototype, v1.0
 - Be a functional gamepad that works with Android
 - Cases for the team's personal phones (Pixel 3, Pixel 3 XL, Pixel 2 XL)
 - Controls for 2D-era emulation: D-Pad, 4 face buttons, 2 shoulder buttons, Start/Select
#### Public project, v2.0
 - Give the project a cool name
 - Ensure it's pocket-portable, make it easy to carry on a daily basis
 - Improve the button hardware, case design, etc based on testing with v1
 - Cases for other phones (community contribution pls)
 - Maybe some of the future goals ↓↓↓
#### Future goals
 - Controls for 3D-era emulation: add 2 joysticks, 2 analog triggers, some kind of L3/R3
 - Charging with the case attached
 - 3.5mm headphone jack
#### Stretch goals
 - Analog face buttons for MGS1-3 compatibility
 - Rotatable case for playing DS/3DS games vertically
 - PCB art




Licensed under Creative Commons CC-BY-SA 4.0
