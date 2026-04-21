LEG_NUT_D = 4;
LEG_NUT_H = 1.5;

module bolt_leg_with_nut_slot(
    nut_d=LEG_NUT_D, nut_h=LEG_NUT_H, bolt_h=10, bolt_top_dz=6, bolt_d=4
) {
    translate([0, 0, 0]) {
        cylinder(d=nut_d, h=nut_h, $fn=6);
        cylinder(d=2, h=bolt_h);
        translate([0, 0, bolt_top_dz]) cylinder(d=bolt_d, h=bolt_h);
    }
}

module bolt_leg(
    shaft_h=44, threads_h=4, sock_h=15, shaft_d=4, threads_d=2, sock_d=6
) {
    union() {
        cylinder(d=shaft_d, h=shaft_h);
        cylinder(d=sock_d, h=sock_h);
        translate([0, 0, shaft_h])
            cylinder(d=threads_d, h=threads_h);
    }
}

module bolt_leg_storage(
    shaft_h=44, threads_h=4, sock_h=15, shaft_d=4, threads_d=2, sock_d=6,
    hull_dist=0, bidirectional=false, lever_center=0.5, lever_w=6, lever_dr=1.2
) {
    if(hull_dist == 0) // bidirectional does not support zero dist hull
        union() {
            bolt_leg(shaft_h, threads_h, sock_h, shaft_d, threads_d, sock_d);
        }
    else union() {
        // main shaft
        hull() for(i = [0, 1]) 
            translate([i * hull_dist, 0, 0]) cylinder(d=shaft_d, h=shaft_h);
        // lever
        difference() {
            hull() for(i = [0, 1]) translate([0, 0, shaft_h * lever_center])
                translate([i * hull_dist, 0, -lever_w / 4]) difference() {
                    cylinder(d=shaft_d + lever_dr * 2, h=lever_w);
                    translate([0, -shaft_d / 2 - lever_dr, lever_w / 2]) cube([
                        shaft_d + lever_dr * 2, shaft_d + lever_dr * 2, lever_w + 2
                    ], true);
                }
            translate([-shaft_d / 2 - lever_dr, 0, shaft_h * lever_center + lever_w / 4]) cube(
                [shaft_d + lever_dr * 2, shaft_d + lever_dr * 2, lever_w + 2]
                , center=true);
        }
        // sock
        hull() for(i = [0, 1]) 
            translate([i * hull_dist, 0, 0]) cylinder(d=sock_d, h=sock_h);
        // threads or the other sock, depending on bidirectional
        hull() for(i = [0, 1])
            if(bidirectional)
                translate([i * hull_dist, 0, shaft_h + threads_h - sock_h])
                    cylinder(d=sock_d, h=sock_h);
            else
                translate([i * hull_dist, 0, shaft_h])
                    cylinder(d=threads_d, h=threads_h);
    }
}

bolt_leg_with_nut_slot();

translate([10, 0, 0]) bolt_leg_storage();
translate([30, 0, 0]) bolt_leg_storage(hull_dist=6);
translate([50, 0, 0]) bolt_leg_storage(hull_dist=6, bidirectional=true);

$fn = 128;
