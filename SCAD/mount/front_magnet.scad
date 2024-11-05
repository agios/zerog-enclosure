include <../config.scad>
include <mount.scad>

magnets = 6;
h = 10;
difference() {
    union() {
        translate([0, 0, -19]) rotate([90, 0, 90])
        mount(102, top = str("face,d=", panel_front_distance), add_screw_supports = false);
        polyRoundExtrude(
            [
                [0, 0, 0],
                [0, 102, 0],
                [8, 102, 1],
                [8, 0, 1],
            ],
            h,
            0,
            0
        );
    }
    for(y=[20:(102-40)/(magnets - 1):102-20])
        translate([4, y, h - 3.2 +0.6])
            cylinder(h=3.2, d=6.2);
}