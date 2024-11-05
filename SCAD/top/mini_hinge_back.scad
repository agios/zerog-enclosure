use <../lib/Round-Anything/polyround.scad>
include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/screws.scad>
include <../config.scad>

w = 9;
module mini_hinge_back() {
    difference() {
        polyRoundExtrude(
            [
                [0, 0, 1],
                [0, w + 2*mini_hinge_d, 1],
                [w, w + 2*mini_hinge_d, 1],
                [w, 0, 1],
            ],
            3,
            0,
            0
        );
        for(i=[
            [w/2, w/2],
            [w/2, w/2 + mini_hinge_d],
            [w/2, w/2 + 2*mini_hinge_d],
        ]) translate([i.x, i.y, -tiny]) union() {
            nut_trap_inline(1.5, "M4");
            screw_hole("M4,6", anchor=BOTTOM);
        } 
    }
}

mini_hinge_back();