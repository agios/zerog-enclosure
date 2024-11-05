$fa = $preview ? 9 : 1;
$fs = $preview ? 1 : 0.1;

include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/screws.scad>

difference() {
  import("../lib/Handle_SMALL.stl", convexity=20);
  translate([8.5, -0.001, 7.5])
  rotate([-90, 0, 0])
  screw_hole("M4", counterbore=20, length=2.5, head="socket", anchor=BOTTOM);
  translate([93.5, -0.001, 7.5])
  rotate([-90, 0, 0])
  screw_hole("M4", counterbore=20, length=2.5, head="socket", anchor=BOTTOM);
}
