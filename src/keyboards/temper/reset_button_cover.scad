EMBOSS_H = 2.8;
TRAVEL_Z = 4.1;

WALL_TH = 1.5;

BTN_W = 4.5;
BTN_H = 4;
BTN_TH = 1.7;

COVER_R = 2.75;

intersection() {
    rotate([0, 0, 45])
        cube([BTN_W * 1.8, BTN_W * 1.8, (EMBOSS_H + TRAVEL_Z) * 3], center=true);
    union() {
        difference() {
            linear_extrude(height=BTN_TH + WALL_TH) offset(r=WALL_TH)
                square([BTN_W, BTN_H], center=true);
            translate([0, 0, BTN_TH / 2 + 1+ WALL_TH]) 
                cube([BTN_W, BTN_H, BTN_TH + 2], center=true); 
        }

        mirror([0, 0, 1]) union() {
            cylinder(h=TRAVEL_Z + EMBOSS_H - WALL_TH, r=COVER_R);
            linear_extrude(height=TRAVEL_Z - WALL_TH) offset(r=WALL_TH)
                square([BTN_W, BTN_H], center=true);
        }
    }
}

$fn = $preview? 20 : 128;
