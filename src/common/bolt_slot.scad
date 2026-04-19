LEG_NUT_D = 4;
LEG_NUT_H = 1.5;

module bolt_leg_slot(
    nut_d=LEG_NUT_D, nut_h=LEG_NUT_H, bolt_h=10, bolt_top_dz=6, bolt_d=4
) {
    translate([0, 0, 0]) {
        cylinder(d=nut_d, h=nut_h, $fn=6);
        cylinder(d=2, h=bolt_h);
        translate([0, 0, bolt_top_dz]) cylinder(d=bolt_d, h=bolt_h);
    }
}

bolt_leg_slot();

$fn = 128;
