include <libraries/BOSL2_submodule/std.scad>

$fn=35;

magnet_width = 7.1; // [ 0.1 : 0.1 : 10  ]
magnet_depth = 1.7; // [ 0.1 : 0.1 : 10  ]
taper_width = 0.1; // [ 0 : 0.1 : 1.5  ]
//cup_depth = 1.0;

holder_length = 6.9; // [ 1 : 1 : 12 ]
hex_length=12; // [ 1 : 1 : 20 ]

// size of the chuck in mm. 1/4"==6.35mm
hex_diam=6.35; // 1/4 inch from flat to flat
slot_width=6.7;

smidge=0.01;

// m3 screw == 2.6mm hole
screw_hole_diam = 2.6; 

difference() {
    union() {
        // hex shank
        rotate([180,0,0])
        linear_extrude(height=hex_length) {
            hexagon(
                id=hex_diam
            );
        }
        
        // magnet holder
        cyl(
            d=magnet_width*1.3, 
            h=holder_length,
            anchor=BOTTOM
        );
        
        // taper down so we don't need supports
        cyl(
            d1=hex_diam/2, 
            d2=magnet_width*1.3, 
            h=holder_length,
            anchor=TOP
        );
    }
    
    // cup cutout to hold magnet
    translate([0,0,holder_length+smidge])
    cyl(
        d1=magnet_width,
        d2=magnet_width+taper_width,
        h=magnet_depth,
        anchor=TOP
    );
    
    // shave sides to fit in the joycon2 slot
    translate([-slot_width/2,0,0])
    cuboid([50,50,50], anchor=BOTTOM+RIGHT);
    
    translate([slot_width/2,0,0])
    cuboid([50,50,50], anchor=BOTTOM+LEFT);
    
    
    // screw hole for magnetic screwdriver shaft
    translate([0,0,-hex_length-smidge])
    cyl(d=screw_hole_diam, h=hex_length, anchor=BOTTOM);
    
}