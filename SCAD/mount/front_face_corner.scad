include <../config.scad>
include <../lib/helpers.scad>
include <mount.scad>
use <../lib/Round-Anything/polyround.scad>

front_plate_points = [
    [0, 20, mount_chamfer],
    [5, 20, mount_chamfer],
    [5, 30, mount_chamfer],
    [15, 30, mount_chamfer],
    [15, 20, mount_chamfer],
    [20, 20, mount_chamfer],
    [20, 0, mount_chamfer],
    [20, -30, mount_chamfer],
    [0, -30, mount_chamfer]
];
front_plate_screws = [
    [10, -20],
    [10, -5],
];

module front_plate() {
    difference() {
        union() {
            polyRoundExtrude(
                front_plate_points,
                mount_thickness,
                mount_chamfer,
                0
            );
            // for(s=front_plate_screws)
            //     translate([s.x, s.y, -tiny])
            //         screw_support("M5");
        }
        for(s=front_plate_screws)
            translate([s.x, s.y, -tiny])
                screw_hole("M5", counterbore=20, length=mount_thickness-0.8, head="socket", anchor=BOTTOM);
    }
}

difference() {
    union() {
        front_plate();
        translate([0, 20 - mount_thickness - mount_chamfer, panel_front_distance - mount_thickness]) 
        rotate([-90, 0, 0]) ledge(panel_front_distance - mount_thickness, 20, single_lip = true);
    }
    translate([10, 25, 0])
            screw_hole("M3", counterbore=20, length=mount_thickness-0.6, head="socket", anchor=BOTTOM);
}

