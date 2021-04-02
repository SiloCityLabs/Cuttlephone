/* Phone case generator
 * Supports phone case, Joycon rails, Junglecat rails, and Cuttlephone gamepad
 * Designed to 3d print with PLA+, 0.4 nozzle, 0.2 layer height
 * Author: Maave
 */

$fn=20;
use <fonts/orbitron/orbitron-light.otf>
//TODO: include these in the repo
include <BOSL2/std.scad> 
include <BOSL2/hull.scad>

/*  measurements from the phone
 *  all values are in mm
 *  Customizer's UI precision (0.1, 0.01, etc) depends on the precision of the variable
 */

//Is there a good way to measuring this on the phone? Print-out guide template?
//rounding of the corners when viewed screen-up.
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
extra_lip = false;

//this should be a multiple of nozzle diameter
shell_thickness = 1.2;

right_button = false;
right_button_from_top = 31;
right_button_length = 42;
left_button = false;
left_button_from_top = 35;
left_button_length = 42;

//camera cutout is a rectangle with rounded corners
camera_width = 20.5;
camera_height = 9.0;
//get a circle by setting camera_radius to half of height and width
camera_radius = 4.5;
camera_from_side = 8.5;
camera_from_top = 8.7;
// extra gap around camera. 0.5 - 1.0 recommended. 
camera_clearance = 1.0;

//for irregular shapes like Galaxy S9+
camera_cut_2 = false;
camera_width_2 = 20.5;
camera_height_2 = 9.0;
camera_from_side_2 = 8.5;
camera_from_top_2 = 8.7;

mic_notch_top = false;
mic_from_right_edge = 14.0;
headphone_from_left_edge = 14.0;
headphone_jack_cut = false;

bottom_speakers = false;

fingerprint = false;
fingerprint_center_from_top = 36.5;
fingerprint_diam = 13;

case_type = "phone case"; // [phone case, gamepad, joycon, junglecat]
//joycon and junglecat rail requires support to print horizontally. "Cutout" support is designed to remove easily with a razor blade. "None" means you'll handle it yourself in your slicer.
rail_support = "cutout"; // [cutout, none]
//set this to your layer height
support_airgap = 0.20; //TODO: test and tweak. This may depend on layer height.

//unsupported
lanyard_loop = false;

emboss_version_text = true;
phone_model = "Pixel 3";

//end customizer variables
module end_customizer_variables(){}
 
 /* I cannot override case_type for some reason, it doesn't take effect. But this works. */
case_type_override="stupid_hack";
case_type2 = (case_type_override!=undef && case_type_override!="stupid_hack") ? case_type_override : case_type;

// phone case / general variables
buttons_fillet = 3;
buttons_cut_thickness = 3;
buttons_clearance = 10;

// gamepad variables
gamepad_wing_length = 35; //max that will fit on my printer
gamepad_face_radius = 10;
gamepad_shell_radius = 2;
gamepad_peg_y_distance = 14;

// joycon and junglecat shared variables
rail_shell_radius = 2; //sharper corner for looks
rail_face_radius = 2; //sharper corner for looks

// joycon variables
joycon_inner_width = 10.4;
joycon_lip_width = 8.0;
joycon_lip_thickness = 0.4; //should be a multiple of nozzle width
joycon_depth = 2.8;
// shell is thickened to fit the joycon
joycon_min_thickness = joycon_inner_width + 2*shell_thickness;
joycon_thickness = (body_thickness < joycon_min_thickness) ? joycon_min_thickness:body_thickness;
joycon_z_shift = body_thickness-joycon_thickness+2*shell_thickness;

//junglecat variables
junglecat_inner_width = 3.5;
junglecat_lip_width = 2;
junglecat_lip_thickness = 0.4; //should be a multiple of nozzle width
junglecat_depth = 3.3;
junglecat_dimple_from_top = 63.5;

//embossment text
name = "Cuttlephone";
author = "Maave";
version = "v0.1";


color("SeaGreen")
if(case_type2=="phone case") {
    phone_case();
}
else if(case_type2=="gamepad") {
    gamepad();
}
else if(case_type2=="joycon") {
    joycon_rails();
}
else if(case_type2=="junglecat") {
    junglecat_rails();
}

module phone_case(){
    difference(){
        phone_shell();
        body();
        shell_cuts();
    }
}

module gamepad(){
    difference(){
        gamepad_shell();
        body();
        shell_cuts();
        gamepad_cuts();
    }
    
    gamepad_trigger();
    copy_mirror() gamepad_trigger();
    //gamepad_faceplates();
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
        cube([ face_width - 2*face_radius, 
            face_length - 2*face_radius, 
            0.05 ], 
            center=true
        );
        body_profile();
    }
}
//body_profile();
module body_profile(){
    cyl( 
        l=body_thickness, 
        r=face_radius,
        rounding1=body_radius, 
        rounding2=body_radius,
        $fn=15
    );
}

//phone_shell();
module phone_shell(){
    minkowski() {
        cube(
            [ face_width - 2*face_radius,
            face_length - 2*face_radius ,
            0.05 ],
            center=true
        );
        shell_profile();
    }
}

//shell_profile();
module shell_profile(){
    extra_lip_bonus = extra_lip ? 1 : 0;
    translate([0,0,extra_lip_bonus/2])
    cyl( 
        l=body_thickness + 2*shell_thickness + extra_lip_bonus, 
        r=face_radius+shell_thickness,
        rounding1=body_radius, 
        rounding2=body_radius
    );
}

module gamepad_shell(){
    minkowski() {
        //face shape
        cube(
            [ face_width - 2*gamepad_face_radius,
            face_length + gamepad_wing_length*2 - 2*gamepad_face_radius,
            0.05 ], 
            center=true);
        //edge shape and thickness
        cyl( 
            l=body_thickness + 2*shell_thickness, 
            r=gamepad_face_radius+shell_thickness,
            rounding1=gamepad_shell_radius, 
            rounding2=gamepad_shell_radius
        );
    }
}

module joycon_shell(){
    translate([0,0,joycon_z_shift])
    minkowski() {
        //face shape
        cube(
            [ face_width - 2*rail_face_radius,
            face_length + 2*joycon_depth + 2*joycon_lip_thickness - 2*rail_face_radius,
            0.05 ],
            center=true);
        //edge shape and thickness
        cyl( 
            l=joycon_thickness + 2*shell_thickness, 
            r=rail_face_radius+shell_thickness,
            rounding1=rail_shell_radius, 
            rounding2=rail_shell_radius
        );
    }
}


//TODO: tidy this up like the gamepad/joycon
module junglecat_shell(){
    minkowski() {
        //face shape
        cube(
            [ face_width - 2*rail_face_radius,
            face_length + 2*junglecat_depth + 2*junglecat_lip_thickness - 2*rail_face_radius,
            0.05 ],
            center=true
        );
        //edge shape and thickness
        cyl( 
            l=body_thickness + 2*shell_thickness, 
            r=rail_face_radius+shell_thickness,
            rounding1=rail_shell_radius, 
            rounding2=rail_shell_radius
        );
    }
}

//junglecat_cuts();
junglecat_rail_length = 60.0; //there's a bevel that I'm not trying to model
module junglecat_cuts(){
    copy_mirror() {
        color("red", 0.2)
        translate([0, -face_length/2-shell_thickness-junglecat_depth/2, 0]) {
            //dimple
            translate([face_width/2-junglecat_dimple_from_top,
            -(shell_thickness+junglecat_lip_thickness),
            0])
            sphere(d=2.0);
            //inner cutout
            //junglecat_fudge = 0;
            //junglecat_inner_chamfer = 0;
            translate([(face_width-junglecat_rail_length)/2+shell_thickness,0,0])
            rotate([0,90,0])
            prismoid(
                size1=[junglecat_inner_width, junglecat_depth], 
                size2=[junglecat_inner_width, junglecat_depth], 
                h=junglecat_rail_length,
                chamfer=[0,0,0,0],
                rounding=[0,junglecat_depth/2,junglecat_depth/2,0],
                anchor=CENTER
            );
            //lip cutout
            translate([(face_width-junglecat_rail_length)/2+shell_thickness,-junglecat_depth/2-junglecat_lip_thickness/2,0]) {
                if(rail_support=="cutout"){
                    //this adds a visible lip so you rip off the support and not the rail
                    removal_aid = 4;
                    rotate([90,0,0])
                    rect_tube(
                        size=[ junglecat_rail_length+shell_thickness, junglecat_lip_width+support_airgap],
                        isize=[junglecat_rail_length, junglecat_lip_width], 
                        h=junglecat_depth,
                        anchor=CENTER);
                } else { //bring your own support
                    cube([face_width+shell_thickness+1, junglecat_lip_thickness+2, junglecat_lip_width], center=true);
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
                if(rail_support=="cutout"){
                    //this adds a visible lip so you rip off the support and not the rail
                    removal_aid = 4;
                    rotate([90,0,0])
                    rect_tube(
                        size=[ face_width+5, joycon_lip_width+support_airgap],
                        isize=[face_width+shell_thickness-removal_aid, joycon_lip_width], 
                        h=joycon_depth,
                        anchor=CENTER);
                } else { //bring your own support
                    cube([face_width+shell_thickness+1, joycon_lip_thickness+2, joycon_lip_width], center=true);
                }
            }
            //lock notch
            translate([
                face_width/2-lock_notch_depth/2-lock_notch_offset, 
                -joycon_depth/2-joycon_lip_thickness/2, 
                -joycon_lip_width/2-lock_notch_depth/2
            ])
            cube([
                lock_notch_width, 
                joycon_lip_thickness+0.5, 
                lock_notch_depth], 
                center=true
            );
        }
    }
}

gamepad_cutout_translate = -face_length/2-gamepad_wing_length/2;
gamepad_length_buffer = 2;
gamepad_width_buffer = 2;
//gamepad_cuts();
//gamepad_hole();
module gamepad_hole(){
    gamepad_cut_radius = gamepad_face_radius/1.3;
    extra_height = 5;
    translate([
        0,
        gamepad_cutout_translate,
        extra_height/2
    ])
    prismoid(
        size1=[face_width-gamepad_width_buffer, gamepad_wing_length-gamepad_length_buffer], 
        size2=[face_width-gamepad_width_buffer, gamepad_wing_length-gamepad_length_buffer], 
        h=body_thickness+extra_height,
        rounding=gamepad_cut_radius,
        anchor=CENTER,
        $fn=15
    );
}

trigger_debug = true;
trigger_rounding = 1;
trigger_rounding2 = 4; //this affects the "peg" separating the triggers
trigger_space = 2.5; //this affects the "peg" separating the triggers
trigger_width = 10;
trigger_height = 10;
trigger_clearance = 0.5;
trigger_rounding_profile = [trigger_rounding,0,0,trigger_rounding2];
trigger_inside_lip = 2;
min_trigger_inside_lip_thickness = 1.6; //should be multiple of layer height
//translate([0,0,10]) gamepad_trigger();
module gamepad_trigger(){
    trigger_stickout = 2.5;
    //TODO: changig the height affects other sizes. Huh?
    translate([
        face_width/2+shell_thickness,
        gamepad_cutout_translate,
        shell_thickness/2
    ])
    rotate([0,90,0])
    copy_mirror() 
    translate([0,trigger_width/2+trigger_space/2,shell_thickness]) {
        prismoid( 
            size1=[body_thickness+shell_thickness, trigger_width], 
            size2=[body_thickness-3, trigger_width-3], 
            h=trigger_stickout,
            rounding=trigger_rounding_profile, 
            anchor=BOTTOM+CENTER,
            $fn=10
        );
        
        translate([0,0,-shell_thickness-gamepad_width_buffer]){
            prismoid( 
                size1=[body_thickness+shell_thickness, trigger_width],
                size2=[body_thickness+shell_thickness, trigger_width],
                h=shell_thickness+gamepad_width_buffer,
                rounding=trigger_rounding_profile, 
                anchor=BOTTOM+CENTER,
                $fn=10
            );
            
            
            translate([0,0,-min_trigger_inside_lip_thickness])
            prismoid( 
                size1=[body_thickness+shell_thickness, trigger_width+trigger_inside_lip],
                size2=[body_thickness+shell_thickness, trigger_width+trigger_inside_lip],
                h=min_trigger_inside_lip_thickness,
                rounding=trigger_rounding_profile, 
                anchor=BOTTOM+CENTER,
                $fn=10
            );
        }
    }
}
//gamepad_trigger_cut();
module gamepad_trigger_cut() {
    gamepad_trigger(); //ensure it fits
    //refactor this so the translations are easier to keep track of. Prob means changing anchor
    color("red", 0.2)
    translate([
        face_width/2,
        gamepad_cutout_translate,
        0
    ]) 
    rotate([0,90,0])
    copy_mirror() translate([body_thickness/2,trigger_width/2+trigger_space/2,])
    prismoid( 
        size1=[ body_thickness+shell_thickness+1, trigger_width+trigger_clearance],
        size2=[ body_thickness+shell_thickness+1, trigger_width+trigger_clearance],
        h=body_thickness*2,
        rounding=trigger_rounding_profile,
        anchor=RIGHT+CENTER,
        $fn=10
    );
}
//gamepad_ffc_cut();
module gamepad_ffc_cut(){
    //
    ffc_radius = 3;
    ffc_cut_length = 8;
    ffc_off_center = -12;
    translate([
        ffc_off_center, 
        -face_length/2 , 
        -body_thickness/2
    ])
    rotate( [90, 0, 0] )
    pie_slice(ang=180, l=ffc_cut_length, r=ffc_radius, center=true);
}
module gamepad_cuts(){
    copy_mirror() {
        gamepad_hole();
        gamepad_trigger_cut();
        gamepad_ffc_cut();
    }
}
//gamepad_faceplates();
module gamepad_faceplates(){
    //color("red", 0.2) peg_cuts();
    module peg_cuts() {
        translate([0,gamepad_cutout_translate,-body_thickness/2+shell_thickness +2]) {
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
        translate([10, gamepad_cutout_translate, -body_thickness/2+shell_thickness +2])
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
        translate([10, gamepad_cutout_translate, -body_thickness/2+shell_thickness +10]) {
            cube([dpad_width,dpad_thickness,20],center=true);
            rotate([0,0,90])
            cube([dpad_width,dpad_thickness,20],center=true);
        }
    }
    //start_select_hole();
    module start_select_hole(){
        start_select_length = 7; //not actually length, arbitrary number
        start_select_radius = 1.5;
        translate([-20, gamepad_cutout_translate+5, -body_thickness/2+shell_thickness +5])
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

//screen_cut();
module screen_cut(){   
   //straight cut, quick
   //height must be more than shell_thickness cus of the way corners cut
   color("red", 0.2)
   translate([0,0,body_thickness/2+shell_thickness/2])
   linear_extrude(height = 6, center = true) {
        minkowski() {
            //TODO: why is this -2? That greatly affects how much the lip is gripping
            square([screen_width-2*screen_radius, screen_length-2*screen_radius], true);
            circle(screen_radius);
        }
    }
    //TODO: round the inside. Use a bezier curve on a path. Try BOSL2 library
}

//color("red", 0.2) lanyard_cut();
module lanyard_cut(){
    //unsupported
    /*  
    //thick ring shaped extension
    if(lanyard_loop)
    color("red", 0.2) 
    rotate([0,90,0])
    translate([0,-face_length/2-3,face_width/4])
    ring(8, body_thickness+shell_thickness*2, 7, 0.1 );
    */
    //ring cutout makes 2 slots for thin string lanyards
    if(lanyard_loop)
    color("red", 0.2) 
    translate([face_width/3.5,-face_length/2,-body_thickness/3])
    ring(body_thickness/2, 9, 6, 0.1 );
}

//usb_cut();
module usb_cut(){
    charge_port_height = 10;
    //why'd I do this with the gamepad? It doesn't even cut flush with the bottom surface
    charge_port_width = (bottom_speakers || case_type=="gamepad") ? face_width*0.5 : 8;
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
        button_cut(true, right_button_length, right_button_from_top);
    }
}

//left_button=true; left_button_cut();
module left_button_cut(){
    if(left_button){
        button_cut(false, left_button_length, right_button_from_top);
    }
}

module button_cut(left, button_length, button_offset){
    left_or_right = left ? 1 : -1;
    color("red", 0.2)
    translate( [ left_or_right*(face_width/2+buttons_cut_thickness),
    face_length/2 - button_offset - button_length/2 + buttons_fillet - buttons_clearance/2,
    0 ] )
    rotate([0,-90,0])
    {
        //cuts the radius part of the buttons
        minkowski() {
            cube([10, button_length - 2*buttons_fillet + buttons_clearance, buttons_cut_thickness],true);
            sphere(r=buttons_fillet);
        }
        
        //cuts the top edge
        translate ([body_thickness/2, 0, 0]) 
        rotate([0,0,90])
        cube([button_length+buttons_clearance/2,body_thickness,15], center=true);
        
        //45-degree anti snag cut (toward top)
        translate ([body_thickness/2, button_length/2 + buttons_fillet, 0]) 
        rotate([0,0,45])
        cube([15,5,15], center=true);
        //(toward bottom)
        translate ([body_thickness/2, -button_length/2-buttons_fillet, 0]) 
        rotate([0,0,-45])
        cube([15,5,15], center=true);
        
        //experimental corner rounter
        //translate ([body_thickness+10, button_length/2 - buttons_fillet + buttons_clearance, 0]) 
        //rotate([0,0,90])
        //corner_rounder();
    }
}

//camera_cut();
module camera_cut(){
    camera_radius_clearanced = camera_radius+camera_clearance;
    height = 5;
    angle = 8; //just an offset. TODO: calculate this in degrees
    color("red", 0.2)
    down(body_thickness/2)
    back(face_length/2-camera_from_top+camera_clearance)
    right(face_width/2-camera_from_side+camera_clearance)
    prismoid(
        size1=[camera_width+camera_clearance*2+angle, camera_height+camera_clearance*2+angle], 
        size2=[camera_width+camera_clearance*2, camera_height+camera_clearance*2], 
        h=height,
        rounding=camera_radius_clearanced,
        anchor=ALLPOS
    );
}

//extra_camera_cut();
module extra_camera_cut(){
    camera_radius_clearanced = camera_radius+camera_clearance;
    height = 5;
    angle=8;
    if(camera_cut_2)
    color("red", 0.2)
    //viewed from above, this  object is anchored to the top-right and translated to the top-right of the phone
    translate([
        face_width/2-camera_from_side_2+camera_clearance,
        face_length/2-camera_from_top_2+camera_clearance,
        -body_thickness/2
    ])
    prismoid(
        size1=[camera_width_2+camera_clearance*2+angle, camera_height_2+camera_clearance*2+angle], 
        size2=[camera_width_2+camera_clearance*2, camera_height_2+camera_clearance*2], 
        h=height,
        rounding=camera_radius_clearanced,
        anchor=ALLPOS
    );
}



//fingerprint_cut();
module fingerprint_cut(){
    fingerprint_radius = fingerprint_diam/2;
    fingerprint_cut_height = 6; //TODO: calculate this
    if (fingerprint)
    color("red", 0.2)
    translate([ 
        0, 
        face_length/2-fingerprint_center_from_top, 
        -body_thickness/2-fingerprint_cut_height/2 
    ])
    cylinder( fingerprint_cut_height, fingerprint_radius*2, fingerprint_radius, true);
}

//mic_cut();
module mic_cut(){
    //can this be improved?
    mic_diam = 2.0;
    if (mic_notch_top) 
    color("red", 0.2)
    if (case_type=="joycon") {
        //this cuts upward
        translate( [ face_width/2-mic_from_right_edge, face_length/2, -2 ] )
        rotate([90,0,0])
        hull(){
            cylinder( 20, mic_diam, mic_diam, true);
            translate ([0,6,0]) 
                cylinder( 20, mic_diam, mic_diam, true);
        }
    } else {
        //simple hole
        translate( [ face_width/2-mic_from_right_edge, face_length/2, 0 ] )
        rotate([90,0,0])
        cylinder( 20, mic_diam, mic_diam, true);
    }
    
}

//top_headphone_cut();
module top_headphone_cut(){
    //can this be improved?
    headphone_diam = 4.0;
    if (headphone_jack_cut) {
        if (case_type=="joycon") {
            color("red", 0.2)
            translate( [ -face_width/2+headphone_from_left_edge+1.7, face_length/2, -2 ] )
            rotate([90,0,0])
            hull(){
                cylinder( 20, headphone_diam, headphone_diam, true);
                translate ([0,6,0]) 
                    cylinder( 20, headphone_diam, headphone_diam, true);
            }
        } else {
            //case_type=="junglecat"
            color("red", 0.2)
            //we measure from edge of phone to edge of the 3.5mm jack. +1.7 to center it
            translate( [ -face_width/2+headphone_from_left_edge+1.7, face_length/2, 0 ] ) {
                rotate([90,0,0])
                hull(){
                    cylinder( 20, headphone_diam, headphone_diam, true);
                    translate ([0,6,0])
                        cylinder( 20, headphone_diam, headphone_diam, true);
                }
                
                //anti snag bevel
                translate([0,0,6])
                rotate([0,45,0])
                cube([10,10,10], center=true);
            }
        }
    }
}

//corner_rounder();
module corner_rounder(){
    round_radius = body_radius/2+shell_thickness;
    color("red", 0.4)
    difference(){
        cube([10,10,round_radius*3], center=true);
        translate([round_radius,round_radius,0])
        hull(){
            sphere(round_radius);
            translate([round_radius*2,0,0])
            sphere(round_radius);
            translate([0,round_radius*2,0])
            sphere(round_radius);
        }
    }
}

//version_info_emboss();
module version_info_emboss(){
    if(emboss_version_text) {
        emboss_font = "Orbitron";
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

/* support functions */

//replace with bosl?
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