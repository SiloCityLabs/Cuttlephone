/* Phone case generator
 * Supports phone case, Joycon rails, Junglecat rails, and Cuttlephone gamepad
 * Designed to 3d print with PLA+, 0.4 nozzle, 0.2 layer height
 * Author: Maave
 */

use <fonts/orbitron/orbitron-light.otf>
//TODO: include these in libraries directory. They're saved on my comp
include <BOSL2/std.scad>
include <BOSL2/hull.scad>
include <BOSL2/rounding.scad>

/*  measurements from the phone
 *  all values are in mm
 *  Customizer's UI precision (0.1, 0.01, etc) depends on the precision of the variable
 */

case_material = "hard"; // [hard, soft]
case_type = "phone case"; // [phone case, gamepad, joycon, junglecat]
//joycon and junglecat rail requires support to print horizontally. "Cutout" support is designed to remove with a razor blade. "None" means you'll handle it yourself in your slicer. "Peeloff" is experimental and still requires a blade

//Is there a good way to measuring this on the phone? Print-out guide template?
//rounding of the corners when viewed screen-up.
face_radius = 5.25;
face_length = 145.5;
face_width = 70.1;
body_thickness = 8.1;
body_radius_top = 2.1;
body_radius_bottom = 3.1;

screen_radius = 8.01;
screen_lip_length = 3.1;
screen_length = face_length - screen_lip_length;
screen_lip_width = 3.1;
screen_width = face_width - screen_lip_width;
extra_lip = false;
screen_extra_top_left = 0;
screen_extra_top_right = 0;
screen_extra_bottom_left = 0;
screen_extra_bottom_right = 0;

//this should be a multiple of nozzle diameter
shell_thickness = 1.6;

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
headphone_jack_cut = true;

bottom_speakers = false;

fingerprint = false;
fingerprint_center_from_top = 36.5;
fingerprint_diam = 13;

rail_support = "cutout"; // [cutout, peeloff, none]
//set this to your layer height
support_airgap = 0.20; //TODO: test and tweak. This may depend on layer height.

emboss_version_text = true;
phone_model = "Pixel 3";

//debug cuts
debug = "none"; //[none, corners, side_edge, bottom_edge, top_edge]

//end customizer variables
module end_customizer_variables(){}

//alternate Fn values to speed up OpenSCAD. Turn this up during build
$fn=20;
lowFn = 10;
renderFn = 20;

 /* I cannot override case_type for some reason, it doesn't take effect. But this works. */
case_type_override="stupid_hack";
case_type2 = (case_type_override!=undef && case_type_override!="stupid_hack") ? case_type_override : case_type;

// phone case / general variables
buttons_clearance = 10;
extra_lip_bonus = extra_lip ? 1 : 0;
anti_snag_radius = 3.8;

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
junglecat_rail_length = 61.0;
junglecat_dimple_from_top = 63.5;
junglecat_inner_width = 3.5;
junglecat_lip_width = 2;
junglecat_lip_thickness = 0.4; //should be a multiple of nozzle width
junglecat_depth = 3.3;

//embossment text
name = "Cuttlephone";
author = "Maave";
version = "v0.1";

//unsupported features
lanyard_loop = false;

difference(){
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
    debug_cuts();
}

module phone_case(){
    difference(){
        phone_shell();
        body();
        shell_cuts();
    }
    soft_supports();
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
    button_cuts();
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
            0.01 ], 
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
        rounding1=body_radius_bottom, 
        rounding2=body_radius_top,
        $fn=15
    );
}

//manual supports for soft TPU prints
module soft_supports(){
    soft_button_supports();
    soft_usb_support();
}

//phone_shell();
module phone_shell(){
    minkowski() {
        cube(
            [ face_width - 2*face_radius,
            face_length - 2*face_radius ,
            0.01 ],
            center=true
        );
        shell_profile();
    }
}

//shell_profile();
module shell_profile(){
    translate([0,0,extra_lip_bonus/2])
    cyl( 
        l=body_thickness + 2*shell_thickness + extra_lip_bonus, 
        r=face_radius+shell_thickness,
        rounding1=body_radius_bottom, 
        rounding2=body_radius_top
    );
}

module gamepad_shell(){
    minkowski() {
        //face shape
        cube(
            [ face_width - 2*gamepad_face_radius,
            face_length + gamepad_wing_length*2 - 2*gamepad_face_radius,
            0.01 ], 
            center=true);
        //edge shape and thickness
        translate([0,0,extra_lip_bonus/2])
        cyl( 
            l=body_thickness + 2*shell_thickness + extra_lip_bonus, 
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
            0.01 ],
            center=true);
        //edge shape and thickness
        translate([0,0,extra_lip_bonus/2])
        cyl( 
            l=joycon_thickness + 2*shell_thickness + extra_lip_bonus, 
            r=rail_face_radius+shell_thickness,
            rounding1=rail_shell_radius, 
            rounding2=rail_shell_radius
        );
    }
}

module junglecat_shell(){
    minkowski() {
        //face shape
        cube(
            [ face_width - 2*rail_face_radius,
            face_length + 2*junglecat_depth + 2*junglecat_lip_thickness - 2*rail_face_radius,
            0.01 ],
            center=true
        );
        //edge shape and thickness
        translate([0,0,extra_lip_bonus/2])
        cyl( 
            l=body_thickness + 2*shell_thickness + extra_lip_bonus, 
            r=rail_face_radius+shell_thickness,
            rounding1=rail_shell_radius, 
            rounding2=rail_shell_radius
        );
    }
}

//junglecat_cuts();
module junglecat_cuts(){
    copy_mirror() {
        color("red", 0.2)
        translate([0, -face_length/2-shell_thickness-junglecat_depth/2, 0]) {
            //dimple
            translate([face_width/2-junglecat_dimple_from_top,
            -(shell_thickness+junglecat_lip_thickness),
            0])
            sphere(d=2.0);
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
                if(rail_support=="peeloff"){
                    //this adds a visible lip so you rip off the support and not the rail
                    removal_aid = 4;
                    rotate([90,0,0])
                    rect_tube(
                        size=[ junglecat_rail_length+support_airgap*2, junglecat_lip_width+support_airgap],
                        isize=[junglecat_rail_length, junglecat_lip_width], 
                        h=junglecat_depth,
                        anchor=CENTER);
                } else if (rail_support=="cutout") {
                    //solid wall that you must cut with a craft knife
                    //the only cutout is a "hint" on one side
                    translate([-junglecat_rail_length/2,0,0])
                    cuboid([1,1,junglecat_lip_width]);
                }
                else { //bring your own support
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
    screen_cut_height = shell_thickness+extra_lip_bonus+0.5;
    screen_corners = [
        screen_radius + screen_extra_bottom_right,
        screen_radius + screen_extra_bottom_left,
        screen_radius + screen_extra_top_left,
        screen_radius + screen_extra_top_right,
    ];
    rectangle = square([screen_width, screen_length],center=true);
    round_rectangle = round_corners(rectangle, radius=screen_corners,$fn=20);
    color("red", 0.2)
    translate([0,0,body_thickness/2-screen_cut_height+shell_thickness+extra_lip_bonus+0.05])
    offset_sweep(round_rectangle, height=screen_cut_height,top=os_circle(r=-shell_thickness));
}

//color("red", 0.2) lanyard_cut();
module lanyard_cut(){
    //unsupported
    /*  
    //thick ring-shaped extension
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

usb_cut_width = 12;
usb_cut_rounding = 2;
bottom_speaker_cut_width = face_width*0.65;
charge_port_width = (bottom_speakers || case_type=="gamepad") ? bottom_speaker_cut_width : usb_cut_width;
//usb_cut();
module usb_cut(){
    //why'd I do this with the gamepad? It doesn't even cut flush with the bottom surface
    usb_cut_height = shell_thickness+body_thickness+extra_lip_bonus+0.01;
    
    color("red", 0.2)
    translate( [0, -face_length/2, 0] )
    if(case_material=="hard"){
        anti_snag(charge_port_width);
    }
    else {
        rotate([90,0,0])
        //straight-thru cut
        prismoid( size1=[charge_port_width,body_thickness*0.6], 
            size2=[charge_port_width,body_thickness*0.6], 
            rounding=usb_cut_rounding, h=shell_thickness*10, anchor=CENTER
        );
        //bevel cut
        rotate([90,0,0])
        prismoid( size1=[charge_port_width,body_thickness*0.6], 
            size2=[charge_port_width,body_thickness*0.6+3], 
            rounding=usb_cut_rounding, h=shell_thickness*3, anchor=CENTER+BOTTOM
        );
    }
}

//soft_usb_support();
module soft_usb_support(){
    if(case_material=="soft")
    color("blue", 0.2)
    translate( [0, -face_length/2, 0] )
    rotate([90,0,0])
    prismoid(
    size1=[charge_port_width-usb_cut_rounding,body_thickness*0.6], 
    size2=[charge_port_width-usb_cut_rounding,body_thickness*0.6], h=0.4, anchor=CENTER);
    
}

module button_cuts(){
    //left_button=true;
    if(left_button){
        button_cut(false, left_button_length, right_button_from_top);
    }
    //right_button_cut=true;
    if(right_button) {
        button_cut(true, right_button_length, right_button_from_top);
    }
}

buttons_rounding = 2;
module button_cut(left, button_length, button_offset){
    left_or_right = left ? 1 : -1;
    anti_snag_height = body_thickness; //TODO: use joycon_thickness on joycon version
    button_cut_thickness = 6;
    
    color("red", 0.2)
    translate( [ left_or_right*(face_width/2),
        face_length/2 - button_offset - button_length/2, 
        0
    ] )
    if(case_material=="hard"){
        translate([0,0,-body_thickness/2+shell_thickness+extra_lip_bonus+0.05])
        rotate([0,0,90]) {
            //button cut
            cuboid([button_length+buttons_clearance, button_cut_thickness, 50], rounding=buttons_rounding);

            //anti snag rounding
            rectangle = square([button_length+buttons_clearance, shell_thickness*4+0.1],center=true);
            offset_sweep(rectangle, height=anti_snag_height,top=os_circle(r=-anti_snag_radius));
        }
    }
    else{
        rotate([left_or_right*90,0,90]) {
            //straight-thru cut
            prismoid(size1=[button_length+buttons_clearance,body_thickness*0.6], size2=[button_length+buttons_clearance,body_thickness*0.6], rounding=buttons_rounding, h=shell_thickness*3, anchor=CENTER);
            //bevel cut. Needs to be nugdged over
            prismoid(size1=[button_length+buttons_clearance,body_thickness*0.6], size2=[button_length+buttons_clearance+10,body_thickness*0.6+3], rounding=buttons_rounding, h=shell_thickness*3, anchor=CENTER+BOTTOM);
        }
    }
}

//soft_button_supports();
module soft_button_supports(){
    if(case_material=="soft") {
        //left_button=true;
        if(left_button){
            soft_button_support(false, left_button_length, right_button_from_top);
        }
        //right_button_cut=true;
        if(right_button) {
            soft_button_support(true, right_button_length, right_button_from_top);
        }
    }
}

module soft_button_support(left, button_length, button_offset){
    left_or_right = left ? 1 : -1;
    support_thickness = 0.4;
    color("blue", 0.2)
    translate( [ left_or_right*(face_width/2),
        face_length/2 - button_offset - button_length/2, 
        0
    ] )
    rotate([left_or_right*90,0,90]) {
        prismoid(size1=[button_length+buttons_clearance-buttons_rounding,body_thickness*0.6], size2=[button_length+buttons_clearance-buttons_rounding,body_thickness*0.6], h=support_thickness, anchor=CENTER);
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
    //if(case_material=="soft") //soft
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

//mic_notch_top=true; mic_cut();
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
            cylinder( 20, mic_diam, mic_diam, center=true, $fn=lowFn);
            translate ([0,10,0]) 
                cylinder( 20, mic_diam, mic_diam, center=true, $fn=lowFn);
        }
    } else {
        //simple hole
        translate( [ face_width/2-mic_from_right_edge, face_length/2, 0 ] )
        rotate([90,0,0])
        cylinder( 20, mic_diam, mic_diam, center=true, $fn=lowFn);
    }   
}

//headphone_jack_cut=true; top_headphone_cut();
module top_headphone_cut(){
    headphone_radius_hard = 5;
    headphone_radius_soft = 4;
    trans = [ -face_width/2+headphone_from_left_edge+1.7, face_length/2, 0 ];
    color("red", 0.2)
    if (headphone_jack_cut) {
        if(case_material=="hard"){
            //we measure from edge of phone to edge of the 3.5mm jack. +1.7 to center it
            translate(trans)
            anti_snag(headphone_radius_hard*2, top_radius=headphone_radius_hard/1.1, bottom_radius=headphone_radius_hard/1.1);
            //anti_snag(headphone_radius_hard); //trying this with default radius out but it's kinda ugly
        } else {
            translate(trans)
            rotate([90,0,0])
            cylinder(9, headphone_radius_soft*1.2, headphone_radius_soft*0.9, center=true);
        }
    }
}

//version_info_emboss();
module version_info_emboss(){
    if(emboss_version_text) {
        emboss_font = "Orbitron"; //need a simple sans-serif font to come out good in the print
        font_size = 8;
        version_font_size = 6;
        line_translate = 12;
        color("red")
        rotate([0,0,-90])
        translate([-10,10,-body_thickness/2]) {
            linear_extrude(height = shell_thickness/2, center = true) {
                text(name, font=emboss_font, size=font_size);
                translate([0,-line_translate,0])
                text(version, font=emboss_font, size=version_font_size);
                translate([0,-line_translate*2,0])
                text(phone_model, font=emboss_font, size=font_size);
            }
        }
    }
}

//debug_cuts();
module debug_cuts(){
    if(debug=="corners") {
        translate([0,0,0])
        cuboid([100,200,50], anchor=CENTER+BOTTOM);
    }
    else if(debug=="bottom_edge") {
        translate([0,-face_length/2+15,0])
        cuboid([100,200,50], anchor=CENTER+FRONT);
    }
    else if(debug=="top_edge") {
        translate([0,face_length/2-15,0])
        cuboid([100,200,50], anchor=CENTER+BACK);
    }
    else if(debug=="side_edge") {
        translate([-face_width/4,0,0])
        cuboid([100,200,50], anchor=CENTER+LEFT);
    }
}

/* support functions */

//anti_snag(8);
module anti_snag(width=8, top_radius=4, bottom_radius=3.9){
    anti_snag_height = body_thickness + shell_thickness+extra_lip_bonus;
    if(bottom_radius >= width/2 || bottom_radius >=anti_snag_height/2){
        echo(width=width, top_radius=top_radius, bottom_radius=bottom_radius, anti_snag_height=anti_snag_height);
        echo("too much bottom rounding. Fixing ... ");
        smaller_width = (width>anti_snag_height)? anti_snag_height : width;
        bottom_radius=smaller_width/2.05;
        echo("Bottom radius must be half the width or less.");
        echo(str("Called by: ", parent_module(1)));
    }
    //if((top_radius+bottom_radius) >= anti_snag_height){
    if((bottom_radius+top_radius) >= anti_snag_height){
        echo(width=width, top_radius=top_radius, bottom_radius=bottom_radius, anti_snag_height=anti_snag_height);
        echo("too much rounding. Fixing ...");
        top_radius = anti_snag_height/2.05;
        echo("top+bottom radius must be less than anti_snag_height");
        echo(str("Called by: ", parent_module(1)));
    }
    
    rectangle = square([width, 20],center=true);
    round_rectangle = round_corners(rectangle, radius=bottom_radius,$fn=15);
    //round_rectangle = round_corners(rectangle, radius=bottom_radius,$fn=15);
    color("red", 0.2)
    translate( [0, 0, -body_thickness/2  +0.01] )
    offset_sweep(round_rectangle, height=anti_snag_height,top=os_circle(r=-top_radius),bottom=os_circle(r=bottom_radius));
}

//used for lanyard
module ring(h=8, od = body_thickness+shell_thickness*2, id = 7, de = 0.1 ) {
    difference() {
        cylinder(h=h, r=od/2);
        translate([0, 0, -de])
            cylinder(h=h+2*de, r=id/2);
    }
}

//used for copying the rails and gamepad features
module copy_mirror(vec=[0,1,0]){
    children();
    mirror(vec) children();
}