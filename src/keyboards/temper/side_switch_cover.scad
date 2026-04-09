module switch_cover() {

BW_ON = 4;
BWM = 8;
BW_OFF = 3.25;
BH = 5.5;
BD = 1.6 + 0.6;

DX_BUMP = 5.6;
DZ_BUMP = 0.5;
W_BUMP = 5.5;
H_BUMP = 2.4;
D_BUMP = 2.25;

DX_SLOT = 4.75 + 2;
W_SLOT = 1.5;
D_SLOT = 1.;
H_SLOT = 3.5;

difference() {
    union() {
        cube([BW_ON + BWM + BW_OFF, BD, BH]);
        translate([DX_BUMP, BD, DZ_BUMP]) difference() {
            cube([W_BUMP, D_BUMP, H_BUMP]);
            for(i = [0, 1, 2]) {
                translate([i * 1.8 + 1, D_BUMP + 0.5, -1])
                    cylinder(h=H_BUMP + 2, r=0.75);
            }
        }
    }

    translate([DX_SLOT, -1, -1])
        cube([W_SLOT, D_SLOT + 1, H_SLOT + 1]);

    translate([-0.01, BD - 1.4, -0.01]) mirror([0, 1, 0])
        cube([BW_OFF + 1, 2, 1.8]);
}

}

switch_cover();

$fn = 128;
