include <../config.scad>
use <../lib/Round-Anything/polyround.scad>
include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/screws.scad>

module handle_corner_mount() {
    difference() {
        polyRoundExtrude(
            [
                [0, 0, 1],
                [0, large_handle_length, 1],
                [large_handle_width, large_handle_length, 1],
                [large_handle_width, 0, 1],
            ],
            large_handle_width,
            1,
            1
        );
        for(i=[
            [large_handle_width / 2, (large_handle_length - large_handle_hole_d) / 2],
            [large_handle_width / 2, (large_handle_length - large_handle_hole_d) / 2 + large_handle_hole_d],
        ]) translate([i.x, i.y, -tiny]) union() {
            nut_trap_inline(3.3, "M5");
            screw_hole("M5", length=large_handle_width, anchor=BOTTOM);
        }
        for(i=[
            [large_handle_width / 2, (large_handle_length - large_handle_hole_d) / 2 + 10],
            [large_handle_width / 2, (large_handle_length - large_handle_hole_d) / 2 + large_handle_hole_d - 10],
        ])  translate([-tiny, i.y, i.x]) rotate([0, 90, 0]) union() {
            nut_trap_inline(3.3, "M5");
            screw_hole("M5", length=large_handle_width, anchor=BOTTOM);
        }
    }
}

// rotate([0, 90, 0])
// handle_corner_mount();
