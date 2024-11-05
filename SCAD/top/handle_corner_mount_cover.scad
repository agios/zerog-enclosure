include <../config.scad>
use <../lib/Round-Anything/polyround.scad>
include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/screws.scad>

module handle_corner_mount_cover() {
    difference() {
        polyRoundExtrude(
            [
                [0, 0, 1],
                [0, large_handle_length, 1],
                [large_handle_width, large_handle_length, 1],
                [large_handle_width, 0, 1],
            ],
            mount_thickness,
            1,
            0
        );
        for(i=[
            [large_handle_width / 2, (large_handle_length - large_handle_hole_d) / 2 + 10],
            [large_handle_width / 2, (large_handle_length - large_handle_hole_d) / 2 + large_handle_hole_d - 10],
        ])  translate([i.x, i.y, -tiny]) 
            screw_hole("M5", length=mount_thickness-1.5, head="socket", anchor=BOTTOM);
    }
}

handle_corner_mount_cover();
