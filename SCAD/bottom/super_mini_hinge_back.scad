use <../lib/Round-Anything/polyround.scad>
include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/screws.scad>
include <../config.scad>

w = 8;
module super_mini_hinge_back() {
    difference() {
        polyRoundExtrude(
            [
                [0, 0, 1],
                [0, w + 2*super_mini_hinge_d, 1],
                [w, w + 2*super_mini_hinge_d, 1],
                [w, 0, 1],
            ],
            3,
            0,
            0
        );
        for(i=[
            [w/2, w/2],
            [w/2, w/2 + super_mini_hinge_d],
            [w/2, w/2 + 2*super_mini_hinge_d],
        ]) translate([i.x, i.y, -tiny]) union() {
            nut_trap_inline(1.5, "M3");
            screw_hole("M3,6", anchor=BOTTOM);
        } 
    }
}

super_mini_hinge_back();