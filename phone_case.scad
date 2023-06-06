/* Phone case generator.
 * Supports phone case, Joycon rails, Junglecat rails, and Cuttlephone gamepad
 * Designed to 3d print with PLA+, 0.4mm nozzle, 0.2mm layer height.
 * Author: Maave
 */

use <fonts/orbitron/orbitron-light.otf>
use <fonts/Baloo_2/Baloo2-VariableFont_wght.ttf>
use <fonts/Audiowide/Audiowide-Regular.ttf>

// The Belfry OpenScad Library, v2
// These have to be imported using an "include" statement because several variables for things like anchors are defined in here.
include <libraries/BOSL2_submodule/std.scad>
include <libraries/BOSL2_submodule/geometry.scad>
include <libraries/BOSL2_submodule/rounding.scad>
include <libraries/BOSL2_submodule/shapes3d.scad>

/*  measurements from the phone
 *  all values are in mm
 *  Customizer's UI precision (0.1, 0.01, etc) depends on the precision of the variable.
 */

/* [shell] */

case_material = "hard"; // [hard, soft]
case_type = "phone case"; // [phone case, gamepad, joycon, junglecat]

case_thickness = 1.6;
//if the screen is curved and the case cutaway, you might want some extra grip
shell_side_stickout = 0;

/* [emboss] */
phone_model = "Pixel 3";
emboss_size = "large"; // [logo, large, small, very_small, none]
//Check font names in OpenSCAD > Help > Font List. Simple sans-serif fonts will print better
emboss_font = "Audiowide";
font_size = 7.1;
emboss_small_font = "Audiowide";
small_font_size = 6.1;
emboss_logo = "logos/dude.svg";
logo_x = 0.0;
logo_y = 0.0;

/* [3D print] */

//this will support the rail and some overhangs during a horizontal print, and support the Joycon lock notch on a vertical print
manual_supports = true;
support_thickness = 0.4;
//This will make a gap in between the supports and the object. Set this to approx your layer height. 
support_airgap = 0.20;

//test cuts. Print part of the case to see how it fits
test_mode = "none"; //[none, corners, right_edge, right_buttons, left_edge, bottom_edge, top_edge, left_button, top_half_pla, telescopic]

//NOT WORKING. A plastic guide to help you cut the support out of the Joycon or Junglecat rails
rail_cut_tools = false;

/* [body] */

//rounding of the corners when viewed screen-up.
body_radius = 5.25;
//replaces the round radius with a 45-degree cut
body_chamfer = false;
body_length = 145.5;
body_width = 70.1;
body_thickness = 8.1;
body_radius_top = 2.1;
body_radius_bottom = 3.1;
//for phones with different rounding on the sides, like Galaxy S9
body_bottom_side_radius = 0.1;
//decrease for shallow shallow curves like the S9
body_bottom_side_angle = 90;

/* [screen] */

screen_radius = 8.01;
screen_lip_length = 3.1;
screen_length = body_length - screen_lip_length;
screen_lip_width = 3.1;
screen_width = body_width - screen_lip_width;
//left/right curved screen radius
screen_curve_radius = 0.1;
//decrease for shallow shallow curves like the S9
screen_curve_angle = 90;
//cuts away the side of the case for curved screens
screen_undercut = 0.1; //default is 0.01 because of Openscad precision bug
//sticks up so the screen is recessed
extra_lip = false;
//NOT WORKING: if the corners are sharp, add some "ramp" to the sides
extra_sides = false;
//use these if one of the corners is particularly loose and you've already tuned the body tight
screen_extra_top_left = 0;
screen_extra_top_right = 0;
screen_extra_bottom_left = 0;
screen_extra_bottom_right = 0;

/* [buttons] */
right_power_button = false;
right_power_from_top = 31.1;
right_power_length = 10.1;
right_volume_buttons = false;
right_volume_from_top = 50.1;
right_volume_length = 20.1;
left_power_button = false;
left_power_from_top = 30.1;
left_power_length = 10.1;
left_volume_from_top = 50.1;
left_volume_buttons = false;
left_volume_length = 20.1;
//moves the buttons toward the screen (positive) or toward the back panel (negative). Buttons are centered by default
buttons_vertical_fudge = 0.1;
//how much the buttons stick out
button_recess = 1.8;

/* [more buttons] */
right_button_1 = false;
right_button_1_from_top = 111.1;
right_button_1_length = 10.1;
left_button_1 = false;
left_button_1_from_top = 111.1;
left_button_1_length = 10.1;
right_button_2 = false;
right_button_2_from_top = 131.1;
right_button_2_length = 10.1;
left_button_2 = false;
left_button_2_from_top = 131.1;
left_button_2_length = 10.1;
right_hole_1 = false;
right_hole_1_from_top = 89.1;
right_hole_1_length = 10.1;
right_hole_2 = false;
right_hole_2_from_top = 89.1;
right_hole_2_length = 10.1;
left_hole_1 = false;
left_hole_1_from_top = 89.1;
left_hole_1_length = 10.1;
left_hole_2 = false;
left_hole_2_from_top = 89.1;
left_hole_2_length = 10.1;

/* [camera/fingerprint] */

//camera cutout is a rectangle with rounded corners
camera = true;
camera_width = 20.5;
camera_height = 9.1;
//get a circle by setting camera_radius to half of height and width
camera_radius = 4.5;
camera_from_side = 8.5;
camera_from_top = 8.7;
// extra gap around camera. 0.5 - 1.0 recommended. 
camera_clearance = 1.1;

//for irregular shapes like Galaxy S9+
camera_cut_2 = false;
camera_width_2 = 20.5;
camera_height_2 = 9.1;
camera_from_side_2 = 8.5;
camera_from_top_2 = 8.7;

fingerprint = false;
fingerprint_center_from_top = 36.5;
fingerprint_diam = 13.1;

/* [charge, headphone, and mic] */
mic_on_top = false;
mic_on_bottom = false;
top_mic_from_right_edge = 14.1;
bottom_mic_from_right_edge = 14.1;
top_mic_offset_up = 0.1;
bottom_mic_offset_up = 0.1;
headphone_from_left_edge = 14.1;
headphone_on_top = false;
headphone_on_bottom = false;

charge_on_bottom = true;
bottom_speakers_right = false;
bottom_speakers_left = false;

/* [universal phone adapters] */
split_in_half = false;
telescopic_pocket = false;
body_seam_width = 0.1;
body_seam_offset = 0.1;
open_top = false;
open_top_backchop = false;
open_top_chop_ratio = 0.51;
speaker_holes_bottom = false;
clamp_top = false;
rotate_upright = false;
upright_angle = rotate_upright ? -90 : 0;
telescopic = false;
telescopic_clearance_thickness = 0.5;
telescopic_clearance_width = 0.8; //the body_width direction of the slider, This often needs sanding

/* [build vars] */
//will this version be posted on the website?
build_phone=true;
build_junglecat=true;
build_joycon=true;
build_hard=true;
build_soft=true;
in_development=false;

//end customizer variables
module end_customizer_variables(){}

//alternate Fn values to speed up OpenSCAD. Turn this up during build
$fn=20;
//$fn= $preview ? 32 : 60;
lowFn = 10;
highFn = 25;

 /* I cannot override some variables via command line. Why? This works. */
case_type_override="stupid_hack";
case_type2 = (case_type_override!=undef && case_type_override!="stupid_hack") ? case_type_override : case_type;
case_material_override="stupid_hack";
case_material2 = (case_material_override!=undef && case_material_override!="stupid_hack") ? case_material_override : case_material;
case_thickness2_override="stupid_hack";
case_thickness2 = (case_thickness2_override!=undef && case_thickness2_override!="stupid_hack") ? case_thickness2_override : case_thickness;

// phone case / general variables
buttons_clearance = 5;
soft_buttons_clearance = 3;
//the base near the phone
soft_button_thickness1 = body_thickness*0.55;
button_cut_rounding = body_thickness*0.15;
button_rounding=body_thickness*0.1;
//peak of the button
soft_button_thickness2 = body_thickness*0.22;
soft_cut_height1=body_thickness*0.6;
soft_cut_height2=body_thickness*0.8;
extra_lip_bonus = extra_lip ? 1 : 0;
anti_snag_radius = 3.8;
upright_translate = rotate_upright ? body_width/2 + case_thickness2 : 0;

// gamepad variables
gamepad_wing_length = 35; //max that will fit on my printer
gamepad_body_radius = 10;
gamepad_shell_radius = 2;
gamepad_peg_y_distance = 14;

// joycon and junglecat shared variables
max_rail_shell_radius = 2.5; //if too high it'll intersect with the rail
max_rail_body_radius = 1.1; //sharper corner for looks
rail_shell_radius_top = (body_radius_top<max_rail_shell_radius) ? body_radius_top : max_rail_shell_radius; //TODO: tweak this, make is softer to hold, ensure it doesn't conflict with body
rail_shell_radius_bottom = (body_radius_bottom<max_rail_shell_radius) ? body_radius_bottom : max_rail_shell_radius; //TODO: tweak this, make is softer to hold, ensure it doesn't conflict with body
rail_body_radius = (body_radius<max_rail_body_radius) ? body_radius : max_rail_body_radius; //sharper corner for looks

// joycon variables
joycon_inner_width = 10.2;
joycon_lip_width = 7.3;
joycon_lip_thickness = 0.7;
joycon_depth = 2.34;
//this will bottom-out the rail if the body is wide enough
joycon_length = 91.5; 
// shell is thickened to fit the joycon
joycon_min_thickness = joycon_inner_width + 2*case_thickness2;
joycon_thickness = (body_thickness < joycon_min_thickness) ? joycon_min_thickness:body_thickness;
joycon_z_shift = body_thickness-joycon_thickness+case_thickness2;
lock_notch_width = 3.8;
lock_notch_offset = 9.8; //how far from the top
lock_notch_depth = (joycon_inner_width-joycon_lip_width)/2;
    
//junglecat variables
junglecat_rail_length = 61.0;
junglecat_dimple_from_top = 63.5;
junglecat_inner_width = 3.5;
junglecat_lip_width = 2.0;
junglecat_lip_thickness = 0.4;
junglecat_depth = 3.3;
//max joycon thickness. If the entire case is thicker than this, we must make stick-out junglecat rails
junglecat_wing_thickness = 11.4;
junglecat_wing_radius = 1.3;
junglecat_wings = body_thickness+case_thickness2*2 >= junglecat_wing_thickness;
junglecat_stickout = 4.2;

//embossment text
name = "Cuttlephone";
author = "Maave";
version = "v 0.4";

//unsupported features
lanyard_loop = false;

//colors are only visual, and only in OpenSCAD
//use hex values or https://en.wikipedia.org/wiki/Web_colors#X11_color_names
bodyColor="SeaGreen";

translate([0,0,upright_translate])
rotate([0,upright_angle, 0])
main();


module main() {
    difference(){
        
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
        
        test_cuts();
    }
    
    if(rail_cut_tools) {
        if(case_type2=="joycon") {
            joycon_cut_guide();
        }
        else if(case_type2=="junglecat") {
            junglecat_cut_guide();
        }
    }
}

module phone_case(){
    difference(){
        color(bodyColor)
        phone_shell();
        body();
        shell_cuts();
    }
    manual_supports_();
    universal_clamp();
    telescopic_clamp();
}

module gamepad(){
    difference(){
        color(bodyColor)
        gamepad_shell();
        body();
        shell_cuts();
        gamepad_cuts();
    }
    
    gamepad_trigger();
    copy_mirror() gamepad_trigger();
    //gamepad_faceplates();
    universal_clamp();
    telescopic_clamp();
}

module shell_cuts(){
    usb_cut();
    button_cuts();
    camera_cut();
    extra_camera_cut();
    fingerprint_cut();
    mic_cuts();
    top_headphone_cut();
    screen_cut();
    lanyard_cut();
    universal_cuts();
    version_info_emboss();
}


module joycon_rails(){
    difference(){
        color(bodyColor)
        joycon_shell();
        body();
        shell_cuts();
        joycon_cuts();
    }
    manual_supports_();
    universal_clamp();
    telescopic_clamp();
}

module junglecat_rails(){
    difference(){
        color(bodyColor)
        junglecat_shell();
        body();
        shell_cuts();
        junglecat_cuts();
    }
    manual_supports_();
    universal_clamp();
    telescopic_clamp();
}

//body();
module body(disable_curved_screen=false){
    color("orange", 0.6)
    difference() {
        minkowski() {
            cube([ body_width - 2*body_radius, 
                body_length - 2*body_radius, 
                0.01 ], 
                center=true
            );
            //edge profile
            //this pill shape will spin around the cube
            if(body_chamfer) {
                cyl( 
                    l=body_thickness, 
                    r=body_radius,
                    chamfer1=body_radius_bottom, 
                    chamfer2=body_radius_top,
                    $fn=15
                );
            } else {
                cyl( 
                    l=body_thickness, 
                    r=body_radius,
                    rounding1=body_radius_bottom, 
                    rounding2=body_radius_top,
                    $fn=15
                );
            }
            
        }
        //for curved screens and irregular shapes like Galaxy S9+
        //only for the phone shape, not the outside of the case. It causes a snag at the corner
        if(!disable_curved_screen){
            body_extra_radius();
        }
    }
}

*body_extra_radius();
module body_extra_radius(){

    debug = 1; //1.2;
    if(body_bottom_side_radius>0.1){ //customizer precision workaround
        //bottom curve right
        color("Crimson", 0.4)
        translate([body_width/2,0,-body_thickness/2])
        rotate([90,0,180])
        shallow_fillet(l=body_length*debug-body_radius, r=body_bottom_side_radius, ang=body_bottom_side_angle);
        //bottom curve left
        color("red", 0.4)
        translate([-body_width/2,0,-body_thickness/2])
        rotate([90,0,0])
        shallow_fillet(l=body_length*debug-body_radius, r=body_bottom_side_radius, ang=body_bottom_side_angle);
    }
   
    if(screen_curve_radius>0.1){
        //curved screen right
        color("red", 0.4)
        translate([body_width/2,0,body_thickness/2])
        rotate([-90,0,180])
        shallow_fillet(l=body_length*debug-body_radius, r=screen_curve_radius, ang=screen_curve_angle);
        //curved screen left
        color("red", 0.4)
        translate([-body_width/2,0,body_thickness/2])
        rotate([-90,0,0])
        shallow_fillet(l=body_length*debug-body_radius, r=screen_curve_radius, ang=screen_curve_angle);
    }
}

//manual supports, and stick-out buttons for soft TPU prints
module manual_supports_(){
    if(case_material2=="soft") {
        soft_buttons();
    }
    //support the lock notch on vertical Joycon prints
    copy_mirror()
    if(case_type2=="joycon" && rotate_upright==true && manual_supports==true){
        tower_peak_w = 1;
        tower_peak_l = 1;
        //support tower
        translate([
            -body_width/2-case_thickness2,
            -body_length/2-case_thickness2-joycon_depth-joycon_lip_thickness-support_airgap,
            joycon_z_shift-joycon_lip_width/2
        ])
        rotate([0,90,0])
        prismoid(
            //wide base, shifted peak
            size1=[ tower_peak_l*8, tower_peak_w*8 ], 
            size2=[ tower_peak_l, tower_peak_w ],
            shift=[ -tower_peak_l*3.25, tower_peak_w*3.5 ],
            h=body_width+case_thickness2-lock_notch_width/2-lock_notch_depth/2-lock_notch_offset,
            anchor=BOTTOM+BACK+LEFT
        );
        
        //lock notch support
        translate([
            body_width/2-lock_notch_depth/2-lock_notch_offset-support_airgap/2, 
            -body_length/2-case_thickness2-joycon_depth-joycon_lip_thickness, 
            joycon_z_shift-joycon_lip_width/2-lock_notch_depth/2
        ])
        rotate([0,90,0])
        prismoid(
            size1=[ tower_peak_l, tower_peak_w ], 
            //wide enough to tuck under the rail
            size2=[ lock_notch_depth-support_airgap, joycon_lip_thickness*2 ],
            //shift over so the base meets the support tower
            shift=[ 0, joycon_lip_thickness*2-tower_peak_w ],
            h=lock_notch_width,
            anchor=BACK
        );
    }
}

//phone_shell();
module phone_shell(){
    translate([0,0,extra_lip_bonus/2])
    difference() {
        resize(newsize=[
            body_width + 2*case_thickness2 + 2*shell_side_stickout,
            body_length + 2*case_thickness2,
            body_thickness + 2*case_thickness2 + extra_lip_bonus
        ])
        body(disable_curved_screen=true);
        
    }
}


module gamepad_shell(){
    minkowski() {
        //face shape
        cube(
            [ body_width - 2*gamepad_body_radius,
            body_length + gamepad_wing_length*2 - 2*gamepad_body_radius,
            0.01 ], 
            center=true);
        //edge shape and thickness
        translate([0,0,extra_lip_bonus/2])
        cyl( 
            l=body_thickness + 2*case_thickness2 + extra_lip_bonus, 
            r=gamepad_body_radius+case_thickness2,
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
            [ body_width - 2*rail_body_radius,
            body_length + 2*joycon_depth + 2*joycon_lip_thickness - 2*rail_body_radius,
            0.01 ],
            center=true);
        //edge shape and thickness
        translate([0,0,extra_lip_bonus/2])
        cyl( 
            l=joycon_thickness + 2*case_thickness2 + extra_lip_bonus, 
            r=rail_body_radius+case_thickness2,
            rounding1=rail_shell_radius_bottom, 
            rounding2=rail_shell_radius_top
        );
    }
}

module junglecat_shell(){
    minkowski() {
        //face shape
        cube(
            [ body_width - 2*rail_body_radius,
            body_length + 2*junglecat_depth + 2*junglecat_lip_thickness - 2*rail_body_radius,
            0.01 ],
            center=true
        );
            
        junglecat_edge_shape();
    }
    
    //the case is too thick. The junglecat rail needs to stick out
    if(junglecat_wings) {
        echo("case too thick. Extending for junglecat rails");
        minkowski(){
            wing_length_margin = 8;
            translate([body_width/2-junglecat_dimple_from_top/2-wing_length_margin/2,0,0])
            cuboid(
                [ junglecat_dimple_from_top+wing_length_margin,
                body_length + 2*junglecat_depth + 2*junglecat_lip_thickness+ junglecat_stickout*2+case_thickness2*2,
                junglecat_wing_thickness ],
                rounding=junglecat_wing_radius,
                anchor=CENTER
            );
            //junglecat_edge_shape();
        }
    }
    
    universal_clamp();
    telescopic_clamp();
    
    module junglecat_edge_shape(){
        //edge shape and thickness
        translate([0,0,extra_lip_bonus/2])
        cyl( 
            l=body_thickness + 2*case_thickness2 + extra_lip_bonus, 
            r=rail_body_radius+case_thickness2,
            rounding1=rail_shell_radius_bottom, 
            rounding2=rail_shell_radius_top
        );
    }
}


//junglecat_cut_guide();
module junglecat_cut_guide(){
    finger_tab_l = 40;
    finger_tab_h = 40;
    copy_mirror() {
    translate([0,-body_length*0.6,0]) {
        difference() {
            union(){
                //tube to stick down the rail
                scale([1.1,0.9,0.9]) //shrink for clearance and overhang droops
                rotate([0,90,0])
                prismoid(
                    size1=[junglecat_inner_width, junglecat_depth], 
                    size2=[junglecat_inner_width, junglecat_depth], 
                    h=junglecat_rail_length,
                    chamfer=[0,0,0,0],
                    rounding=[0,junglecat_depth/2,junglecat_depth/2,0],
                    anchor=CENTER
                );
                //something to hold onto so you don't cut yourself
                rotate([0,0,0])
                translate([junglecat_rail_length/2,0.4,-6])
                cuboid( [ finger_tab_l, junglecat_inner_width, finger_tab_h], 
                    rounding=1, 
                    edges=[RIGHT,TOP,BOTTOM],
                    anchor=LEFT+CENTER
                );
            }
            
            finger_r = 15;
            //finger hole
            translate([junglecat_rail_length/2+finger_tab_l-finger_r/2,0,-finger_tab_h/2])
            rotate([90,0,0])
            cyl(h=10, r=finger_r);
            
            //cutout lines
            translate([0,-junglecat_depth/2-junglecat_lip_thickness/2,0]) {
                rotate([90,0,0])
                rect_tube(
                    size=[ junglecat_rail_length*2+support_airgap*2, junglecat_lip_width+support_airgap*2],
                    isize=[junglecat_rail_length*2, junglecat_lip_width], 
                    h=junglecat_depth,
                    anchor=CENTER
                );
            }
            
            
        }

    }
    }
    
}

//junglecat_cuts();
module junglecat_cuts(universal_inside=false){
    //adding the universal cut has janked this up
    //TODO: make a single shape and then mirror/translate to desired position
    junglecat_stickout_adjust = junglecat_wings && !universal_inside ? junglecat_stickout : 0;
    universal_inside_negative = universal_inside ? -1 : 1;
    universal_inside_off = universal_inside ? 0 : 1;
    universal_inside_on = universal_inside ? 1 : 0;
    universal_inside_length = junglecat_rail_length * 1.2;

    copy_mirror() {
        color("red", 0.4)
        translate([0, -body_length/2-case_thickness2*universal_inside_off-junglecat_depth/2 - junglecat_stickout_adjust, 0]) {
            //dimple
            if(!universal_inside){
            translate([body_width/2-junglecat_dimple_from_top,
            -case_thickness2-junglecat_lip_thickness,
            0])
            sphere(d=2.0);}
            //inside channels
            translate([(body_width-junglecat_rail_length)/2+case_thickness2,-junglecat_lip_thickness*universal_inside_on,0])
            rotate([0,90,0])
            prismoid(
                size1=[junglecat_inner_width, junglecat_depth], 
                size2=[junglecat_inner_width, junglecat_depth], 
                h=junglecat_rail_length*1.05,
                chamfer=[0,0,0,0],
                rounding=[0,junglecat_depth/2,junglecat_depth/2,0],
                anchor=CENTER
            );
            //manual supports or just a cutout
            translate([(body_width-junglecat_rail_length)/2+case_thickness2,
            (-junglecat_depth/2-junglecat_lip_thickness/2)*universal_inside_negative, 0]) {
                if(manual_supports==true && rotate_upright==false){
                    //this adds a gap to aide removal. It'll probably still require a razor blade
                    removal_aid = 4;
                    rotate([90,0,0])
                    rect_tube(
                        size=[ junglecat_rail_length + 0.5, junglecat_lip_width ],
                        isize=[junglecat_rail_length, junglecat_lip_width - support_airgap - 0.01 ], 
                        h=junglecat_depth,
                        anchor=CENTER);
                }
                else {
                    //cut out the rail slot. Bring your own support
                    cube([junglecat_rail_length + 0.5, junglecat_depth, junglecat_lip_width ], center=true);
                }
            }
        }
    }
}


*joycon_cut_guide();
module joycon_cut_guide() {
    translate([0,-body_length*0.6,0]) {
        difference() {
            //bar
            cube([body_width*1.5,joycon_depth,joycon_inner_width],center=true);
            
            //cut guides
            translate([0,-joycon_depth/2-joycon_lip_thickness/2,0]) {
                rotate([90,0,0])
                rect_tube(
                    size=[body_width*2, joycon_lip_width+support_airgap],
                    isize=[body_width*2-support_airgap, joycon_lip_width], 
                    h=joycon_depth,
                    anchor=CENTER
                );
            }
        }
    }
}

*joycon_cuts();
module joycon_cuts(){
    copy_mirror() {
        color("red", 0.2)
        translate([0, -body_length/2-case_thickness2-joycon_depth/2, joycon_z_shift]) {
            //inner cutout
            translate([body_width/2+case_thickness2,0,0])
            cuboid([joycon_length,joycon_depth,joycon_inner_width], anchor=RIGHT);
            //lip cutout
            translate([body_width/2+case_thickness2,-joycon_depth/2-joycon_lip_thickness/2,0]) {
                if(manual_supports==true && rotate_upright==false){
                    //this adds a visible lip so you rip off the support and not the rail
                    removal_aid = 4;
                    rotate([90,0,0])
                    rect_tube(
                        size=[ body_width+5, joycon_lip_width+support_airgap],
                        isize=[body_width+case_thickness2-removal_aid, joycon_lip_width], 
                        h=joycon_depth,
                        anchor=RIGHT);
                } else { //bring your own support
                    cuboid([joycon_length, joycon_lip_thickness+2, joycon_lip_width], anchor=RIGHT);
                }
            }
            //lock notch
            translate([
                body_width/2-lock_notch_depth/2-lock_notch_offset, 
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

gamepad_cutout_translate = -body_length/2-gamepad_wing_length/2;
gamepad_length_buffer = 2;
gamepad_width_buffer = 2;
//gamepad_cuts();
//gamepad_hole();
module gamepad_hole(){
    gamepad_cut_radius = gamepad_body_radius/1.3;
    extra_height = 5;
    translate([
        0,
        gamepad_cutout_translate,
        extra_height/2
    ])
    prismoid(
        size1=[body_width-gamepad_width_buffer, gamepad_wing_length-gamepad_length_buffer], 
        size2=[body_width-gamepad_width_buffer, gamepad_wing_length-gamepad_length_buffer], 
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
        body_width/2+case_thickness2,
        gamepad_cutout_translate,
        case_thickness2/2
    ])
    rotate([0,90,0])
    copy_mirror() 
    translate([0,trigger_width/2+trigger_space/2,case_thickness2]) {
        prismoid( 
            size1=[body_thickness+case_thickness2, trigger_width], 
            size2=[body_thickness-3, trigger_width-3], 
            h=trigger_stickout,
            rounding=trigger_rounding_profile, 
            anchor=BOTTOM+CENTER,
            $fn=10
        );
        
        translate([0,0,-case_thickness2-gamepad_width_buffer]){
            prismoid( 
                size1=[body_thickness+case_thickness2, trigger_width],
                size2=[body_thickness+case_thickness2, trigger_width],
                h=case_thickness2+gamepad_width_buffer,
                rounding=trigger_rounding_profile, 
                anchor=BOTTOM+CENTER,
                $fn=10
            );
            
            
            translate([0,0,-min_trigger_inside_lip_thickness])
            prismoid( 
                size1=[body_thickness+case_thickness2, trigger_width+trigger_inside_lip],
                size2=[body_thickness+case_thickness2, trigger_width+trigger_inside_lip],
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
        body_width/2,
        gamepad_cutout_translate,
        0
    ]) 
    rotate([0,90,0])
    copy_mirror() translate([body_thickness/2,trigger_width/2+trigger_space/2,])
    prismoid( 
        size1=[ body_thickness+case_thickness2+1, trigger_width+trigger_clearance],
        size2=[ body_thickness+case_thickness2+1, trigger_width+trigger_clearance],
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
        -body_length/2 , 
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
        translate([0,gamepad_cutout_translate,-body_thickness/2+case_thickness2 +2]) {
            cube( 
                [body_width +10,
                gamepad_peg_y_distance,
                body_thickness/2+8],
                center=true
            );
            cube( 
                [body_width - body_thickness -3,
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
        translate([10, gamepad_cutout_translate, -body_thickness/2+case_thickness2 +2])
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
        translate([10, gamepad_cutout_translate, -body_thickness/2+case_thickness2 +10]) {
            cube([dpad_width,dpad_thickness,20],center=true);
            rotate([0,0,90])
            cube([dpad_width,dpad_thickness,20],center=true);
        }
    }
    //start_select_hole();
    module start_select_hole(){
        start_select_length = 7; //not actually length, arbitrary number
        start_select_radius = 1.5;
        translate([-20, gamepad_cutout_translate+5, -body_thickness/2+case_thickness2 +5])
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


*translate([0,0,10])
screen_cut();
module screen_cut(){
    //TODO: this offset is janky. I cannot properly align "top face cut" 
    screen_cut_height = case_thickness2+extra_lip_bonus+0.5;
    screen_corners = [
        screen_radius + screen_extra_bottom_right,
        screen_radius + screen_extra_bottom_left,
        screen_radius + screen_extra_top_left,
        screen_radius + screen_extra_top_right,
    ];
    rectangle = square([screen_width, screen_length],center=true);
    round_rectangle = round_corners(rectangle, radius=screen_corners,$fn=highFn);
    
    smooth_edge_radius = (case_thickness2 < screen_cut_height/2) ? case_thickness2 : screen_cut_height/2 - 0.1;
    
    //this cuts the screen hole and smooths the edge
    color("red", 0.2)
    translate([0, 0, body_thickness/2 - screen_cut_height + case_thickness2 + extra_lip_bonus + 0.05])
    offset_sweep( 
        round_rectangle, 
        height=screen_cut_height,
        top=os_circle(r=-smooth_edge_radius) //negative radius
     );
    
    //top face cut
    //disabled cus I can't align it
    * color("red", 0.2)
    translate([0, 0, body_thickness/2 + case_thickness2 + extra_lip_bonus + 0.401])
    cuboid([body_width+smooth_edge_radius, body_length+smooth_edge_radius, 10], anchor=BOTTOM);
    
    //vertical cut
    color("red", 0.1)
    translate([0, 0, body_thickness/2 - screen_cut_height + case_thickness2 + extra_lip_bonus + 0.05])
    linear_extrude(height = body_thickness*1.5, center = true)
    rect([screen_width, screen_length], rounding=screen_radius);
    
    //low cut for curved screens
    if(screen_undercut>0.1)
    color("orange", 0.8)
    translate([0, 0, body_thickness/2])
    prismoid( 
        size1=[screen_width+smooth_edge_radius+10, screen_length+smooth_edge_radius-case_thickness2],
        size2=[screen_width+smooth_edge_radius+10, screen_length+smooth_edge_radius+case_thickness2],
        h=screen_undercut+0.1,
        rounding=screen_radius,
        anchor=BOTTOM
    );
    
}

*color("red", 0.2) lanyard_cut();
module lanyard_cut(){
    //unsupported
    //ring cutout makes 2 slots for thin string lanyards
    if(lanyard_loop)
    color("red", 0.2) 
    translate([body_width/3.5,-body_length/2,-body_thickness/3])
    ring(body_thickness/2, 9, 6, 0.1 );
}

usb_cut_width = 14;
usb_cut_rounding = 2;
speaker_cut_width = body_width*0.2;
speaker_hard_cut_width = body_width*0.65;
charge_port_width = (bottom_speakers_left || bottom_speakers_right || case_type2=="gamepad") ? speaker_hard_cut_width : usb_cut_width;

*usb_cut();
module usb_cut(){
    if(charge_on_bottom)
    color("red", 0.2)
    translate( [0, -body_length/2, 0] )
    if(case_material2=="hard"){
        hard_cut(charge_port_width);
    }
    else { //soft cut
        //usb
        rotate([90,0,0])
        soft_cut(
            usb_cut_width, 
            clearance=0, 
            disable_bevel=(case_type2=="junglecat" || case_type2=="joycon" || case_type2=="gamepad"),
            junglecat_support=true,
            extra_tall=true
        );
        
        //speakers
        fudge=3; //avoid overlapping the USB's bevel cut
        if(bottom_speakers_right){
            //calculate speaker cuts based on phone width
            translate([usb_cut_width/2+fudge+speaker_cut_width/2,0,0])
            rotate([90,0,0])
            soft_cut(
                speaker_cut_width, disable_bevel=true, clearance=0,
                shallow_cut=(case_type2=="junglecat" || case_type2=="joycon" || case_type2=="gamepad")
            );
        }
        if(bottom_speakers_left){ 
            translate([-usb_cut_width/2-fudge-speaker_cut_width/2,0,0])
            rotate([90,0,0])
            soft_cut(
                speaker_cut_width, disable_bevel=true, clearance=0, shallow_cut=(case_type2=="junglecat" || case_type2=="joycon" || case_type2=="gamepad")
            );
        }
    }
}

*button_cuts();
module button_cuts(){
    //hard buttons have a single cutout
    if(case_material2=="hard"){
        if(left_power_button || left_volume_buttons){
            hard_button_cut(false, left_power_button, left_power_from_top, left_power_length, left_volume_buttons, left_volume_from_top, left_volume_length);
        }
        //right_button_cut=true;
        if(right_power_button || right_volume_buttons){
            hard_button_cut(true, right_power_button, right_power_from_top, right_power_length, right_volume_buttons, right_volume_from_top, right_volume_length);
        }
    }
    //soft buttons have their own recesses, not joined
    //maybe needs an overlap detector but that's as complicated as the hard_button_cut
    else {
        if(right_power_button)
        soft_button_recess(true, right_power_length, right_power_from_top);
        if(right_volume_buttons)
        soft_button_recess(true, right_volume_length, right_volume_from_top);
        if(left_power_button)
        soft_button_recess(false, left_power_length, left_power_from_top);
        if(left_volume_buttons)
        soft_button_recess(false, left_volume_length, left_volume_from_top);
        
        if(right_button_1)
        soft_button_recess(true, right_button_1_length, right_button_1_from_top);
        if(left_button_1)
        soft_button_recess(false, left_button_1_length, left_button_1_from_top);
        if(right_button_2)
        soft_button_recess(true, right_button_2_length, right_button_2_from_top);
        if(left_button_2)
        soft_button_recess(false, left_button_2_length, left_button_2_from_top);
        if(right_hole_1)
        soft_button_recess(true, right_hole_1_length, right_hole_1_from_top, disable_supports=false);
        if(right_hole_2)
        soft_button_recess(true, right_hole_2_length, right_hole_2_from_top, disable_supports=false);
        if(left_hole_1)
        soft_button_recess(false, left_hole_1_length, left_hole_1_from_top, disable_supports=false);
        if(left_hole_2)
        soft_button_recess(false, left_hole_2_length, left_hole_2_from_top, disable_supports=false);
        
    }
    
}

module soft_button_recess(right, button_length, button_offset, disable_supports=false) {
    right_or_left = right ? 1 : -1;
    translate( [ right_or_left*(body_width/2),
        body_length/2 - button_offset - button_length/2, 
        buttons_vertical_fudge
    ] )
    rotate([right_or_left*90,0,90])
    soft_cut(button_length, disable_support=disable_supports, clearance=soft_buttons_clearance);
}

module hard_button_cut(right,  power_button, power_from_top, power_length, volume_buttons, volume_from_top, volume_length){
    right_or_left = right ? 1 : -1;
    has_power_button = power_button ? 1 : 0;
    has_volume_buttons = volume_buttons ? 1 : 0;
    has_space = (has_volume_buttons && has_power_button) ? 1 : 0;
    power_position = (power_from_top < volume_from_top) ? 1 : 0;
    volume_position = (power_from_top > volume_from_top) ? 1 : 0;
    space_between_buttons = abs(power_from_top-volume_from_top) - volume_position*volume_length - power_position*power_length;
    button_length = has_volume_buttons*volume_length + has_power_button*power_length + has_space*space_between_buttons;
    //if we have both buttons, offset by the one closer to the top
    button_offset = has_space ? min(power_from_top*has_power_button, volume_from_top*has_volume_buttons) : power_from_top*has_power_button + volume_from_top*has_volume_buttons;

    button_cut_thickness = 6;
    hard_cut_height = body_thickness; //TODO: use joycon_thickness on joycon version
    
    color("red", 0.2)
    translate( [ right_or_left*(body_width/2),
        body_length/2 - button_offset - button_length/2, 
        -body_thickness/2+case_thickness2+extra_lip_bonus+0.05
    ] )
    translate([0,0,0])
    rotate([0,0,90]) {
        //button cut
        cuboid([button_length+buttons_clearance*2, button_cut_thickness, 50], rounding=button_cut_rounding, $fn=lowFn);

        //anti snag rounding
        rectangle = square([button_length+buttons_clearance*2, case_thickness2*4+0.1],center=true);
        offset_sweep(rectangle, height=hard_cut_height,top=os_circle(r=-anti_snag_radius));
    }
    
}

//simple cutout for mute switches
module soft_cut( button_length, disable_support=false, disable_bevel=false, clearance, shallow_cut=false, junglecat_support=false, joycon_support=false, extra_tall=false ){
    cut_height = extra_tall ? soft_cut_height2 : soft_cut_height1;
    cut_depth = shallow_cut ? 0 : 15;
    
    difference() {
        //cutout
        soft_cut_submodule();
        
        //manual supports
        color("blue", 0.2)
        if(manual_supports==true && !disable_support) {
            prismoid(
                size1=[button_length+clearance*2 - button_cut_rounding*2, cut_height],
                size2=[button_length+clearance*2 - button_cut_rounding*2, cut_height],
                h=support_thickness, 
                anchor=CENTER
            );
            //TODO: manual support for junglecat and joycon
            if(junglecat_support && ( case_type2=="junglecat" || case_type2=="joycon" ) ) {
                //for(i=[0:floor(case_thickness2+junglecat_inner_width)]) {
                //  translate([0,0,1*i])
                //  prismoid(size1=[button_length+clearance*2-button_cut_rounding*2,body_thickness*0.6], size2=[button_length+clearance*2-button_cut_rounding*2,body_thickness*0.6], h=support_thickness, anchor=CENTER);
                //}
                translate([0,0,case_thickness2+junglecat_inner_width])
                prismoid(size1=[button_length+clearance*2-button_cut_rounding*2,cut_height], size2=[button_length+clearance*2-button_cut_rounding*2,cut_height], h=support_thickness, anchor=CENTER);
            }
        }
    }
    
    module soft_cut_submodule(){
        //straight-thru cut
        prismoid( 
            size1=[ button_length+clearance*2, cut_height ], 
            size2=[ button_length+clearance*2, cut_height ], 
            rounding=button_cut_rounding, 
            h=case_thickness2*3+cut_depth, 
            anchor=CENTER, 
            $fn=lowFn
        );
        //bevel
        y_angle = 60;
        z_angle = 45;
        bevel_cut_height = case_thickness2*3; //adjacent side
        y_bonus = bevel_cut_height*tan(y_angle); //opposite side
        z_bonus = bevel_cut_height*tan(z_angle); //opposite side
        if(!disable_bevel)
        prismoid(
            size1=[ button_length+clearance*2, cut_height ], 
            size2=[ button_length+clearance*2+y_bonus, cut_height+z_bonus ], 
            rounding=button_cut_rounding, 
            h=bevel_cut_height, 
            anchor=CENTER+BOTTOM, 
            $fn=lowFn
        );
    }
}

module soft_buttons(){
    //left_button=true;
    if(left_power_button){
        soft_button(false, left_power_length, left_power_from_top);
    }
    if(left_volume_buttons){
        soft_button(false, left_volume_length, left_volume_from_top, volume_notch=true);
    }
    
    //right_button_cut=true;
    if(right_power_button){
        soft_button(true, right_power_length, right_power_from_top);
    }
    if(right_volume_buttons){
        soft_button(true, right_volume_length, right_volume_from_top, volume_notch=true);
    }

    //TODO: make soft_button more general
    if(right_button_1)
    soft_button(right=true, button_length=right_button_1_length, button_from_top=right_button_1_from_top);
    if(left_button_1)
    soft_button(right=false, button_length=left_button_1_length, button_from_top=left_button_1_from_top);
    if(right_button_2)
    soft_button(right=true, button_length=right_button_2_length, button_from_top=right_button_2_from_top);
    if(left_button_2)
    soft_button(right=false, button_length=left_button_2_length, button_from_top=left_button_2_from_top);
}

module soft_button(right, button_length, button_from_top, volume_notch=false){
    right_or_left = right ? 1 : -1;
    button_protrusion2 = 0.8;
    //if the case is thin and the button sticks out a lot, extend the button
    button_protrusion = (button_recess >  case_thickness2+button_protrusion2) ? button_recess+button_protrusion2 : case_thickness2+button_protrusion2;
    button_padding=2; //bonus to allow error in measuring
    
    color("SeaGreen", 0.8)
    translate( [ right_or_left*(body_width/2),
        body_length/2,
        buttons_vertical_fudge
    ] )
    rotate([right_or_left*90,0,90]) {
        difference(){
            soft_button_positive2();
            soft_button_negative2();
        }
    }
    
    module soft_button_positive2(){
        //backing
        translate([soft_buttons_clearance - button_from_top, 0, 0])
        prismoid(
            size1=[button_length+soft_buttons_clearance*2, body_thickness*0.8], 
            size2=[button_length+soft_buttons_clearance*2, body_thickness*0.8], 
            h=support_thickness, 
            anchor=CENTER+RIGHT
        );
        if(test_mode!="top_half_pla")
        translate([-button_from_top-button_length/2,0,0])
        prismoid(
            size1=[button_length+button_padding*2,soft_button_thickness1], 
            size2=[(button_length+button_padding*2)*0.9,soft_button_thickness2], 
            h=button_protrusion, 
            rounding=button_rounding, 
            anchor=CENTER+BOTTOM
        );
    }
    module soft_button_negative2(){
    
        translate([-button_from_top-button_length/2,0,0]) {
            //recess
            prismoid(
                size1=[button_length+button_padding*2,body_thickness*0.4], 
                size2=[button_length,body_thickness*0.4], 
                h=button_recess, 
                rounding=button_rounding, 
                anchor=CENTER
            );
            
            if(volume_notch) {
                //a single cut in the middle of the button
                translate([0,0,button_protrusion])
                rotate([0,45,0])
                cuboid([2,2,2], anchor=CENTER);
            }
            else {
                //a serrated texture
                box=1;
                sep=2;
                for(i=[0:floor(button_length/sep)]){
                    translate([-i*sep+button_length/2,0,button_protrusion])
                    rotate([0,45,0])
                    cuboid([2,2,2], 
                    anchor=CENTER);
                }
            }
        }
    }
}

//camera_cut();
module camera_cut(){
    camera_radius_clearanced = camera_radius+camera_clearance;
    height = (case_type2=="joycon") ? joycon_thickness : 5;
    angle = (case_type2=="joycon") ? 12 : 8; //TODO: calculate this in degrees
    if(camera)
    color("red", 0.2)
    down(body_thickness/2)
    back(body_length/2-camera_from_top+camera_clearance)
    right(body_width/2-camera_from_side+camera_clearance)
    prismoid(
        size1=[camera_width+camera_clearance*2+angle, camera_height+camera_clearance*2+angle], 
        size2=[camera_width+camera_clearance*2, camera_height+camera_clearance*2], 
        h=height,
        rounding=camera_radius_clearanced,
        anchor=[1,1,1]
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
        body_width/2-camera_from_side_2+camera_clearance,
        body_length/2-camera_from_top_2+camera_clearance,
        -body_thickness/2
    ])
    prismoid(
        size1=[camera_width_2+camera_clearance*2+angle, camera_height_2+camera_clearance*2+angle], 
        size2=[camera_width_2+camera_clearance*2, camera_height_2+camera_clearance*2], 
        h=height,
        rounding=camera_radius_clearanced,
        anchor=[1,1,1]
    );
}



//fingerprint_cut();
module fingerprint_cut(){
    fingerprint_radius = fingerprint_diam/2;
    //wider on joycon-mode so you can fit your finger
    //TODO: use an angle
    fingerprint_radius2 = (case_type2=="joycon") ? fingerprint_radius*3 : fingerprint_radius*2;
    fingerprint_cut_height = (case_type2=="joycon") ? joycon_thickness+2 : case_thickness2+6;
    if (fingerprint)
    color("red", 0.2)
    translate([ 
        0, 
        body_length/2-fingerprint_center_from_top, 
        -body_thickness/2-fingerprint_cut_height/2 
    ])
    cylinder( fingerprint_cut_height, fingerprint_radius2, fingerprint_radius, true);
}

//mic_on_top=true; mic_cuts();
mic_diam = 2.0;
module mic_cuts(){
    if (mic_on_top) {
        mic_cut(1, top_mic_from_right_edge, top_mic_offset_up);
    }
    if (mic_on_bottom) {
        mic_cut(-1, bottom_mic_from_right_edge, bottom_mic_offset_up);
    }

}

module mic_cut(top_or_bottom, mic_from_right_edge, mic_offset_up){
    color("red", 0.2)
    if (case_type2=="joycon" && case_material2=="hard") {
        //this cuts upward
        translate( [ body_width/2-mic_from_right_edge, top_or_bottom*body_length/2, -2 ] )
        rotate([90,0,0])
        hull(){
            cylinder( 20, mic_diam, mic_diam, center=true, $fn=lowFn);
            translate ([0,10,0]) 
                cylinder( 20, mic_diam, mic_diam, center=true, $fn=lowFn);
        }
    } else {
        //simple hole
        translate( [ body_width/2-mic_from_right_edge, top_or_bottom*body_length/2, mic_offset_up ] )
        rotate([90,0,0])
        cylinder( 20, mic_diam, mic_diam, center=true, $fn=lowFn);
    }   
}

//headphone_on_top=true; top_headphone_cut();
module top_headphone_cut(){
    top_or_bottom = headphone_on_top? 1:-1;
    headphone_radius_hard = 5;
    headphone_radius_soft = 4;
    trans = [ -body_width/2+headphone_from_left_edge+1.7, top_or_bottom*body_length/2, 0 ];
    color("red", 0.2)
    if (headphone_on_top || headphone_on_bottom) {
        if(case_material2=="hard"){
            //we measure from edge of phone to edge of the 3.5mm jack. +1.7 to center it
            translate(trans)
            hard_cut(headphone_radius_hard*2);
        } else {
            // a slightly beveled hole
            translate(trans)
            rotate([90*top_or_bottom,0,0])
            cylinder(15, headphone_radius_soft*1.2, headphone_radius_soft*0.9, center=true);
        }
    }
}

*version_info_emboss();
module version_info_emboss(){
    font_kerning = 1.08;
    if(emboss_size=="logo") {
        line_translate = 10.8;
        logo_size_ratio = 0.85; //logo-to-body_width ratio
        
        //text
        color("red")
        rotate([0,0,0])
        translate([-30,-body_length/2+30,-body_thickness/2])
        linear_extrude(height = case_thickness2/2, center = true) {
            text(name, font=emboss_font, size=font_size, spacing=font_kerning);
            translate([0,-line_translate*2,0])
            text(phone_model, font=emboss_small_font, size=small_font_size, spacing=font_kerning);
            translate([0,-line_translate,0])
            text(version, font=emboss_small_font, size=small_font_size, spacing=font_kerning);
        }
        
        //logo
        translate([0+logo_x,-body_length/2+70+logo_y,-body_thickness/2-case_thickness2/2])
        color("red")
        resize([body_width*logo_size_ratio, 0, case_thickness2/2], auto=[false,true,false])
        linear_extrude(height=case_thickness2/2)
        import(emboss_logo, center=true);
        //scale() might have better performance than resize(). But resize() takes absolute size. scale() takes a ratio so I'd need to know the input size.
    }
    if(emboss_size=="large") {
        line_translate = 12;
        color("red")
        rotate([0,0,-90])
        translate([-10,10,-body_thickness/2]) {
            linear_extrude(height = case_thickness2/2, center = true) {
                text(name, font=emboss_font, size=font_size, spacing=font_kerning);
                translate([0,-line_translate,0])
                text(version, font=emboss_font, size=small_font_size);
                translate([0,-line_translate*2,0])
                text(phone_model, font=emboss_font, size=small_font_size);
            }
        }
    }
    if(emboss_size=="small") {
        font_size = 4;
        small_font_size = 3;
        line_translate = font_size*2;
        color("red")
        rotate([0,0,0])
        translate([-20,-body_length/2+font_size*5.5,-body_thickness/2]) {
            linear_extrude(height = case_thickness2/2, center = true) {
                text(name, font=emboss_font, size=font_size, spacing=font_kerning);
                translate([0,-line_translate,0])
                text(version, font=emboss_font, size=small_font_size);
                translate([0,-line_translate*2,0])
                text(phone_model, font=emboss_font, size=small_font_size);
            }
        }
    }
    if(emboss_size=="very_small") {
        font_size = 4;
        small_font_size = 3;
        line_translate = font_size*2;
        color("red")
        rotate([0,0,-90])
        translate([16,-body_width/2+font_size*5.5,-body_thickness/2]) {
            linear_extrude(height = case_thickness2/2, center = true) {
                text(name, font=emboss_font, size=font_size, spacing=font_kerning);
                translate([0,-line_translate,0])
                text(version, font=emboss_font, size=small_font_size);
                translate([0,-line_translate*2,0])
                text(phone_model, font=emboss_font, size=small_font_size);
                //TODO: fix build script, change "phone_model" var to "display_name"
                //TODO: show small display_name
            }
        }
    }
}


module universal_clamp() {
    if(clamp_top) {
        clamp_thickness = 10;
        echo("plz");
        //translate([0,0,20])
    //    cuboid([body_length, body_width, body_thickness*0.9], rounding=body_radius);

        color("red", 0.4)
        //translate([clamp_thickness,0,0])
        cuboid([body_length, body_width, body_thickness*0.9], rounding=body_radius);
    }
}

telescopic_width = body_width*open_top_chop_ratio-body_radius;
// special telescopic with space for a charger or something
//TODO: calculate this crap automatically instead of manual adjust
telescopic_pocket_thick_ness = 15;
telescopic_pocket_thin_ness = 5;
telescopic_pocket_thin_offset = 2.5;
pocket_depth = 5;
pocket_padding = 0.5;
usb_pocket_width = 10;
usb_from_right = 12.5;
pocket_width = telescopic_width - pocket_padding*2;
//pocket_length = body_seam_width - pocket_padding*2;
//this needs a usable default value to avoid errors
pocket_length = (body_seam_width>pocket_padding*2) ? body_seam_width - pocket_padding*2 : 60 - pocket_padding*2;
//pocket_depth = thick_side_thickness - thin_side_thickness - telescopic_clearance_thickness*2 - thin_side_inset - pocket_padding;

body_bottom = (case_type2=="joycon") ? body_thickness-joycon_z_shift-0.2 : body_thickness;
tele_rounding = 4;
thick_side_thickness = telescopic_pocket ? telescopic_pocket_thick_ness : 8.2;
thin_side_thickness = telescopic_pocket ? telescopic_pocket_thin_ness : 4.1;
thin_side_z_offset = telescopic_pocket ? telescopic_pocket_thin_offset : 0;
thin_side_inset = 2.0;
tele_seam = -body_length/2 + ( telescopic_pocket ? 10 : 6 ) ;
tele_seam_width = 0.2;
module telescopic_clamp(){
    telescopic_offset = body_width*(1-open_top_chop_ratio)/2;
    telescopic_length = body_length-body_radius;
    if(telescopic) {
        //thin part of the slider
        translate([-telescopic_offset,0,-body_bottom/2-case_thickness2-thick_side_thickness/2 - thin_side_z_offset])
        minkowski(){
            cuboid([
                    telescopic_width-thin_side_inset-telescopic_clearance_width-tele_rounding*2, 
                    body_length-thin_side_inset-telescopic_clearance_width-tele_rounding*2, 
                    0.01 ],
                    edges=[BACK+RIGHT,BACK+LEFT, FRONT+RIGHT, FRONT+LEFT],
                    anchor=CENTER
            );
            
            //edge profile. Big rounding on the flat face
            cyl( 
                l=thin_side_thickness-telescopic_clearance_thickness,
                r=tele_rounding,
                rounding=(thin_side_thickness-telescopic_clearance_thickness)/2-0.1,
                anchor=CENTER
            );
        }
    
        //thick parts of the telescoping rail & cutout
        color("yellow", 0.2)
        difference(){
            //main thick block
            translate([-telescopic_offset,0,-body_bottom/2-case_thickness2])
            minkowski() {
                cuboid(
                    [ telescopic_width, telescopic_length, 0.01 ],
                    anchor=TOP+CENTER
                );
            
                //edge profile. Tapered so that it holds a rubber band
                cyl( 
                    l=thick_side_thickness,
                    r1=tele_rounding,
                    r2=tele_rounding/3,
                    rounding1=tele_rounding*0.7,
                    anchor=TOP+CENTER
                );
            
            }
                
            //split the block
            color("red", 0.2)
            translate([0,tele_seam,0])
            cuboid([body_width*2,tele_seam_width,body_width*2], anchor=CENTER);
            //viewing window in OpenSCAD only
            *color("red", 0.2)
            translate([0,body_width,0])
            cuboid([body_width/4,body_width*2,body_width*2], anchor=CENTER);
            
            //inner cutout
            intersection() {
                //cutout
                translate([-telescopic_offset,0,-body_bottom/2-case_thickness2-thick_side_thickness/2 - thin_side_z_offset])
                cuboid([
                    telescopic_width-thin_side_inset, body_length-thin_side_inset, thin_side_thickness ],
                    anchor=CENTER);
                    
                //mask to only cutout on one side
                translate([0,tele_seam,0])
                cuboid([body_width*body_length,body_width*body_length,body_width*body_length], anchor=FRONT);
            }
            
            //disconnect the outer shell from the right side
            translate([
                0,
                tele_seam/2 + body_seam_width/4 + body_seam_offset/2,
                -body_bottom/2-case_thickness2+0.01
            ])
            cuboid(
                [ body_width*1.5, -tele_seam+body_seam_width/2 + body_seam_offset, telescopic_clearance_thickness ],
                anchor=TOP //TODO: change to simplify translate
            );
            

            if(telescopic_pocket) {               
                //pocket
                translate([-telescopic_offset,0, -body_bottom/2 - case_thickness2])
                cuboid(
                    [pocket_width,pocket_length,pocket_depth],
                    anchor=TOP
                );
                
                //USB cut
                color("red", 0.2)
                translate([-telescopic_offset,pocket_length/2-usb_from_right, -body_bottom/2 - case_thickness2+0.01])
                cuboid(
                    [pocket_width,usb_pocket_width,pocket_depth],
                    anchor=TOP+BACK+RIGHT
                );
                
            }
            
        }

    }    
        
}



*universal_cuts();
module universal_cuts(){
    if(split_in_half==true) {
        color("red", 0.2)
        translate([0,body_seam_offset,0])
        cuboid([body_width*2,body_seam_width,100], anchor=CENTER);
    }
    if(open_top) {
        color("red", 0.2)
        translate([body_width/2,0,0]) {
            scale([1, 1, 0.99])
            body();
            
            scale([1, 1, 1])
            screen_cut();
        }
        
        if (open_top_backchop==true)
        color("red", 0.2)
        translate([body_width*open_top_chop_ratio,0,-body_thickness/2]) {
            scale([1, 1, 1])
            body();
            
            scale([1, 1, 1])
            screen_cut();
        }
    }
    if(clamp_top) {
        color("red", 0.2)
        translate([20,0,0]) {
            //scale([1, 0.95, 0.99])
            body();
            
            //scale([1, 0.95, 1])
            screen_cut();
        }
        
        junglecat_cuts(universal_inside=true);
    }
    if(speaker_holes_bottom) {
        hole_sep = body_thickness/1.7;
        hole_rad = body_thickness/4;
        copy_mirror()
        for(i=[0:floor((body_length-body_radius*2)/hole_sep/2)]){
            if(i*hole_sep>body_seam_width/2)
            color("red", 0.2)
            translate([-body_width/2,i*hole_sep,0])
            rotate([0,90,0])
            cyl(r=hole_rad, h=body_width/4, anchor=CENTER);
        }
    }

}

//test_cuts();
module test_cuts(){
    if(test_mode=="corners") {
        translate([0,0,0])
        cuboid([100,200,50], anchor=CENTER+BOTTOM);
    }
    else if(test_mode=="bottom_edge") {
        translate([0,-body_length/2+15,0])
        cuboid([100,200,50], anchor=CENTER+FRONT);
    }
    else if(test_mode=="top_edge") {
        translate([0,body_length/2-15,0])
        cuboid([100,200,50], anchor=CENTER+BACK);
    }
    else if(test_mode=="right_edge") {
        translate([body_width/4,0,0])
        cuboid([100,200,50], anchor=CENTER+RIGHT);
    }
    else if(test_mode=="left_edge") {
        translate([-body_width/4,0,0])
        cuboid([100,200,50], anchor=CENTER+LEFT);
    }
    else if(test_mode=="right_buttons") {
        translate([body_width/4,0,0])
        cuboid([100,200,50], anchor=CENTER+RIGHT);
        
        translate([0,
            body_length/3-max(right_volume_from_top,right_power_from_top) - max(right_volume_length,right_power_length),
            0
        ])
        cuboid([100,200,50], anchor=[0,1,0]);
    }
    else if(test_mode=="left_button") {
        translate([-body_width/4,0,0])
        cuboid([100,200,50], anchor=CENTER+LEFT);
        
        translate([0,
            body_length/3-max(left_volume_from_top,left_power_from_top) - max(left_volume_length,left_power_length),
            0
        ])
        cuboid([100,200,50], anchor=[0,1,0]);
    }
    else if(test_mode=="top_half_pla") {
        translate([0,0,0])
        cuboid([100,200,50], anchor=CENTER+BACK);
    }
    else if(test_mode=="telescopic") {
        translate([0,0,-body_thickness/2-case_thickness2-0.5]) //why -0.5
        cuboid([100,200,50], anchor=CENTER+BOTTOM);
    }
}

/* support functions */

/* cutouts for use with hard plastic. 
 * The edges are rounded so they don't snag on pockets 
*/
//hard_cut(8);
module hard_cut(width=8, top_radius=4, bottom_radius=3.9){
    hard_cut_height = body_thickness + case_thickness2 + extra_lip_bonus;
    smaller_width = (width>hard_cut_height)? hard_cut_height : width;
    hard_cut_depth = 25;
    
    if(bottom_radius >= width/2 || bottom_radius >=hard_cut_height/2){
        echo(width=width, top_radius=top_radius, bottom_radius=bottom_radius, hard_cut_height=hard_cut_height);
        echo("too much bottom rounding. Fixing ... ");
        bottom_radius=smaller_width/2.05;
        echo("Bottom radius must be half the width or less.");
        echo(str("Called by: ", parent_module(1)));
    }
    if((bottom_radius+top_radius) >= hard_cut_height){
        echo(width=width, top_radius=top_radius, bottom_radius=bottom_radius, hard_cut_height=hard_cut_height);
        echo("too much rounding. Fixing ...");
        top_radius = smaller_width/2.05;
        echo("top+bottom radius must be less than hard_cut_height");
        echo(str("Called by: ", parent_module(1)));
    }
    
    rectangle = square([width, hard_cut_depth],center=true);
    round_rectangle = round_corners(rectangle, radius=bottom_radius,$fn=15);
    //round_rectangle = round_corners(rectangle, radius=bottom_radius,$fn=15);
    color("red", 0.2)
    translate( [0, 0, -body_thickness/2  +0.01] )
    offset_sweep(round_rectangle, height=hard_cut_height,top=os_circle(r=-top_radius),bottom=os_circle(r=bottom_radius));
}

//for curved screens
module shallow_fillet(l=1.0, r, ang=90) {
    steps = ceil(segs(r)*ang/360); //based on $fn
    step = ang/steps;
    path = concat(
        [[0,0]],
        [ for (i=[0:1:steps]) 
            let(a=270-i*step) 
            // make a pie slice, then move the arc points up and over
            r*[ cos(a), sin(a) ] + [r*sin(ang), r]
        ]
    );
    linear_extrude(height=l, convexity=10, center=true)
    polygon(path);
    
    //todo: smooth the transition from this cut to the body radius
}

module ring(h=8, od = body_thickness+case_thickness2*2, id = 7, de = 0.1 ) {
    difference() {
        cylinder(h=h, r=od/2);
        translate([0, 0, -de])
            cylinder(h=h+2*de, r=id/2);
    }
}

//copy and mirror and object
module copy_mirror(vec=[0,1,0]){
    children();
    mirror(vec) children();
}
