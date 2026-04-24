LEG_NUT_D = 4.3;
LEG_NUT_H = 1.5;

module bolt_leg_with_nut_slot(
    nut_d=LEG_NUT_D, nut_h=LEG_NUT_H, bolt_h=10, bolt_top_dz=6, bolt_d=4.3
) {
    translate([0, 0, 0]) {
        cylinder(d=nut_d, h=nut_h, $fn=6);
        cylinder(d=2.6, h=bolt_h);
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
    shaft_h=44, threads_h=4, sock_h=15, shaft_d=4.4, threads_d=2.4, sock_d=6.4,
    hull_dist=0, bidirectional=false, lever_center=0.5, lever_w=6, lever_dr=1.2,
    bump_index=0, bump_r=0.35, bump_shaft_shift=0, bump_hull_shift=0
) {
    if(hull_dist == 0) // bidirectional does not support zero dist hull
        difference() {
            bolt_leg(shaft_h, threads_h, sock_h, shaft_d, threads_d, sock_d);
            for(i = [-1, 1]) translate([0, i * sock_d / 2, (sock_h - 4) / 2])
                cylinder(r=bump_r, h=4);
        }
    else union() {
        // main shaft
        bd_shaft_hull_shift = bidirectional? (sock_d - shaft_d) / 2 : 0;
        difference() {
            hull() for(i = [0, 1]) 
                translate([i * hull_dist - (1 - i) * bd_shaft_hull_shift, 0, 0])
                    cylinder(d=shaft_d, h=shaft_h);
            // bumps for shaft
            for(i = [-1, 1]) translate([
                  bump_index * sock_d/*level with sock*/ + bump_hull_shift
                , i * shaft_d / 2
                , (shaft_h - 4) / 2 + bump_shaft_shift
            ]) cylinder(r=bump_r, h=4);
        }
        // lever
        if(lever_dr > 0) difference() {
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
        difference() {
            hull() for(i = [0, 1]) 
                translate([i * hull_dist, 0, 0]) cylinder(d=sock_d, h=sock_h);
            // bumps for sock
            for(i = [-1, 1]) translate([
                  bump_index * sock_d + bump_hull_shift
                , i * sock_d / 2
                , (sock_h - 4) / 2
            ]) cylinder(r=bump_r, h=4);
        }
        // threads or the other sock, depending on bidirectional
        if(bidirectional) difference() {
            hull() for(i = [0, 1])
                translate([i * hull_dist, 0, shaft_h + threads_h - sock_h])
                    cylinder(d=sock_d, h=sock_h);
            // bumps for sock
            for(i = [-1, 1]) translate([
                  bump_index * sock_d + bump_hull_shift
                , i * sock_d / 2
                , shaft_h + threads_d  - sock_h / 2
            ]) cylinder(r=bump_r, h=4);
        } else
            hull() for(i = [0, 1])
                translate([i * hull_dist, 0, shaft_h])
                    cylinder(d=threads_d, h=threads_h);
    }
}

bolt_leg_with_nut_slot();

translate([10, 0, 0]) bolt_leg_storage();
translate([30, 0, 0]) bolt_leg_storage(hull_dist=6);
translate([30, 20, 0]) bolt_leg_storage(hull_dist=6, bump_index=1, bump_shaft_shift=12);
translate([50, 0, 0]) bolt_leg_storage(hull_dist=6, bidirectional=true);

$fn = 128;
