use <lib/Round-Anything/polyround.scad>
include <lib/helpers.scad>
include <lib/BOSL2/std.scad>
include <lib/BOSL2/screws.scad>

magnets = 3;
door_magnet_positions = [20:(small_handle_length-40)/(magnets - 1):small_handle_length-20];

module door_handle_back(thickness = 6) {
    difference() {
        polyRoundExtrude(
            [
                [0, 0, 1],
                [0, small_handle_length, 1],
                [small_handle_width, small_handle_length, 1],
                [small_handle_width, 0, 1],
            ],
            thickness,
            0,
            0
        );
        for(i=[
            [small_handle_width / 2, 8.5],
            [small_handle_width / 2, small_handle_length - 8.5],
        ]) translate([i.x, i.y, -tiny]) union() {
            nut_trap_inline(3, "M4", $slop=0.1);
            screw_hole("M4,10", anchor=BOTTOM);
        }
        for(y=door_magnet_positions)
            translate([small_handle_width / 2, y, 0.6])
                cylinder(h=3.2, d=6.1);
    }
}

module door_stop(clearance=0, stop_position=6, offset=5, thickness = 6, screw_support = true) {
    difference() {
        union() {
            // base (screwed to extrusion)
            polyRoundExtrude(
                [
                    [0, 0, 1],
                    [0, small_handle_length, 1],
                    [20 - clearance, small_handle_length, 1],
                    [20 - clearance, 0, 1],
                ],
                mount_thickness,
                mount_chamfer,
                0
            );
            if (screw_support) for(i=[
                [10, 8.5],
                [10, small_handle_length - 8.5],
            ]) translate([i.x, i.y, -tiny])
                screw_support("M3");
            // stop
            translate([20 - clearance - stop_position, 0, 0]) rotate([0, -90, 0]) polyRoundExtrude(
                [
                    [0, 14, 1],
                    [0, small_handle_length - 14, 1],
                    [small_handle_width + offset, small_handle_length - 14, 1],
                    [small_handle_width + offset, 14, 1],
                ],
                thickness,
                mount_chamfer,
                mount_chamfer,
            );
            
        }
        for(i=[
            [10, 8.5],
            [10, small_handle_length - 8.5],
        ]) translate([i.x, i.y, -tiny])
            screw_hole("M3,2", head="socket", anchor=BOTTOM);
        for(y=door_magnet_positions) {
            translate([20 - clearance - stop_position - 3.2 - 0.6, y, offset + small_handle_width / 2]) rotate([0, 90, 0])
                cylinder(h=3.2, d=6.2);
            translate([20 - clearance - stop_position - 0.6, y - 3.1, -tiny]) rotate([0, -90, 0])
                cube([ offset + small_handle_width / 2 + tiny, 6.2, 3.2]);
        }
    }
}