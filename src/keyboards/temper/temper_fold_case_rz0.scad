use <../../lib/rect.scad>;
use <twist_lock.scad>;
use <../../common/bolt_slot.scad>;
use <../../lib/holes.scad>;
use <side_switch_cover.scad>;

LEFT = true;
//LEFT = false;
VERT_BATTERY = false; // Battery on the side

if ($preview) {
*linear_extrude(height=10) import("../assets/temper-bottomplate.svg");
*linear_extrude(height=10) import("../assets/temper-bottom-contour-orig.svg");
}

PLATE_TH = 1.5 - 0.5 + 0.3;
SCREW_STUB_H0 = PLATE_TH + 2.1 + 0.3 /* switch socket, soldering tips + magsafe */;
SCREW_R_INNER_OFF = -0.6;
SCREW_R_OUTER_OFF = 0.5;
SCREW_R_OUTER_OFF_2 = 1.5;
NUT_TH = 1.64;
NUT_DR = 0.7;
NUT_R = 2.40;
NUT_WALL_TH = 0.75;
NUT_DZ = 0.2;

// Now used to desribe battery
BATTERY_XYZ = [-19.5, 6.2, 1]; 
BATTERY_WHD = [36.6, 12 + 20, 5];
BATTERY_RZ = -8;

// Room for MCU
MCU_XY = [0, 0]; // Relative to top right
MCU_W0 = 20;
MCU_D0 = 35.5;
MCU_TH = SCREW_STUB_H0 - 4/*depth of battery*/;
MCU_PIN_HOLLOW_XYWH = [[96.5, 65, 1.5, 31], [112.5, 65, 1.5, 31]];

PLATE_TOP = 84;
PLATE_RIGHT = 115;

RUBBER_R = 6.6 / 2;
RUBBER_CAVE_TH = 1.4;

MAG_BUTTON_TH = 2;
MAG_BUTTON_COVER_TH = 0.4;
MAG_BUTTON_R = 6.1 / 2;
MAG_CONN_BUTTON_XY = [
    [0, 23], [12, 96], [118.8, 79], [107.75, 6]
];
MAG_BOTTOM_BUTTON_XY = [
    [6, 44], [11, 77], [37, 91], [86, 83], 
    [118.5, 69.5], [108.5, 23.5], [75, 13], [30, 20],
    [87, 43], [38, 50], [58, 32], [61, 60]
];
MAG_TOP_BUTTON_XY = [ // before rotation
    /*[-5, 21.5], [-5.5, 28.5], [-5, 91.5], */[5, 92], 
    /*[106.75, 20.5], [107.5, 27.5], [107, 91.5], */[114.5, 92], 
];
THREADED_LEG_NUT_XY = [ // before rotation, cherry pick from above
    [113.5, 12], [113.5, 93.5], 
];
// shorter side stubs
SHORT_STUB_BASE_XY = [ // before rotation, cherry pick from above
    [5, 12 + 8], [5, 93.5 - 8], 
];
SHORT_STUB_COVER_XY = [ // before rotation, cherry pick from above
    [5, 12 + 8], [5, 93.5 - 8 - 1], 
];
MAG_BUTTON_COVER_W = 10;
MAG_BUTTON_COVER_D = 20;
MAG_BUTTON_AREA_CORNER_R = 3;

RUBBER_XY = [
    [5, 9.5], [5, 94.5], 
    [104.5, 94.5], [114, 85], [114, 21], [104.5, 11],
];

POST_W = 2.5;
POST_CR = 0.75;
POST_XY = [
    [101, 7], [112, 46], [95, 46], [92, 81.5], /*[73, 84]*/, [55, 90.5], [42, 90.5],
    [24, 84.5], [5.5, 73], [5.5, 53], [5.5, 34], [20, 26], [43, 36],
    [53, 17], [86, 14]
];

MINI_CONTAINER_POZ_RZ_WDH = [
    [15, 86.23, 2, 0, 8, 16, 15]
//,   [25, 93.5, 2, 0, 24, 8, 15]
];

WALL_CUTOUT = concat([
    // on/off switch
    [113, 33.75 + 1.3, PLATE_TH + 0.4, 7, 8, 2.4 + 0.8 + 0.3], 
    [113 + 3.25 - 1, 33.75 + 1.3 - 5.5, PLATE_TH, 2, 20, 6 + 0.3], 

    [27.35, 34, SCREW_STUB_H0 - 2.2, 6, 4, 18],
    [10, 22, SCREW_STUB_H0 - 2.2, 6, 4, 18],
    // Type C port
//    [98, 81, SCREW_STUB_H0 + 4.2 + 2.2, 13, 9, 4 - 1.6],
    [98, 83.5, SCREW_STUB_H0 + 3 + 1.7, 13, 14, 7 + 0.4],
    // Battery wire clearance
    [99, 84, PLATE_TH, 8.75, 2, 4.4],
    [107, 84, RUBBER_CAVE_TH + 1, 4, 2, 3.25], // tunnel under
    // Clean up leg slot near hinge
    /*
    [34, 15, RUBBER_CAVE_TH + 3.5, 18, 6, 8],
    [50.35, 12, RUBBER_CAVE_TH + 1.5, 8, 5, 8],
    [54, 13, RUBBER_CAVE_TH + 2.5, 8, 6, 8],
    */
],
// Only the left version needs the following three cut-outs
LEFT ? [
    [2, 28.2, SCREW_STUB_H0 - 2.2, 4, 2.2, 18],
    [2, 45.2, SCREW_STUB_H0 - 2.2, 4, 2.2, 18],
    [2, 62.2, SCREW_STUB_H0 - 2.2, 4, 2.2, 18],
] : [
// Only the right version needs the following
    [19, 28.2, SCREW_STUB_H0 - 2.2, 4, 2.2, 18]
]);

MAG_CENTER_OFFSET = [54, 45, 0.4];
MAG_SAFE_OUTER_R = 56 / 2;
MAG_SAFE_INNER_R = 43 / 2;
MAG_SAFE_TH = PLATE_TH - 0.4 + 0.02; // Thickness of metal ring
MAG_RING_OFF_R = 0;

// Extract xy of screws
//import("../assets/temper-bottom-stubs.svg");
SCREW_XY = [
    [60.7, 72.9],
    [213.7, 81.6],
    [142.8, 178.8],
    [264.8, 196.4],
    [60.7, 121.2],
    [277.45, 157.6],
    [317.8, 184.4],
];

// Base rect contour
CASE_W = 126 - 6 + 2 - 4;
CASE_D = 94 - 8 + 4 + 2 + 4;
CASE_RZ = 0;
CASE_CORNER_R = 6;

// Cover
COVER_TH = 7.35 - 0.35 + 0.25;
COVER_WALL_TH = 2;
COVER_PLATE_TH = 2;
COVER_CONN_DH = 2;
COVER_RUBBER_DX = 2;
COVER_RUBBER_DY = 2;

// Wall
H_ABOVE_PCB_BOTTOM = 13.8 - 1;
PCB_TH = 1.68;
H_HALVES_CONTACT = 16; // Mininum height that two halves can connect
// Thumb clearance
KEYCAP_BOTTOM_H = 10 + 0.3;
THUMB_CLUSTER_W = 98;
THUMB_CLUSTER_CR = 4;
THUMB_TOUCH_UP_W = 20;
// Side clearance
SIDE_CUT_W = 50;

// Rise
FINGER_TIP_SIDE_RISE_W = 72;

// Twist lock
TL_RIDGE_DZ = 0;
TL_RIDGE_H = 1;
TL_RIDGE_R = 1.08;
TL_R = 6.3 / 2;
//TL_DTH = -0.5;
TL_TENT_XY /* before rotation */ = [ [86, 101.5], [86, 20.5] ];
TL_DEPTH = 2 * TL_RIDGE_R + 2.2 + 0.6;
TL_H0 = 32 + 19;

// Twist lock
TENT_LEG_H0 = 28 + 19 - 1.5;
TENT_END_R0 = 4;
TENT_LEG_RUBBER_FEET_D0 = 6.5;
CASE_W1 = 98; // From twist cener to little finger edge

tent_leg_dh = TENT_END_R0 * TENT_LEG_H0 / CASE_W1;
// Fingertip curve
FINGER_TIP_XYZ = [ // relative to rect, before rotation
    [58, -10.75, -1], [58, 114.1, -1]
];
FINGER_TIP_R = 16;

// Hinge connecting two halves
HINGE_R = 1.5 / 2; // Radius of shaft going through
HINGE_H = 18;
HINGE_R_PADDING = 1;
HINGE_OFFSETS = [
    [18, 16.2 - 10.7, KEYCAP_BOTTOM_H - HINGE_R - HINGE_R_PADDING + 0.35],
    [98, 16.2 - 10.7, KEYCAP_BOTTOM_H - HINGE_R - HINGE_R_PADDING + 0.35],
];

// Bolted leg storage pose
BOLTED_LEG_POSES = [
    // x, y, z, rx, ry, rz, hull_dist, shaft_h, bidirectional, bump shaft shift, index, hull_shift, sock_h, lever_dr
    [29, 10.5, 4, 0, 0, -3, 10, 49, true, 10, 1, -3, 15, 1.2],
//    [7, 9.5, 9, 0, 0, 36, 10, 49, false, 10, 0, 0, 15, 1.2],
    [51, 37 - 0.18, 9.5, 0, 0, 29 + 180, 10, 49, false, 10, 0, 0, 15, 1.2],
    [60 + 50, 91.5, 4.5, 0, -4.5, 180, 10, 46, false, 15, 0, 0, 15, 1.2],
    // Extensions
    [50, 27.8, 10, 0, 0, 29 + 180, 10, 17, false, 0, 0, 0, 0, 0],
    [11.5, 8, 8.5, 0, 0, 29, 10, 17, false, 0, 0, 0, 0, 0],
    [17.5, 92, 4.2, 0, 0, 0, 10, 16, false, 0, 1, 0, 0, 0],
];

// Hex stub for tenting
HEX_STUB_XY_H_RZ_RX_DZ = [
    // first two, 30 mm, the longer ones
//    [50, 22.7, 30, -CASE_RZ, 0, 0], //[50, 30.6, 30, -CASE_RZ, 0, 0],
    // Make bumps for the one closer to the center
//    [53.5, 30.6, 30, -CASE_RZ, 0, 0],

    // 1 out of the other two shorter ones
//    [76, 18.875, 28.5, 2, 0, -2.5], [76, 18.875, 27.5, 2, 0, -.5],
    // 2 of 2 shorter ones
//    [73, 70.25, 28.5, 27 - CASE_RZ, 0, 0],

    // Extra if no battery on the side
//    [-44, -101, 28.5/*len*/, 180, 0, 2/*dz*/],

// Take 2: the one clip deeper close to hinge
    [60, 10, 28.5, 0, 0, -3.5, 0.5/*extra skew xz if not zero*/], 
    [110, 91.75, 28.5, 0, 0, -3.5/*z*/, 0], 

    [71.25, 25, 30, -CASE_RZ - 2, 0, 2, 0], 
    [74, 31, 30, -CASE_RZ, 0, 2, 0]
];
HEX_STUB_R = (3 + 1) * 2 / sqrt(3); // See defaults in hex_tent_stub.scad
HEX_STUB_THUMB_SINK_POS = [21.5, 16, PCB_TH + SCREW_STUB_H0];
HEX_STUB_THUMB_SINK_POLYGON = [
    [0, 3], [0, 21], [17.5, 21], /*[17.5, 25], [36, 25], */[17.5, 27],
    [37, 27], [37, 19],
    [31, 14.75], [31, 1.25], [47, 0], [25, 2], [10, 3]
    //[51, -1], [63, -4], [62, -11.75], [0, -2]
];
HEX_STUB_THUMB_SINK_BOLT_POS = [[28, 23, PLATE_TH], [50.4, 33.25, PLATE_TH + 1]];

// Latch, snap fit (not used)
LT_D1 = 2.5;
LT_H1 = 4;
LT_D2 = 8;
LT_W = 20;
LT_TIP_H = 8;
LT_OFFSETS = [[10, 113.7, 0], [66, 113.7, 0]];

LT_CONN_H = 8;

module off_xyz_case_wall() {
    translate([0, -2.5, 0]) children();
}

module rect_contour() {
    rotate([0, 0, CASE_RZ]) translate([0, -1, 0]) 
        rect_r(CASE_W, CASE_D, CASE_CORNER_R);
}
module cover_wall_contur() {
hinge_offset = HINGE_R + HINGE_R_PADDING;
    rotate([0, 0, CASE_RZ]) translate([0, -1 + hinge_offset, 0]) 
        offset(r=-COVER_WALL_TH)
            rect_r(CASE_W, CASE_D - hinge_offset * 2, CASE_CORNER_R);
}

module battery180mah() {
    rotate([0, 0, BATTERY_RZ]) mirror([1, 0, 0])
        rotate([90, 0, 0]) union() {
            cube(BATTERY_WHD);
            // tunnel for wire
            translate([-2, -0.5, 1.5]) cube([4, BATTERY_WHD.y + 2, 2]);
            translate([-2, 0, 1.5]) cube([2, BATTERY_WHD.y + 2, 4.9]);
        }
}

// Curved cuts
module clearance(w=50, h=8, th=10, cr=4, top_h_coef=2) {
    rotate([90, 0, 0]) difference() {
        translate([0, cr, 0]) linear_extrude(height=th)
            offset(-cr) offset(cr * 2)
                union() {
                    translate([0, -h / 2, 0])
                        square([w - 2 * cr, h], center=true);
                    translate([0, top_h_coef * h / 2, 0])
                        square([w + 4 * cr, top_h_coef * h], center=true);
                }
        // Remove unwanted height caused by offset
        translate([-(w + 10 * cr) / 2, top_h_coef * h, -1])
            cube([w + 10 * cr, cr * 2 + top_h_coef * h, th + 2]);
    }
}

module grabber(base_off=0, shaft_off=0, height_off=0, only_base=false, base_ext=0) {
union() {
        if (!only_base) {
            cylinder(
                r=HINGE_R + HINGE_R_PADDING - shaft_off,
                h=HINGE_H - height_off,
                center=true
            );
        }
        translate([-HINGE_R - HINGE_R_PADDING - base_ext / 2, 0, 0]) cube([
            2 * (HINGE_R + HINGE_R_PADDING) + base_ext, 
            2 * (HINGE_R + HINGE_R_PADDING) - 2 * base_off, 
            HINGE_H - height_off,
        ], center=true);
    }
}

module cover_base() {
difference() {
    union() {
        translate([2.5, 88.5, 0]) translate([57, -36, 0]) difference() {
            linear_extrude(height=COVER_TH) {
                    rect_contour();
            }
            translate([0, 0, COVER_PLATE_TH])
            linear_extrude(height=COVER_TH)
                offset(r=MAG_BUTTON_AREA_CORNER_R)
                offset(r=-MAG_BUTTON_AREA_CORNER_R) difference() {
                    cover_wall_contur();
                    // Make room for magsafe button
                    for(i = [-.5, .5], j = [-.5, .5]) {
                        rotate([0, 0, CASE_RZ])
                        translate([
                                i * CASE_W - i * MAG_BUTTON_COVER_W,
                                j * CASE_D - j * MAG_BUTTON_COVER_D,
                                0
                        ]) rect_r(MAG_BUTTON_COVER_W, MAG_BUTTON_COVER_D, 
                                  MAG_BUTTON_AREA_CORNER_R);
                    }
                }
        }
    }
        // Rise on the finger tip side
        rotate([0, 0, CASE_RZ]) translate([51 + 8.2, 106.16 - 6.6 + 0.9, COVER_TH])
            clearance(
                w=FINGER_TIP_SIDE_RISE_W + 0.04,
                h=SCREW_STUB_H0 + H_ABOVE_PCB_BOTTOM - KEYCAP_BOTTOM_H + 0.04,
                th=4 + 1, cr=THUMB_CLUSTER_CR, top_h_coef=1
            );
}
}

module wall() {
//mirror([LEFT ? 0 : 1, 0, 0])
difference() {
    union() {
        translate([2.5, 88.5, 0])
            linear_extrude(height=KEYCAP_BOTTOM_H) difference() {
                off_xyz_case_wall() union() {
                    translate([57, -36, 0]) rect_contour();
                    difference() {
                        import("../assets/temper_bottom_outline_projection.svg");
                        translate([85, -91.5 + 4.75 - 1, 0]) square([20, 5]);
                    }
                }
                difference() {
                    offset(r=0.6)
                        import("../assets/temper_bottom_outline_projection.svg");
                    translate([85, -91.5 + 4.75, 0]) square([20, 5]);
                }
            }
*        intersection() {
        off_xyz_case_wall() translate([2.5, 88.5, 0])
            linear_extrude(height=SCREW_STUB_H0 + H_ABOVE_PCB_BOTTOM + 1) 
                    translate([57, -36, 0]) rect_contour();
            // Rise on the finger tip side
            union() {
                rise_wall_th = 1.5;
                rotate([0, 0, CASE_RZ]) off_xyz_case_wall() {
                    translate([51 + 8.2, 106.16 - 6.6, KEYCAP_BOTTOM_H])
                    mirror([0, 0, 1]) clearance(
                        w=FINGER_TIP_SIDE_RISE_W,
                        h=SCREW_STUB_H0 + H_ABOVE_PCB_BOTTOM - KEYCAP_BOTTOM_H,
                        th=rise_wall_th, cr=THUMB_CLUSTER_CR, top_h_coef=0.1
                    );
                    translate(
                        [FINGER_TIP_XYZ[1].x, FINGER_TIP_XYZ[1].y, KEYCAP_BOTTOM_H]
                    ) cylinder(
                        r=FINGER_TIP_R + rise_wall_th, 
                        h=SCREW_STUB_H0 + H_ABOVE_PCB_BOTTOM - KEYCAP_BOTTOM_H
                    );
                }
            }
        }
    }
    // Cut-outs
    for (xyzwdh = WALL_CUTOUT) {
        translate([xyzwdh[0], xyzwdh[1], xyzwdh[2]])
            cube([xyzwdh[3], xyzwdh[4], xyzwdh[5]]);
    }
    // Mini Containers
    for (pos_rz_wdh = MINI_CONTAINER_POZ_RZ_WDH) {
        translate([pos_rz_wdh[0], pos_rz_wdh[1], pos_rz_wdh[2]])
            rotate([0, 0, pos_rz_wdh[3]]) linear_extrude(height=pos_rz_wdh[6])
                rect_r(pos_rz_wdh[4], pos_rz_wdh[5], 2);
    }
}
}

// Contacting mag button
module button_holder() {
    difference() {
        translate([0, 0, SCREW_STUB_H0 + H_ABOVE_PCB_BOTTOM - 0.01]) 
            cylinder(r=MAG_BUTTON_R + 1.5, h=H_HALVES_CONTACT - H_ABOVE_PCB_BOTTOM - SCREW_STUB_H0);
        translate([0, 0, H_HALVES_CONTACT - MAG_BUTTON_TH])
            cylinder(r=MAG_BUTTON_R, h=MAG_BUTTON_TH);
    }
}

// Sinking area next to thumb, under index-midel-ring fingers
module hex_sink_block(h=12, r=2, off_r=0) {
    linear_extrude(height=h) offset(r=r) offset(r=-r + off_r)
        polygon(HEX_STUB_THUMB_SINK_POLYGON);
}

function skew_leg_end_clearance(factor=0)
     = [  [ 1  , 0  , 0  , 0   ],
          [ 0  , 1  , 0, 0   ],
          [ factor  , 0  , 1  , 0   ],
          [ 0  , 0  , 0  , 1   ] ] ;
    

module tent_leg_diff(travel_x=12) {
    for(c = HEX_STUB_XY_H_RZ_RX_DZ) rotate([0, 0, CASE_RZ])
        rotate([0, 0, c[3]]) translate([c.x, c.y, SCREW_STUB_H0 + PCB_TH + HEX_STUB_R + c[5]])
            rotate([c[4], 0, 0]) rotate([0, 90, 0]) union() {
                mirror([0, 0, 1]) {
                    difference() {
                        pin_slot(ridge_dz=TL_RIDGE_DZ, ridge_r=TL_RIDGE_R + 0.08, ridge_h=TL_RIDGE_H + 0.15, r=TL_R + 0.1, refined=false, h=TL_H0, travel_x=travel_x);
                        for(i = [1, -1], j=[0.25, 0.5, 0.75]) rotate([0, 0, 90 + i * 12]) // bumps to hold leg
                            translate([(TL_R + 0.3)* i, 0, TL_H0 * j + 2])
                                cylinder(h=3, r=0.4, center=true);
                    }
                    for(skew_xz = (c[6] == 0 ? [0]: [0, c[6]]))
                    translate([0, 0, -TENT_END_R0 * skew_xz])
                        multmatrix(skew_leg_end_clearance(skew_xz)) hull() {
                            cylinder(r=TENT_END_R0 + 0.2, h=tent_leg_dh * 4 + 0.4);
                            translate([-travel_x, 0, 0])
                                cylinder(r=TENT_END_R0 + 0.2, h=tent_leg_dh * 4 + 0.4);
                        }
                }
            }
}

module bolted_tent_leg_diff() {
    for(c = BOLTED_LEG_POSES) {
        translate([c.x, c.y, c.z]) rotate([c[3], c[4], c[5]])
            mirror([1, 0, 0]) rotate([0, -90, 0])
                bolt_leg_storage(
                    hull_dist=c[6], shaft_h=c[7], bidirectional=c[8], lever_w=9,
                    bump_shaft_shift=c[9], bump_index=c[10], bump_hull_shift=c[11], 
                    sock_h=c[12], lever_dr=c[13]
                );
    }
}

module place_mcu_cover() {
    translate([CASE_W - 3, CASE_D - 12, SCREW_STUB_H0 + PCB_TH]) children();
}

module place_mcu_bumps() {
    translate([12.6, 32.9, HEX_STUB_THUMB_SINK_POS.z]) children();
}

module mcu_cover_base() {
    polygon([[0, 0], [-21, 0], [-21, -45], [0, -57]]);
}

mirror([LEFT ? 0 : 1, 0, 0]) rotate([0, 0, -CASE_RZ]) {
if($preview)
    translate([115.5, 46.25, 1.2]) rotate([0, 0, -90]) switch_cover();
//intersection() {
//#    rotate([0, 0, CASE_RZ]) translate([-15, 2, 0]) cube([80, 25, 20]);

difference() {
    union() {
        wall();
        // Fill PCB plate contour
        translate([-73.5, 137.5, 0])
            linear_extrude(height=PLATE_TH)
            offset(r=-1.8) projection() import("../assets/chocofi_bottom.stl");
        // Screw housing
        translate([0, 96.35, 0]) mirror([0, 1, 0]) for(xy = SCREW_XY)
            translate([xy.x / 2.8345, xy.y / 2.8345, SCREW_STUB_H0]) rotate([0, 0, -15])
                mirror([0, 0, 1])
                linear_extrude(height=SCREW_STUB_H0, scale=1.25) circle(r=NUT_R + NUT_WALL_TH, $fn=6);
        // Supporting posts
        for (post_xy = POST_XY)
            translate([post_xy.x, post_xy.y, 0]) 
                linear_extrude(height=SCREW_STUB_H0) rect_r(POST_W, POST_W, POST_CR);
        // Rubber housing
        off_xyz_case_wall() for (rb_offset = RUBBER_XY)
            rotate([0, 0, CASE_RZ]) translate([rb_offset.x, rb_offset.y, 0])
                cylinder(h=RUBBER_CAVE_TH + 1, r=RUBBER_R + 1);
        // Contacting holder for mag button
*        for(xy = MAG_CONN_BUTTON_XY) {
            translate([xy.x, xy.y, 0]) button_holder();
        }
        // Mag button on bottom
*        for (mag_bottom_xy = MAG_BOTTOM_BUTTON_XY)
            translate([mag_bottom_xy.x, mag_bottom_xy.y, 0])
                cylinder(h=MAG_BUTTON_TH + 1, r=MAG_BUTTON_R + 1);
    }
    // Screw
#    translate([0, 0, 0.2]) linear_extrude(height=SCREW_STUB_H0 + 1) 
        offset(r=SCREW_R_INNER_OFF) import("../assets/temper-bottom-stubs.svg");
    for(bolt_pos = HEX_STUB_THUMB_SINK_BOLT_POS)
        translate(bolt_pos) cylinder(h=15, r=1);
    // Nut not really necessary
*    translate([0, 96.35, 0]) mirror([0, 1, 0]) for(xy = SCREW_XY)
        translate([xy.x / 2.8345, xy.y / 2.8345, -.25]) rotate([0, 0, -15])
            linear_extrude(height=NUT_TH + NUT_DZ + .25) circle(r=NUT_R, $fn=6);
    // Make room for battery
    if(VERT_BATTERY)
        translate([PLATE_RIGHT + BATTERY_XYZ.x, PLATE_TOP + BATTERY_XYZ.y, BATTERY_XYZ.z])
            battery180mah();
    // Rubber feet cave in
    off_xyz_case_wall() for (rb_offset = RUBBER_XY)
        rotate([0, 0, CASE_RZ]) translate([rb_offset.x, rb_offset.y, -1])
            cylinder(h=RUBBER_CAVE_TH + 1, r=RUBBER_R);
    // Mag safe cave in
    translate(MAG_CENTER_OFFSET)
        difference() {
            cylinder(h=MAG_SAFE_TH + 4 + 1, r=MAG_SAFE_OUTER_R + MAG_RING_OFF_R);
            translate([0, 0, -0.5])
            cylinder(h=MAG_SAFE_TH + 1 + 4 + 1, r=MAG_SAFE_INNER_R - MAG_RING_OFF_R);
        }
    // Mag button on top
#    for (mag_top_xy = MAG_TOP_BUTTON_XY) rotate([0, 0, CASE_RZ])
        translate([mag_top_xy.x, mag_top_xy.y, KEYCAP_BOTTOM_H - MAG_BUTTON_TH - MAG_BUTTON_COVER_TH])
            cylinder(h=MAG_BUTTON_TH + 0.01, r=MAG_BUTTON_R);

    // Threaded legs on bottom to form taller side of tent
    for(xy = THREADED_LEG_NUT_XY) {
        rotate([0, 0, CASE_RZ]) off_xyz_case_wall() translate([xy.x, xy.y, TL_DEPTH])
            mirror([0, 0, 1]) rotate([0, 0, 2 * CASE_RZ + 0 + 90])
                mirror([LEFT? 1: 0, 0, 0]) {
                    bolt_leg_with_nut_slot(bolt_top_dz=4);
                }
    }
    // Twist lock on bottom to form shorter side of tent
    for(xy = SHORT_STUB_BASE_XY) {
        rotate([0, 0, CASE_RZ]) off_xyz_case_wall() translate([xy.x, xy.y, TL_DEPTH])
            mirror([0, 0, 1]) rotate([0, 0, 2 * CASE_RZ + 0 + 90])
                mirror([LEFT? 1: 0, 0, 0]) {
                    inv_slot(ridge_dz=TL_RIDGE_DZ, ridge_r=TL_RIDGE_R, ridge_h=TL_RIDGE_H, r=TL_R, ang=75);
                }
    }
    // Finger tip curve
    for(xyz = FINGER_TIP_XYZ) {
        rotate([0, 0, CASE_RZ]) off_xyz_case_wall() translate(xyz) cylinder(r=FINGER_TIP_R, h=20);
    }

    rotate([0, 0, CASE_RZ]) off_xyz_case_wall() {
        // Lower wall near thumb cluster
*        translate([43.30, 20, 10]) rotate([-30, 0, 0]) cube([52, 15, 8]);
*        translate([70.18, 25, 5]) rotate([0, 0, 0]) cube([5, 15, 8]);
        // Room for hinge
        for(dxyz = HINGE_OFFSETS) translate(dxyz + [0, 0, 3]/*clearance*/) rotate([0, -90, 0])
            grabber(base_off=-0.3, shaft_off=0, base_ext=7, only_base=false);
        xyz0 = HINGE_OFFSETS[0];
        translate([(xyz0.x + HINGE_OFFSETS[1].x) / 2, xyz0.y, xyz0.z]) {
            // Shaft
            translate([0, -0.4, -0.2]) // To compensate print errors
                rotate([0, 90, 0]) difference() {
                    cylinder(r=HINGE_R, h=CASE_W + 2, center=true);
                    translate([0, 0, -15]) cylinder(r=HINGE_R + 2, h=30);
                }
            // Teeth between bottom and cover
            hinge_offset = HINGE_R + HINGE_R_PADDING;
            translate([0, -hinge_offset + /*compenate print error*/0.4, -hinge_offset + 0.5 / 2/*2 lines below*/]) rotate([0, -90, 0])
                grabber(height_off=-CASE_W, only_base=true, 
                        base_ext=COVER_TH - hinge_offset * 2 - COVER_CONN_DH + 0.5);
        }
    }
    // Hold tent stubs, when not in use
*    tent_leg_diff(travel_x=3);
    bolted_tent_leg_diff();
    // Cut-out to polish leg holder
    for(pos_rz = [ 
        [30, 17.1, 8.5, 29, 5, 2, 6] 
      , [27.5, 18, 8.5, 29, 5, 2, 6]
    ]) {
        translate([pos_rz[0], pos_rz[1], pos_rz[2]])
            rotate([0, 0, pos_rz[3]]) cube([pos_rz[4], pos_rz[5], pos_rz[6]]);
    }
    
    // Make an sink to fill later
//    rotate([0, 0, CASE_RZ])
    translate(HEX_STUB_THUMB_SINK_POS) hex_sink_block(h=12, r=1);

    // Cave in for bumps (latch) on MCU cover
    place_mcu_bumps()
        for(xy = [[96, 26], [96, 43]])
            rotate([0, 0, xy.z==undef? 0:xy.z]) for(i = [-1, 1]) 
            translate([xy.x, xy.y + i * 4, 0])
                cube([15.2 + 0.4, 4 + 0.4, .65 + 1 + 0.4], center=true);
    // Cut corners
    rotate([0, 0, CASE_RZ]) off_xyz_case_wall() translate([9, -10.7, 0 + 0.3]) {
        translate([-10, 11.5, 6.2])
            rotate([45, 0, 0]) cube([CASE_W + 2, 6, 2]);
        translate([-10, 10, 9.4])
            rotate([-45, 0, 0]) cube([CASE_W + 2, 6, 2]);

        translate([-10, 11.5, -2])
            rotate([45, 0, 0]) cube([CASE_W + 2, 6, 2]);
        translate([-10, 14.1615 +/*compenate print error*/ 0.4, -2])
            rotate([90, 0, 0]) cube([CASE_W + 2, 6, 2]);
    }

}
//}// test bottom / base plate by intersection


/* ==================== Leg storage sink block fill ==================== */
*translate([0, 0, 0]) union() {
    difference() {
        union() {
            translate(HEX_STUB_THUMB_SINK_POS) 
                hex_sink_block(h=KEYCAP_BOTTOM_H - SCREW_STUB_H0, r=1, off_r=-0.75);
            translate([-18.5, -17, HEX_STUB_THUMB_SINK_POS.z]) linear_extrude(height=2)
                union() {
                    offset(r=0.36) import("../assets/temper-topplate-brd.svg");
                    translate([39, 41.75, 0]) square([22, 12]);
*                    translate([71.5, 33.5, 0]) square([16, 16]);
                }
        }
        // Cut lower corner near thumb
        translate([90, 1.5, HEX_STUB_THUMB_SINK_POS.z - 1]) cube([20, 6, 4]);
        // SCREW under
        translate([0, 0, HEX_STUB_THUMB_SINK_POS.z]) linear_extrude(height=0.8) 
            offset(r=1) import("../assets/temper-bottom-stubs.svg");
        // SCREW
*        for(bolt_pos = HEX_STUB_THUMB_SINK_BOLT_POS)
            translate(bolt_pos) {
                cylinder(h=8.5, r=1);
                translate([0, 0, 4.5]) cylinder(h=6, r=2.25);
            }
        // Switch side latch/nibs
        translate([12.6, 32.9, HEX_STUB_THUMB_SINK_POS.z])
            for(xy = [
                /* c1 */ [0, 0], [0, 17], [0, 34]
              , /* c2 */ [18, 12], [18, 29], [18, 46]
              , /* c3 */ [36, 18], [36, 35], [36, 52]
              , /* c4 */ [54, 11.5], [54, 28.5], [54, 45.5]
              , /* c5 */ [72, 9], [72, 26], [72, 43]
              , /* thumb */ [68.7, 7, -15], [32, -84, 60], [48, -8.6]
              , /* extra */ [88, 9], [88, 26], [88, 43], [52, -84, 60]
            ]) rotate([0, 0, xy.z==undef? 0:xy.z]) for(i = [-1, 1]) 
                translate([xy.x, xy.y + i * 4, 0])
                    cube([15.2, 4, 1 + 1], center=true);
        // Cut-out to polish leg holder
        for(pos_rz = [
        //      [36, 19, 8, -8, 2, 2, 6]
        ]) {
            translate([pos_rz[0], pos_rz[1], pos_rz[2]])
                rotate([0, 0, pos_rz[3]]) cube([pos_rz[4], pos_rz[5], pos_rz[6]]);
        }
        // Hold tent stubs, when not in use
        *tent_leg_diff(travel_x=3);
        bolted_tent_leg_diff();
    }
}

/* ==================== Micro-controller Cover ==================== */
*difference() {
    cover_h = KEYCAP_BOTTOM_H - SCREW_STUB_H0 - PCB_TH + /*pin soldering*/4;
    union() {
        place_mcu_cover() {
            linear_extrude(height=cover_h)
                offset(r=1.1) offset(r=-1) mcu_cover_base();
        }
        // Switch side latch/nibs, copied from above, partially
        intersection() {
            place_mcu_cover()
                linear_extrude(height=cover_h) offset(r=0.65) mcu_cover_base();
            place_mcu_bumps()
                for(xy = [
                   /* extra */ /*[88, 9],*/ [88, 26], [88, 43], [52, -84, 60]
                   , [96, 26], [96, 43]
                ]) rotate([0, 0, xy.z==undef? 0:xy.z]) for(i = [-1, 1]) 
                    translate([xy.x, xy.y + i * 4, 0])
                        cube([15.2, 4, .65 + 1], center=true);
        }
        // Power switch side latch
        place_mcu_cover() translate([-0.2, -33.5, 0]) cube([1, 3, 1.6]);
    }
    place_mcu_cover() translate([0, 0, -1])
        linear_extrude(height=cover_h)
            offset(r=-1) mcu_cover_base();
    // Clearance for powner switch cover
    place_mcu_cover() translate([-1.5, -50.5, -1])
        cube([3, 17, 4]);
    // Clearance for USB-C port
    place_mcu_cover() translate([-15.5, -1.25, -1])
        cube([11, 5, cover_h + 2]);
    // Reset button cover
    place_mcu_cover() translate([-8.75, -45.75, -1])
        cylinder(h=10, r=3);
    // Bolt head
    place_mcu_cover() translate([-2.5, -52.5, -0.01])
        cylinder(h=1.2, r=2.2);
    // Remove thin wall due to bolt clearance
    place_mcu_cover() translate([-1.5, -54.5, -1])
        cube([3, 4.5, 4]);
    // A MCU pattern to make it less boring
    place_mcu_cover() translate([-10.5, -16, cover_h]) union() {
        difference() {
            cube([10, 18, 1], center=true);
            cube([9, 17, 2], center=true);
        }
        for(i = [-1, 1], j = [-3:3]) {
            translate([i * 3.4, j * 2.4, 0]) cube([1.2, 1.2, 1], center=true);
        }
    }
}

echo("Thickness difference of plate and cover:", KEYCAP_BOTTOM_H - COVER_TH); 

/* ==================== Case Cover ==================== */
translate([0, 0, 30])
translate([0, 0, KEYCAP_BOTTOM_H + COVER_TH]) difference() {
    difference() {
        mirror([0, 0, 1]) off_xyz_case_wall() cover_base();
        // Subtract PCB plate contour
        translate([0, 0, -COVER_PLATE_TH]) mirror([0, 0, 1])
            translate([-73.5, 137.5, 0]) // Copied above
                linear_extrude(height=COVER_TH) difference() {
                    offset(r=-1.8) projection()
                        import("../assets/chocofi_bottom.stl");
                    translate([162, -135, 0]) square([20, 5]);
                }
    }
    translate([0, 0, -COVER_TH - 0.01]) rotate([0, 0, CASE_RZ]) off_xyz_case_wall() {
        // Room for hinge
        for(dxyz = HINGE_OFFSETS) translate(dxyz) {
            translate([0, -0.4/*Compensate print error*/, 0]) rotate([0, -90, 0])
                grabber(base_off=-0.3, shaft_off=0, base_ext=8, only_base=false);
        }
        // Teeth between bottom and cover
        hinge_offset = HINGE_R + HINGE_R_PADDING;
        xyz0 = HINGE_OFFSETS[0];
        translate([(xyz0.x + HINGE_OFFSETS[1].x) / 2, xyz0.y, xyz0.z]) {
            translate([0, -hinge_offset, -hinge_offset + 0.38 - COVER_PLATE_TH]) rotate([0, -90, 0])
                grabber(height_off=-CASE_W, only_base=true, base_ext=COVER_TH - hinge_offset * 2 - COVER_CONN_DH);
            translate([0, -0.29, -hinge_offset + 3.625]) rotate([0, -90, 0])
                grabber(height_off=-CASE_W, only_base=true, base_ext=COVER_TH - hinge_offset * 2 - COVER_CONN_DH);
        }
    }
    // Cut corners
    rotate([0, 0, CASE_RZ]) off_xyz_case_wall() translate([9, -10.7, 0]) {
        translate([-10, 13 - sqrt(0.5), -5 - sqrt(0.5)])
            rotate([-45, 0, 0]) cube([CASE_W + 2, 8, 2 + 1]);
        translate([-10, 13, -6])
            rotate([45, 0, 0]) cube([CASE_W + 2, 6, 2]);
    }
    

    translate([0,  0, -(SCREW_STUB_H0 + H_ABOVE_PCB_BOTTOM)]) rotate([0, 0, CASE_RZ]) off_xyz_case_wall() {
        for(dxyz = HINGE_OFFSETS) translate(dxyz) rotate([0, 0, 0])
                // Bolts
                translate([0, -1, 3.5]) rotate([0, 30, 0]) rotate([-90, 0, 0]) m2_bolt_nut();
    }

    // Mag button on top
    for (mag_top_xy = MAG_TOP_BUTTON_XY) rotate([0, 0, CASE_RZ]) 
        translate([mag_top_xy.x, mag_top_xy.y, KEYCAP_BOTTOM_H - SCREW_STUB_H0 - H_ABOVE_PCB_BOTTOM - 1.35 + MAG_BUTTON_COVER_TH])
            cylinder(h=MAG_BUTTON_TH + 0.01 + 0.4/*make room for base*/, r=MAG_BUTTON_R);
    // Twist lock on bottom to form tent
    for(xy = SHORT_STUB_COVER_XY) {
        rotate([0, 0, CASE_RZ]) /*?*/off_xyz_case_wall() translate([xy.x, xy.y, -TL_DEPTH])
            rotate([0, 0, 2 * CASE_RZ + 90]) mirror([LEFT? 0 : 1, 0, 0])
                inv_slot(ridge_dz=TL_RIDGE_DZ, ridge_r=TL_RIDGE_R, ridge_h=TL_RIDGE_H, r=TL_R, ang=75);
    }
    // Threaded legs on bottom to form taller side of tent
    for(xy = THREADED_LEG_NUT_XY) {
        rotate([0, 0, CASE_RZ]) off_xyz_case_wall() translate([xy.x, xy.y, -TL_DEPTH])
                    bolt_leg_with_nut_slot(bolt_top_dz=4);
    }

    // Rubber feet on 4 corners
    for (i = [0, 1], j = [0, 1]) rotate([0, 0, CASE_RZ]) off_xyz_case_wall() mirror([0, 0, 1])
        translate([RUBBER_R + 1 + COVER_RUBBER_DX, RUBBER_R + 6.5 + COVER_RUBBER_DY, 0])
        translate([
            i * (CASE_W - RUBBER_R * 2 - COVER_RUBBER_DX * 2),
            j * (CASE_D - RUBBER_R * 2 - COVER_RUBBER_DY * 2 - /*??*/4)
            - sign(j - 0.5) * (i == 1? 10 : 0),
            -0.01
        ]) cylinder(r=RUBBER_R, h=RUBBER_CAVE_TH + 0.01);
    // Finger tip curve
    for(xyz = [FINGER_TIP_XYZ[0], FINGER_TIP_XYZ[1]]) {
        rotate([0, 0, CASE_RZ]) off_xyz_case_wall() translate(xyz + [0, 0, -10]) cylinder(r=FINGER_TIP_R, h=50);
    }
    rotate([0, 0, CASE_RZ]) {
        rise_wall_th=2.4 + 0.2;
        translate([FINGER_TIP_XYZ[1].x, FINGER_TIP_XYZ[1].y, -COVER_PLATE_TH + 0.69])
            mirror([0, 0, 1]) cylinder(
                r=FINGER_TIP_R + rise_wall_th, 
                h=SCREW_STUB_H0 + H_ABOVE_PCB_BOTTOM - KEYCAP_BOTTOM_H
            );
    }
}


/* ==================== Hinge  ==================== */
*translate([0, -30, 0])
rotate([0, 0, CASE_RZ]) {
    for(dxyz = HINGE_OFFSETS) translate(dxyz) rotate([0, 0, 0])
        difference() {
            rotate([0, 90, 0]) union() {
                base_off = 0.22;
                grabber(base_off=base_off, shaft_off=0, base_ext=5.7 - COVER_CONN_DH, only_base=false, height_off=0.7);
                translate([0, base_off, 0]) // Compensate cave-in, connect with cover
                    grabber(base_off=base_off, shaft_off=0, base_ext=5.7 - COVER_CONN_DH, only_base=true, height_off=0.7);
                // Test position of cover
                cover_dth = 0.35;
                if($preview)
                translate([-(COVER_TH - cover_dth) - (HINGE_R + HINGE_R_PADDING), HINGE_R + HINGE_R_PADDING, -18])
                    cube([COVER_TH, 20, 40]);
            }
            // Shaft
            rotate([0, 90, 0]) {
                cylinder(r=HINGE_R + 0.15, h=CASE_W + 2, center=true);
            }
            // Bolts
            translate([0, 0, 1]) // Compensate for print error
            translate([0, 3.75, 3.5]) rotate([-90, 0, 0]) m2_bolt_nut();
        }
}

} // Global mirror

// switches
*if($preview && LEFT) translate([-81.5, -70.5, 30])
    import("../assets/temper_layout.dxf");

*cylinder(h=SCREW_STUB_H0 - PLATE_TH, r=2.5);


// Since we conditioinally mirror slots on the cover/base, the leg
// will work for both sides. See `mirror([LEFT?...])`
*difference() {
union() {
    translate([0, 0, tent_leg_dh]) rotate([0, 0, -60])
        pin(
            ridge_dz=TL_RIDGE_DZ, 
            ridge_r=TL_RIDGE_R - 0.04/*compensate for PTEG*/ - 0.08, 
            ridge_h=TL_RIDGE_H - 0.12, 
            r=TL_R - 0.1,
            refined=true, 
            h=TENT_LEG_H0,
            top_only=true
        );
    translate([0, 0, -tent_leg_dh]) // Optionally add for one side to differentite
        cylinder(r=TENT_END_R0, h=tent_leg_dh * 3);
}

rotate([0, atan(TENT_LEG_H0 / CASE_W1), 90]) union() {
    translate([0, 0, -tent_leg_dh])
        cube([20, 20, tent_leg_dh * 2], center=true);
    cylinder(d=TENT_LEG_RUBBER_FEET_D0, h=1);
}

// Cave-in for indictating which side facing user when inserting
rotate([0, 0, -60]) translate([0, TL_R + 0.3, TENT_LEG_H0 * 0.75])
    cube([1.2, 2, 8], center=true);
rotate([0, 0, -60 - 12]) translate([0, TL_R - 0.15, TENT_LEG_H0 * 0.75]) 
    rotate([90, 0, 0]) translate([0, 0, 0]) cylinder(h=1, r=1.5, center=true, $fn=3);

}

// Just the lock
*difference() {
    translate([0, 0, -4])
        pin(ridge_dz=TL_RIDGE_DZ, ridge_r=TL_RIDGE_R - 0.08, ridge_h=TL_RIDGE_H - 0.15, r=TL_R - 0.1, refined=true, h=TL_H0 + 4);
    rotate([0, 20, 0]) mirror([0, 0, 1]) union() {
        cylinder(h=8, r=TL_R + TL_RIDGE_H + 5);
*        mirror([0, 0, 1]) translate([0, 0, -0.1])
            cylinder(h=0.5, r=RUBBER_R);
    }
}
$fn = 128;
