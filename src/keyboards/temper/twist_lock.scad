
module place_ridge(h, ridge_r, ridge_dz, top_only=false) {
        for(i = top_only? [-1] : [-1, 1]) 
            translate([0, 0, (i==-1? h : 0) + i * (ridge_r + ridge_dz)])
                children();
}

module mk_ridge_cylinder(r, ridge_r, ridge_h, rz=0, refined=false) {
                if(refined) intersection() {
                    rotate([0, 90, rz])
                        cylinder(r=ridge_r, h=r * 2 + ridge_h * 6, center=true);
                    cylinder(r=r + ridge_r, h=ridge_r * 2 + 1, center=true);
                } else rotate([0, 90, rz])
                        cylinder(r=ridge_r, h=r * 2 + ridge_h * 2, center=true);
}

module pin(r=4, h=20, ridge_r=1, ridge_h=0.75, ridge_dz=1, refined=false, top_only=false) {
    union() {
        cylinder(r=r, h=h);
        place_ridge(h, ridge_r, ridge_dz, top_only=top_only)
            mk_ridge_cylinder(r, ridge_r, ridge_h, refined=refined);
    }
}

module inv_slot(r=4, h=20, ridge_r=1, ridge_h=0.75, ridge_dz=1, ang=60) {
    union() {
        cylinder(r=r, h=h);
        // Start
*        pin(r, h, ridge_r, ridge_h, ridge_dz, refined=true);
        // End
*        place_ridge(h, ridge_r, ridge_dz)
            mk_ridge_cylinder(r, ridge_r, ridge_h, ang, refined=true);
        // Arc
        place_ridge(h, ridge_r, ridge_dz)
        for(i = [0, 1]) translate([0, 0, -ridge_r])
            rotate([0, 0, i * 180]) rotate_extrude(angle=ang) 
                translate([r - 0.05, 0, 0]) square([ridge_h + 0.05, ridge_r* 2]);
        // Travel (slide in)
        for(i = [0, 1]) translate([0, 0, ridge_dz]) {
            rotate([0, 0, i * 180 -atan(ridge_r / r)]) 
                rotate_extrude(angle=2 * atan(ridge_r / r))
                    translate([r - 0.05, 0, 0]) square([ridge_h + 0.05, h - ridge_dz * 2]);
        }
*        hull() 
        place_ridge(h, ridge_r, ridge_dz)
            mk_ridge_cylinder(r, ridge_r, ridge_h, 0, refined=true);
    }
}

module pin_slot(r=4, h=20, ridge_r=1, ridge_h=0.75, ridge_dz=1, refined=false, top_only=false, travel_x=12, ridge_repeat=6) {
    union() {
        pin(r, h, ridge_r, ridge_h, ridge_dz, refined, top_only);
        hull() {
            cylinder(h=h, r=r);
            translate([-travel_x, 0, 0]) cylinder(h=h, r=r);
        }
        place_ridge(h, ridge_r, ridge_dz, top_only=true)
            translate([0, 0, -ridge_r - ridge_r * (ridge_repeat - 2)])
                rotate([0, 0, -45]) rotate_extrude(angle=90) 
                    translate([r - 0.05, 0, 0]) square([ridge_h + 0.05, ridge_r* ridge_repeat]);
    }
}

translate([0, -6, 0])
    pin(ridge_dz=1.5, refined=false, ridge_h=1, r=3.2);

translate([0, -18, 0])
    inv_slot(ridge_dz=1.5, ridge_h=1, r=3.2);

translate([0, 6, 0])
    pin(ridge_dz=1.5, refined=true, ridge_h=1, r=3.2);

translate([0, 18, 0]) difference() {
    linear_extrude(height=6) offset(r=2) circle(r=3.5, $fn=6);
    inv_slot(ridge_dz=1.5, ridge_r=1.08, ridge_h=1, r=3.2);
}

translate([0, 30, 0])
    pin_slot(ridge_dz=1.5, refined=true, ridge_h=1, r=3.2, travel_x=20);

$fn = 128;
