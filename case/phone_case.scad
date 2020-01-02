// Gamepad phone case
// Author: Maave

$fn=50;

//Default values for Pixel 3

body_radius = 5.25;
body_length = 145.5;
body_width = 68.7;

//a combination of the edge profile radius and the devices thickness
side_radius_thickness = 4.03;
screen_length = 143.5; //should I change these to "screen lip=2"?
screen_width = 66.5;

//make this a multiple of nozzle size
shell_thickness = 0.8;

button_right_offset = 31;
button_right_length = 42;
camera_height = 12;
camera_width = 22;
camera_from_edge = 9.7; //correct measurement, position is wrong
camera_from_top = 8.7;  //correct measurement, position is wrong
mic_from_edge = 14.0;

fingerprint_center_from_top = 36.5;
fingerprint_diam = 13;

case_type = "gamepad"; // [phone case, gamepad, joycon rails, junglecat rails]

module end_customizer_variables(){} //jank to get variables out of the customizer
wing_length = 30; //max that will fit on my printer
gamepad_body_radius = 10;
buttons_fillet = 3;


if(case_type=="phone case") {
    phone_case();
} 
else if(case_type=="gamepad") {
    gamepad();
}
else if(case_type=="joycon rails") {
    joycon_rails();
}
else if(case_type=="junglecat rails") {
    junglecat_rails();
}

module phone_case(){
    color("SeaGreen")
    difference(){
        phone_shell();
        body();
        cuts();
    }
}

module gamepad(){
    color("SeaGreen")
    difference(){
        gamepad_shell();
        body();
        cuts();
        gamepad_cuts();
    }
    
    gamepad_trigger();
    copy_mirror() gamepad_trigger();
    gamepad_faceplates();
}


module joycon_rails(){
    color("SeaGreen")
    difference(){
        joycon_shell();
        body();
        cuts();
        joycon_cuts();
    }
}

module junglecat_rails(){
}

//body();
module body(){
    minkowski() {
        linear_extrude(height = 0.05, center = true) {
            //face profile
            minkowski() {
                square( [body_width - 2*body_radius - 2*side_radius_thickness, 
                body_length - 2*body_radius - 2*side_radius_thickness], true );
                circle(body_radius);
            }
        }
        // side profile
        // TODO: separate thickness and radius
        sphere(side_radius_thickness);
    }
}

module cuts(){
    usb_cut();
    right_button_cut();
    camera_cut();
    fingerprint_cut();
    mic_cut();
    screen_cut();
    top_cut();
}

module phone_shell(){
    minkowski() {
        //face shape
        linear_extrude(height = 0.05, center = true) {
            minkowski() {
                square(
                    [ body_width + shell_thickness - 2*body_radius - 2*side_radius_thickness,
                    body_length + shell_thickness - 2*body_radius - 2*side_radius_thickness ], 
                    true);
                circle(body_radius-0.25); //can't intersect with phone body
            }
        }
        //edge shape and thickness
        sphere(side_radius_thickness+shell_thickness);
    }
}

module gamepad_shell(){
    minkowski() {
        //face shape
        linear_extrude(height = 0.05, center = true) {
            minkowski() {
                square(
                    [ body_width + shell_thickness - 2*gamepad_body_radius - 2*side_radius_thickness,
                    body_length + wing_length*2 + shell_thickness - 2*gamepad_body_radius - 2*side_radius_thickness ], 
                    true);
                circle(gamepad_body_radius-0.25); //can't intersect with phone body
            }
        }
        //edge shape and thickness
        sphere(side_radius_thickness+shell_thickness);
    }
}

module joycon_shell(){
    joycon_body_radius = 2; //sharper corner for joycon rail
    joycon_depth = 10;
    joycon_width = 10;
    
    if (body_radius < joycon_body_radius) {
        joycon_body_radius = body_radius-0.25;
    }
    
    minkowski() {
        //face shape
        linear_extrude(height = 0.05, center = true) {
            minkowski() {
                square(
                    [ body_width + shell_thickness - 2*joycon_body_radius - 2*side_radius_thickness,
                    body_length + joycon_depth*2 + shell_thickness - 2*joycon_body_radius - 2*side_radius_thickness ], 
                    true);
                circle(joycon_body_radius); //can't intersect with phone body
            }
        }
        //edge shape and thickness
        sphere(side_radius_thickness+shell_thickness);
    }
}

module joycon_cuts(){
    
}

gamepad_cutout_radius = gamepad_body_radius;
gamepad_cutout_translate = body_length/2+wing_length/2-1;
//gamepad_cuts();
//gamepad_hole();
module gamepad_hole(){
    //TOOD: cylinder-minkowski clips through sphere-minkowski, hence "+1"
    translate([0,-gamepad_cutout_translate,-side_radius_thickness+shell_thickness +2])
    minkowski() {
        cube( 
            [body_width - 2*gamepad_cutout_radius - 2*side_radius_thickness + side_radius_thickness,
            wing_length - 2*gamepad_cutout_radius - shell_thickness -2,
            side_radius_thickness],
            center=true
        );
        cylinder(
            h=side_radius_thickness+shell_thickness, 
            r=gamepad_cutout_radius,
            center=false
        );
    }
}
module gamepad_trigger_cut() {
        gamepad_trigger();
}
module gamepad_ffc_cut(){
    ffc_height = 4;
    ffc_width = 5;
    translate( [-12, -body_length/2 - 2, -side_radius_thickness+ffc_height/2] )
    rotate( [90, 0, 0] )
    hull(){
        translate ([ffc_width/2, 0]) 
            cylinder( 10, ffc_height/2, ffc_height/2, true);
        translate ([-ffc_width/2, 0]) 
            cylinder( 10, ffc_height/2, ffc_height/2, true);
    }
}
module gamepad_cuts(){
    copy_mirror() {
        gamepad_hole();
        gamepad_trigger_cut();
        gamepad_ffc_cut();
    }
}
module gamepad_faceplates(){
    //color("red") peg_cuts();
    module peg_cuts() {
        translate([0,-gamepad_cutout_translate,-side_radius_thickness+shell_thickness +2]) {
            cube( 
                [body_width +10,
                wing_length - 2*gamepad_cutout_radius - shell_thickness +2,
                side_radius_thickness+8],
                center=true
            );
            cube( 
                [body_width - 2*side_radius_thickness -3,
                wing_length+0,
                side_radius_thickness+8],
                center=true
            );
        }
    }
    //button_holes();
    module button_holes(){
        hole_diam = 10.5;
        hole_offset_crap = 8.85; //todo: make this edge-to-edge for hand measuring
        translate([10, -gamepad_cutout_translate, -side_radius_thickness+shell_thickness +2])
        rotate([0,0,45])
        copy_mirror([0,1,0]) {
            copy_mirror([1,0,0]) {
                translate([hole_offset_crap,hole_offset_crap,0])
                cylinder(h=20,r=hole_diam/2,center=true);
            }
        }
    }
    //dpad_hole();
    module dpad_hole(){
        dpad_width = 25.4;
        dpad_thickness = 9.6;
        translate([10, -gamepad_cutout_translate, -side_radius_thickness+shell_thickness +10]) {
            cube([dpad_width,dpad_thickness,20],center=true);
            rotate([0,0,90])
            cube([dpad_width,dpad_thickness,20],center=true);
        }
    }
    //start_select_hole();
    module start_select_hole(){
        start_select_length = 7; //not actually length, arbitrary number
        start_select_radius = 1.5;
        translate([-20, -gamepad_cutout_translate+5, -side_radius_thickness+shell_thickness +5])
        rotate([0,0,90])
        hull(){
            cylinder( 20, start_select_radius, start_select_radius, true);
            translate ([start_select_length-2*start_select_radius,0,0]) 
            cylinder( 20, start_select_radius, start_select_radius, true);
        }
    }

    color("SteelBlue")
    translate([0,0,10])
    difference(){
        gamepad_hole();
        peg_cuts();
        button_holes();
        start_select_hole();
    }
    color("SteelBlue")
    mirror([0,1,0])
    translate([0,0,10])
    difference(){
        gamepad_hole();
        peg_cuts();
        dpad_hole();
        start_select_hole();
    }
}

//gamepad_trigger();
// awful
module gamepad_trigger(){
    translate( [ body_width/2-10.5,
    -gamepad_cutout_translate-10,
    -side_radius_thickness+shell_thickness +1 ] ) {
        rotate([0,180,-90])
        prism(20,10,5);
        //extend button pusher
        translate([-8,4.5,-2])
        cube(size=[10,10,2], center=false);
        //extend trigger face up to pin
        translate([8,0,-5])
        cube(size=[3,20,10], center=false);
        //pin
        rotate([-90,0,0])
        translate([9,-4,-1])
        cylinder(h=22,r=1, center=false);
    }
}

//screen_cut();
module screen_cut(){
    clearanced_body_radius = body_radius+2; //give the screen radius a little more lip
    translate([0,0,5]) 
    minkowski() {
        linear_extrude(height = 10, center = true) {
            minkowski() {
                square([screen_width-2*clearanced_body_radius, screen_length-2*clearanced_body_radius], true);
                circle(clearanced_body_radius);
            }
        }
    }
}

//usb_cut();
module usb_cut(){
    charge_port_height = 7;
    charge_port_width = 7;
    translate( [0, -body_length/2 - 2, 0] )
    rotate( [90, 0, 0] )
    hull(){
        translate ([charge_port_width/2, 0]) 
            cylinder( 10, charge_port_height/2, charge_port_height/2, true);
        translate ([-charge_port_width/2, 0]) 
            cylinder( 10, charge_port_height/2, charge_port_height/2, true);
    }
}

//right_button_cut();
module right_button_cut(){
    color("red")
    translate( [ body_width/2, 
    body_length/2 - button_right_offset - button_right_length + buttons_fillet, buttons_fillet-side_radius_thickness/1.5 ] )
    rotate([0,-90,0])
    minkowski() {
        linear_extrude(height = 20, center = true) {
            minkowski() {
                square([10, button_right_length - 2*buttons_fillet],false);
                circle(buttons_fillet);
            }
        }
    }
}

//camera_cut();
module camera_cut(){
    camera_radius = camera_height/2;
    translate( [ body_width/2-camera_radius-camera_from_edge,
    body_length/2-camera_radius-camera_from_top,
    -side_radius_thickness ] )
    hull(){
        cylinder( 5, camera_radius, camera_radius, true);
        translate ([camera_height-camera_width,0,0]) 
            cylinder( 5, camera_radius, camera_radius, true);
    }
}

//fingerprint_cut();
module fingerprint_cut(){
    fingerprint_radius = fingerprint_diam/2;
    translate( [ 0, body_length/2-fingerprint_center_from_top, -side_radius_thickness-2 ] )
    cylinder( 4, fingerprint_radius*3, fingerprint_radius, true);     
}

//mic_cut();
module mic_cut(){
    //I feel like this could be improved
    translate( [ body_width/2-mic_from_edge, body_length/2, 0 ] )
    hull(){
        cylinder( 20, 2, 2, true);
        translate ([0,2,0]) 
            cylinder( 20, 2, 2, true);
    }
}

//top_cut();
module top_cut(){
    translate([0,0,7]) 
    cube( [ 100, screen_length+200, 5 ], center=true );
}

/////////////////////
// support functions

module prism(l, w, h){
   polyhedron(
           points=[ [0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h] ],
           faces=[ [0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1] ]
    );
}

module copy_mirror(vec=[0,1,0]){
    children();
    mirror(vec) children();
}