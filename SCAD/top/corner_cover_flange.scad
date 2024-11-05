include <../config.scad>
include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/screws.scad>

difference() {
    cylinder(h=2.5, d=14);
    translate([0, 0, -tiny]) screw_hole("m3", length=2, head="socket", counterbore = 0.8, anchor=BOTTOM);
}