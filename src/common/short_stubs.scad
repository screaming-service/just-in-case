union() {
    h = 5 + 2;
    d = 3.75;
    cylinder(d=d, h=h);
    translate([0, 0, h]) sphere(d=d);
}

$fn = 128;
