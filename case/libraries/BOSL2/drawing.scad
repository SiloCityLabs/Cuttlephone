//////////////////////////////////////////////////////////////////////
// LibFile: drawing.scad
//   This file includes stroke(), which converts a path into a
//   geometric object, like drawing with a pen.  It even works on
//   three-dimensional paths.  You can make a dashed line or add arrow
//   heads.  The turtle() function provides a turtle graphics style
//   approach for producing paths.  The arc() function produces arc paths,
//   and helix() produces helix paths.
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Basic Modeling
// FileSummary: Attachable cubes, cylinders, spheres, ruler, and text.  Many can produce a VNF.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////


// Section: Line Drawing

// Module: stroke()
// Usage:
//   stroke(path, [width], [closed], [endcaps], [endcap_width], [endcap_length], [endcap_extent], [trim]);
//   stroke(path, [width], [closed], [endcap1], [endcap2], [endcap_width1], [endcap_width2], [endcap_length1], [endcap_length2], [endcap_extent1], [endcap_extent2], [trim1], [trim2]);
// Topics: Paths (2D), Paths (3D), Drawing Tools
// Description:
//   Draws a 2D or 3D path with a given line width.  Joints and each endcap can be replaced with
//   various marker shapes, and can be assigned different colors.  If passed a region instead of
//   a path, draws each path in the region as a closed polygon by default. If `closed=false` is
//   given with a region, each subpath is drawn as an un-closed line path.
// Figure(Med,NoAxes,2D,VPR=[0,0,0],VPD=250): Endcap Types
//   cap_pairs = [
//       ["butt",  "chisel" ],
//       ["round", "square" ],
//       ["line",  "cross"  ],
//       ["x",     "diamond"],
//       ["dot",   "block"  ],
//       ["tail",  "arrow"  ],
//       ["tail2", "arrow2" ]
//   ];
//   for (i = idx(cap_pairs)) {
//       fwd((i-len(cap_pairs)/2+0.5)*13) {
//           stroke([[-20,0], [20,0]], width=3, endcap1=cap_pairs[i][0], endcap2=cap_pairs[i][1]);
//           color("black") {
//               stroke([[-20,0], [20,0]], width=0.25, endcaps=false);
//               left(28) text(text=cap_pairs[i][0], size=5, halign="right", valign="center");
//               right(28) text(text=cap_pairs[i][1], size=5, halign="left", valign="center");
//           }
//       }
//   }
// Arguments:
//   path = The path to draw along.
//   width = The width of the line to draw.  If given as a list of widths, (one for each path point), draws the line with varying thickness to each point.
//   closed = If true, draw an additional line from the end of the path to the start.
//   joints  = Specifies the joint shape for each joint of the line.  If a 2D polygon is given, use that to draw custom joints.
//   endcaps = Specifies the endcap type for both ends of the line.  If a 2D polygon is given, use that to draw custom endcaps.
//   endcap1 = Specifies the endcap type for the start of the line.  If a 2D polygon is given, use that to draw a custom endcap.
//   endcap2 = Specifies the endcap type for the end of the line.  If a 2D polygon is given, use that to draw a custom endcap.
//   dots = Specifies both the endcap and joint types with one argument.  If given `true`, sets both to "dot".  If a 2D polygon is given, uses that to draw custom dots.
//   joint_width = Some joint shapes are wider than the line.  This specifies the width of the shape, in multiples of the line width.
//   endcap_width = Some endcap types are wider than the line.  This specifies the size of endcaps, in multiples of the line width.
//   endcap_width1 = This specifies the size of starting endcap, in multiples of the line width.
//   endcap_width2 = This specifies the size of ending endcap, in multiples of the line width.
//   dots_width = This specifies the size of the joints and endcaps, in multiples of the line width.
//   joint_length = Length of joint shape, in multiples of the line width.
//   endcap_length = Length of endcaps, in multiples of the line width.
//   endcap_length1 = Length of starting endcap, in multiples of the line width.
//   endcap_length2 = Length of ending endcap, in multiples of the line width.
//   dots_length = Length of both joints and endcaps, in multiples of the line width.
//   joint_extent = Extents length of joint shape, in multiples of the line width.
//   endcap_extent = Extents length of endcaps, in multiples of the line width.
//   endcap_extent1 = Extents length of starting endcap, in multiples of the line width.
//   endcap_extent2 = Extents length of ending endcap, in multiples of the line width.
//   dots_extent = Extents length of both joints and endcaps, in multiples of the line width.
//   joint_angle = Extra rotation given to joint shapes, in degrees.  If not given, the shapes are fully spun (for 3D lines).
//   endcap_angle = Extra rotation given to endcaps, in degrees.  If not given, the endcaps are fully spun (for 3D lines).
//   endcap_angle1 = Extra rotation given to a starting endcap, in degrees.  If not given, the endcap is fully spun (for 3D lines).
//   endcap_angle2 = Extra rotation given to a ending endcap, in degrees.  If not given, the endcap is fully spun (for 3D lines).
//   dots_angle = Extra rotation given to both joints and endcaps, in degrees.  If not given, the endcap is fully spun (for 3D lines).
//   trim = Trim the the start and end line segments by this much, to keep them from interfering with custom endcaps.
//   trim1 = Trim the the starting line segment by this much, to keep it from interfering with a custom endcap.
//   trim2 = Trim the the ending line segment by this much, to keep it from interfering with a custom endcap.
//   color = If given, sets the color of the line segments, joints and endcap.
//   endcap_color = If given, sets the color of both endcaps.  Overrides `color=` and `dots_color=`.
//   endcap_color1 = If give, sets the color of the starting endcap.  Overrides `color=`, `dots_color=`,  and `endcap_color=`.
//   endcap_color2 = If given, sets the color of the ending endcap.  Overrides `color=`, `dots_color=`,  and `endcap_color=`.
//   joint_color = If given, sets the color of the joints.  Overrides `color=` and `dots_color=`.
//   dots_color = If given, sets the color of the endcaps and joints.  Overrides `color=`.
//   convexity = Max number of times a line could intersect a wall of an endcap.
//   hull = If true, use `hull()` to make higher quality joints between segments, at the cost of being much slower.  Default: true
// Example(2D): Drawing a Path
//   path = [[0,100], [100,100], [200,0], [100,-100], [100,0]];
//   stroke(path, width=20);
// Example(2D): Closing a Path
//   path = [[0,100], [100,100], [200,0], [100,-100], [100,0]];
//   stroke(path, width=20, endcaps=true, closed=true);
// Example(2D): Fancy Arrow Endcaps
//   path = [[0,100], [100,100], [200,0], [100,-100], [100,0]];
//   stroke(path, width=10, endcaps="arrow2");
// Example(2D): Modified Fancy Arrow Endcaps
//   path = [[0,100], [100,100], [200,0], [100,-100], [100,0]];
//   stroke(path, width=10, endcaps="arrow2", endcap_width=6, endcap_length=3, endcap_extent=2);
// Example(2D): Mixed Endcaps
//   path = [[0,100], [100,100], [200,0], [100,-100], [100,0]];
//   stroke(path, width=10, endcap1="tail2", endcap2="arrow2");
// Example(2D): Plotting Points
//   path = [for (a=[0:30:360]) [a-180, 60*sin(a)]];
//   stroke(path, width=3, joints="diamond", endcaps="arrow2", endcap_angle=0, endcap_width=5, joint_angle=0, joint_width=5);
// Example(2D): Joints and Endcaps
//   path = [for (a=[0:30:360]) [a-180, 60*sin(a)]];
//   stroke(path, width=8, joints="dot", endcaps="arrow2");
// Example(2D): Custom Endcap Shapes
//   path = [[0,100], [100,100], [200,0], [100,-100], [100,0]];
//   arrow = [[0,0], [2,-3], [0.5,-2.3], [2,-4], [0.5,-3.5], [-0.5,-3.5], [-2,-4], [-0.5,-2.3], [-2,-3]];
//   stroke(path, width=10, trim=3.5, endcaps=arrow);
// Example(2D): Variable Line Width
//   path = circle(d=50,$fn=18);
//   widths = [for (i=idx(path)) 10*i/len(path)+2];
//   stroke(path,width=widths,$fa=1,$fs=1);
// Example: 3D Path with Endcaps
//   path = rot([15,30,0], p=path3d(pentagon(d=50)));
//   stroke(path, width=2, endcaps="arrow2", $fn=18);
// Example: 3D Path with Flat Endcaps
//   path = rot([15,30,0], p=path3d(pentagon(d=50)));
//   stroke(path, width=2, endcaps="arrow2", endcap_angle=0, $fn=18);
// Example: 3D Path with Mixed Endcaps
//   path = rot([15,30,0], p=path3d(pentagon(d=50)));
//   stroke(path, width=2, endcap1="arrow2", endcap2="tail", endcap_angle2=0, $fn=18);
// Example: 3D Path with Joints and Endcaps
//   path = [for (i=[0:10:360]) [(i-180)/2,20*cos(3*i),20*sin(3*i)]];
//   stroke(path, width=2, joints="dot", endcap1="round", endcap2="arrow2", joint_width=2.0, endcap_width2=3, $fn=18);
// Example: Coloring Lines, Joints, and Endcaps
//   path = [for (i=[0:15:360]) [(i-180)/3,20*cos(2*i),20*sin(2*i)]];
//   stroke(
//       path, width=2, joints="dot", endcap1="dot", endcap2="arrow2",
//       color="lightgreen", joint_color="red", endcap_color="blue",
//       joint_width=2.0, endcap_width2=3, $fn=18
//   );
// Example(2D): Simplified Plotting
//   path = [for (i=[0:15:360]) [(i-180)/3,20*cos(2*i)]];
//   stroke(path, width=2, dots=true, color="lightgreen", dots_color="red", $fn=18);
// Example(2D): Drawing a Region
//   rgn = [square(100,center=true), circle(d=60,$fn=18)];
//   stroke(rgn, width=2);
// Example(2D): Drawing a List of Lines
//   paths = [
//       for (y=[-60:60:60]) [
//           for (a=[-180:15:180])
//           [a, 2*y+60*sin(a+y)]
//       ]
//   ];
//   stroke(paths, closed=false, width=5);
function stroke(
    path, width=1, closed,
    endcaps,       endcap1,        endcap2,        joints,       dots,
    endcap_width,  endcap_width1,  endcap_width2,  joint_width,  dots_width,
    endcap_length, endcap_length1, endcap_length2, joint_length, dots_length,
    endcap_extent, endcap_extent1, endcap_extent2, joint_extent, dots_extent,
    endcap_angle,  endcap_angle1,  endcap_angle2,  joint_angle,  dots_angle,
    endcap_color,  endcap_color1,  endcap_color2,  joint_color,  dots_color, color,
    trim, trim1, trim2,
    convexity=10, hull=true
) = no_function("stroke");


module stroke(
    path, width=1, closed,
    endcaps,       endcap1,        endcap2,        joints,       dots,
    endcap_width,  endcap_width1,  endcap_width2,  joint_width,  dots_width,
    endcap_length, endcap_length1, endcap_length2, joint_length, dots_length,
    endcap_extent, endcap_extent1, endcap_extent2, joint_extent, dots_extent,
    endcap_angle,  endcap_angle1,  endcap_angle2,  joint_angle,  dots_angle,
    endcap_color,  endcap_color1,  endcap_color2,  joint_color,  dots_color, color,
    trim, trim1, trim2,
    convexity=10, hull=true
) {
    no_children($children);
    module setcolor(clr) {
        if (clr==undef) {
            children();
        } else {
            color(clr) children();
        }
    }
    function _shape_defaults(cap) =
        cap==undef?     [1.00, 0.00, 0.00] :
        cap==false?     [1.00, 0.00, 0.00] :
        cap==true?      [1.00, 1.00, 0.00] :
        cap=="butt"?    [1.00, 0.00, 0.00] :
        cap=="round"?   [1.00, 1.00, 0.00] :
        cap=="chisel"?  [1.00, 1.00, 0.00] :
        cap=="square"?  [1.00, 1.00, 0.00] :
        cap=="block"?   [2.00, 1.00, 0.00] :
        cap=="diamond"? [2.50, 1.00, 0.00] :
        cap=="dot"?     [2.00, 1.00, 0.00] :
        cap=="x"?       [2.50, 0.40, 0.00] :
        cap=="cross"?   [3.00, 0.33, 0.00] :
        cap=="line"?    [3.50, 0.22, 0.00] :
        cap=="arrow"?   [3.50, 0.40, 0.50] :
        cap=="arrow2"?  [3.50, 1.00, 0.14] :
        cap=="tail"?    [3.50, 0.47, 0.50] :
        cap=="tail2"?   [3.50, 0.28, 0.50] :
        is_path(cap)?   [0.00, 0.00, 0.00] :
        assert(false, str("Invalid cap or joint: ",cap));

    function _shape_path(cap,linewidth,w,l,l2) = (
        (cap=="butt" || cap==false || cap==undef)? [] : 
        (cap=="round" || cap==true)? scale([w,l], p=circle(d=1, $fn=max(8, segs(w/2)))) :
        cap=="chisel"?  scale([w,l], p=circle(d=1,$fn=4)) :
        cap=="diamond"? circle(d=w,$fn=4) :
        cap=="square"?  scale([w,l], p=square(1,center=true)) :
        cap=="block"?   scale([w,l], p=square(1,center=true)) :
        cap=="dot"?     circle(d=w, $fn=max(12, segs(w*3/2))) :
        cap=="x"?       [for (a=[0:90:270]) each rot(a,p=[[w+l/2,w-l/2]/2, [w-l/2,w+l/2]/2, [0,l/2]]) ] :
        cap=="cross"?   [for (a=[0:90:270]) each rot(a,p=[[l,w]/2, [-l,w]/2, [-l,l]/2]) ] :
        cap=="line"?    scale([w,l], p=square(1,center=true)) :
        cap=="arrow"?   [[0,0], [w/2,-l2], [w/2,-l2-l], [0,-l], [-w/2,-l2-l], [-w/2,-l2]] :
        cap=="arrow2"?  [[0,0], [w/2,-l2-l], [0,-l], [-w/2,-l2-l]] :
        cap=="tail"?    [[0,0], [w/2,l2], [w/2,l2-l], [0,-l], [-w/2,l2-l], [-w/2,l2]] :
        cap=="tail2"?   [[w/2,0], [w/2,-l], [0,-l-l2], [-w/2,-l], [-w/2,0]] :
        is_path(cap)? cap :
        assert(false, str("Invalid endcap: ",cap))
    ) * linewidth;

    closed = default(closed, is_region(path));
    assert(is_bool(closed));

    dots = dots==true? "dot" : dots;

    endcap1 = first_defined([endcap1, endcaps, dots, "round"]);
    endcap2 = first_defined([endcap2, endcaps, if (!closed) dots, "round"]);
    joints  = first_defined([joints, dots, "round"]);
    assert(is_bool(endcap1) || is_string(endcap1) || is_path(endcap1));
    assert(is_bool(endcap2) || is_string(endcap2) || is_path(endcap2));
    assert(is_bool(joints)  || is_string(joints)  || is_path(joints));

    endcap1_dflts = _shape_defaults(endcap1);
    endcap2_dflts = _shape_defaults(endcap2);
    joint_dflts   = _shape_defaults(joints);

    endcap_width1 = first_defined([endcap_width1, endcap_width, dots_width, endcap1_dflts[0]]);
    endcap_width2 = first_defined([endcap_width2, endcap_width, dots_width, endcap2_dflts[0]]);
    joint_width   = first_defined([joint_width, dots_width, joint_dflts[0]]);
    assert(is_num(endcap_width1));
    assert(is_num(endcap_width2));
    assert(is_num(joint_width));

    endcap_length1 = first_defined([endcap_length1, endcap_length, dots_length, endcap1_dflts[1]*endcap_width1]);
    endcap_length2 = first_defined([endcap_length2, endcap_length, dots_length, endcap2_dflts[1]*endcap_width2]);
    joint_length   = first_defined([joint_length, dots_length, joint_dflts[1]*joint_width]);
    assert(is_num(endcap_length1));
    assert(is_num(endcap_length2));
    assert(is_num(joint_length));

    endcap_extent1 = first_defined([endcap_extent1, endcap_extent, dots_extent, endcap1_dflts[2]*endcap_width1]);
    endcap_extent2 = first_defined([endcap_extent2, endcap_extent, dots_extent, endcap2_dflts[2]*endcap_width2]);
    joint_extent   = first_defined([joint_extent, dots_extent, joint_dflts[2]*joint_width]);
    assert(is_num(endcap_extent1));
    assert(is_num(endcap_extent2));
    assert(is_num(joint_extent));

    endcap_angle1 = first_defined([endcap_angle1, endcap_angle, dots_angle]);
    endcap_angle2 = first_defined([endcap_angle2, endcap_angle, dots_angle]);
    joint_angle = first_defined([joint_angle, dots_angle]);
    assert(is_undef(endcap_angle1)||is_num(endcap_angle1));
    assert(is_undef(endcap_angle2)||is_num(endcap_angle2));
    assert(is_undef(joint_angle)||is_num(joint_angle));

    endcap_color1 = first_defined([endcap_color1, endcap_color, dots_color, color]);
    endcap_color2 = first_defined([endcap_color2, endcap_color, dots_color, color]);
    joint_color = first_defined([joint_color, dots_color, color]);

    paths = is_region(path)? path : [path];
    for (path = paths) {
        assert(is_list(path));
        if (len(path) > 1) {
            assert(is_path(path,[2,3]), "The path argument must be a list of 2D or 3D points, or a region.");
        }
        path = deduplicate( closed? close_path(path) : path );

        assert(is_num(width) || (is_vector(width) && len(width)==len(path)));
        width = is_num(width)? [for (x=path) width] : width;
        assert(all([for (w=width) w>0]));

        endcap_shape1 = _shape_path(endcap1, width[0], endcap_width1, endcap_length1, endcap_extent1);
        endcap_shape2 = _shape_path(endcap2, last(width), endcap_width2, endcap_length2, endcap_extent2);

        trim1 = width[0] * first_defined([
            trim1, trim,
            (endcap1=="arrow")? endcap_length1-0.01 :
            (endcap1=="arrow2")? endcap_length1*3/4 :
            0
        ]);
        assert(is_num(trim1));

        trim2 = last(width) * first_defined([
            trim2, trim,
            (endcap2=="arrow")? endcap_length2-0.01 :
            (endcap2=="arrow2")? endcap_length2*3/4 :
            0
        ]);
        assert(is_num(trim2));


        if (len(path) == 1) {
            if (len(path[0]) == 2) {
                // Endcap1
                setcolor(endcap_color1) {
                    translate(path[0]) {
                        mat = is_undef(endcap_angle1)? ident(3) : zrot(endcap_angle1);
                        multmatrix(mat) polygon(endcap_shape1);
                    }
                }
            } else {
                // Endcap1
                setcolor(endcap_color1) {
                    translate(path[0]) {
                        $fn = segs(width[0]/2);
                        if (is_undef(endcap_angle1)) {
                            rotate_extrude(convexity=convexity) {
                                right_half(planar=true) {
                                    polygon(endcap_shape1);
                                }
                            }
                        } else {
                            rotate([90,0,endcap_angle1]) {
                                linear_extrude(height=max(widths[0],0.001), center=true, convexity=convexity) {
                                    polygon(endcap_shape1);
                                }
                            }
                        }
                    }
                }
            }
        } else {
            dummy=assert(trim1<path_length(path)-trim2, "Path is too short for endcap(s).  Try a smaller width, or set endcap_length to a smaller value.");
            pathcut = _path_cut_points(path, [trim1, path_length(path)-trim2], closed=false);
            pathcut_su = _cut_to_seg_u_form(pathcut,path);
            path2 = _path_cut_getpaths(path, pathcut, closed=false)[1];
            widths = _path_select(width, pathcut_su[0][0], pathcut_su[0][1], pathcut_su[1][0], pathcut_su[1][1]);
            start_vec = path[0] - path[1];
            end_vec = last(path) - select(path,-2);

            if (len(path[0]) == 2) {
                // Straight segments
                setcolor(color) {
                    for (i = idx(path2,e=-2)) {
                        seg = select(path2,i,i+1);
                        delt = seg[1] - seg[0];
                        translate(seg[0]) {
                            rot(from=BACK,to=delt) {
                                trapezoid(w1=widths[i], w2=widths[i+1], h=norm(delt), anchor=FRONT);
                            }
                        }
                    }
                }

                // Joints
                setcolor(joint_color) {
                    for (i = [1:1:len(path2)-2]) {
                        $fn = quantup(segs(widths[i]/2),4);
                        translate(path2[i]) {
                            if (joints != undef) {
                                joint_shape = _shape_path(
                                    joints, width[i],
                                    joint_width,
                                    joint_length,
                                    joint_extent
                                );
                                v1 = unit(path2[i] - path2[i-1]);
                                v2 = unit(path2[i+1] - path2[i]);
                                mat = is_undef(joint_angle)
                                  ? rot(from=BACK,to=v1)
                                  : zrot(joint_angle);
                                multmatrix(mat) polygon(joint_shape);
                            } else if (hull) {
                                hull() {
                                    rot(from=BACK, to=path2[i]-path2[i-1])
                                        circle(d=widths[i]);
                                    rot(from=BACK, to=path2[i+1]-path2[i])
                                        circle(d=widths[i]);
                                }
                            } else {
                                rot(from=BACK, to=path2[i]-path2[i-1])
                                    circle(d=widths[i]);
                                rot(from=BACK, to=path2[i+1]-path2[i])
                                    circle(d=widths[i]);
                            }
                        }
                    }
                }

                // Endcap1
                setcolor(endcap_color1) {
                    translate(path[0]) {
                        mat = is_undef(endcap_angle1)? rot(from=BACK,to=start_vec) :
                            zrot(endcap_angle1);
                        multmatrix(mat) polygon(endcap_shape1);
                    }
                }

                // Endcap2
                setcolor(endcap_color2) {
                    translate(last(path)) {
                        mat = is_undef(endcap_angle2)? rot(from=BACK,to=end_vec) :
                            zrot(endcap_angle2);
                        multmatrix(mat) polygon(endcap_shape2);
                    }
                }
            } else {
                quatsums = q_cumulative([
                    for (i = idx(path2,e=-2)) let(
                        vec1 = i==0? UP : unit(path2[i]-path2[i-1], UP),
                        vec2 = unit(path2[i+1]-path2[i], UP),
                        axis = vector_axis(vec1,vec2),
                        ang = vector_angle(vec1,vec2)
                    ) quat(axis,ang)
                ]);
                rotmats = [for (q=quatsums) q_matrix4(q)];
                sides = [
                    for (i = idx(path2,e=-2))
                    quantup(segs(max(widths[i],widths[i+1])/2),4)
                ];

                // Straight segments
                setcolor(color) {
                    for (i = idx(path2,e=-2)) {
                        dist = norm(path2[i+1] - path2[i]);
                        w1 = widths[i]/2;
                        w2 = widths[i+1]/2;
                        $fn = sides[i];
                        translate(path2[i]) {
                            multmatrix(rotmats[i]) {
                                cylinder(r1=w1, r2=w2, h=dist, center=false);
                            }
                        }
                    }
                }

                // Joints
                setcolor(joint_color) {
                    for (i = [1:1:len(path2)-2]) {
                        $fn = sides[i];
                        translate(path2[i]) {
                            if (joints != undef) {
                                joint_shape = _shape_path(
                                    joints, width[i],
                                    joint_width,
                                    joint_length,
                                    joint_extent
                                );
                                multmatrix(rotmats[i] * xrot(180)) {
                                    $fn = sides[i];
                                    if (is_undef(joint_angle)) {
                                        rotate_extrude(convexity=convexity) {
                                            right_half(planar=true) {
                                                polygon(joint_shape);
                                            }
                                        }
                                    } else {
                                        rotate([90,0,joint_angle]) {
                                            linear_extrude(height=max(widths[i],0.001), center=true, convexity=convexity) {
                                                polygon(joint_shape);
                                            }
                                        }
                                    }
                                }
                            } else if (hull) {
                                hull(){
                                    multmatrix(rotmats[i]) {
                                        sphere(d=widths[i],style="aligned");
                                    }
                                    multmatrix(rotmats[i-1]) {
                                        sphere(d=widths[i],style="aligned");
                                    }
                                }
                            } else {
                                multmatrix(rotmats[i]) {
                                    sphere(d=widths[i],style="aligned");
                                }
                                multmatrix(rotmats[i-1]) {
                                    sphere(d=widths[i],style="aligned");
                                }
                            }
                        }
                    }
                }

                // Endcap1
                setcolor(endcap_color1) {
                    translate(path[0]) {
                        multmatrix(rotmats[0] * xrot(180)) {
                            $fn = sides[0];
                            if (is_undef(endcap_angle1)) {
                                rotate_extrude(convexity=convexity) {
                                    right_half(planar=true) {
                                        polygon(endcap_shape1);
                                    }
                                }
                            } else {
                                rotate([90,0,endcap_angle1]) {
                                    linear_extrude(height=max(widths[0],0.001), center=true, convexity=convexity) {
                                        polygon(endcap_shape1);
                                    }
                                }
                            }
                        }
                    }
                }

                // Endcap2
                setcolor(endcap_color2) {
                    translate(last(path)) {
                        multmatrix(last(rotmats)) {
                            $fn = last(sides);
                            if (is_undef(endcap_angle2)) {
                                rotate_extrude(convexity=convexity) {
                                    right_half(planar=true) {
                                        polygon(endcap_shape2);
                                    }
                                }
                            } else {
                                rotate([90,0,endcap_angle2]) {
                                    linear_extrude(height=max(last(widths),0.001), center=true, convexity=convexity) {
                                        polygon(endcap_shape2);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


// Function&Module: dashed_stroke()
// Usage: As a Module
//   dashed_stroke(path, dashpat, [closed=]);
// Usage: As a Function
//   dashes = dashed_stroke(path, dashpat, width=, [closed=]);
// Topics: Paths, Drawing Tools
// See Also: stroke(), path_cut()
// Description:
//   Given a path (or region) and a dash pattern, creates a dashed line that follows that
//   path or region boundary with the given dash pattern.
//   - When called as a function, returns a list of dash sub-paths.
//   - When called as a module, draws all those subpaths using `stroke()`.
//   When called as a module the dash pattern is multiplied by the line width.  When called as
//   a function the dash pattern applies as you specify it.  
// Arguments:
//   path = The path or region to subdivide into dashes.
//   dashpat = A list of alternating dash lengths and space lengths for the dash pattern.  This will be scaled by the width of the line.
//   ---
//   width = The width of the dashed line to draw.  Module only.  Default: 1
//   closed = If true, treat path as a closed polygon.  Default: false
// Example(2D): Open Path
//   path = [for (a=[-180:10:180]) [a/3,20*sin(a)]];
//   dashed_stroke(path, [3,2], width=1);
// Example(2D): Closed Polygon
//   path = circle(d=100,$fn=72);
//   dashpat = [10,2,3,2,3,2];
//   dashed_stroke(path, dashpat, width=1, closed=true);
// Example(FlatSpin,VPD=250): 3D Dashed Path
//   path = [for (a=[-180:5:180]) [a/3, 20*cos(3*a), 20*sin(3*a)]];
//   dashed_stroke(path, [3,2], width=1);
function dashed_stroke(path, dashpat=[3,3], closed=false) =
    is_region(path) ? [for(p=path) each dashed_stroke(p,dashpat,closed=true)] : 
    let(
        path = closed? close_path(path) : path,
        dashpat = len(dashpat)%2==0? dashpat : concat(dashpat,[0]),
        plen = path_length(path),
        dlen = sum(dashpat),
        doff = cumsum(dashpat),
        reps = floor(plen / dlen),
        step = plen / reps,
        cuts = [
            for (i=[0:1:reps-1], off=doff)
            let (st=i*step, x=st+off)
            if (x>0 && x<plen) x
        ],
        dashes = path_cut(path, cuts, closed=false),
        evens = [for (i=idx(dashes)) if (i%2==0) dashes[i]]
    ) evens;


module dashed_stroke(path, dashpat=[3,3], width=1, closed=false) {
    no_children($children);
    segs = dashed_stroke(path, dashpat=dashpat*width, closed=closed);
    for (seg = segs)
        stroke(seg, width=width, endcaps=false);
}



// Section: Computing paths

// Function&Module: arc()
// Usage: 2D arc from 0º to `angle` degrees.
//   arc(N, r|d=, angle);
// Usage: 2D arc from START to END degrees.
//   arc(N, r|d=, angle=[START,END])
// Usage: 2D arc from `start` to `start+angle` degrees.
//   arc(N, r|d=, start=, angle=)
// Usage: 2D circle segment by `width` and `thickness`, starting and ending on the X axis.
//   arc(N, width=, thickness=)
// Usage: Shortest 2D or 3D arc around centerpoint `cp`, starting at P0 and ending on the vector pointing from `cp` to `P1`.
//   arc(N, cp=, points=[P0,P1], [long=], [cw=], [ccw=])
// Usage: 2D or 3D arc, starting at `P0`, passing through `P1` and ending at `P2`.
//   arc(N, points=[P0,P1,P2])
// Topics: Paths (2D), Paths (3D), Shapes (2D), Path Generators
// Description:
//   If called as a function, returns a 2D or 3D path forming an arc.
//   If called as a module, creates a 2D arc polygon or pie slice shape.
// Arguments:
//   N = Number of vertices to form the arc curve from.
//   r = Radius of the arc.
//   angle = If a scalar, specifies the end angle in degrees (relative to start parameter).  If a vector of two scalars, specifies start and end angles.
//   ---
//   d = Diameter of the arc.
//   cp = Centerpoint of arc.
//   points = Points on the arc.
//   long = if given with cp and points takes the long arc instead of the default short arc.  Default: false
//   cw = if given with cp and 2 points takes the arc in the clockwise direction.  Default: false
//   ccw = if given with cp and 2 points takes the arc in the counter-clockwise direction.  Default: false
//   width = If given with `thickness`, arc starts and ends on X axis, to make a circle segment.
//   thickness = If given with `width`, arc starts and ends on X axis, to make a circle segment.
//   start = Start angle of arc.
//   wedge = If true, include centerpoint `cp` in output to form pie slice shape.
//   endpoint = If false exclude the last point (function only).  Default: true
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  (Module only) Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  (Module only) Default: `0`
// Examples(2D):
//   arc(N=4, r=30, angle=30, wedge=true);
//   arc(r=30, angle=30, wedge=true);
//   arc(d=60, angle=30, wedge=true);
//   arc(d=60, angle=120);
//   arc(d=60, angle=120, wedge=true);
//   arc(r=30, angle=[75,135], wedge=true);
//   arc(r=30, start=45, angle=75, wedge=true);
//   arc(width=60, thickness=20);
//   arc(cp=[-10,5], points=[[20,10],[0,35]], wedge=true);
//   arc(points=[[30,-5],[20,10],[-10,20]], wedge=true);
//   arc(points=[[5,30],[-10,-10],[30,5]], wedge=true);
// Example(2D):
//   path = arc(points=[[5,30],[-10,-10],[30,5]], wedge=true);
//   stroke(closed=true, path);
// Example(FlatSpin,VPD=175):
//   path = arc(points=[[0,30,0],[0,0,30],[30,0,0]]);
//   stroke(path, dots=true, dots_color="blue");
function arc(N, r, angle, d, cp, points, width, thickness, start, wedge=false, long=false, cw=false, ccw=false, endpoint=true) =
    assert(is_bool(endpoint))
    !endpoint ? assert(!wedge, "endpoint cannot be false if wedge is true")
               list_head(arc(N+1,r,angle,d,cp,points,width,thickness,start,wedge,long,cw,ccw,true)) :
    assert(is_undef(N) || (is_integer(N) && N>=2), "Number of points must be an integer 2 or larger")
    // First try for 2D arc specified by width and thickness
    is_def(width) && is_def(thickness)? (
                assert(!any_defined([r,cp,points]) && !any([cw,ccw,long]),"Conflicting or invalid parameters to arc")
                assert(width>0, "Width must be postive")
                assert(thickness>0, "Thickness must be positive")
        arc(N,points=[[width/2,0], [0,thickness], [-width/2,0]],wedge=wedge)
    ) : is_def(angle)? (
        let(
            parmok = !any_defined([points,width,thickness]) &&
                ((is_vector(angle,2) && is_undef(start)) || is_num(angle))
        )
        assert(parmok,"Invalid parameters in arc")
        let(
            cp = first_defined([cp,[0,0]]),
            start = is_def(start)? start : is_vector(angle) ? angle[0] : 0,
            angle = is_vector(angle)? angle[1]-angle[0] : angle,
            r = get_radius(r=r, d=d)
        )
        assert(is_vector(cp,2),"Centerpoint must be a 2d vector")
        assert(angle!=0, "Arc has zero length")
        assert(is_def(r) && r>0, "Arc radius invalid")
        let(
            N = is_def(N) ? N : max(3, ceil(segs(r)*abs(angle)/360)),
            arcpoints = [for(i=[0:N-1]) let(theta = start + i*angle/(N-1)) r*[cos(theta),sin(theta)]+cp],
            extra = wedge? [cp] : []
        )
        concat(extra,arcpoints)
    ) :
          assert(is_path(points,[2,3]),"Point list is invalid")
        // Arc is 3D, so transform points to 2D and make a recursive call, then remap back to 3D
         len(points[0])==3? (
                assert(!(cw || ccw), "(Counter)clockwise isn't meaningful in 3d, so `cw` and `ccw` must be false")
                assert(is_undef(cp) || is_vector(cp,3),"points are 3d so cp must be 3d")
        let(
            plane = [is_def(cp) ? cp : points[2], points[0], points[1]],
            center2d = is_def(cp) ? project_plane(plane,cp) : undef,
            points2d = project_plane(plane, points)
        )
        lift_plane(plane,arc(N,cp=center2d,points=points2d,wedge=wedge,long=long))
    ) : is_def(cp)? (
        // Arc defined by center plus two points, will have radius defined by center and points[0]
        // and extent defined by direction of point[1] from the center
                assert(is_vector(cp,2), "Centerpoint must be a 2d vector")
                assert(len(points)==2, "When pointlist has length 3 centerpoint is not allowed")
                assert(points[0]!=points[1], "Arc endpoints are equal")
                assert(cp!=points[0]&&cp!=points[1], "Centerpoint equals an arc endpoint")
                assert(count_true([long,cw,ccw])<=1, str("Only one of `long`, `cw` and `ccw` can be true",cw,ccw,long))
        let(    
            angle = vector_angle(points[0], cp, points[1]),
            v1 = points[0]-cp,
            v2 = points[1]-cp,
            prelim_dir = sign(det2([v1,v2])),   // z component of cross product
                        dir = prelim_dir != 0
                                  ? prelim_dir
                                  : assert(cw || ccw, "Collinear inputs don't define a unique arc")
                                    1,
            r=norm(v1),
                        final_angle = long || (ccw && dir<0) || (cw && dir>0) ? -dir*(360-angle) : dir*angle
        )
        arc(N,cp=cp,r=r,start=atan2(v1.y,v1.x),angle=final_angle,wedge=wedge)
    ) : (
        // Final case is arc passing through three points, starting at point[0] and ending at point[3]
        let(col = is_collinear(points[0],points[1],points[2]))
        assert(!col, "Collinear inputs do not define an arc")
        let(
            cp = line_intersection(_normal_segment(points[0],points[1]),_normal_segment(points[1],points[2])),
            // select order to be counterclockwise
            dir = det2([points[1]-points[0],points[2]-points[1]]) > 0,
            points = dir? select(points,[0,2]) : select(points,[2,0]),
            r = norm(points[0]-cp),
            theta_start = atan2(points[0].y-cp.y, points[0].x-cp.x),
            theta_end = atan2(points[1].y-cp.y, points[1].x-cp.x),
            angle = posmod(theta_end-theta_start, 360),
            arcpts = arc(N,cp=cp,r=r,start=theta_start,angle=angle,wedge=wedge)
        )
        dir ? arcpts : reverse(arcpts)
    );


module arc(N, r, angle, d, cp, points, width, thickness, start, wedge=false, anchor=CENTER, spin=0)
{
    path = arc(N=N, r=r, angle=angle, d=d, cp=cp, points=points, width=width, thickness=thickness, start=start, wedge=wedge);
    attachable(anchor,spin, two_d=true, path=path, extent=false) {
        polygon(path);
        children();
    }
}


// Function: helix()
// Usage:
//   helix([l|h], [turns], [angle], r|r1|r2, d|d1|d2)
// Description:
//   Returns a 3D helical path on a cone, including the degerate case of flat spirals.
//   You can specify start and end radii.  You can give the length, the helix angle, or the number of turns: two
//   of these three parameters define the helix.  For a flat helix you must give length 0 and a turn count.
//   Helix will be right handed if turns is positive and left handed if it is negative.
//   The angle is calculateld based on the radius at the base of the helix.
// Arguments:
//   h|l = Height/length of helix, zero for a flat spiral
//   ---
//   turns = Number of turns in helix, positive for right handed
//   angle = helix angle
//   r = Radius of helix
//   r1 = Radius of bottom of helix
//   r2 = Radius of top of helix
//   d = Diameter of helix
//   d1 = Diameter of bottom of helix
//   d2 = Diameter of top of helix
// Example(3D):
//   stroke(helix(turns=2.5, h=100, r=50), dots=true, dots_color="blue");
// Example(3D):  Helix that turns the other way
//   stroke(helix(turns=-2.5, h=100, r=50), dots=true, dots_color="blue");
// Example(3D): Flat helix (note points are still 3d)
//   stroke(helix(h=0,r1=50,r2=25,l=0, turns=4));
module helix(l,h,turns,angle, r, r1, r2, d, d1, d2) {no_module();}
function helix(l,h,turns,angle, r, r1, r2, d, d1, d2)=
    let(
        r1=get_radius(r=r,r1=r1,d=d,d1=d1,dflt=1),
        r2=get_radius(r=r,r1=r2,d=d,d1=d2,dflt=1),
        length = first_defined([l,h])
    )
    assert(num_defined([length,turns,angle])==2,"Must define exactly two of l/h, turns, and angle")
    assert(is_undef(angle) || length!=0, "Cannot give length 0 with an angle")
    let(
        // length advances dz for each turn
        dz = is_def(angle) && length!=0 ? 2*PI*r1*tan(angle) : length/abs(turns),

        maxtheta = is_def(turns) ? 360*turns : 360*length/dz,
        N = segs(max(r1,r2))
    )
    [for(theta=lerpn(0,maxtheta, max(3,ceil(abs(maxtheta)*N/360))))
       let(R=lerp(r1,r2,theta/maxtheta))
       [R*cos(theta), R*sin(theta), abs(theta)/360 * dz]];


function _normal_segment(p1,p2) =
    let(center = (p1+p2)/2)
    [center, center + norm(p1-p2)/2 * line_normal(p1,p2)];


// Function: turtle()
// Usage:
//   turtle(commands, [state], [full_state=], [repeat=])
// Topics: Shapes (2D), Path Generators (2D), Mini-Language
// See Also: turtle3d()
// Description:
//   Use a sequence of turtle graphics commands to generate a path.  The parameter `commands` is a list of
//   turtle commands and optional parameters for each command.  The turtle state has a position, movement direction,
//   movement distance, and default turn angle.  If you do not give `state` as input then the turtle starts at the
//   origin, pointed along the positive x axis with a movement distance of 1.  By default, `turtle` returns just
//   the computed turtle path.  If you set `full_state` to true then it instead returns the full turtle state.
//   You can invoke `turtle` again with this full state to continue the turtle path where you left off.
//   .
//   The turtle state is a list with three entries: the path constructed so far, the current step as a 2-vector, the current default angle,
//   and the current arcsteps setting.  
//   .
//   Commands     | Arguments          | What it does
//   ------------ | ------------------ | -------------------------------
//   "move"       | [dist]             | Move turtle scale*dist units in the turtle direction.  Default dist=1.  
//   "xmove"      | [dist]             | Move turtle scale*dist units in the x direction. Default dist=1.  Does not change turtle direction.
//   "ymove"      | [dist]             | Move turtle scale*dist units in the y direction. Default dist=1.  Does not change turtle direction.
//   "xymove"     | vector             | Move turtle by the specified vector.  Does not change turtle direction. 
//   "untilx"     | xtarget            | Move turtle in turtle direction until x==xtarget.  Produces an error if xtarget is not reachable.
//   "untily"     | ytarget            | Move turtle in turtle direction until y==ytarget.  Produces an error if xtarget is not reachable.
//   "jump"       | point              | Move the turtle to the specified point
//   "xjump"      | x                  | Move the turtle's x position to the specified value
//   "yjump       | y                  | Move the turtle's y position to the specified value
//   "turn"       | [angle]            | Turn turtle direction by specified angle, or the turtle's default turn angle.  The default angle starts at 90.
//   "left"       | [angle]            | Same as "turn"
//   "right"      | [angle]            | Same as "turn", -angle
//   "angle"      | angle              | Set the default turn angle.
//   "setdir"     | dir                | Set turtle direction.  The parameter `dir` can be an angle or a vector.
//   "length"     | length             | Change the turtle move distance to `length`
//   "scale"      | factor             | Multiply turtle move distance by `factor`
//   "addlength"  | length             | Add `length` to the turtle move distance
//   "repeat"     | count, commands    | Repeats a list of commands `count` times.
//   "arcleft"    | radius, [angle]    | Draw an arc from the current position toward the left at the specified radius and angle.  The turtle turns by `angle`.  A negative angle draws the arc to the right instead of the left, and leaves the turtle facing right.  A negative radius draws the arc to the right but leaves the turtle facing left.  
//   "arcright"   | radius, [angle]    | Draw an arc from the current position toward the right at the specified radius and angle
//   "arcleftto"  | radius, angle      | Draw an arc at the given radius turning toward the left until reaching the specified absolute angle.  
//   "arcrightto" | radius, angle      | Draw an arc at the given radius turning toward the right until reaching the specified absolute angle.  
//   "arcsteps"   | count              | Specifies the number of segments to use for drawing arcs.  If you set it to zero then the standard `$fn`, `$fa` and `$fs` variables define the number of segments.  
//
// Arguments:
//   commands = List of turtle commands
//   state = Starting turtle state (from previous call) or starting point.  Default: start at the origin, pointing right.
//   ---
//   full_state = If true return the full turtle state for continuing the path in subsequent turtle calls.  Default: false
//   repeat = Number of times to repeat the command list.  Default: 1
//
// Example(2D): Simple rectangle
//   path = turtle(["xmove",3, "ymove", "xmove",-3, "ymove",-1]);
//   stroke(path,width=.1);
// Example(2D): Pentagon
//   path=turtle(["angle",360/5,"move","turn","move","turn","move","turn","move"]);
//   stroke(path,width=.1,closed=true);
// Example(2D): Pentagon using the repeat argument
//   path=turtle(["move","turn",360/5],repeat=5);
//   stroke(path,width=.1,closed=true);
// Example(2D): Pentagon using the repeat turtle command, setting the turn angle
//   path=turtle(["angle",360/5,"repeat",5,["move","turn"]]);
//   stroke(path,width=.1,closed=true);
// Example(2D): Pentagram
//   path = turtle(["move","left",144], repeat=4);
//   stroke(path,width=.05,closed=true);
// Example(2D): Sawtooth path
//   path = turtle([
//       "turn", 55,
//       "untily", 2,
//       "turn", -55-90,
//       "untily", 0,
//       "turn", 55+90,
//       "untily", 2.5,
//       "turn", -55-90,
//       "untily", 0,
//       "turn", 55+90,
//       "untily", 3,
//       "turn", -55-90,
//       "untily", 0
//   ]);
//   stroke(path, width=.1);
// Example(2D): Simpler way to draw the sawtooth.  The direction of the turtle is preserved when executing "yjump".
//   path = turtle([
//       "turn", 55,
//       "untily", 2,
//       "yjump", 0,
//       "untily", 2.5,
//       "yjump", 0,
//       "untily", 3,
//       "yjump", 0,
//   ]);
//   stroke(path, width=.1);
// Example(2DMed): square spiral
//   path = turtle(["move","left","addlength",1],repeat=50);
//   stroke(path,width=.2);
// Example(2DMed): pentagonal spiral
//   path = turtle(["move","left",360/5,"addlength",1],repeat=50);
//   stroke(path,width=.7);
// Example(2DMed): yet another spiral, without using `repeat`
//   path = turtle(concat(["angle",71],flatten(repeat(["move","left","addlength",1],50))));
//   stroke(path,width=.7);
// Example(2DMed): The previous spiral grows linearly and eventually intersects itself.  This one grows geometrically and does not.
//   path = turtle(["move","left",71,"scale",1.05],repeat=50);
//   stroke(path,width=.15);
// Example(2D): Koch Snowflake
//   function koch_unit(depth) =
//       depth==0 ? ["move"] :
//       concat(
//           koch_unit(depth-1),
//           ["right"],
//           koch_unit(depth-1),
//           ["left","left"],
//           koch_unit(depth-1),
//           ["right"],
//           koch_unit(depth-1)
//       );
//   koch=concat(["angle",60,"repeat",3],[concat(koch_unit(3),["left","left"])]);
//   polygon(turtle(koch));
module turtle(commands, state=[[[0,0]],[1,0],90,0], full_state=false, repeat=1) {no_module();}
function turtle(commands, state=[[[0,0]],[1,0],90,0], full_state=false, repeat=1) =
    let( state = is_vector(state) ? [[state],[1,0],90,0] : state )
        repeat == 1?
            _turtle(commands,state,full_state) :
            _turtle_repeat(commands, state, full_state, repeat);

function _turtle_repeat(commands, state, full_state, repeat) =
    repeat==1?
        _turtle(commands,state,full_state) :
        _turtle_repeat(commands, _turtle(commands, state, true), full_state, repeat-1);

function _turtle_command_len(commands, index) =
    let( one_or_two_arg = ["arcleft","arcright", "arcleftto", "arcrightto"] )
    commands[index] == "repeat"? 3 :   // Repeat command requires 2 args
    // For these, the first arg is required, second arg is present if it is not a string
    in_list(commands[index], one_or_two_arg) && len(commands)>index+2 && !is_string(commands[index+2]) ? 3 :  
    is_string(commands[index+1])? 1 :  // If 2nd item is a string it's must be a new command
    2;                                 // Otherwise we have command and arg

function _turtle(commands, state, full_state, index=0) =
    index < len(commands) ?
    _turtle(commands,
            _turtle_command(commands[index],commands[index+1],commands[index+2],state,index),
            full_state,
            index+_turtle_command_len(commands,index)
        ) :
        ( full_state ? state : state[0] );

// Turtle state: state = [path, step_vector, default angle, default arcsteps]

function _turtle_command(command, parm, parm2, state, index) =
    command == "repeat"?
        assert(is_num(parm),str("\"repeat\" command requires a numeric repeat count at index ",index))
        assert(is_list(parm2),str("\"repeat\" command requires a command list parameter at index ",index))
        _turtle_repeat(parm2, state, true, parm) :
    let(
        path = 0,
        step=1,
        angle=2,
        arcsteps=3,
        parm = !is_string(parm) ? parm : undef,
        parm2 = !is_string(parm2) ? parm2 : undef,
        needvec = ["jump", "xymove"],
        neednum = ["untilx","untily","xjump","yjump","angle","length","scale","addlength"],
        needeither = ["setdir"],
        chvec = !in_list(command,needvec) || is_vector(parm,2),
        chnum = !in_list(command,neednum) || is_num(parm),
        vec_or_num = !in_list(command,needeither) || (is_num(parm) || is_vector(parm,2)),
        lastpt = last(state[path])
    )
    assert(chvec,str("\"",command,"\" requires a vector parameter at index ",index))
    assert(chnum,str("\"",command,"\" requires a numeric parameter at index ",index))
    assert(vec_or_num,str("\"",command,"\" requires a vector or numeric parameter at index ",index))

    command=="move" ? list_set(state, path, concat(state[path],[default(parm,1)*state[step]+lastpt])) :
    command=="untilx" ? (
        let(
            int = line_intersection([lastpt,lastpt+state[step]], [[parm,0],[parm,1]]),
            xgood = sign(state[step].x) == sign(int.x-lastpt.x)
        )
        assert(xgood,str("\"untilx\" never reaches desired goal at index ",index))
        list_set(state,path,concat(state[path],[int]))
    ) :
    command=="untily" ? (
        let(
            int = line_intersection([lastpt,lastpt+state[step]], [[0,parm],[1,parm]]),
            ygood = is_def(int) && sign(state[step].y) == sign(int.y-lastpt.y)
        )
        assert(ygood,str("\"untily\" never reaches desired goal at index ",index))
        list_set(state,path,concat(state[path],[int]))
    ) :
    command=="xmove" ? list_set(state, path, concat(state[path],[default(parm,1)*norm(state[step])*[1,0]+lastpt])):
    command=="ymove" ? list_set(state, path, concat(state[path],[default(parm,1)*norm(state[step])*[0,1]+lastpt])):
        command=="xymove" ? list_set(state, path, concat(state[path], [lastpt+parm])):
    command=="jump" ?  list_set(state, path, concat(state[path],[parm])):
    command=="xjump" ? list_set(state, path, concat(state[path],[[parm,lastpt.y]])):
    command=="yjump" ? list_set(state, path, concat(state[path],[[lastpt.x,parm]])):
    command=="turn" || command=="left" ? list_set(state, step, rot(default(parm,state[angle]),p=state[step],planar=true)) :
    command=="right" ? list_set(state, step, rot(-default(parm,state[angle]),p=state[step],planar=true)) :
    command=="angle" ? list_set(state, angle, parm) :
    command=="setdir" ? (
        is_vector(parm) ?
            list_set(state, step, norm(state[step]) * unit(parm)) :
            list_set(state, step, norm(state[step]) * [cos(parm),sin(parm)])
    ) :
    command=="length" ? list_set(state, step, parm*unit(state[step])) :
    command=="scale" ?  list_set(state, step, parm*state[step]) :
    command=="addlength" ?  list_set(state, step, state[step]+unit(state[step])*parm) :
    command=="arcsteps" ? list_set(state, arcsteps, parm) :
    command=="arcleft" || command=="arcright" ?
        assert(is_num(parm),str("\"",command,"\" command requires a numeric radius value at index ",index))  
        let(
            myangle = default(parm2,state[angle]),
            lrsign = command=="arcleft" ? 1 : -1,
            radius = parm*sign(myangle),
            center = lastpt + lrsign*radius*line_normal([0,0],state[step]),
            steps = state[arcsteps]==0 ? segs(abs(radius)) : state[arcsteps], 
            arcpath = myangle == 0 || radius == 0 ? [] : arc(
                steps,
                points = [
                    lastpt,
                    rot(cp=center, p=lastpt, a=sign(parm)*lrsign*myangle/2),
                    rot(cp=center, p=lastpt, a=sign(parm)*lrsign*myangle)
                ]
            )
        )
        list_set(
            state, [path,step], [
                concat(state[path], list_tail(arcpath)),
                rot(lrsign * myangle,p=state[step],planar=true)
            ]
        ) :
    command=="arcleftto" || command=="arcrightto" ?
        assert(is_num(parm),str("\"",command,"\" command requires a numeric radius value at index ",index))
        assert(is_num(parm2),str("\"",command,"\" command requires a numeric angle value at index ",index))
        let(
            radius = parm,
            lrsign = command=="arcleftto" ? 1 : -1,
            center = lastpt + lrsign*radius*line_normal([0,0],state[step]),
            steps = state[arcsteps]==0 ? segs(abs(radius)) : state[arcsteps],
            start_angle = posmod(atan2(state[step].y, state[step].x),360),
            end_angle = posmod(parm2,360),
            delta_angle =  -start_angle + (lrsign * end_angle < lrsign*start_angle ? end_angle+lrsign*360 : end_angle),
            arcpath = delta_angle == 0 || radius==0 ? [] : arc(
                steps,
                points = [
                    lastpt,
                    rot(cp=center, p=lastpt, a=sign(radius)*delta_angle/2),
                    rot(cp=center, p=lastpt, a=sign(radius)*delta_angle)
                ]
            )
        )
        list_set(
            state, [path,step], [
                concat(state[path], list_tail(arcpath)),
                rot(delta_angle,p=state[step],planar=true)
            ]
        ) :
    assert(false,str("Unknown turtle command \"",command,"\" at index",index))
    [];


// Section: Debugging polygons

// Module: debug_polygon()
// Usage:
//   debug_polygon(points, paths, [vertices=], [edges=], [convexity=], [size=]);
// Description:
//   A drop-in replacement for `polygon()` that renders and labels the path points and
//   edges.  The start of each path is marked with a blue circle and the end with a pink diamond.
//   You can suppress the display of vertex or edge labeling using the `vertices` and `edges` arguments.
// Arguments:
//   points = The array of 2D polygon vertices.
//   paths = The path connections between the vertices.
//   ---
//   vertices = if true display vertex labels and start/end markers.  Default: true
//   edges = if true display edge labels.  Default: true
//   convexity = The max number of walls a ray can pass through the given polygon paths.
//   size = The base size of the line and labels.
// Example(Big2D):
//   debug_polygon(
//       points=concat(
//           regular_ngon(or=10, n=8),
//           regular_ngon(or=8, n=8)
//       ),
//       paths=[
//           [for (i=[0:7]) i],
//           [for (i=[15:-1:8]) i]
//       ]
//   );
module debug_polygon(points, paths, vertices=true, edges=true, convexity=2, size=1)
{
    paths = is_undef(paths)? [count(points)] :
        is_num(paths[0])? [paths] :
        paths;
    echo(points=points);
    echo(paths=paths);
    linear_extrude(height=0.01, convexity=convexity, center=true) {
        polygon(points=points, paths=paths, convexity=convexity);
    }
    dups = vector_search(points, EPSILON, points);
    
    if (vertices) color("red") {
        for (ind=dups){
            numstr = str_join([for(i=ind) str(i)],",");
            up(0.2) {
                translate(points[ind[0]]) {
                    linear_extrude(height=0.1, convexity=10, center=true) {
                        text(text=numstr, size=size, halign="center", valign="center");
                    }
                }
            }
        }
    }
    if (edges)
    for (j = [0:1:len(paths)-1]) {
        path = paths[j];
        if (vertices){
            translate(points[path[0]]) {
                color("cyan") up(0.1) cylinder(d=size*1.5, h=0.01, center=false, $fn=12);
            }
            translate(points[path[len(path)-1]]) {
                color("pink") up(0.11) cylinder(d=size*1.5, h=0.01, center=false, $fn=4);
            }
        }
        for (i = [0:1:len(path)-1]) {
            midpt = (points[path[i]] + points[path[(i+1)%len(path)]])/2;
            color("blue") {
                up(0.2) {
                    translate(midpt) {
                        linear_extrude(height=0.1, convexity=10, center=true) {
                            text(text=str(chr(65+j),i), size=size/2, halign="center", valign="center");
                        }
                    }
                }
            }
        }
    }
}


// vim: expandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap