/* Phone case generator.
 * Supports phone case, Joycon rails, Junglecat rails, and Cuttlephone gamepad
 * Designed to 3d print with PLA+, 0.4mm nozzle, 0.2mm layer height.
 * Author: Maave
 */

use <fonts/orbitron/orbitron-light.otf>
include <libraries/BOSL2/std.scad>
include <libraries/BOSL2/hull.scad>
include <libraries/BOSL2/rounding.scad>
include <libraries/BOSL2/shapes3d.scad>

/*  measurements from the phone
 *  all values are in mm
 *  Customizer's UI precision (0.1, 0.01, etc) depends on the precision of the variable
 */

/* [shell] */

case_material = "hard"; // [hard, soft]
case_type = "phone case"; // [phone case, gamepad, joycon, junglecat]
//a plastic guide to help you cut out the Joycon or Junglecat rails
rail_cut_tools = false;

//this should be a multiple of nozzle diameter
shell_thickness = 1.6;
//thing wall manual supports. Set this to nozzle diameter. In your slicer, enable thin wall support
support_thickness = 0.4;

 //"Cutout" can be removed with a razor blade. Use "thin wall detection" in your slicer. "None" means you'll handle it yourself in your slicer. "Peeloff" is experimental and still requires a blade
manual_supports = "cutout"; // [cutout, peeloff, none]
//set this to your layer height
support_airgap = 0.20; //TODO: test and tweak. This may depend on layer height.

emboss_version_text = true;
phone_model = "Pixel 3";

//test cuts
test_mode = "none"; //[none, corners, right_edge, right_buttons, left_edge, bottom_edge, top_edge, left_button, top_half_pla]

//the blank option gives each part and cut a color
//display_color = ""; //["", SeaGreen]
//TODO: blank string does what I want but generates a warning

/* [body] */

//Is there a good way to measuring this on the phone? Print-out guide template?
//rounding of the corners when viewed screen-up.
body_radius = 5.25;
body_length = 145.5;
body_width = 70.1;
body_thickness = 8.1;
body_radius_top = 2.1;
body_radius_bottom = 3.1;
//for phones with different rounding on the sides, like Galaxy S9+
body_bottom_side_radius = 0;
shell_side_wings = 0;

/* [screen] */

screen_radius = 8.01;
screen_lip_length = 3.1;
screen_length = body_length - screen_lip_length;
screen_lip_width = 3.1;
screen_width = body_width - screen_lip_width;
//left/right curved screen radius
screen_curve_radius = 0.0;
//for shallow curves like the S9+
screen_curve_inset = 0.0;
//sticks up
extra_lip = false;
//sticks out left and right
extra_sides = false;
screen_extra_top_left = 0;
screen_extra_top_right = 0;
screen_extra_bottom_left = 0;
screen_extra_bottom_right = 0;

/* [side buttons] */
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
//moves the buttons toward the screen (positive) or away (negative). Buttons are centered by default
buttons_vertical_fudge = 0.1;

/* [camera/fingerprint] */

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

fingerprint = false;
fingerprint_center_from_top = 36.5;
fingerprint_diam = 13;

/* [headphone and mic] */
mic_on_top = false;
mic_on_bottom = false;
mic_from_right_edge = 14.0;
headphone_from_left_edge = 14.0;
headphone_on_top = false;
headphone_on_bottom = false;

bottom_speakers = false;

//end customizer variables
module end_customizer_variables(){}

//alternate Fn values to speed up OpenSCAD. Turn this up during build
$fn=20;
//$fn= $preview ? 32 : 60;
lowFn = 10;
highFn = 25;

 /* I cannot override some variables via command line for some reason. But this works. */
case_type_override="stupid_hack";
case_type2 = (case_type_override!=undef && case_type_override!="stupid_hack") ? case_type_override : case_type;
case_material_override="stupid_hack";
case_material2 = (case_material_override!=undef && case_material_override!="stupid_hack") ? case_material_override : case_material;

// phone case / general variables
buttons_clearance = 5;
extra_lip_bonus = extra_lip ? 1 : 0;
anti_snag_radius = 3.8;

// gamepad variables
gamepad_wing_length = 35; //max that will fit on my printer
gamepad_body_radius = 10;
gamepad_shell_radius = 2;
gamepad_peg_y_distance = 14;

// joycon and junglecat shared variables
max_rail_shell_radius = 4;
max_rail_body_radius = 3; //sharper corner for looks
rail_shell_radius_top = (body_radius_top<max_rail_shell_radius) ? body_radius_top : max_rail_shell_radius; //TODO: tweak this, make is softer to hold, ensure it doesn't conflict with body
rail_shell_radius_bottom = (body_radius_bottom<max_rail_shell_radius) ? body_radius_bottom : max_rail_shell_radius; //TODO: tweak this, make is softer to hold, ensure it doesn't conflict with body
rail_body_radius = (body_radius<max_rail_body_radius) ? body_radius : max_rail_body_radius; //sharper corner for looks

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
version = "v0.2";

//unsupported features
lanyard_loop = false;

//colors are only visual, and only in OpenSCAD
bodyColor="SeaGreen";

difference(){
    //color(display_color)
    if(case_type2=="phone case") {
        phone_case();
    }
    else if(case_type2=="gamepad") {
        gamepad();
    }
    else if(case_type2=="joycon") {
        joycon_rails();
        if(rail_cut_tools) {
            joycon_cut_guide();
        }
    }
    else if(case_type2=="junglecat") {
        junglecat_rails();
        if(rail_cut_tools) {
            junglecat_cut_guide();
        }
    }
    
    test_cuts();
}

module phone_case(){
    difference(){
        color(bodyColor)
        phone_shell();
        body();
        shell_cuts();
    }
    soft_supports();
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
    difference(){
        color(bodyColor)
        joycon_shell();
        body();
        shell_cuts();
        joycon_cuts();
    }
    soft_supports();
}

module junglecat_rails(){
    difference(){
        color(bodyColor)
        junglecat_shell();
        body();
        shell_cuts();
        junglecat_cuts();
    }
    soft_supports();
}

//body();
module body(){
    color("orange", 0.2)
    difference() {
        minkowski() {
            cube([ body_width - 2*body_radius, 
                body_length - 2*body_radius, 
                0.01 ], 
                center=true
            );
            //this pill shape will spin around the cube.
            //it sets the radius of the body
            cyl( 
                l=body_thickness, 
                r=body_radius,
                rounding1=body_radius_bottom, 
                rounding2=body_radius_top,
                $fn=15
            );
        }
        //for curved screens and irregular shapes like Galaxy S9+
        body_extra_radius();
    }
}

//body_extra_radius();
module body_extra_radius(){
    //bottom curve right
    color("red", 0.2)
    translate([body_width/2,0,-body_thickness/2])
    rotate([90,0,0])
    interior_fillet(l=body_length-body_radius, r=body_bottom_side_radius, spin=90); 
    //bottom curve left
    color("red", 0.2)
    translate([-body_width/2,0,-body_thickness/2])
    rotate([90,0,0])
    interior_fillet(l=body_length-body_radius, r=body_bottom_side_radius, spin=0);
   
    //curved screen right
    color("red", 0.2)
    translate([body_width/2,0,body_thickness/2])
    rotate([90,0,0])
    interior_fillet(l=body_length-body_radius, r=screen_curve_radius, spin=180); 
    //curved screen left
    color("red", 0.2)
    translate([-body_width/2,0,body_thickness/2])
    rotate([90,0,0])
    interior_fillet(l=body_length-body_radius, r=screen_curve_radius, spin=-90);   
}

//manual supports and stick-out buttons for soft TPU prints
module soft_supports(){
    if(case_material2=="soft") {
        soft_buttons();
    }
}

//phone_shell();
module phone_shell(){
    difference() {
        resize(newsize=[
            body_width + 2*shell_thickness + 2*shell_side_wings,
            body_length + 2*shell_thickness,
            body_thickness + 2*shell_thickness
        ])
        body();
        
        //curved_screen_cuts();
    }
    
}

//color("red", 0.4) curved_screen_cuts();
module curved_screen_cuts(){
    //curved screen right
    color("red", 0.2)
    translate([body_width/2,0,body_thickness/2+0.5])
    rotate([90,0,0])
    interior_fillet(l=body_length-2*screen_radius, r=screen_curve_radius+0.05, spin=-90); 
    
    //curved screen left
    color("red", 0.2)
    translate([-body_width/2,0,body_thickness/2])
    rotate([90,0,0])
    interior_fillet(l=body_length-2*body_radius, r=screen_curve_radius, spin=-90);
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
            l=body_thickness + 2*shell_thickness + extra_lip_bonus, 
            r=gamepad_body_radius+shell_thickness,
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
            l=joycon_thickness + 2*shell_thickness + extra_lip_bonus, 
            r=rail_body_radius+shell_thickness,
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
        //edge shape and thickness
        translate([0,0,extra_lip_bonus/2])
        cyl( 
            l=body_thickness + 2*shell_thickness + extra_lip_bonus, 
            r=rail_body_radius+shell_thickness,
            rounding1=rail_shell_radius_bottom, 
            rounding2=rail_shell_radius_top
        );
    }
}


//junglecat_cut_guide();
module junglecat_cut_guide(){
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
                translate([junglecat_rail_length/2,0,-6])
                cuboid( [ 10, junglecat_inner_width, 15], 
                    rounding=1, 
                    edges=[RIGHT,TOP,BOTTOM],
                    anchor=LEFT+CENTER
                );
            }
            
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
module junglecat_cuts(){
    copy_mirror() {
        color("red", 0.2)
        translate([0, -body_length/2-shell_thickness-junglecat_depth/2, 0]) {
            //dimple
            translate([body_width/2-junglecat_dimple_from_top,
            -(shell_thickness+junglecat_lip_thickness),
            0])
            sphere(d=2.0);
            //inside channels
            translate([(body_width-junglecat_rail_length)/2+shell_thickness,0,0])
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
            translate([(body_width-junglecat_rail_length)/2+shell_thickness,-junglecat_depth/2-junglecat_lip_thickness/2,0]) {
                if(manual_supports=="peeloff" || manual_supports=="cutout"){ //TODO fixerize
                    //this adds a visible lip so you rip off the support and not the rail
                    removal_aid = 4;
                    rotate([90,0,0])
                    rect_tube(
                        size=[ junglecat_rail_length+support_airgap*2, junglecat_lip_width+support_airgap],
                        isize=[junglecat_rail_length, junglecat_lip_width], 
                        h=junglecat_depth,
                        anchor=CENTER);
                } else if (manual_supports=="cutout") {
                    //solid wall that you must cut with a craft knife
                    //the only cutout is a "hint" on one side
                    translate([-junglecat_rail_length/2,0,0])
                    cuboid([1,1,junglecat_lip_width]);
                }
                else { //bring your own support
                    cube([body_width+shell_thickness+1, junglecat_lip_thickness+2, junglecat_lip_width], center=true);
                }
            }
        }
    }
}


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

//joycon_cuts();
module joycon_cuts(){
    lock_notch_width = 4.5;
    lock_notch_depth = (joycon_inner_width-joycon_lip_width)/2;
    lock_notch_offset = 9.75;
    copy_mirror() {
        color("red", 0.2)
        translate([0, -body_length/2-shell_thickness-joycon_depth/2, joycon_z_shift]) {
            //inner cutout
            cube([body_width+shell_thickness+2,joycon_depth,joycon_inner_width],center=true);
            //lip cutout
            translate([0,-joycon_depth/2-joycon_lip_thickness/2,0]) {
                if(manual_supports=="cutout"){
                    //this adds a visible lip so you rip off the support and not the rail
                    removal_aid = 4;
                    rotate([90,0,0])
                    rect_tube(
                        size=[ body_width+5, joycon_lip_width+support_airgap],
                        isize=[body_width+shell_thickness-removal_aid, joycon_lip_width], 
                        h=joycon_depth,
                        anchor=CENTER);
                } else { //bring your own support
                    cube([body_width+shell_thickness+1, joycon_lip_thickness+2, joycon_lip_width], center=true);
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
        body_width/2+shell_thickness,
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
        body_width/2,
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
        translate([0,gamepad_cutout_translate,-body_thickness/2+shell_thickness +2]) {
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

screen_cut();
module screen_cut(){
    screen_cut_height = shell_thickness+extra_lip_bonus+0.5;
    screen_corners = [
        screen_radius + screen_extra_bottom_right,
        screen_radius + screen_extra_bottom_left,
        screen_radius + screen_extra_top_left,
        screen_radius + screen_extra_top_right,
    ];
    rectangle = square([screen_width, screen_length],center=true);
    round_rectangle = round_corners(rectangle, radius=screen_corners,$fn=highFn);
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
    translate([0,-body_length/2-3,body_width/4])
    ring(8, body_thickness+shell_thickness*2, 7, 0.1 );
    */
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
charge_port_width = (bottom_speakers || case_type=="gamepad") ? speaker_hard_cut_width : usb_cut_width;
//usb_cut();
module usb_cut(){
    color("red", 0.2)
    translate( [0, -body_length/2, 0] )
    if(case_material2=="hard"){
        anti_snag(charge_port_width);
    }
    else { //soft cut
        //usb
        rotate([90,0,0])
        soft_cut(
            usb_cut_width, 
            disable_clearance=true, 
            disable_bevel=(case_type=="junglecat" || case_type=="joycon" || case_type=="gamepad"),
            junglecat_support=true,
            extra_tall=true
        );
        
        //speakers
        if(bottom_speakers){
            fudge=3; //avoid overlapping the USB's bevel cut
            //calculate speaker cuts based on phone width
            translate([usb_cut_width/2+fudge+speaker_cut_width/2,0,0])
            rotate([90,0,0])
            soft_cut(
                speaker_cut_width, disable_bevel=true, disable_clearance=true,
                shallow_cut=(case_type=="junglecat" || case_type=="joycon" || case_type=="gamepad")
            );
            
            translate([-usb_cut_width/2-fudge-speaker_cut_width/2,0,0])
            rotate([90,0,0])
            soft_cut(
                speaker_cut_width, disable_bevel=true, disable_clearance=true, shallow_cut=(case_type=="junglecat" || case_type=="joycon" || case_type=="gamepad")
            );
        }
    }
}

//button_cuts();
module button_cuts(){
    //left_button=true;
    if(left_power_button || left_volume_buttons){
        button_cut(false, left_power_button, left_power_from_top, left_power_length, left_volume_buttons, left_volume_from_top, left_volume_length);
    }
    //right_button_cut=true;
    if(right_power_button || right_volume_buttons){
        button_cut(true, right_power_button, right_power_from_top, right_power_length, right_volume_buttons, right_volume_from_top, right_volume_length);
    }
}

button_cut_rounding = 2;
module button_cut(right,  power_button, power_from_top, power_length, volume_buttons, volume_from_top, volume_length){
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
    anti_snag_height = body_thickness; //TODO: use joycon_thickness on joycon version
    
    color("red", 0.2)
    if(case_material2=="hard"){
        translate( [ right_or_left*(body_width/2),
            body_length/2 - button_offset - button_length/2, 
            -body_thickness/2+shell_thickness+extra_lip_bonus+0.05
        ] )
        translate([0,0,])
        rotate([0,0,90]) {
            //button cut
            cuboid([button_length+buttons_clearance*2, button_cut_thickness, 50], rounding=button_cut_rounding, $fn=lowFn);

            //anti snag rounding
            rectangle = square([button_length+buttons_clearance*2, shell_thickness*4+0.1],center=true);
            offset_sweep(rectangle, height=anti_snag_height,top=os_circle(r=-anti_snag_radius));
        }
    }
    else {
        translate( [ right_or_left*(body_width/2),
            body_length/2 - button_offset - button_length/2, 
            buttons_vertical_fudge
        ] )
        rotate([right_or_left*90,0,90])
        soft_cut(button_length, disable_support=true, disable_clearance=false);
    }
}

//simple cutout for mute switches
module soft_cut( button_length, disable_support=false, disable_bevel=false, disable_clearance=false, shallow_cut=false, junglecat_support=false, joycon_support=false, extra_tall=false ){
    soft_clearance = disable_clearance ? 0:buttons_clearance;
    cut_depth = shallow_cut ? 0 : 10;
    difference() {
        //cutout
        soft_cut_submodule();
        
        //manual supports
        color("blue", 0.2)
        if(manual_supports=="cutout" && !disable_support) {
            prismoid(size1=[button_length+soft_clearance*2-button_cut_rounding*2,body_thickness*0.6], size2=[button_length+soft_clearance*2-button_cut_rounding*2,body_thickness*0.6], h=support_thickness, anchor=CENTER);
            //TODO: manual support for junglecat and joycon
            if(junglecat_support) {
                //for(i=[0:floor(shell_thickness+junglecat_inner_width)]) {
                //  translate([0,0,1*i])
                //  prismoid(size1=[button_length+soft_clearance*2-button_cut_rounding*2,body_thickness*0.6], size2=[button_length+soft_clearance*2-button_cut_rounding*2,body_thickness*0.6], h=support_thickness, anchor=CENTER);
                //}
                translate([0,0,shell_thickness+junglecat_inner_width])
                prismoid(size1=[button_length+soft_clearance*2-button_cut_rounding*2,body_thickness*0.6], size2=[button_length+soft_clearance*2-button_cut_rounding*2,body_thickness*0.6], h=support_thickness, anchor=CENTER);
            }
        }
    }
    
    module soft_cut_submodule(){
        cut_height = extra_tall ? body_thickness*0.6 : body_thickness*0.8;
        //straight-thru cut
        prismoid( 
            size1=[ button_length+soft_clearance*2, cut_height ], 
            size2=[ button_length+soft_clearance*2, cut_height ], 
            rounding=button_cut_rounding, 
            h=shell_thickness*3+cut_depth, 
            anchor=CENTER, 
            $fn=lowFn
        );
        //bevel cut. Needs better angle calculation
        if(!disable_bevel)
        prismoid(
            size1=[ button_length+soft_clearance*2, cut_height ], 
            size2=[ button_length+soft_clearance*2+10, cut_height+7 ], 
            rounding=button_cut_rounding, 
            h=shell_thickness*3, 
            anchor=CENTER+BOTTOM, 
            $fn=lowFn
        );
    }
}

module soft_buttons(){
    //left_button=true;
    if(left_power_button || left_volume_buttons){
        soft_button(false, left_power_button, left_power_from_top, left_power_length, left_volume_buttons, left_volume_from_top, left_volume_length);
    }
    //right_button_cut=true;
    if(right_power_button || right_volume_buttons){
        soft_button(true, right_power_button, right_power_from_top, right_power_length, right_volume_buttons, right_volume_from_top, right_volume_length);
    }
}

module soft_button(right,  power_button, power_from_top, power_length, volume_buttons, volume_from_top, volume_length){
    //lots of booleans to enable/disable features
    right_or_left = right ? 1 : -1;
    has_power_button = power_button ? 1 : 0;
    has_volume_buttons = volume_buttons ? 1 : 0;
    has_space = (has_volume_buttons && has_power_button) ? 1 : 0;
    power_position = (power_from_top < volume_from_top) ? 1 : 0;
    volume_position = (power_from_top > volume_from_top) ? 1 : 0;
    space_between_buttons = abs(power_from_top-volume_from_top) - volume_position*volume_length - power_position*power_length;
    button_length = has_volume_buttons*volume_length + has_power_button*power_length + has_space*space_between_buttons;
    button_offset = has_space ? min(power_from_top*has_power_button, volume_from_top*has_volume_buttons) : power_from_top*has_power_button + volume_from_top*has_volume_buttons;
    
    button_protrusion = 0.8;
    button_recess = 1.6; //TODO: parametize
    button_rounding=body_thickness*0.1;
    button_padding=2; //bonus to allow error in measuring
    
    color("blue", 0.2)
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
    
    module soft_button_positive(){
        //backing
        //I tried having this all filled in (looks better) but it makes the buttons hard to press
        translate([buttons_clearance - button_offset-button_cut_rounding,0,0])
        prismoid(
            size1=[button_length+buttons_clearance*2-button_cut_rounding*2,body_thickness*0.6], 
            size2=[button_length+buttons_clearance*2-button_cut_rounding*2,body_thickness*0.6], 
            h=support_thickness, 
            anchor=CENTER+RIGHT
        );
        //power
        if(has_power_button && test_mode!="top_half_pla")
        translate([-power_from_top-power_length/2,0,0])
        prismoid(
            size1=[power_length+button_padding*2,body_thickness*0.55], 
            size2=[(power_length+button_padding*2)*0.9,body_thickness*0.2], 
            h=shell_thickness+button_protrusion, 
            rounding=button_rounding, 
            anchor=CENTER+BOTTOM
        );
        //volume
        if(has_volume_buttons && test_mode!="top_half_pla")
        translate([-volume_from_top-volume_length/2,0,0])
        prismoid(
            size1=[volume_length+button_padding*2,body_thickness*0.55], 
            size2=[(volume_length+button_padding*2)*0.9,body_thickness*0.2], 
            h=shell_thickness+button_protrusion, 
            rounding=button_rounding, 
            anchor=CENTER+BOTTOM
        );
    }
    
    module soft_button_negative(){
        //power
        translate([-power_from_top-power_length/2,0,0])
        if(has_power_button){
            //recess
            prismoid(
                size1=[power_length+button_padding*2,body_thickness*0.4], 
                size2=[power_length,body_thickness*0.4], 
                h=button_recess, 
                rounding=button_rounding, 
                anchor=CENTER
            );
            
            //power button texture. Use a cube's edge to make serrations
            box=1;
            sep=2;
            for(i=[0:floor((power_length)/sep)]){
                translate([-i*sep+power_length/2,0,shell_thickness+button_protrusion])
                rotate([0,45,0])
                cuboid([2,2,2], 
                anchor=CENTER);
            }
        }
        //volume
        translate([-volume_from_top-volume_length/2,0,0])
        if(has_volume_buttons){
            //recess
            prismoid(
                size1=[volume_length+button_padding*2,body_thickness*0.4], 
                size2=[volume_length,body_thickness*0.4], 
                h=button_recess, 
                rounding=button_rounding, 
                anchor=CENTER
            );
        
            //use a cube's edge to make a cut
            translate([0,0,shell_thickness+button_protrusion])
            rotate([0,45,0])
            cuboid([2,2,2], anchor=CENTER);
        }
    }
}

//camera_cut();
module camera_cut(){
    camera_radius_clearanced = camera_radius+camera_clearance;
    height = 5;
    angle = 8; //just an offset. TODO: calculate this in degrees
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
    //if(case_material2=="soft") //soft
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
    fingerprint_cut_height = 6; //TODO: calculate this
    if (fingerprint)
    color("red", 0.2)
    translate([ 
        0, 
        body_length/2-fingerprint_center_from_top, 
        -body_thickness/2-fingerprint_cut_height/2 
    ])
    cylinder( fingerprint_cut_height, fingerprint_radius*2, fingerprint_radius, true);
}

//mic_on_top=true; mic_cut();
module mic_cut(){
    top_or_bottom = mic_on_top?1:-1;
    //can this be improved?
    mic_diam = 2.0;
    if (mic_on_top || mic_on_bottom) 
    color("red", 0.2)
    if (case_type=="joycon") {
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
        translate( [ body_width/2-mic_from_right_edge, top_or_bottom*body_length/2, 0 ] )
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
            anti_snag(headphone_radius_hard*2, top_radius=headphone_radius_hard/1.1, bottom_radius=headphone_radius_hard/1.1);
            //anti_snag(headphone_radius_hard); //I tried this with default radius out but it's kinda ugly
        } else {
            translate(trans)
            rotate([90*top_or_bottom,0,0])
            cylinder(15, headphone_radius_soft*1.2, headphone_radius_soft*0.9, center=true);
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
