include <../config.scad>
include <../lib/helpers.scad>

module cover_front() {
    difference() {
        polyRoundExtrude([
                [0, 0, mount_chamfer],
                [frame_width - door_clearance / 2, 0, mount_chamfer],
                [frame_width - door_clearance / 2, top_height + panel_thickness, mount_chamfer],
                [0, top_height + panel_thickness, mount_chamfer],
            ],
            panel_thickness,
            0,
            0
        );
        // door hinges
        translate([50 - panel_side_distance - 0.5, 14, -tiny])
            mini_hinge_holes();
        translate([frame_width - panel_side_distance - 0.5 - 50 - 33.6 + 2 * mount_thickness + panel_thickness, 14, -tiny])
            mini_hinge_holes();
        // door handle
        translate([(frame_width - 1 - 85) / 2, top_height + panel_thickness - 15, -tiny])
            small_handle_holes();
    }
}