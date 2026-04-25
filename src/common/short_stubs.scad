union() {
    h = 5 + 1;
    d = 3.96;
    cylinder(d=d, h=h);
    translate([0, 0, h]) sphere(d=d);
}

$fn = 128;
