include <../config.scad>
include <../lib/helpers.scad>
use <../lib/Round-Anything/polyround.scad>

module door(){
    door_corner_w = 40;
    door_corner_h = 48;
    door_corner_y_chamfer = 9.5;
    door_corner_x_chamfer = 5.5;

    difference() {
    polyRoundExtrude([
            [0, 0, mount_chamfer],
            [door_w, 0, mount_chamfer],
            [door_w, door_h - door_corner_h, mount_chamfer],
            [door_w - door_corner_x_chamfer, door_h - door_corner_h, mount_chamfer],
            [door_w - door_corner_w, door_h - door_corner_y_chamfer, mount_chamfer],
            [door_w - door_corner_w, door_h, mount_chamfer],
            [door_corner_w, door_h, mount_chamfer],
            [door_corner_w, door_h - door_corner_y_chamfer, mount_chamfer],
            [door_corner_x_chamfer, door_h - door_corner_h, mount_chamfer],
            [0, door_h - door_corner_h, mount_chamfer],
        ],
        panel_thickness,
        0,
        0
    );
    // door hinges
    translate([door_w - (26.4 - 10 - door_clearance / 2), 10, -tiny])
    rotate([0, 0, 90])
        super_mini_hinge_holes();
    translate([door_w - (26.4 - 10 - door_clearance / 2), (door_h - door_corner_h - 26.26)/2, -tiny])
    rotate([0, 0, 90])
        super_mini_hinge_holes();
    translate([door_w - (26.4 - 10 - door_clearance / 2), door_h - door_corner_h - 26.26 - 10, -tiny])
    rotate([0, 0, 90])
        super_mini_hinge_holes();
    // handle
    translate([door_handle_d, (door_h - 85)/2, -tiny])
        rotate([0, 0, 90])
        small_handle_holes();
    }
}