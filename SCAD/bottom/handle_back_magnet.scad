$fa = $preview ? 9 : 1;
$fs = $preview ? 1 : 0.1;
tiny = 0.005;

use <../lib/Round-Anything/polyround.scad>
include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/screws.scad>

magnets = 6;
module handle_back_magnet() {
    difference() {
        polyRoundExtrude(
            [
                [0, 0, 1],
                [0, 102, 1],
                [15, 102, 1],
                [15, 0, 1],
            ],
            10,
            0,
            0
        );
        for(i=[
            [7.5, 8.5],
            [7.5, 93.5],
        ]) translate([i.x, i.y, -tiny]) union() {
            nut_trap_inline(3.3, "M4", $slop=0.1);
            screw_hole("M4,10", anchor=BOTTOM);
        }
        for(y=[20:(102-40)/(magnets - 1):102-20])
            translate([0.6, y, 4])
            rotate([0, 90, 0])
                cylinder(h=3.2, d=6.1);
    }
}

rotate([0, -90, 0])
handle_back_magnet();