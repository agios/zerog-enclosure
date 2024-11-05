include <../config.scad>
include <../lib/helpers.scad>
use <../lib/Round-Anything/polyround.scad>

module cover_top(){
    difference() {
        cube([frame_width + 2 * panel_side_distance,
                frame_depth + panel_rear_distance + panel_front_distance,
                panel_thickness]);
        // corner fastener holes
        translate([frame_width + 2 * panel_side_distance - mount_thickness - corner_size /2,
                    frame_depth + panel_rear_distance + panel_front_distance - mount_thickness - corner_size /2,
                    - mount_chamfer + tiny])
            extrudeWithRadius(panel_thickness + mount_chamfer, mount_chamfer)
                circle(r=4.0);
        translate([mount_thickness + corner_size /2,
                    mount_thickness + corner_size /2,
                    - mount_chamfer + tiny])
            extrudeWithRadius(panel_thickness + mount_chamfer, mount_chamfer)
                circle(r=4.0);
        translate([frame_width + 2 * panel_side_distance - mount_thickness - corner_size /2,
                    mount_thickness + corner_size /2,
                    - mount_chamfer + tiny])
            extrudeWithRadius(panel_thickness + mount_chamfer, mount_chamfer)
                circle(r=4.0);
        translate([mount_thickness + corner_size /2,
                    frame_depth + panel_rear_distance + panel_front_distance - mount_thickness - corner_size /2,
                    - mount_chamfer + tiny])
            extrudeWithRadius(panel_thickness + mount_chamfer, mount_chamfer)
                circle(r=4.0);
        // door hinges
        translate([50, 14 - panel_thickness, -tiny])
            mini_hinge_holes();
        translate([frame_width - 50 - 33.6 + 2 * mount_thickness + panel_thickness, 14 - panel_thickness, -tiny])
            mini_hinge_holes();
        // handle holes
        translate([large_handle_width / 2, (frame_depth + panel_rear_distance + panel_front_distance - large_handle_hole_d) / 2, -tiny])
        rotate([0, 0, 90]) large_handle_holes();
        translate([frame_width + 2 * panel_side_distance - large_handle_width / 2, (frame_depth + panel_rear_distance + panel_front_distance - large_handle_hole_d) / 2, -tiny])
        rotate([0, 0, 90]) large_handle_holes();
    }
}
