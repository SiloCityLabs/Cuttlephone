// Gamepad phone case
// Author: Maave

$fn=25;

/*  measurements from the phone
    all values in mm
    clearances and fudge-factors should be in separate variables
    Customizer's precision (0.1, 0.01, etc) depends on the precision of the variable
    
*/

face_radius = 5.25;
face_length = 145.5;
face_width = 70.1;
body_thickness = 8.1;
body_radius = 3.1;

screen_radius = 5.25;
screen_lip_length = 2.0;
screen_length = face_length - screen_lip_length;
screen_lip_width = 4.0;
screen_width = face_width - screen_lip_width;
extra_lip = true;

//this should be a multiple of nozzle diameter
shell_thickness = 1.2;

right_button = true;
right_button_offset = 31;
right_button_length = 42;
left_button = true;
left_button_offset = 35;
left_button_length = 42;

//camera cutout is a rectangle with rounded corners
camera_width = 20.5;
camera_height = 9.0;
camera_radius = 4.5;
camera_from_side = 8.5;
camera_from_top = 8.7;
// extra gap around camera. 0.5 - 2.0 recommended
camera_clearance = 1.0;

//for irregular shapes like Galaxy S9+
camera_cut_2 = false;
camera_width_2 = 20.5;
camera_height_2 = 9.0;
camera_from_side_2 = 8.5;
camera_from_top_2 = 8.7;

mic_notch_top = true;
mic_from_right_edge = 14.0;
headphone_from_left_edge = 14.0;
headphone_jack_cut = false;

bottom_speakers = false;

fingerprint = true;
fingerprint_center_from_top = 36.5;
fingerprint_diam = 13;

case_type = "phone case"; // [phone case, gamepad, joycon]
//joycon and junglecat rail requires support to print horizontally. "Cutout" support is designed to remove easily with a razor blade. "None" means you'll handle it yourself in your slicer.
rail_support = "cutout"; // [cutout, none]
//set this to your layer height
rail_support_airgap = 0.20; //TODO: test and tweak. This may depend on layer height.

//unsupported
lanyard_loop = false;

version_text = true;
phone_model = "Pixel 3";
minor_version = "";

module end_customizer_variables(){}

// phone case / general variables
buttons_fillet = 3;
buttons_flat = 3;
buttons_clearance = 10;
shell_radius = body_radius + shell_thickness;

// gamepad variables
gamepad_wing_length = 30; //max that will fit on my printer
gamepad_face_radius = 10;
gamepad_peg_y_distance = 14;

// joycon and junglecat shared variables
rail_shell_radius = 2; //sharper corner for looks
rail_face_radius = 2; //sharper corner for looks

// joycon variables
joycon_inner_width = 10.4;
joycon_lip_width = 8.0;
joycon_lip_thickness = 0.3; //should be a multiple of nozzle width
joycon_depth = 2.8;
// shell is thickened to fit the joycon
joycon_min_thickness = joycon_inner_width + 2*shell_thickness;
joycon_thickness = (body_thickness < joycon_min_thickness) ? joycon_min_thickness:body_thickness;
joycon_z_shift = body_thickness-joycon_thickness+2*shell_thickness;

//junglecat variables
junglecat_inner_width = 6;
junglecat_lip_width = 2;
junglecat_lip_thickness = 1;
junglecat_depth = 2;

//embossment. These variables come in via command line arguments
name = "Cuttlephone";
author = "Maave";
major_version = "v0.1 ";
version = str(major_version, minor_version);

if(case_type=="phone case") {
    phone_case();
}
else if(case_type=="gamepad") {
    gamepad();
}
else if(case_type=="joycon") {
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
        shell_cuts();
    }
}

module gamepad(){
    color("SeaGreen")
    difference(){
        gamepad_shell();
        body();
        shell_cuts();
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
        shell_cuts();
        joycon_cuts();
    }
}

module junglecat_rails(){
    color("SeaGreen")
    difference(){
        junglecat_shell();
        body();
        shell_cuts();
        junglecat_cuts();
    }
}

//body();
module body(){
    color("orange", 0.2)
    minkowski() {
        linear_extrude(height = 0.05, center = true) {
            //face profile
            minkowski() {
                square( [face_width - 2*face_radius - 2*body_radius, 
                face_length - 2*face_radius - 2*body_radius], true );
                circle(face_radius);
            }
        }
        // side profile
        body_profile();
    }
}
//body_profile();
module body_profile(){
    hull(){
        translate ([0, 0, body_thickness/2-body_radius]) 
            sphere(body_radius);
        translate ([0, 0, -body_thickness/2+body_radius]) 
            sphere(body_radius);
    }   
}

module shell_cuts(){
    usb_cut();
    right_button_cut();
    left_button_cut();
    camera_cut();
    extra_camera_cut();
    fingerprint_cut();
    mic_cut();
    top_headphone_cut();
    screen_cut();
    lanyard_cut();
    version_info_emboss();
}

//phone_shell();
module phone_shell(){
    minkowski() {
        //face shape
        linear_extrude(height = 0.05, center = true) {
            minkowski() {
                square(
                    [ face_width + shell_thickness - 2*face_radius - 2*body_radius,
                    face_length + shell_thickness - 2*face_radius - 2*body_radius ], 
                    true);
                circle(face_radius-0.25); //can't intersect with phone body
            }
        }
        //edge shape and thickness
        shell_profile();
    }
}

//shell_profile();
module shell_profile(){
    lip_length = 0.5;
    extra_lip_bonus = extra_lip ? 1 : 0;
    hull(){
        translate ([0, 0, body_thickness/2-body_radius+extra_lip_bonus])
        sphere(shell_radius);
        translate ([0, 0, -body_thickness/2+body_radius])
        sphere(shell_radius);
    }
}

module gamepad_shell(){
    minkowski() {
        //face shape
        linear_extrude(height = 0.05, center = true) {
            minkowski() {
                square(
                    [ face_width + shell_thickness - 2*gamepad_face_radius - 2*body_radius,
                    face_length + gamepad_wing_length*2 + shell_thickness - 2*gamepad_face_radius - 2*body_radius ], 
                    true);
                circle(gamepad_face_radius-0.25); //can't intersect with phone body
            }
        }
        //edge shape and thickness
        shell_profile();
    }
}

module joycon_shell(){
    //sharper corners for joycon rail
    rail_face_radius = 2;
    
    translate([0,0,joycon_z_shift])
    minkowski() {
        //face shape
        linear_extrude(height = 0.05, center = true) {
            minkowski() {
                square(
                    [ face_width + shell_thickness - 2*rail_face_radius - 2*rail_shell_radius,
                    face_length + shell_thickness + 2*joycon_depth + 2*joycon_lip_thickness - 2*rail_face_radius - 2*rail_shell_radius ],
                    true);
                circle(rail_face_radius);
            }
        }
        //edge shape and thickness
        joycon_shell_profile();
    }
}
module joycon_shell_profile(){
    shell_radius = rail_shell_radius + shell_thickness;
    hull(){
        translate ([0, 0, joycon_thickness/2-rail_shell_radius]) 
            sphere(shell_radius);
        translate ([0, 0, -joycon_thickness/2+rail_shell_radius]) 
            sphere(shell_radius);
    }
}

module junglecat_shell(){
    minkowski() {
        //face shape
        linear_extrude(height = 0.05, center = true) {
            minkowski() {
                square(
                    [ face_width + shell_thickness - 2*rail_face_radius - 2*rail_shell_radius,
                    face_length + shell_thickness + 2*junglecat_depth + 2*junglecat_lip_thickness - 2*rail_face_radius - 2*rail_shell_radius ],
                    true);
                circle(rail_face_radius);
            }
        }
        //edge shape and thickness
        junglecat_shell_profile();
    }
}
module junglecat_shell_profile(){
        shell_radius = rail_shell_radius + shell_thickness;
        hull(){
        translate ([0, 0, body_thickness/2-rail_shell_radius]) 
            sphere(shell_radius);
        translate ([0, 0, -body_thickness/2+rail_shell_radius]) 
            sphere(shell_radius);
    }   
}

//junglecat_cuts();
module junglecat_cuts(){
    copy_mirror() {
        color("red", 0.2)
        translate([0, -face_length/2-shell_thickness-junglecat_depth/2, 0]) {
            //inner cutout
            cube([face_width+shell_thickness+2,junglecat_depth,junglecat_inner_width],center=true);
            //lip cutout
            translate([0,-junglecat_depth/2-junglecat_lip_thickness/2,0]) {
                if(rail_support=="cutout"){
                    //manual support inspired by Tokytome https://www.thingiverse.com/thing:2337833
                    difference(){
                        cube([face_width+shell_thickness+1, junglecat_lip_thickness+1, junglecat_lip_width], center=true);
                        cube([face_width+shell_thickness-rail_support_airgap, junglecat_lip_thickness+1.5, junglecat_lip_width-rail_support_airgap], center=true);
                    }
                } else { //bring your own support
                    cube([face_width+shell_thickness+1, junglecat_lip_thickness+1, junglecat_lip_width], center=true);
                }
            }
        }
    }
}

//joycon_cuts();
module joycon_cuts(){
    lock_notch_width = 4.5;
    lock_notch_depth = (joycon_inner_width-joycon_lip_width)/2;
    lock_notch_offset = 9.75;
    copy_mirror() {
        color("red", 0.2)
        translate([0, -face_length/2-shell_thickness-joycon_depth/2, joycon_z_shift]) {
            //inner cutout
            cube([face_width+shell_thickness+2,joycon_depth,joycon_inner_width],center=true);
            //lip cutout
            translate([0,-joycon_depth/2-joycon_lip_thickness/2,0]) {
                //manual support inspired by Tokytome https://www.thingiverse.com/thing:2337833
                if(rail_support=="cutout"){
                    //this adds a visible lip so you rip off the support and not the rail
                    removal_aid = 8;
                    difference(){
                        cube([face_width+shell_thickness+1, joycon_lip_thickness+1, joycon_lip_width], center=true);
                        cube([face_width-removal_aid, joycon_lip_thickness+1.5, joycon_lip_width-rail_support_airgap], center=true);
                    }
                } else { //bring your own support
                    cube([face_width+shell_thickness+1, joycon_lip_thickness+1, joycon_lip_width], center=true);
                }
            }
            //lock notch
            translate([face_width/2-lock_notch_depth/2-lock_notch_offset, -joycon_depth/2-joycon_lip_thickness/2, -joycon_lip_width/2-lock_notch_depth/2])
            cube([lock_notch_width, joycon_lip_thickness+0.5, lock_notch_depth], center=true);
        }
    }
}

gamepad_cut_radius = gamepad_face_radius;
gamepad_cutout_translate = face_length/2+gamepad_wing_length/2-1;
//gamepad_cuts();
//gamepad_hole();
module gamepad_hole(){
    //TOOD: cylinder-minkowski clips through sphere-minkowski
    radius_buffer = 2;
    translate([0,-gamepad_cutout_translate,-body_thickness/2+shell_thickness +2])
    minkowski() {
        cube( 
            [face_width - 2*gamepad_cut_radius - radius_buffer,
            gamepad_wing_length - 2*gamepad_cut_radius - shell_thickness - radius_buffer,
            body_thickness/2],
            center=true
        );
        cylinder(
            h=body_thickness/2+shell_thickness, 
            r=gamepad_cut_radius,
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
    translate( [-12, -face_length/2 - 2, -body_thickness/2+ffc_height/2] )
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
    //color("red", 0.2) peg_cuts();
    module peg_cuts() {
        translate([0,-gamepad_cutout_translate,-body_thickness/2+shell_thickness +2]) {
            cube( 
                [face_width +10,
                gamepad_peg_y_distance,
                body_thickness/2+8],
                center=true
            );
            cube( 
                [face_width - body_thickness -3,
                gamepad_wing_length+0,
                body_thickness/2+8],
                center=true
            );
        }
    }
    //button_holes();
    module button_holes(){
        gamepad_button_diam = 7; //snes=10.5
        //center of A to center of B
        gamepad_button_offset = 13; //should I make this edge-to-edge for easier caliper measuring?
        translate([10, -gamepad_cutout_translate, -body_thickness/2+shell_thickness +2])
        rotate([0,0,45])
        copy_mirror([0,1,0]) {
            copy_mirror([1,0,0]) {
                translate([gamepad_button_offset/2,gamepad_button_offset/2,0])
                cylinder(h=20,r=gamepad_button_diam/2,center=true);
            }
        }
    }
    //dpad_hole();
    module dpad_hole(){
        dpad_width = 25.4;
        dpad_thickness = 9.6;
        translate([10, -gamepad_cutout_translate, -body_thickness/2+shell_thickness +10]) {
            cube([dpad_width,dpad_thickness,20],center=true);
            rotate([0,0,90])
            cube([dpad_width,dpad_thickness,20],center=true);
        }
    }
    //start_select_hole();
    module start_select_hole(){
        start_select_length = 7; //not actually length, arbitrary number
        start_select_radius = 1.5;
        translate([-20, -gamepad_cutout_translate+5, -body_thickness/2+shell_thickness +5])
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
// awful. Too many hardcoded numbers. I don't have a good vision of how this should work
module gamepad_trigger(){
    pin_length = 2 + gamepad_peg_y_distance;
    //translate([5,0,-10])
    translate( [ face_width/2-11,
    -gamepad_cutout_translate,
    -body_thickness/2+shell_thickness +1 ] ) {
        //pivot pin
        rotate([-90,0,0])
        translate([9,-4,0])
        cylinder(h=pin_length,r=1, center=true);
        //trigger face
        translate([8.5,0,0])
        cube(size=[3,gamepad_peg_y_distance,10], center=true);
        //the part that presses the silicone
        translate([2,0,-2])
        cube(size=[12,gamepad_peg_y_distance/2,2], center=true);
        //angle keep the trigger in
        rotate([-180,0,90])
        translate([-3.5,-9,1])
        prism(gamepad_peg_y_distance/2, 5, 2);

    }
}

//color("red", 0.2) screen_cut();
module screen_cut(){
   translate([0,0,body_thickness/2]) 
   linear_extrude(height = 6, center = true) {
        minkowski() {
            //TODO: why is this -2?
            square([screen_width-2*screen_radius, screen_length-2*screen_radius], true);
            circle(screen_radius);
        }
    }
}

//color("red", 0.2) lanyard_cut();
module lanyard_cut(){
    //unsupported
    if(lanyard_loop) {
        /*  
        //thick ring shaped extension
        rotate([0,90,0])
        translate([0,-face_length/2-3,face_width/4])
        ring(8, body_thickness+shell_thickness*2, 7, 0.1 );
        */
        //ring cutout makes 2 slots for thin string lanyards
        translate([face_width/3.5,-face_length/2,-body_thickness/3])
        ring(body_thickness/2, 9, 6, 0.1 );
    }
}

//usb_cut();
module usb_cut(){
    charge_port_height = 10;
    charge_port_width = bottom_speakers ? face_width*0.55 : 8;
    color("red", 0.2)
    translate( [0, -face_length/2 - 2, 2] )
    rotate( [90, 0, 0] )
    union(){
        hull(){
            translate ([charge_port_width/2, 0, 0]) 
                cylinder( 10, charge_port_height/2, charge_port_height/2, true);
            translate ([-charge_port_width/2, 0, 0]) 
                cylinder( 10, charge_port_height/2, charge_port_height/2, true);
            //bridges weren't printing nicely. Trying a full cutout
            translate ([charge_port_width/2, 5, 0]) 
                cylinder( 10, charge_port_height/2, charge_port_height/2, true);
            translate ([-charge_port_width/2, 5, 0]) 
                cylinder( 10, charge_port_height/2, charge_port_height/2, true);
        }
        
        //corner of the cutout was snagging clothing
        translate ([charge_port_width/2+5, 5, 0]) 
        rotate([0,0,45])
        cube([10,5,10], center=true);
        
        translate ([-charge_port_width/2-5, 5, 0]) 
        rotate([0,0,-45])
        cube([10,5,10], center=true);
    }
}

//right_button_cut=true; right_button_cut();
module right_button_cut(){
    if(right_button) {
        color("red", 0.2)
        translate( [ face_width/2+buttons_flat+1.4, 
        face_length/2 - right_button_offset - right_button_length + buttons_fillet - buttons_clearance/2, -body_thickness/2 ] )
        rotate([0,-90,0]) {
            minkowski() {
                cube([10, right_button_length - 2*buttons_fillet + buttons_clearance, buttons_flat],false);
                sphere(r=buttons_fillet);
            }
            
            //corner of the cutout was snagging clothing
            translate ([body_thickness+1, right_button_length - buttons_fillet + buttons_clearance, 1]) 
            rotate([0,0,45])
            cube([10,5,15], center=true);
            
            translate ([body_thickness+1, -buttons_fillet, 1]) 
            rotate([0,0,-45])
            cube([10,5,15], center=true);
            
            translate ([body_thickness+1, right_button_length/2 + buttons_fillet/2, 1]) 
            rotate([0,0,90])
            cube([right_button_length+buttons_clearance,5,15], center=true);
        }
    }
}

//left_button=true; left_button_cut();
module left_button_cut(){
    if(left_button){
        color("red", 0.2)
        translate( [ -face_width/2+buttons_flat-4.5, //match this offset, it's cus the cube isn't centered)
        face_length/2 - left_button_offset - left_button_length + buttons_fillet - buttons_clearance/2, -body_thickness/2 ] )
        rotate([0,-90,0]) {
            minkowski() {
                cube([10, left_button_length - 2*buttons_fillet + buttons_clearance, buttons_flat],false);
                sphere(r=buttons_fillet);
            }
            
            //corner of the cutout was snagging clothing
            translate ([body_thickness+1, left_button_length - buttons_fillet + buttons_clearance, 1]) 
            rotate([0,0,45])
            cube([10,5,15], center=true);
            
            translate ([body_thickness+1, -buttons_fillet, 1]) 
            rotate([0,0,-45])
            cube([10,5,15], center=true);
            
            translate ([body_thickness+1, left_button_length/2 + buttons_fillet/2 , 1]) 
            rotate([0,0,90])
            cube([left_button_length+buttons_clearance,5,15], center=true);
        }
    }
}

//color("red", 0.2) camera_cut();
module camera_cut(){
    camera_radius_clearanced = camera_radius+camera_clearance;
    color("red", 0.2)
    translate( [ face_width/2-camera_radius-camera_from_side,
    face_length/2-camera_radius-camera_from_top,
    -body_thickness-shell_thickness+0.5] )
    hull(){
        //top left
        cylinder( 10.1, camera_radius_clearanced*2, camera_radius_clearanced, true);
        //top right
        translate ([-camera_width+camera_radius,0,0]) 
            cylinder( 10.1, camera_radius_clearanced*2, camera_radius_clearanced, true);
        //bottom left
        translate ([0,-camera_height+2*camera_radius,0]) 
            cylinder( 10.1, camera_radius_clearanced*2, camera_radius_clearanced, true);
        //bottom right
        translate ([-camera_width+camera_radius,-camera_height+2*camera_radius,0]) 
            cylinder( 10.1, camera_radius_clearanced*2, camera_radius_clearanced, true);
    }
}

//color("red", 0.2) extra_camera_cut();
module extra_camera_cut(){
    if (camera_cut_2) {
        camera_radius_clearanced = camera_radius+camera_clearance;
        color("red", 0.2)
        translate( [ face_width/2-camera_radius-camera_from_side_2,
        face_length/2-camera_radius-camera_from_top_2,
        -body_thickness-shell_thickness+0.5] )
        hull(){
            //top left
            cylinder( 10.1, camera_radius_clearanced*2, camera_radius_clearanced, true);
            //top right
            translate ([-camera_width_2+camera_radius,0,0]) 
                cylinder( 10.1, camera_radius_clearanced*2, camera_radius_clearanced, true);
            //bottom left
            translate ([0,-camera_height_2+2*camera_radius,0]) 
                cylinder( 10.1, camera_radius_clearanced*2, camera_radius_clearanced, true);
            //bottom right
            translate ([-camera_width_2+camera_radius,-camera_height_2+2*camera_radius,0]) 
                cylinder( 10.1, camera_radius_clearanced*2, camera_radius_clearanced, true);
        }
    }
}



//fingerprint_cut();
module fingerprint_cut(){
    if (fingerprint){
        fingerprint_radius = fingerprint_diam/2;
        fingerprint_cut_height = 6; //TODO: calculate this
        color("red", 0.2)
        translate( [ 0, face_length/2-fingerprint_center_from_top, -body_thickness/2-fingerprint_cut_height/2 ] )
        cylinder( fingerprint_cut_height, fingerprint_radius*2, fingerprint_radius, true);
    }
}

//color("red", 0.2) mic_cut();
module mic_cut(){
    //can this be improved?
    hole_size = 3;
    if (mic_notch_top) {
        if (case_type=="joycon") {
            translate( [ face_width/2-mic_from_right_edge, face_length/2, -2 ] )
            rotate([90,0,0])
            hull(){
                cylinder( 20, hole_size, hole_size, true);
                translate ([0,6,0]) 
                    cylinder( 20, hole_size, hole_size, true);
            }
        } else {
            translate( [ face_width/2-mic_from_right_edge, face_length/2, 0 ] )
            rotate([90,0,0])
            cylinder( 20, hole_size, hole_size, true);
        }
    }
}

//top_headphone_cut();
module top_headphone_cut(){
    //can this be improved?
    hole_size = 4;
    if (headphone_jack_cut) {
        if (case_type=="joycon") {
            color("red", 0.2)
            translate( [ -face_width/2+headphone_from_left_edge+1.7, face_length/2, -2 ] )
            rotate([90,0,0])
            hull(){
                cylinder( 20, hole_size, hole_size, true);
                translate ([0,6,0]) 
                    cylinder( 20, hole_size, hole_size, true);
            }
        } else {
            color("red", 0.2)
            //we measure from edge of phone to edge of the 3.5mm jack. Move an extra +1.7 to center
            translate( [ -face_width/2+headphone_from_left_edge+1.7, face_length/2, 1 ] ) {
                rotate([90,0,0])
                hull(){
                    cylinder( 20, hole_size, hole_size, true);
                    translate ([0,6,0])
                        cylinder( 20, hole_size, hole_size, true);
                }
                
                //anti snag bevel
                translate([0,0,5])
                rotate([0,45,0])
                cube([8,8,8], center=true);
            }
        }
    }
}

//version_info_emboss();
module version_info_emboss(){
    if(version_text) {
        //emboss_font = "Liberation Sans";
        emboss_font = "Project Paintball"; //non-commercial
        font_size = 8;
        line_translate = 12;
        color("red")
        rotate([0,0,-90])
        translate([-10,10,-body_thickness/2]) {
            linear_extrude(height = shell_thickness/2, center = true) {
                text(name, font=emboss_font, size=font_size);
                translate([0,-line_translate,0])
                text(version, font=emboss_font, size=font_size);
                translate([0,-line_translate*2,0])
                text(phone_model, font=emboss_font, size=font_size);
            }
        }
    }
}

/////////////////////
// support functions

module prism(l, w, h){
   polyhedron(
           points=[ [0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h] ],
           faces=[ [0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1] ]
    );
}
module ring(h=8, od = body_thickness+shell_thickness*2, id = 7, de = 0.1 ) {
    difference() {
        cylinder(h=h, r=od/2);
        translate([0, 0, -de])
            cylinder(h=h+2*de, r=id/2);
    }
}
module copy_mirror(vec=[0,1,0]){
    children();
    mirror(vec) children();
}