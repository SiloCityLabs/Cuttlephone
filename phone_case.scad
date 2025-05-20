/* Phone case generator.
 * Supports phone case, Joycon rails, Junglecat rails, and Cuttlephone gamepad
 * Designed for FDM 3D printing with PLA+ or TPU, 0.4mm nozzle, 0.2mm layer height.
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
 *  Customizer UI precision (0.1, 0.01) is based on the comments
 */

/* [shell] */

case_material = "hard"; // [hard, soft]
case_type = "phone case"; // [phone case, gamepad, joycon, junglecat]

case_thickness = 1.6; // 0.1
//if the screen is curved and the case cutaway, you might want some extra grip
shell_side_stickout = 0; // 0.1
// Thin the shell lips around the screen bezels, keeping full case thickness at the top and bottom
shell_enable_angled_screen_bezels = false;
// Thickest the lip should be on the outer edges (in practice - a little under that due to curves used)
shell_screen_max_lip_outer = 2; // 0.1
// Thinnest the lip should be on the inner edges
shell_screen_min_lip_inner = 1; // 0.1

lanyard_loop = false;
lanyard_reinforcement = false;

/* [emboss] */
phone_model = "Sample case";
emboss_size = "large"; // [logo, large, small, very_small, medium_rotated, none]
//Check available fonts in the menu Help > Font List. Simple sans-serif fonts will print better.
emboss_font = "Audiowide";
font_size = 7.1; // 0.1
small_font_size = 6.1; // 0.1
emboss_logo = "logos/dude.svg";
logo_x = 0.0; // 0.1
logo_y = 0.0; // 0.1

/* [3D print] */

//this will support the rail and some overhangs during a horizontal print, and support the Joycon lock notch on a vertical print
manual_supports = true;
support_thickness = 0.4; // [0.1:1 : 0.01]
//This will make a gap in between the supports and the object. Set this to approx your layer height. 
support_airgap = 0.20;  // [0.0:0.4 : 0.01]
//for soft case cutouts, don't support on the curved part 
manual_support_retract = 2; // [0:1:2]
rotate_upright = false;
//the telescoping back can warp, hold it onto the bed
telescopic_back_support = false;


//Chop the case in half for a test print to see how it fits. To check body_radius, use "top_half_pla".
test_cut = "none"; //[none, corners, right_edge, right_buttons, left_edge, bottom_edge, top_edge, left_button, top_half_pla, telescopic]

//A plastic guide to help you cut the support out of the Joycon or Junglecat rails
rail_cut_tools = false;

render_quality="quick"; // [quick, export]

/* [debug view] */
show_phone_body=false;
transparent_body=false;
transparent_shell=false;
show_cuts=false;
transparent_cuts=false;

/* [body] */

body_length = 140.0; // 0.1
body_width = 50.0; // 0.1
body_thickness = 8.1; // 0.1
//rounding of the corners when viewed screen-up.
body_radius = 5.25; // 0.01
body_radius_top = 2.1; // 0.01
body_radius_bottom = 3.1; // 0.01
//replaces the round radius with a 45-degree cut
body_chamfer = false;
body_chamfer_angle_top = 45; // [1:1:89]
body_chamfer_angle_bottom = 45;// [1:1:89]
//for phones with different rounding on the sides, like Galaxy S9
body_bottom_side_radius = 0.1; // 0.01
//decrease for shallow shallow curves like the S9
body_bottom_side_angle = 90; // 0.1

/* [screen] */

screen_radius = 8.01; // 0.01
screen_lip_length = 3.1; // 0.1
screen_length = body_length - screen_lip_length;
screen_lip_width = 3.1; // 0.1
screen_width = body_width - screen_lip_width;
//left/right curved screen radius
screen_curve_radius = 0.1; // 0.1
//decrease for shallow shallow curves like the S9
screen_curve_angle = 90; // 0.1
//cuts away the side of the case for curved screens
screen_undercut = 0.1; //default is 0.01 because of Openscad precision bug
//TODO: represent this better, like a single variable for screen lip. And find a better name than "shimmy"
// move the "body" cutout up (towards the screen), reducing the front lip and thickening the back plate. 0=body centered in shell (screen lip). 1=(no screen lip).
body_z_shimmy = 0; // [0 : 0.1 : 1]
// if shimmying, keep case thickness consistent. If false, the back panel gets thicker as the body moves up
shimmy_consistent_thickness = true;
//sticks up so the screen is recessed
extra_lip = false;
//NOT WORKING: if the corners are sharp, add some "ramp" to the sides
extra_sides = false;
//use these if one of the corners is particularly loose and you've already tuned the body tight
screen_extra_top_left = 0; // 0.1
screen_extra_top_right = 0; // 0.1
screen_extra_bottom_left = 0; // 0.1
screen_extra_bottom_right = 0; // 0.1

/* [buttons - on the phone's body] */
right_power_button = false;
right_power_from_top = 31.1; // 0.1
right_power_length = 10.1; // 0.1
right_volume_buttons = false;
right_volume_from_top = 50.1; // 0.1
right_volume_length = 20.1; // 0.1
left_power_button = false;
left_power_from_top = 30.1; // 0.1
left_power_length = 10.1; // 0.1
left_volume_from_top = 50.1; // 0.1
left_volume_buttons = false;
left_volume_length = 20.1; // 0.1

//moves the buttons toward the screen (positive) or toward the back panel (negative). Buttons are centered by default
buttons_vertical_fudge = 0.1; // 0.1

// how much to the buttons protrude from the device body's edge in the X or Y axis
button_body_protrusion = 0.5; // 0.01

// how thick are the buttons in the Z axis?
button_case_thickness = 2; // 0.1

/* [buttons - on the case] */
// how much should the buttons protrude out of the case in the X or Y axis
button_shell_protrusion = 0.8; // 0.1

// Button and wall position in the shell, 0 being right on the phone, 100 on the outer edge of the case. (Values further away from center may or may not work well depending on the case thickness and shape of the device.)
button_wall_offset_percentage = 50; // [10.0:0.1:90.0]

// wall thickness, impacts how stiff are the buttons going to be
button_wall_thickness = 0.8; // 0.1
right_power_button_texture = "serrated"; //[none,serrated]
left_power_button_texture = "serrated"; //[none,serrated]
// To allow error in measuring length
button_padding = 2; // 0.1
// Button clearance on hard cases
buttons_clearance_hard_case = 5; // 0.1
// Button clearance on soft cases
buttons_clearance_soft_case = 3; // 0.1
// How thick should the button face be (zero uses hardcoded body_thickness ratios)
buttons_outer_thickness = 0; // 0.1
// Button prismoid angle
buttons_overhang_angle = 60; // 0.1
// Include a notch in the volume rocker
button_volume_rocker_notch = false;
rocker_notch_length = 1; // 0.1

/* [more buttons] */
right_button_1 = false;
right_button_1_from_top = 111.1; // 0.1
right_button_1_length = 10.1; // 0.1
left_button_1 = false;
left_button_1_from_top = 111.1; // 0.1
left_button_1_length = 10.1; // 0.1
right_button_2 = false;
right_button_2_from_top = 131.1; // 0.1
right_button_2_length = 10.1; // 0.1
left_button_2 = false;
left_button_2_from_top = 131.1; // 0.1
left_button_2_length = 10.1; // 0.1

/* [more holes] */

right_hole_1 = false;
right_hole_1_from_top = 89.1; // 0.1
right_hole_1_length = 10.1; // 0.1
right_hole_1_bevel = false;
right_hole_2 = false;
right_hole_2_from_top = 89.1; // 0.1
right_hole_2_length = 10.1; // 0.1
right_hole_2_bevel = false;
left_hole_1 = false;
left_hole_1_from_top = 89.1; // 0.1
left_hole_1_length = 10.1; // 0.1
left_hole_1_bevel = false;
left_hole_2 = false;
left_hole_2_from_top = 89.1; // 0.1
left_hole_2_length = 10.1; // 0.1
left_hole_2_bevel = false;

//increase bevel around fingerprint scanners
more_hole_bevel_z = 88; // [0:0.1:89.9]
more_hole_bevel_y = 70; // [0:1:86]
// pushes the cut into the phone case
more_hole_bevel_inset = 0; // [0:0.1:2]

/* [camera / rear fingerprint] */

//camera cutout is a rectangle with rounded corners
camera = true;
camera_width = 20.5; // 0.1
camera_height = 9.1; // 0.1
//get a circle by setting camera_radius to half of height and width
camera_radius = 4.5; // 0.1
camera_from_side = 8.5; // 0.1
camera_from_top = 8.7; // 0.1
// extra gap around camera. 
camera_clearance = 1.1; // [ 0:0.1:2 ]
// how much does the camera protrude from the body
camera_protrusion = 0.0; // 0.1
// Does the camera block interact with the edges of the phone - e.g. "island" does not: Pixel 1 to 5, all iPhones so far; "bar" protrudes from the phone back and joins on both sides: Pixel 6, 7; (unsupported) "right_corner" Galaxy S21
camera_block_style = "island"; //[island,bar,right_corner]
camera_block_fillet_radius = 0.5; // 0.1

camera_cutout_chamfer_angle = 45.0; // [0.0:0.1:89.9]

//for irregular shapes like Galaxy S9+
camera_cut_2 = false;
camera_width_2 = 20.5; // 0.1
camera_height_2 = 9.1; // 0.1
camera_from_side_2 = 8.5; // 0.1
camera_from_top_2 = 8.7; // 0.1

// fingerprint hole on the back
fingerprint = false;
fingerprint_center_from_top = 36.5; // 0.1
fingerprint_diam = 13.1; // 0.1
fingerprint_cutout_chamfer_angle = 45.0; // [0.0:0.1:89.9]

// Combines the fingerprint sensor and camera opening into a single larger one. One example where this works well is a thicker soft case on the Pixel 5. (Using OpenSCAD hull() to be specific.)
fingerprint_combine_with_camera = false;

/* [charge, headphone, and mic] */
mic_on_top = false;
mic_on_bottom = false;
top_mic_from_right_edge = 14.1; // 0.1
bottom_mic_from_right_edge = 14.1; // 0.1
top_mic_offset_up = 0.1; // 0.1
bottom_mic_offset_up = 0.1; // 0.1
headphone_from_left_edge = 14.1; // 0.1
headphone_on_top = false;
headphone_on_bottom = false;
// vertical offset
headphone_z_offset = 0; // [-3 : 0.1 : 3]

charge_on_bottom = true;
charge_cutout_bevel_angle_y = 10;
charge_cutout_bevel_angle_z = 10;
charge_z_offset = 0; // [-5 : 0.1 : 5]

bottom_speakers_right = false;
bottom_speakers_left = false;
bottom_speaker_inner_edge_from_center = 11.6; // 0.1
bottom_speaker_vertical_offset_from_center = 0.0; // 0.1
bottom_speaker_width = 10.5; // 0.1
bottom_speaker_height = 1.2; // 0.1

/* [universal phone adapters] */
split_in_half = false;
telescopic_pocket = false;
// split in the middle
body_seam_width = 0.1; // 0.1
body_seam_offset = 0.1; // 0.1
telescopic_seam = 10; // [4:0.1:16]
open_top = false;
open_top_backchop = false;
open_top_chop_ratio = 0.51; // 0.01
speaker_slots_bottom = false;
speaker_slots_side=false;
speaker_grill = false;
clamp_top = false;
upright_angle = rotate_upright ? -90 : 0;
telescopic = false;
telescopic_clearance_thickness = 0.5; // 0.1
//the body_width direction of the slider, This often needs sanding
telescopic_clearance_width = 0.8;  // 0.1
//adjust the thickness for sturdiness
telescopic_thin_side = 4.1;
telescopic_thick_side = 8.2;

/* [build vars] */
// enable auto build of variants
build_phone=true;
build_junglecat=true;
build_joycon=true;
build_hard=true;
build_soft=true;
// will this phone model be posted on the website?
in_development=false;
notes="";

//end customizer variables
module end_customizer_variables(){}

//alternate Fn values to speed up OpenSCAD. Turn this up during build
lowFn = render_quality == "export" ? 100 : 10;
highFn = render_quality == "export" ? 150 : 25;
$fn=highFn;

 /* I cannot override some variables via command line. Why? This works. */
case_type_override="stupid_hack";
case_type2 = (case_type_override!=undef && case_type_override!="stupid_hack") ? case_type_override : case_type;
case_material_override="stupid_hack";
case_material2 = (case_material_override!=undef && case_material_override!="stupid_hack") ? case_material_override : case_material;
case_thickness2_override="stupid_hack";
case_thickness2 = (case_thickness2_override!=undef && case_thickness2_override!="stupid_hack") ? case_thickness2_override : case_thickness;

// reduce the overall thickness of the case to compensate for thicker back panel
shimmy_thickness = (shimmy_consistent_thickness) ? case_thickness2/2*body_z_shimmy : 0 ;
//move shell down, relative to body
shimmy_translate=-case_thickness2*body_z_shimmy+shimmy_thickness;

//the base near the phone
soft_button_thickness1 = abs(buttons_outer_thickness) < 0.1 ? body_thickness*0.55 : buttons_outer_thickness;
button_cut_rounding = body_thickness*0.15;
button_rounding=body_thickness*0.1;
//peak of the button - ignored if using buttons_outer_thickness
soft_button_thickness2 = body_thickness*0.22;
soft_cut_height1=body_thickness*0.6;
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
max_rail_body_radius = 3.9; //if too high it'll intersect with the stop notch
rail_shell_radius_top = (body_radius_top<max_rail_shell_radius) ? body_radius_top : max_rail_shell_radius; //TODO: tweak this, make is softer to hold, ensure it doesn't conflict with body
rail_shell_radius_bottom = (body_radius_bottom<max_rail_shell_radius) ? body_radius_bottom : max_rail_shell_radius; //TODO: tweak this, make is softer to hold, ensure it doesn't conflict with body
rail_body_radius = (body_radius<max_rail_body_radius) ? body_radius : max_rail_body_radius;

// joycon variables
joycon_lip_width = 7.1; //how far apart the thin rail/lip is
joycon_lip_thickness = 0.7; //how thick the lip is
joycon_inner_width = 10.1;
joycon_depth = 2.3;
//this will bottom-out the rail if the body is wide enough
joycon_length = 91.5; 
// shell is thickened to fit the joycon
joycon_min_thickness = joycon_inner_width + 2*case_thickness2;
joycon_thickness = (body_thickness < joycon_min_thickness) ? joycon_min_thickness:body_thickness;
joycon_z_shift = body_thickness-joycon_thickness - case_thickness2*body_z_shimmy;
lock_notch_width = 3.8;
lock_notch_offset = 9.5; //how far from the top
lock_notch_depth = (joycon_inner_width-joycon_lip_width)/2;

//junglecat variables
junglecat_rail_length = 61.0;
junglecat_dimple_from_top = 63.5;
junglecat_inner_width = 3.5;
junglecat_lip_width = 2.0;
junglecat_lip_thickness = 0.4;
junglecat_depth = 3.3;
//max joycon thickness. If the entire case is thicker than this, we must make stick-out junglecat rails
junglecat_wing_thickness = 11.7;
junglecat_wing_radius = 1.3;
junglecat_wings = body_thickness+case_thickness2*2 >= junglecat_wing_thickness;
junglecat_stickout = 4.2;

//embossment text
name = "Cuttlephone";
author = "Maave";
version = "v 0.4";

//colors are only visual, and only in OpenSCAD
//use hex values or https://en.wikipedia.org/wiki/Web_colors#X11_color_names
shellColor="SeaGreen";
transparentOpacity=0.15;
shellOpacity= transparent_shell ? transparentOpacity : 1.0;
negativeColor="red";
negativeColor2="pink";
additionColor="DeepSkyBlue";
additionColor2="SeaGreen";

translate([0,0,upright_translate])
rotate([0,upright_angle, 0])
debug_views();
//main();

/* shows hidden shapes that are used for cutting
*/
module debug_views(){
    if(show_phone_body) {
        if(transparent_body){ // I wish I could make % (Background modifier) conditional
            % color(negativeColor, transparentOpacity)
            body();
        } else {
            color(negativeColor, shellOpacity)
            body();
        }
    }

    if(show_cuts) {
        if(transparent_cuts) {
            % color(negativeColor, transparentOpacity)
            cuts();
        }
        else {
            color(negativeColor, shellOpacity)
            cuts();
        }
    }

    if(transparent_shell) {
        % color(shellColor, transparentOpacity)
        main();
    }
    else {
        main();
    }


}

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
        color(shellColor, shellOpacity)
        phone_shell();
        body();
        shell_cuts();
    }

    if (case_material2 == "soft") {
        soft_buttons();
    }

    manual_supports_();
    telescopic_clamp();
}

module gamepad(){
    difference(){
        color(shellColor, shellOpacity)
        gamepad_shell();
        body();
        cuts();
    }
    
    gamepad_trigger();
    copy_mirror() gamepad_trigger();
    //gamepad_faceplates();
    telescopic_clamp();
}

module shell_cuts(){
    usb_cut();
    button_cuts();

    if (fingerprint_combine_with_camera) {
        hull() {
            camera_cut();
            extra_camera_cut();
            fingerprint_cut();
        }
    } else {
        camera_cut();
        extra_camera_cut();
        fingerprint_cut();
    }

    mic_cuts();
    headphone_cut();
    screen_cut();
    lanyard_cut();
    universal_cuts();
    version_info_emboss();
}


module joycon_rails(){
    difference(){
        color(shellColor, shellOpacity)
        joycon_shell();
        body();
        cuts();
    }

    if (case_material2 == "soft") {
        soft_buttons();
    }

    manual_supports_();
    telescopic_clamp();
}

module junglecat_rails(){
    difference(){
        color(shellColor, shellOpacity)
        junglecat_shell();
        body();
        cuts();
    }

    if (case_material2 == "soft") {
        soft_buttons();
    }

    manual_supports_();
    telescopic_clamp();
}

module cuts() {
    shell_cuts();
    if(case_type2=="gamepad") {
        gamepad_cuts();
    }
    else if(case_type2=="joycon") {
        joycon_cuts();
    }
    else if(case_type2=="junglecat") {
        junglecat_cuts();
    }
}

*body();
module body(disable_curved_screen=false, include_camera_block=true){
    color(negativeColor2)
    union() {
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
                        chamfang1=body_chamfer_angle_bottom,
                        chamfang2=body_chamfer_angle_top,
                        $fn=lowFn
                    );
                } else {
                    cyl( 
                        l=body_thickness, 
                        r=body_radius,
                        rounding1=body_radius_bottom, 
                        rounding2=body_radius_top,
                        $fn=lowFn
                    );
                }
                
            }
            //for curved screens and irregular shapes like Galaxy S9+
            //only for the phone shape, not the outside of the case. It causes a snag at the corner
            if(!disable_curved_screen){
                body_extra_radius();
            }
        }
        if (camera_block_style == "bar" && include_camera_block) {
            translate([0,body_length/2-camera_from_top-camera_height/2,-body_thickness/2]) body_camera_bar();
        }
    }
}

*body_extra_radius();
module body_extra_radius(){

    debug = 1; //1.2;
    if(body_bottom_side_radius>0.1){ //customizer precision workaround
        //bottom curve right
        color(additionColor, 0.4)
        translate([body_width/2,0,-body_thickness/2])
        rotate([90,0,180])
        shallow_fillet(l=body_length*debug-body_radius, r=body_bottom_side_radius, ang=body_bottom_side_angle);
        //bottom curve left
        color(negativeColor, 0.4)
        translate([-body_width/2,0,-body_thickness/2])
        rotate([90,0,0])
        shallow_fillet(l=body_length*debug-body_radius, r=body_bottom_side_radius, ang=body_bottom_side_angle);
    }
   
    if(screen_curve_radius>0.1){
        //curved screen right
        color(negativeColor, 0.4)
        translate([body_width/2,0,body_thickness/2])
        rotate([-90,0,180])
        shallow_fillet(l=body_length*debug-body_radius, r=screen_curve_radius, ang=screen_curve_angle);
        //curved screen left
        color(negativeColor, 0.4)
        translate([-body_width/2,0,body_thickness/2])
        rotate([-90,0,0])
        shallow_fillet(l=body_length*debug-body_radius, r=screen_curve_radius, ang=screen_curve_angle);
    }
}

*body_camera_bar();
module body_camera_bar(){
    difference() {
        intersection() {
            translate([0,0,camera_block_fillet_radius-camera_protrusion])  cuboid([camera_width+camera_block_fillet_radius*2,camera_height,camera_block_fillet_radius*2], rounding = camera_block_fillet_radius, edges = [BOTTOM+LEFT,BOTTOM+RIGHT]);
            translate([0,0,-camera_protrusion/2]) cube([body_width,camera_height,camera_protrusion*2], center = true);
        }
        translate([body_width/2-body_radius_bottom/2,0,camera_protrusion/2]) cube([body_radius_bottom/2,camera_height*2,camera_protrusion*2], center = true);
        translate([-(body_width/2-body_radius_bottom/2),0,camera_protrusion/2]) cube([body_radius_bottom/2,camera_height*2,camera_protrusion*2], center = true);
    }
}

//manual supports, and stick-out buttons for soft TPU prints
module manual_supports_(){
    //support the lock notch on vertical Joycon prints
    color(additionColor)
    copy_mirror()
    if(case_type2=="joycon" && rotate_upright==true && manual_supports==true){
        // all these numbers are BS that I tweaked until I worked
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

    //manual support inner of telescoping slider. The long part will warp enough to peel off of supports
    if(rotate_upright==true && manual_supports==true && telescopic_back_support==true){
        color(additionColor)
        difference() {
            support_brick_width = thick_side_thickness*0.8;
            support_brick_offset = thick_side_thickness*0.1;
            support_brick_length = 6;
            //support brick
            translate([
                -body_width/2-case_thickness2, 
                tele_seam+tele_seam_width/2, 
                -body_bottom/2-case_thickness2-support_brick_offset
            ]) {
                *cuboid(
                    [5,support_brick_length,support_brick_width],
                    anchor=LEFT+FRONT+TOP
                );

                brick_x = 5;
                brick_y = 0.5;
                brick_bottom_x = 12;
                brick_bottom_y = 1.5;
                translate([0,-(brick_bottom_y-brick_y)/3,0])
                color(additionColor)
                rotate([0,-90,0])
                prismoid(
                    size1=[brick_x,brick_y], 
                    size2=[brick_bottom_x,brick_bottom_y],
                    h=1,
                    anchor=RIGHT+FRONT+TOP
                    //,shift=[0, (brick_bottom_y-brick_y)/2]
                );

            }

            //main thick block of telescoping slider (duplicate code)
            //chop excess so it doesn't cut into the real part
            *translate([-telescopic_offset,0,-body_bottom/2-case_thickness2])
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

        }
    }
}

*phone_shell();
module phone_shell(){
    translate([0,0,extra_lip_bonus/2+shimmy_translate])
    union() {
        difference() {
            resize(newsize=[
                body_width + 2*case_thickness2 + 2*shell_side_stickout,
                body_length + 2*case_thickness2,
                body_thickness + 2*case_thickness2 + extra_lip_bonus - shimmy_thickness
            ])
            body(disable_curved_screen=true, include_camera_block=false);
        }
        if (camera_block_style == "bar" && camera_protrusion > case_thickness2) {
            translate([0,body_length/2-camera_from_top-camera_height/2,-body_thickness/2])
            resize(newsize=[
                body_width + 2*case_thickness2 + 2*shell_side_stickout - body_radius_bottom,
                camera_height + 2*case_thickness2,
                camera_protrusion + 2*case_thickness2 - shimmy_thickness
            ])
            body_camera_bar();
        }
    }
}

module gamepad_shell(){
    translate([0,0,extra_lip_bonus/2+shimmy_translate])
    minkowski() {
        //face shape
        cube(
            [ body_width - 2*gamepad_body_radius,
            body_length + gamepad_wing_length*2 - 2*gamepad_body_radius,
            0.01 ], 
            center=true);
        //edge shape and thickness
        cyl( 
            l=body_thickness + 2*case_thickness2 + extra_lip_bonus - shimmy_thickness, 
            r=gamepad_body_radius+case_thickness2,
            rounding1=gamepad_shell_radius, 
            rounding2=gamepad_shell_radius
        );
    }
}

module joycon_shell(){
    translate([0,0,joycon_z_shift+extra_lip_bonus+shimmy_translate])
    minkowski() {
        //face shape
        cube(
            [ body_width - 2*rail_body_radius,
            body_length + 2*joycon_depth + 2*joycon_lip_thickness - 2*rail_body_radius,
            0.01 ],
            center=true);
        //edge shape and thickness
        cyl( 
            l=joycon_thickness + 2*case_thickness2 + extra_lip_bonus - shimmy_thickness, 
            r=rail_body_radius+case_thickness2,
            rounding1=rail_shell_radius_bottom, 
            rounding2=rail_shell_radius_top
        );
    }
}


module junglecat_shell(){

    translate([0,0,shimmy_translate])
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
        translate([0,0,shimmy_translate])
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
    
    
    telescopic_clamp();
    
    module junglecat_edge_shape(){
        //edge shape and thickness
        translate([0,0,extra_lip_bonus/2])
        cyl( 
            l=body_thickness + 2*case_thickness2 + extra_lip_bonus - shimmy_thickness, 
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
        color(negativeColor, 0.4)
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
        color(negativeColor, 0.2)
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
        $fn=lowFn
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
            $fn=lowFn
        );
        
        translate([0,0,-case_thickness2-gamepad_width_buffer]){
            prismoid( 
                size1=[body_thickness+case_thickness2, trigger_width],
                size2=[body_thickness+case_thickness2, trigger_width],
                h=case_thickness2+gamepad_width_buffer,
                rounding=trigger_rounding_profile, 
                anchor=BOTTOM+CENTER,
                $fn=lowFn
            );
            
            
            translate([0,0,-min_trigger_inside_lip_thickness])
            prismoid( 
                size1=[body_thickness+case_thickness2, trigger_width+trigger_inside_lip],
                size2=[body_thickness+case_thickness2, trigger_width+trigger_inside_lip],
                h=min_trigger_inside_lip_thickness,
                rounding=trigger_rounding_profile, 
                anchor=BOTTOM+CENTER,
                $fn=lowFn
            );
        }
    }
}
//gamepad_trigger_cut();
module gamepad_trigger_cut() {
    gamepad_trigger(); //ensure it fits
    //refactor this so the translations are easier to keep track of. Prob means changing anchor
    color(negativeColor, 0.2)
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
        $fn=lowFn
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
    //color(negativeColor, 0.2) peg_cuts();
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


*translate([0,0,10]) screen_cut();
module screen_cut(){
    //TODO: this offset is janky. I cannot properly align "top face cut" 
    screen_cut_height = case_thickness2+extra_lip_bonus;
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
    color(negativeColor, 0.2)
    translate([0, 0, body_thickness/2 - screen_cut_height + case_thickness2 + extra_lip_bonus + 0.05])
    offset_sweep( 
        round_rectangle, 
        height=screen_cut_height,
        top=os_circle(r=-smooth_edge_radius) //negative radius
     );
    
    //top face cut
    //disabled cus I can't align it
    * color(negativeColor, 0.2)
    translate([0, 0, body_thickness/2 + case_thickness2 + extra_lip_bonus + 0.401])
    cuboid([body_width+smooth_edge_radius, body_length+smooth_edge_radius, 10], anchor=BOTTOM);
    
    //vertical cut
    color(negativeColor, 0.1)
    translate([0, 0, body_thickness/2 - screen_cut_height + case_thickness2 + extra_lip_bonus + 0.05])
    linear_extrude(height = body_thickness*1.5, center = true)
    rect([screen_width, screen_length], rounding=screen_radius);
    
    //low cut for curved screens
    if(screen_undercut>0.1)
    color(negativeColor2, 0.8)
    translate([0, 0, body_thickness/2])
    prismoid( 
        size1=[screen_width+smooth_edge_radius+10, screen_length+smooth_edge_radius-case_thickness2],
        size2=[screen_width+smooth_edge_radius+10, screen_length+smooth_edge_radius+case_thickness2],
        h=screen_undercut+0.1,
        rounding=screen_radius,
        anchor=BOTTOM
    );

    // Screen lip "ramps" - slim the lip on the sides for easier gesture nav
    if (shell_enable_angled_screen_bezels) {
        screen_angled_bezels();
    }

}

*screen_angled_bezels();
module screen_angled_bezels(){

    bezel_shapes();
    mirror([1,0,0]) bezel_shapes();
    mirror([0,1,0]) bezel_shapes();
    mirror([1,0,0]) mirror([0,1,0]) bezel_shapes();

    module bezel_shapes() {
        screen_cut_height = case_thickness2+extra_lip_bonus;
        smooth_edge_radius = (case_thickness2 < screen_cut_height/2) ? case_thickness2 : screen_cut_height/2 - 0.1;

        x1 = -(body_width/2 + case_thickness2 + shell_side_stickout);
        x2 = -(screen_width/2 + smooth_edge_radius); // front of the left lip
        x3 = -(screen_width/2); // left edge of the screen
        x4 = -(screen_width/2 - screen_radius);

        y1 = -(screen_length/2 + smooth_edge_radius); // bottom edge of the case shell
        y2 = -(screen_length/2 + (smooth_edge_radius - screen_radius)/2); // front of the bottom lip
        y3 = -(screen_length/2 - screen_radius);
        y4 = -(screen_length/2 - screen_radius*2);

        z0 = body_thickness / 2; // screen surface
        z1 = z0 + shell_screen_min_lip_inner;
        z2 = z0 + (shell_screen_min_lip_inner + shell_screen_max_lip_outer)/2;
        z3 = z0 + shell_screen_max_lip_outer;
        z4 = z0 + case_thickness2 + extra_lip_bonus;

        // Left edge
        patch_left_edge = [
            [[x1,0,z3], [x2,0,z2], [x3,0,z1]],
            [[x1,y4,z3], [x2,y4,z2], [x3,y4,z1]]
        ];
        *debug_bezier_patches([patch_left_edge]);

        patch_left_cap = [
            [[x1,y4,z3], [x2,y4,z3], [x3,y4,z3]],
            [[x1,0,z3], [x2,0,z3], [x3,0,z3]]
        ];
        *debug_bezier_patches([patch_left_cap]);

        patch_left_bottom_end = [
            [[x1,y4,z3], [x2,y4,z2], [x3,y4,z1]],
            [[x1,y4,z3], [x2,y4,z3], [x3,y4,z3]]
        ];
        *debug_bezier_patches([patch_left_bottom_end]);

        patch_left_side = [
            [[x3,y4,z1], [x3,0,z1]],
            [[x3,y4,z3], [x3,0,z3]]
        ];
        *debug_bezier_patches([patch_left_side]);

        patch_left_top_end = [
            [[x1,0,z3], [x2,0,z3], [x3,0,z3]],
            [[x1,0,z3], [x2,0,z2], [x3,0,z1]]
        ];
        *debug_bezier_patches([patch_left_top_end]);

        left_edge_patches = [patch_left_edge, patch_left_cap, patch_left_bottom_end, patch_left_side, patch_left_top_end];
        *debug_bezier_patches(left_edge_patches);
        left_edge_vnf = bezier_vnf(left_edge_patches, splinesteps=16);
        *vnf_validate(left_edge_vnf);
        vnf_polyhedron(left_edge_vnf);

        translate([x1, y4, z3]) cube([-x1+x3, -y4, z4-z3+1]);
        translate([x3, y4, z1]) cube([1, -y4, z4-z1+1]);

        // Corner
        patch_corner_back = [
            [[x1,y4,z3], [x2,y4,z2], [x3,y4,z1]],
            [[x1,y3,z3], [x2,y3,z2], [x3,y3,z1]],
            [[x1,y2,z4], [x2,y2,z4], [x3,y2,z4]],
            [[x1,y1,z4], [x2,y1,z4], [x3,y1,z4]]
        ];
        *debug_bezier_patches([patch_corner_back]);

        patch_corner_top_end = [
            [[x1,y4,z4], [x2,y4,z4], [x3,y4,z4]],
            [[x1,y4,z3], [x2,y4,z2], [x3,y4,z1]]
        ];
        *debug_bezier_patches([patch_corner_top_end]);

        patch_corner_left_side = [
            [[x1,y1,z4], [x1,y2,z4], [x1,y3,z4],[x1,y4,z4]],
            [[x1,y1,z4], [x1,y2,z4], [x1,y3,z3],[x1,y4,z3]]
        ];
        *debug_bezier_patches([patch_corner_left_side]);

        patch_corner_right_side = [
            [[x3,y1,z4], [x3,y2,z4], [x3,y3,z1],[x3,y4,z1]],
            [[x3,y1,z4], [x3,y2,z4], [x3,y3,z4],[x3,y4,z4]]
        ];
        *debug_bezier_patches([patch_corner_right_side]);

        patch_corner_front = [
            [[x1,y1,z4], [x2,y1,z4], [x3,y1,z4]],
            [[x1,y2,z4], [x2,y2,z4], [x3,y2,z4]],
            [[x1,y3,z4], [x2,y3,z4], [x3,y3,z4]],
            [[x1,y4,z4], [x2,y4,z4], [x3,y4,z4]]
        ];
        *debug_bezier_patches([patch_corner_front]);

        corner_patches = [patch_corner_back, patch_corner_top_end, patch_corner_front, patch_corner_left_side, patch_corner_right_side];
        *debug_bezier_patches(corner_patches);
        corner_vnf = bezier_vnf(corner_patches, splinesteps=16);
        *vnf_validate(corner_vnf);
        vnf_polyhedron(corner_vnf);

        translate([x1, y1, z4]) cube([-x1+x3, -y1+y4, 1]);

        // Bottom
        patch_bottom_back = [
            [[x3,y4,z1], [0,y4,z1]],
            [[x3,y3,z1], [0,y3,z1]],
            [[x3,y2,z4], [0,y2,z4]],
            [[x3,y1,z4], [0,y1,z4]]
        ];
        *debug_bezier_patches([patch_bottom_back]);

        patch_bottom_left_side = [
            [[x3,y1,z4], [x3,y2,z4], [x3,y3,z4],[x3,y4,z4]],
            [[x3,y1,z4], [x3,y2,z4], [x3,y3,z1],[x3,y4,z1]]
        ];
        *debug_bezier_patches([patch_bottom_left_side]);

        patch_bottom_right_side = [
            [[0,y1,z4], [0,y2,z4], [0,y3,z1],[0,y4,z1]],
            [[0,y1,z4], [0,y2,z4], [0,y3,z4],[0,y4,z4]]
        ];
        *debug_bezier_patches([patch_bottom_right_side]);

        patch_bottom_top_side = [
            [[x3,y4,z4], [0,y4,z4]],
            [[x3,y4,z1], [0,y4,z1]]
        ];
        *debug_bezier_patches([patch_bottom_top_side]);

        patch_bottom_front = [
            [[x3,y1,z4], [0,y1,z4]],
            [[x3,y2,z4], [0,y2,z4]],
            [[x3,y3,z4], [0,y3,z4]],
            [[x3,y4,z4], [0,y4,z4]]
        ];
        *debug_bezier_patches([patch_bottom_front]);

        bottom_patches = [patch_bottom_back, patch_bottom_left_side, patch_bottom_right_side, patch_bottom_top_side, patch_bottom_front];
        *debug_bezier_patches(bottom_patches);
        bottom_vnf = bezier_vnf(bottom_patches, splinesteps=16);
        *vnf_validate(bottom_vnf);
        vnf_polyhedron(bottom_vnf);

        translate([x3, y1, z4]) cube([-x3, -y1+y4, 1]);

    }
}


*color(negativeColor, 0.2) lanyard_cut();
module lanyard_cut(){
    
    //unsupported
    //ring cutout makes 2 slots for thin string lanyards
    if(lanyard_loop)
    color(negativeColor, 0.2) 
    translate([body_width/3.5,-body_length/2,-body_thickness/3])
    ring(body_thickness/2, 9, 6, 0.1 );

    if(lanyard_reinforcement) {
        //thicken the case around the lanyard holes
    }
}

// The USB Type C spec prescribes 12.35 x 6.5 for the overmold portion of a plug, but practice shows this is often taken as a suggestion by cable manufacturers.
// Throw in manufacturing and printing tolerances in the mix and it is wiser to leave some room for error.
usb_cut_width = 13.0;
usb_cut_height = 7.0;
usb_cut_rounding = 1.0;

speaker_cut_width = body_width*0.2;
speaker_hard_cut_width = body_width*0.65;
charge_port_width = (bottom_speakers_left || bottom_speakers_right || case_type2=="gamepad") ? speaker_hard_cut_width : usb_cut_width;

*usb_cut();
module usb_cut(){
    if(charge_on_bottom)
    color(negativeColor, 0.2)
    translate( [0, -body_length/2, charge_z_offset] )
    if(case_material2=="hard"){
        hard_cut(charge_port_width);
    }
    else { //soft cut
        //usb
        rotate([90,0,0])
        soft_cut(
            width=usb_cut_width,
            height=usb_cut_height,
            horizontal_clearance=0,
            disable_bevel=( case_type2=="joycon" || case_type2=="gamepad"),
            bevel_angle_y = charge_cutout_bevel_angle_y,
            bevel_angle_z = charge_cutout_bevel_angle_z,
            junglecat_support=(case_type2=="junglecat")
        );
        
        //speakers
        if(bottom_speakers_right){
            translate([bottom_speaker_inner_edge_from_center+bottom_speaker_width/2,0,bottom_speaker_vertical_offset_from_center])
            rotate([90,0,0])
            soft_cut(
                width=bottom_speaker_width, height=bottom_speaker_height, disable_bevel=true, horizontal_clearance=1, vertical_clearance=1,
                shallow_cut=(case_type2=="junglecat" || case_type2=="joycon" || case_type2=="gamepad")
            );
        }
        if(bottom_speakers_left){ 
            translate([-(bottom_speaker_inner_edge_from_center+bottom_speaker_width/2),0,bottom_speaker_vertical_offset_from_center])
            rotate([90,0,0])
            soft_cut(
                width=bottom_speaker_width, height=bottom_speaker_height, disable_bevel=true, horizontal_clearance=1, vertical_clearance=1, shallow_cut=(case_type2=="junglecat" || case_type2=="joycon" || case_type2=="gamepad")
            );
        }
    }
}

*button_cuts();
module button_cuts(){
    //hard buttons have a single cutout
    //power and volume cutouts are combined
    if(case_material2=="hard"){
        if(left_power_button || left_volume_buttons){
            hard_button_cut(false, left_power_button, left_power_from_top, left_power_length, left_volume_buttons, left_volume_from_top, left_volume_length);
        }
        //right_button_cut=true;
        if(right_power_button || right_volume_buttons){
            hard_button_cut(true, right_power_button, right_power_from_top, right_power_length, right_volume_buttons, right_volume_from_top, right_volume_length);
        }
    }
    //soft buttons recess. The rest of the button will be added later
    else if (case_material2=="soft") {
        if(right_power_button)
        soft_button_recess(true, right_power_length, right_power_from_top, disable_supports=true);
        if(right_volume_buttons)
        soft_button_recess(true, right_volume_length, right_volume_from_top, disable_supports=true);
        if(left_power_button)
        soft_button_recess(false, left_power_length, left_power_from_top, disable_supports=true);
        if(left_volume_buttons)
        soft_button_recess(false, left_volume_length, left_volume_from_top, disable_supports=true);
        
        if(right_button_1)
        soft_button_recess(true, right_button_1_length, right_button_1_from_top, disable_supports=true);
        if(left_button_1)
        soft_button_recess(false, left_button_1_length, left_button_1_from_top, disable_supports=true);
        if(right_button_2)
        soft_button_recess(true, right_button_2_length, right_button_2_from_top, disable_supports=true);
        if(left_button_2)
        soft_button_recess(false, left_button_2_length, left_button_2_from_top, disable_supports=true);

        // holes
        if(right_hole_1)
        soft_button_recess(true, right_hole_1_length, right_hole_1_from_top, disable_supports=false, more_bevel=right_hole_1_bevel);
        if(right_hole_2)
        soft_button_recess(true, right_hole_2_length, right_hole_2_from_top, disable_supports=false, more_bevel=right_hole_2_bevel);
        if(left_hole_1)
        soft_button_recess(false, left_hole_1_length, left_hole_1_from_top, disable_supports=false, more_bevel=left_hole_1_bevel);
        if(left_hole_2)
        soft_button_recess(false, left_hole_2_length, left_hole_2_from_top, disable_supports=false, more_bevel=left_hole_2_bevel);
        
    }
    
}

module soft_button_recess(right, button_length, button_offset, disable_supports=false, more_bevel=false) {
    right_or_left = right ? 1 : -1;
    bevel_angle_y = more_bevel ? more_hole_bevel_y : 25;
    bevel_angle_z = more_bevel ? more_hole_bevel_z : 15;
    translate( [ right_or_left*(body_width/2),
        body_length/2 - button_offset - button_length/2, 
        buttons_vertical_fudge
    ] )
    rotate([right_or_left*90,0,90])
    soft_cut(width=button_length, height=soft_cut_height1, disable_support=disable_supports, horizontal_clearance=buttons_clearance_soft_case, bevel_angle_y = bevel_angle_y, bevel_angle_z = bevel_angle_z);
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
    
    color(negativeColor, 0.2)
    translate( [ right_or_left*(body_width/2),
        body_length/2 - button_offset - button_length/2, 
        -body_thickness/2+case_thickness2+extra_lip_bonus+0.05
    ] )
    translate([0,0,0])
    rotate([0,0,90]) {
        //button cut
        cuboid([button_length+buttons_clearance_hard_case*2, button_cut_thickness, 50], rounding=button_cut_rounding, $fn=lowFn);

        //anti snag rounding
        rectangle = square([button_length+buttons_clearance_hard_case*2, case_thickness2*4+0.1],center=true);
        offset_sweep(rectangle, height=hard_cut_height,top=os_circle(r=-anti_snag_radius));
    }
    
}

//simple cutout for mute switches
module soft_cut( width, height, disable_support=false, disable_bevel=false, bevel_angle_y = 30, bevel_angle_z = 22.5, horizontal_clearance = 0, vertical_clearance = 0, shallow_cut=false, junglecat_support=false, joycon_support=false){
    cut_height = height;
    cut_depth = shallow_cut ? 0 : 15;
    cut_rounding = (button_cut_rounding>width)? width/2 : button_cut_rounding; //breaks at high body_width values
    cut_width = cut_rounding * manual_support_retract;
    
    difference() {
        //cutout
        translate([-more_hole_bevel_inset,0,0]) 
        soft_cut_submodule();
        
        //manual supports
        color(additionColor, 0.2)
        if(manual_supports==true && !disable_support) {
            prismoid(
                size1=[width+horizontal_clearance*2 - cut_width, cut_height+vertical_clearance*2],
                size2=[width+horizontal_clearance*2 - cut_width, cut_height+vertical_clearance*2],
                h=support_thickness, 
                anchor=CENTER
            );
            // for junglecat/joycon, support the outside of the USB cut
            if(junglecat_support && ( case_type2=="junglecat" || case_type2=="joycon" ) ) {
                case_depth = case_thickness2 + ( (case_type2=="junglecat")? junglecat_inner_width : 0 ) + ( (case_type2=="joycon")? joycon_depth+joycon_lip_thickness : 0 ) ;
                // adjacent * tan(bevel) = opposite
                beveled_support_width = 2*(case_depth * tan(bevel_angle_y)) + cut_width;
                beveled_support_height = 2*(case_depth * tan(bevel_angle_z)) + cut_depth;
                // echo(width);
                // echo(beveled_support_width);
                // echo(height);
                // echo(beveled_support_height);
                
                translate([0,0,case_thickness2+junglecat_inner_width])
                prismoid(
                    size1=[width+horizontal_clearance*2-cut_width,beveled_support_height], 
                    size2=[width+horizontal_clearance*2-cut_width,beveled_support_height], 
                    h=support_thickness, anchor=CENTER
                );
            }
        }
    }
    
    module soft_cut_submodule(){
        //straight-thru cut
        prismoid( 
            size1=[ width+horizontal_clearance*2, cut_height+vertical_clearance*2 ], 
            size2=[ width+horizontal_clearance*2, cut_height+vertical_clearance*2 ], 
            rounding=cut_rounding, 
            h=case_thickness2*3+cut_depth, 
            anchor=CENTER, 
            $fn=lowFn
        );
        //bevel
        // on gamepad mode, bevel will cut into body if made too large
        bevel_cut_height = (case_type2!="gamepad")  ? case_thickness2*2+junglecat_stickout+joycon_depth : case_thickness2*3;
        if(!disable_bevel)
        prismoid(
            size1=[ width+horizontal_clearance*2, cut_height ], 
            xang=90+bevel_angle_y,
            yang=90+bevel_angle_z,
            rounding=cut_rounding, 
            h=bevel_cut_height, 
            anchor=CENTER+BOTTOM, 
            $fn=lowFn
        );
    }
}

*soft_buttons();
module soft_buttons(){

    if (test_cut!="top_half_pla") {

        if (left_power_button) {
            soft_button(false, left_power_length, left_power_from_top, button_shell_protrusion = button_shell_protrusion, texture=left_power_button_texture);
        }
        if (left_volume_buttons) {
            soft_button(false, left_volume_length, left_volume_from_top, button_shell_protrusion = button_shell_protrusion, rocker_notch=button_volume_rocker_notch);
        }

        if (right_power_button) {
            soft_button(true, right_power_length, right_power_from_top, button_shell_protrusion = button_shell_protrusion, texture=right_power_button_texture);
        }
        if (right_volume_buttons) {
            soft_button(true, right_volume_length, right_volume_from_top, button_shell_protrusion = button_shell_protrusion, rocker_notch=button_volume_rocker_notch);
        }

        //TODO: make soft_button more general
        if (right_button_1) {
            soft_button(right=true, button_length=right_button_1_length, button_shell_protrusion = button_shell_protrusion, button_from_top=right_button_1_from_top);
        }
        if (left_button_1) {
            soft_button(right=false, button_length=left_button_1_length, button_shell_protrusion = button_shell_protrusion, button_from_top=left_button_1_from_top);
        }
        if (right_button_2) {
            soft_button(right=true, button_length=right_button_2_length, button_shell_protrusion = button_shell_protrusion, button_from_top=right_button_2_from_top);
        }
        if (left_button_2) {
            soft_button(right=false, button_length=left_button_2_length, button_shell_protrusion = button_shell_protrusion, button_from_top=left_button_2_from_top);
        }

    }
}

module soft_button(right, button_length, button_from_top, button_shell_protrusion = 0.8, rocker_notch=false, texture="none") {
    right_or_left = right ? 1 : -1;
    //if the case is thin and the button sticks out a lot, extend the button
    button_protrusion_compensated = (button_body_protrusion >  case_thickness2+button_shell_protrusion) ? button_body_protrusion+button_shell_protrusion : case_thickness2+button_shell_protrusion;
    button_wall_offset = case_thickness2 * button_wall_offset_percentage/100;
    button_plunger_width = (button_wall_offset - button_body_protrusion > 0) ? button_wall_offset - button_body_protrusion : 0;
    button_outside_width = case_thickness2 * (100 - button_wall_offset_percentage)/100 + button_shell_protrusion;

    assert(!(button_wall_offset - button_wall_thickness/2 < 0), "button wall is hitting the device body - either button_wall_offset_percentage is too small, button_wall_thickness is too big, or try a thicker case");

    color(shellColor, 0.8)
    translate( [ right_or_left*(body_width/2),
        body_length/2,
        buttons_vertical_fudge
    ] )
    rotate([right_or_left*90,0,90]) {
        difference(){
            soft_button_positive();
            soft_button_negative();
        }
    }

    // Wall fits in the recess and won't poke out of the shell
    color(shellColor, 0.8) difference() {
        intersection() {
            soft_button_wall();
            soft_button_recess(right, button_length, button_from_top, disable_supports=true);
            phone_shell();
        }
        translate([ right_or_left*(body_width/2), body_length/2, buttons_vertical_fudge]) rotate([right_or_left*90,0,90]) soft_button_negative();
    }

    module soft_button_wall() {
        button_wall_length_padding = 1; // To ensure the button walls merge well with the rest of the case regardless of bevel cutout chamfer angles
        button_wall_length = button_length+buttons_clearance_soft_case*2+button_padding + button_wall_length_padding;
        button_wall_height = body_thickness + case_thickness2*2;

        translate( [ right_or_left*(body_width/2), body_length/2, buttons_vertical_fudge] ) {
            rotate([right_or_left*90,0,90]) {
                translate([buttons_clearance_soft_case + button_padding/2 + button_wall_length_padding/2 - button_from_top, 0, button_wall_offset]) {
                    cube(
                        size=[button_wall_length, button_wall_height, button_wall_thickness], 
                        anchor=CENTER+RIGHT
                    );
                }
            }
        }
    }

    module soft_button_positive() {
        // Button shape
        translate([-button_from_top-button_length/2, 0, button_wall_offset])
        {
            if (abs(buttons_outer_thickness) < 0.1) {
                prismoid(
                    size1=[button_length+button_padding*2,soft_button_thickness1], 
                    size2=[(button_length+button_padding*2)*0.9,soft_button_thickness2], 
                    h=button_outside_width, 
                    rounding=button_rounding, 
                    anchor=CENTER+BOTTOM
                );
            } else {
                prismoid(
                    size2=[button_length+button_padding*2,buttons_outer_thickness], 
                    xang=buttons_overhang_angle,
                    yang=buttons_overhang_angle,
                    h=button_outside_width,
                    rounding=button_rounding,
                    anchor=CENTER+BOTTOM
                );
            }
        }

        // Plunger
        if (button_plunger_width > 0) {
            translate([-button_from_top-button_length/2,0,button_body_protrusion]) {
                prismoid(
                    size1=[button_length,button_case_thickness], 
                    size2=[button_length,button_case_thickness*1.33], 
                    h=button_plunger_width, 
                    rounding=button_rounding, 
                    anchor=CENTER+BOTTOM
                );
            }
        }
    }

    module soft_button_negative(){
        translate([-button_from_top-button_length/2,0,0]) {

            // Carves out an area for the device button on (thin) cases where the wall is too close
            prismoid(
                size1=[button_length+button_padding*2,body_thickness*0.4], 
                size2=[button_length,body_thickness*0.4], 
                h=button_body_protrusion, 
                rounding=button_rounding, 
                anchor=CENTER+BOTTOM
            );

            if(rocker_notch) {
                //a single cut in the middle of the button
                translate([0,0,case_thickness2 + button_shell_protrusion + 0.001])
                rotate([0,180,0])
                prismoid(size2=[rocker_notch_length,soft_cut_height1],h=(button_outside_width-button_wall_thickness/2)/2, yang=90, xang=60, anchor=BOTTOM+CENTER);
            }
            else if (texture=="serrated") {
                //a serrated texture
                sep=1.8;
                // TODO: doesn't look quite right on all devices
                for (i=[0:floor(button_length/sep)]) {
                    translate([-i*sep+button_length/2, 0, case_thickness2 + button_shell_protrusion])
                    rotate([0,45,0])
                    cuboid(size=[sqrt(2*sep^2)/2,sep,sqrt(2*sep^2)/2], rounding=sep/10, anchor=CENTER);
                }
            }
        }
    }
}

*camera_cut();
module camera_cut(){
    camera_radius_clearanced = camera_radius+camera_clearance;
    height = (case_type2=="joycon") ? joycon_thickness : case_thickness2*10; // Times 10 is just an arbitrary choice, cleaner preview than having the surfaces overlap
    chamfer_width = case_thickness2*10 * tan(camera_cutout_chamfer_angle);
    if(camera)
    color(negativeColor, 0.2)
    down(body_thickness/2)
    back(body_length/2-camera_from_top+camera_clearance)
    right(body_width/2-camera_from_side+camera_clearance)
    prismoid(
        size1=[camera_width+camera_clearance*2+chamfer_width, camera_height+camera_clearance*2+(camera_block_style == "island" ? chamfer_width : 0)], 
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
    chamfer_width = case_thickness2*2 * tan(camera_cutout_chamfer_angle);
    if(camera_cut_2)
    color(negativeColor, 0.2)
    //viewed from above, this  object is anchored to the top-right and translated to the top-right of the phone
    translate([
        body_width/2-camera_from_side_2+camera_clearance,
        body_length/2-camera_from_top_2+camera_clearance,
        -body_thickness/2
    ])
    prismoid(
        size1=[camera_width_2+camera_clearance*2+chamfer_width, camera_height_2+camera_clearance*2+chamfer_width], 
        size2=[camera_width_2+camera_clearance*2, camera_height_2+camera_clearance*2], 
        h=height,
        rounding=camera_radius_clearanced,
        anchor=[1,1,1]
    );
}



//fingerprint_cut();
module fingerprint_cut(){
    fingerprint_radius = fingerprint_diam/2;
    fingerprint_cut_height = case_thickness2*2;
    fingerprint_radius2 = fingerprint_radius + fingerprint_cut_height * tan(fingerprint_cutout_chamfer_angle);
    if (fingerprint)
    color(negativeColor, 0.2)
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
    color(negativeColor, 0.2)
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

*headphone_cut();
module headphone_cut(){
    top_or_bottom = headphone_on_top? 1:-1;
    headphone_radius_hard = 5;
    headphone_radius_soft = 4;
    trans = [ -body_width/2+headphone_from_left_edge+1.7, top_or_bottom*body_length/2, headphone_z_offset ];
    color(negativeColor, 0.2)
    if (headphone_on_top || headphone_on_bottom) {
        if(case_material2=="hard"){
            //we measure from edge of phone to edge of the 3.5mm jack. +1.7 to center it
            translate(trans)
            hard_cut(headphone_radius_hard*2);
        } else {
            // a slightly beveled hole
            translate(trans)
            rotate([90*top_or_bottom,0,0])
            cylinder(15, headphone_radius_soft*1.4, headphone_radius_soft*0.9, center=true);
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
        color(negativeColor)
        rotate([0,0,0])
        translate([-30,-body_length/2+30,-body_thickness/2])
        linear_extrude(height = case_thickness2/2, center = true) {
            text(name, font=emboss_font, size=font_size, spacing=font_kerning);
            translate([0,-line_translate*2,0])
            text(phone_model, font=emboss_font, size=small_font_size, spacing=font_kerning);
            translate([0,-line_translate,0])
            text(version, font=emboss_font, size=small_font_size, spacing=font_kerning);
        }
        
        //logo
        translate([0+logo_x,-body_length/2+70+logo_y,-body_thickness/2-case_thickness2/2])
        color(negativeColor)
        resize([body_width*logo_size_ratio, 0, case_thickness2/2], auto=[false,true,false])
        linear_extrude(height=case_thickness2/2)
        import(emboss_logo, center=true);
        //scale() might have better performance than resize(). But resize() takes absolute size. scale() takes a ratio so I'd need to know the input size.
    }
    if(emboss_size=="large") {
        line_translate = 12;
        color(negativeColor)
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
        color(negativeColor)
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
        color(negativeColor)
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
    if(emboss_size=="medium_rotated") {
        font_size = 6;
        small_font_size = 6;
        line_translate = font_size*2;
        color(negativeColor)
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

//why is this -joycon_z_shift*2, why *2
body_bottom = (case_type2=="joycon") ? body_thickness-joycon_z_shift*2 : body_thickness;
tele_rounding = 4;
thick_side_thickness = telescopic_pocket ? telescopic_pocket_thick_ness : telescopic_thick_side;
thin_side_thickness = telescopic_pocket ? telescopic_pocket_thin_ness : telescopic_thin_side;
thin_side_z_offset = telescopic_pocket ? telescopic_pocket_thin_offset : 0;
//makes the thin side a little shorter
thin_side_inset = 2.0;
telescopic_pocket_seam = 10; // [4:0.1:16]
tele_seam = -body_length/2 + ( telescopic_pocket ? telescopic_pocket_seam : telescopic_seam ) ;
tele_seam_width = 0.2;
telescopic_offset = body_width*(1-open_top_chop_ratio)/2;
telescopic_length = body_length-body_radius;
module telescopic_clamp(){
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
        color(additionColor2, 0.2)
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
            color(negativeColor, 0.2)
            translate([0,tele_seam,0])
            cuboid([body_width*2,tele_seam_width,body_width*2], anchor=CENTER);
            //viewing window in OpenSCAD only
            *color(negativeColor, 0.2)
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
                color(negativeColor, 0.2)
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
        color(negativeColor, 0.2)
        translate([0,body_seam_offset,0])
        cuboid([body_width*2,body_seam_width,100], anchor=CENTER);
    }
    if(open_top) {
        color(negativeColor, 0.2)
        translate([body_width/2,0,0]) {
            scale([1, 1, 0.99])
            body();
            
            scale([1, 1, 1])
            screen_cut();
        }
        
        if (open_top_backchop==true)
        color(negativeColor, 0.2)
        translate([body_width*open_top_chop_ratio,0,-body_thickness/2]) {
            scale([1, 1, 1])
            body();
            
            scale([1, 1, 1])
            screen_cut();
        }
    }
    if(clamp_top) {
        color(negativeColor, 0.2)
        translate([20,0,0]) {
            //scale([1, 0.95, 0.99])
            body();
            
            //scale([1, 0.95, 1])
            screen_cut();
        }
        
        junglecat_cuts(universal_inside=true);
    }
    if(speaker_slots_bottom) {
        slot_length = body_thickness-body_radius;
        slot_width = 3;
        slot_rounding = slot_width * 0.4;
        hole_sep = 6;
        hole_count = floor((body_length-body_radius*2)/hole_sep/2);
        grill_z = (case_type2=="joycon") ? joycon_z_shift+shimmy_translate : shimmy_translate;
        grill_seam_buffer = 8;
        copy_mirror()
        for(i=[0:hole_count]){
            if(i*hole_sep>body_seam_width/2+grill_seam_buffer)
            color(negativeColor, 0.2)
            translate([-body_width/3, i*hole_sep, grill_z])
            rotate([0,0,0])
            cuboid(
                [body_width, slot_width, slot_length],
                rounding=slot_rounding,
                anchor=CENTER
            );
        }
    }
    if(speaker_slots_side) {
        slot_length = body_thickness * 0.8;
        slot_width = 3;
        slot_rounding = slot_width * 0.4;
        hole_sep = 6;
        // calculate the distance we need to cover (underneath the joycons) then see how many holes will fit
        hole_count = floor((body_width-joycon_length-body_radius*2)/hole_sep);
        grill_z = 0;
        grill_seam_buffer = 8;
        copy_mirror()
        for(i=[0:hole_count]){
            color(negativeColor, 0.2)
            // move to the corner
            // then for each slot, move across body width
            translate([-body_width/2+body_radius*2+i*hole_sep, -body_width/3, grill_z])
            rotate([0,90,90])
            cuboid(
                [slot_length, slot_width, body_width],
                rounding=slot_rounding,
                anchor=CENTER
            );
        }
    }
   
    // speaker and airflow on back
    if(speaker_grill) {
        hole_sep = 6;
        hole_width = 3;
        hole_count = floor((body_length-body_radius*2)/hole_sep/2);
        grill_z = case_thickness/2;
        grill_seam_buffer = 10;
        copy_mirror()
        for(i=[0:hole_count]){
            if(i*hole_sep>body_seam_width/2+grill_seam_buffer)
            color(negativeColor, 0.2)
            translate([-body_width/3, i*hole_sep, -grill_z])
            rotate([0,90,0])
            cuboid(
                [body_thickness, hole_width, body_width], 
                anchor=CENTER
            );
        }
    }

}

//test_cuts();
module test_cuts(){
    easybox=[body_width*10,body_length*10,body_thickness*10];
    if(test_cut=="corners") {
        translate([0,0,0])
        cuboid(easybox, anchor=CENTER+BOTTOM);
    }
    else if(test_cut=="bottom_edge") {
        translate([0,-body_length/2+35,0])
        cuboid(easybox, anchor=CENTER+FRONT);
    }
    else if(test_cut=="top_edge") {
        translate([0,body_length/2-15,0])
        cuboid(easybox, anchor=CENTER+BACK);
    }
    else if(test_cut=="right_edge") {
        translate([body_width/4,0,0])
        cuboid(easybox, anchor=CENTER+RIGHT);
    }
    else if(test_cut=="left_edge") {
        translate([-body_width/4,0,0])
        cuboid(easybox, anchor=CENTER+LEFT);
    }
    else if(test_cut=="right_buttons") {
        translate([body_width/4,0,0])
        cuboid(easybox, anchor=CENTER+RIGHT);
        
        translate([0,
            body_length/3-max(right_volume_from_top,right_power_from_top) - max(right_volume_length,right_power_length),
            0
        ])
        cuboid(easybox, anchor=[0,1,0]);
    }
    else if(test_cut=="left_button") {
        translate([-body_width/4,0,0])
        cuboid(easybox, anchor=CENTER+LEFT);
        
        translate([0,
            body_length/3-max(left_volume_from_top,left_power_from_top) - max(left_volume_length,left_power_length),
            0
        ])
        cuboid(easybox, anchor=[0,1,0]);
    }
    else if(test_cut=="top_half_pla") {
        translate([0,0,0])
        cuboid(easybox, anchor=CENTER+BACK);
    }
    else if(test_cut=="telescopic") {
        translate([0,0,-body_thickness/2-case_thickness2-0.5]) //why -0.5
        cuboid(easybox, anchor=CENTER+BOTTOM);
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
    round_rectangle = round_corners(rectangle, radius=bottom_radius,$fn=lowFn);
    //round_rectangle = round_corners(rectangle, radius=bottom_radius,$fn=15);
    color(negativeColor, 0.2)
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
