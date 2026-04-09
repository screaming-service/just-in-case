module simple_screw(r0=4, r1=2, h0=3, h1=10) {
  cylinder(r2=r1, r1=r0, h=h0);
  cylinder(r=r1, h=h0 + h1);
}

// Center of cap disc sits at (0, 0), z upward
module screw_hex_nut(
  cap_d=4, cap_th=2, shaft_d=2, shaft_h=12, nut_d=4, nut_th=5, nut_offset=undef) {
    union() {
        cylinder(r=cap_d / 2, h=cap_th);
        translate([0, 0, -shaft_h])
            cylinder(r=shaft_d / 2, h=cap_th + shaft_h);
        if(nut_th > 0) translate([
                0,
                0, 
                nut_offset == undef? -shaft_h : (-nut_th - nut_offset)
            ]) cylinder($fn=6, r=nut_d / 2, nut_th);
    }
}

module m2_bolt_nut(shaft_length=8, bolt_head_th=2, nut_th=2.5, nut_d=4.8) {
    /*
     * shaft_length: length between head to nut 
     *
     */
    BOLT_D0 = 2.4; // Diameter of shaft
    BOLT_D1 = 3.8; // Diameter of head
    //NUT_D = 4.8;

    bolt_head_to_nut= shaft_length;

    union() {
        // Shaft of bolt
        cylinder(d=BOLT_D0, h=bolt_head_to_nut + 2, center=true);
        // Head of bolt
        translate([0, 0, -bolt_head_to_nut / 2 - bolt_head_th - 1])
            cylinder(d=BOLT_D1, h=bolt_head_th + 1);
        // Nut
        translate([0, 0, bolt_head_to_nut / 2]) rotate([0, 0, 30])
            cylinder(d=nut_d, h=nut_th + 1, $fn=6);
    }

}
