module short_stub(d=3.96, h=4.5) {
    union() {
        cylinder(d=d, h=h);
        translate([0, 0, h]) sphere(d=d);
    }
}

*translate([0, 20, 0]) short_stub();

mirror([0, 0, 1]) difference() {
    h = 2.5;
    d = 6.2;

    linear_extrude(height=h + d / 2 + 1) offset(r=5)
        square([d * 3, d * 3], center=true);
    for(i = [-1 : 1], j = [-1 : 1]) {
        translate([i * (d + 2), j * (d + 2), -0.1]) 
            short_stub(h=h, d=d + 0.1);
    }
}

$fn = 128;
