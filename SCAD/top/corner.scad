include <../config.scad>
include <../lib/helpers.scad>
include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/screws.scad>
use <../lib/Round-Anything/polyround.scad>

outline = [
    [0, -2 * mount_thickness - panel_thickness, mount_chamfer],
    [0, corner_size, mount_chamfer],
    [mount_thickness, corner_size, mount_chamfer],
    [mount_thickness, mount_thickness, 0],
    [mount_thickness + panel_thickness, mount_thickness, 0],
    [mount_thickness + panel_thickness, corner_size, mount_chamfer],
    [2 * mount_thickness + panel_thickness, corner_size, mount_chamfer],
    [2 * mount_thickness + panel_thickness, 0, 8],
    [2 * mount_thickness + panel_thickness + corner_size, 0, mount_chamfer],
    [2 * mount_thickness + panel_thickness + corner_size, -mount_thickness, mount_chamfer],
    [3 * mount_thickness + panel_thickness, -mount_thickness, 0],
    [3 * mount_thickness + panel_thickness, -mount_thickness - panel_thickness, 0],
    [2 * mount_thickness + panel_thickness + corner_size, -mount_thickness - panel_thickness, mount_chamfer],
    [2 * mount_thickness + panel_thickness + corner_size, -2 * mount_thickness - panel_thickness, mount_chamfer],
];
base_points = [
    outline[0],
    outline[1],
    outline[6],
    outline[7],
    outline[8],
    outline[13],    
];
base_notch1 = [
    [outline[2][0] - mount_chamfer, outline[2][1], 0],
    [outline[5][0] + mount_chamfer, outline[5][1], 0],
    [outline[5][0] + mount_chamfer, outline[5][1] - mount_thickness, 0],
    [outline[2][0] - mount_chamfer, outline[2][1] - mount_thickness, 0],
];
base_notch2 = [
    [outline[9][0], outline[9][1] + mount_chamfer, 0],
    [outline[12][0], outline[12][1] - mount_chamfer, 0],
    [outline[12][0] - mount_thickness, outline[12][1] - mount_chamfer, 0],
    [outline[9][0] - mount_thickness, outline[9][1] + mount_chamfer, 0],
];
top_points = [
    outline[0],
    outline[1],
    outline[2],
    outline[3],
    outline[4],
    [mount_thickness + panel_thickness, -mount_thickness, 0],
    outline[10],
    outline[11],
    outline[12],
    outline[13],
];

module corner() {
    difference() {
        union() {
            // Base
            polyRoundExtrude(
                base_points,
                mount_thickness,
                0,
                0
            );
            // Base notches
            translate([0, 0, mount_thickness - tiny])
            polyRoundExtrude(
                base_notch1,
                mount_thickness * 2,
                mount_chamfer,
                0
            );
            translate([0, 0, mount_thickness - tiny])
            polyRoundExtrude(
                base_notch2,
                mount_thickness * 2,
                mount_chamfer,
                0
            );
            // Main body
            polyRoundExtrude(
                outline,
                top_height + mount_thickness,
                0,
                0
            );
            // Top part
            translate([0, 0, top_height + mount_thickness - tiny])
            polyRoundExtrude(
                top_points,
                mount_thickness + panel_thickness,
                0,
                0
            );
        }
        offset = (mount_thickness + panel_thickness) / 1.8;
        translate([offset, -2 * mount_thickness - panel_thickness + offset, top_height + 2 * mount_thickness + panel_thickness - m3x5_7[5] + tiny])
            heat_insert(m3x5_7, below = 5);
    }
}

module front_corner(support=true) {
    difference() {
        union() {
            // Base
            polyRoundExtrude([
                    base_points[0],
                    base_points[1],
                    base_points[2],
                    [base_points[2][0], base_points[0][1], 0],
                ], 
                mount_thickness,
                0,
                0
            );
            // Base notches
            translate([0, 0, mount_thickness - tiny])
            polyRoundExtrude(
                base_notch1,
                mount_thickness * 2,
                mount_chamfer,
                0
            );
            // Lower body, avoid frame
            polyRoundExtrude([
                    outline[0],
                    outline[1],
                    outline[2],
                    outline[3],
                    outline[4],
                    outline[5],
                    outline[6],
                    [outline[6][0], outline[10][1], mount_chamfer],
                    [outline[10][0], outline[10][1], mount_chamfer],
                    [outline[10][0], outline[0][1], mount_chamfer],

                    // outline[13],
                ],
                20 + mount_thickness,
                0,
                0
            )
            // Lower body, avoid frame
            polyRoundExtrude([
                    outline[0],
                    outline[1],
                    outline[2],
                    outline[3],
                    outline[4],
                    outline[5],
                    outline[6],
                    [outline[6][0], outline[10][1], mount_chamfer],
                    [outline[10][0], outline[10][1], mount_chamfer],
                    [outline[10][0], outline[0][1], mount_chamfer],

                    // outline[13],
                ],
                20 + mount_thickness,
                0,
                0
            );;
            // Main body
            translate([0, 0, 20 + mount_thickness - mount_chamfer])
            polyRoundExtrude([
                    outline[0],
                    outline[1],
                    outline[2],
                    outline[3],
                    outline[4],
                    outline[5],
                    outline[6],
                    outline[7],
                    outline[8],
                    outline[9],
                    [outline[10][0], outline[10][1], mount_chamfer],
                    [outline[11][0], outline[0][1], mount_chamfer],
                ],
                top_height - 20 + mount_chamfer,
                0,
                mount_chamfer
            );
            // Support
            if (support) {
                // translate([0, 0, -10])
                polyRoundExtrude([
                        [outline[7][0], outline[7][1], 0],
                        [outline[8][0], outline[8][1], 0],
                        [outline[9][0], outline[9][1], 0],
                        [outline[10][0], outline[10][1], 0],
                    ],
                    20 + mount_thickness - mount_chamfer - 0.4,
                    0,
                    0
                );
                for(i = [0, 1, 2, 3, 4, 5, 6, 7, 7]) {
                    translate([30 - i*2, -mount_chamfer, 20 + mount_thickness - mount_chamfer - 0.4])
                    cylinder(0.4, mount_chamfer, mount_chamfer / 3);
                    translate([30 - i * 2, -3*mount_chamfer, 20 + mount_thickness - mount_chamfer - 0.4])
                    cylinder(0.4, mount_chamfer, mount_chamfer / 3);
                }

            }
            // Top part
            translate([0, 0, top_height + mount_thickness - tiny])
            polyRoundExtrude([
                    top_points[0],
                    top_points[1],
                    top_points[2],
                    top_points[3],
                    top_points[4],
                    top_points[5],
                    top_points[6],
                    [top_points[6][0], top_points[0][1], mount_chamfer],

                ],
                mount_thickness + panel_thickness,
                0,
                0
            );
        }
        offset = (mount_thickness + panel_thickness) / 1.8;
        translate([offset, -2 * mount_thickness - panel_thickness + offset, top_height + 2 * mount_thickness + panel_thickness - m3x5_7[5] + tiny])
            heat_insert(m3x5_7, below = 5);
    }
}

module corner_cover_drill_guide() {
    difference() {
        // Base
        polyRoundExtrude([
                base_points[0],
                base_points[1],
                [base_points[5][0], base_points[1][1], mount_chamfer],
                base_points[5],

            ],
            mount_thickness * 2,
            0,
            0
        );
        // Drill hole
        translate([2 * mount_thickness + panel_thickness + corner_size /2, corner_size /2, -tiny])
            cylinder(r=3, h = 2 * (mount_thickness + tiny));
        // Top part
        translate([-tiny, -tiny, -tiny])
        polyRoundExtrude([
                [top_points[0][0], top_points[0][1], 0],
                [top_points[1][0], top_points[1][1] + 2 * tiny, 0],
                [top_points[2][0], top_points[2][1] + 2 * tiny, 0],
                [top_points[3][0], top_points[3][1], 0],
                [top_points[4][0], top_points[4][1], 0],
                [top_points[5][0], top_points[5][1], 0],
                [top_points[6][0], top_points[6][1], 0],
                [top_points[7][0], top_points[7][1], 0],
                [top_points[8][0] + 2 * tiny, top_points[8][1], 0],
                [top_points[9][0] + 2 * tiny, top_points[9][1], 0],
            ],
            panel_thickness,
            0,
            0
        );
        offset = (mount_thickness + panel_thickness) / 1.8;
        translate([offset, -2 * mount_thickness - panel_thickness + offset, mount_thickness])
            screw_hole("m3", length=mount_thickness-0.8, head="socket", counterbore = 0.8, anchor=BOTTOM);
    }
}

module corner_cover_w_notch() {
    difference() {
        union() {
            // Base
            polyRoundExtrude([
                    base_points[0],
                    base_points[1],
                    [base_points[5][0], base_points[1][1], mount_chamfer],
                    base_points[5],

                ],
                mount_thickness * 2,
                0,
                0
            );
            // Notch
            translate([2 * mount_thickness + panel_thickness + corner_size /2, corner_size /2, -panel_thickness + tiny])
                extrudeWithRadius(panel_thickness, 0.2)
                    circle(r=3.925);

        }
        translate([2 * mount_thickness + panel_thickness + corner_size /2, corner_size /2, -panel_thickness + 5])
        rotate([180, 0, 0])
            heat_insert(m3x5_7, below = 2);
        // Top part
        translate([-tiny, -tiny, -tiny])
        polyRoundExtrude([
                [top_points[0][0], top_points[0][1], 0],
                [top_points[1][0], top_points[1][1] + 2 * tiny, 0],
                [top_points[2][0], top_points[2][1] + 2 * tiny, 0],
                [top_points[3][0], top_points[3][1], 0],
                [top_points[4][0], top_points[4][1], 0],
                [top_points[5][0], top_points[5][1], 0],
                [top_points[6][0], top_points[6][1], 0],
                [top_points[7][0], top_points[7][1], 0],
                [top_points[8][0] + 2 * tiny, top_points[8][1], 0],
                [top_points[9][0] + 2 * tiny, top_points[9][1], 0],
            ],
            mount_thickness + 0.2,
            0,
            0
        );
        translate([-2*tiny, -2*tiny, -2*tiny])
        polyRoundExtrude([
                [top_points[2][0], top_points[2][1] + 3 * tiny, 0],
                [top_points[3][0], top_points[3][1], 0],
                [top_points[4][0], top_points[4][1], 0],
                [top_points[4][0], top_points[2][1] + 3 * tiny, 0],
            ],
            1.6,
            0,
            0
        );
        translate([-2*tiny, -2*tiny, -2*tiny])
        polyRoundExtrude([
                [top_points[6][0], top_points[6][1], 0],
                [top_points[7][0], top_points[7][1], 0],
                [top_points[8][0] + 3 * tiny, top_points[8][1], 0],
                [top_points[8][0] + 3 * tiny, top_points[6][1], 0],
            ],
            1.6,
            0,
            0
        );
        offset = (mount_thickness + panel_thickness) / 1.8;
        translate([offset, -2 * mount_thickness - panel_thickness + offset, mount_thickness * 2])
            screw_hole("m3", length=mount_thickness * 2, head="socket", counterbore = 0.8, anchor=TOP);
    }
}

module front_corner_cover_w_notch() {
    difference() {
        union() {
            // Base
            polyRoundExtrude([
                    base_points[0],
                    base_points[1],
                    [base_points[5][0], base_points[1][1], mount_chamfer],
                    outline[9],
                    [outline[10][0], outline[10][1], mount_chamfer],
                    [outline[10][0], base_points[0][1], mount_chamfer],

                ],
                mount_thickness * 2,
                0,
                0
            );
            // Notch
            translate([2 * mount_thickness + panel_thickness + corner_size /2, corner_size /2, -panel_thickness + tiny])
                extrudeWithRadius(panel_thickness, 0.2)
                    circle(r=3.925);
        }
        translate([2 * mount_thickness + panel_thickness + corner_size /2, corner_size /2, -panel_thickness + 5])
        rotate([180, 0, 0])
            heat_insert(m3x5_7, below = 2);
        // Top part
        translate([-tiny, -tiny, -tiny])
        polyRoundExtrude([
                [top_points[0][0], top_points[0][1], 0],
                [top_points[1][0], top_points[1][1] + 2 * tiny, 0],
                [top_points[2][0], top_points[2][1] + 2 * tiny, 0],
                [top_points[3][0], top_points[3][1], 0],
                [top_points[4][0], top_points[4][1], 0],
                [top_points[5][0], top_points[5][1], 0],
                [top_points[6][0] + 2 * mount_chamfer, top_points[6][1], 0],
                [top_points[7][0] + 2 * mount_chamfer, top_points[7][1], 0],
                [top_points[8][0] + 2 * tiny, top_points[8][1], 0],
                [top_points[9][0] + 2 * tiny, top_points[9][1], 0],
            ],
            mount_thickness + 0.2,
            0,
            0
        );
        translate([-2*tiny, -2*tiny, -2*tiny])
        polyRoundExtrude([
                [top_points[2][0], top_points[2][1] + 3 * tiny, 0],
                [top_points[3][0], top_points[3][1], 0],
                [top_points[4][0], top_points[4][1], 0],
                [top_points[4][0], top_points[2][1] + 3 * tiny, 0],
            ],
            1.6,
            0,
            0
        );
        offset = (mount_thickness + panel_thickness) / 1.8;
        translate([offset, -2 * mount_thickness - panel_thickness + offset, mount_thickness * 2])
            screw_hole("m3", length=mount_thickness * 2, head="socket", counterbore = 0.8, anchor=TOP);
    }
}

module corner_cover() {
    difference() {
        // Base
        polyRoundExtrude(
            base_points,
            mount_thickness * 2,
            0,
            0
        );
        // Top part
        translate([-tiny, -tiny, -tiny])
        polyRoundExtrude([
                [top_points[0][0], top_points[0][1], 0],
                [top_points[1][0], top_points[1][1] + 2 * tiny, 0],
                [top_points[2][0], top_points[2][1] + 2 * tiny, 0],
                [top_points[3][0], top_points[3][1], 0],
                [top_points[4][0], top_points[4][1], 0],
                [top_points[5][0], top_points[5][1], 0],
                [top_points[6][0], top_points[6][1], 0],
                [top_points[7][0], top_points[7][1], 0],
                [top_points[8][0] + 2 * tiny, top_points[8][1], 0],
                [top_points[9][0] + 2 * tiny, top_points[9][1], 0],
            ],
            panel_thickness,
            0,
            0
        );
        offset = (mount_thickness + panel_thickness) / 1.8;
        translate([offset, -2 * mount_thickness - panel_thickness + offset, mount_thickness])
            screw_hole("m3", length=mount_thickness-0.8, head="socket", counterbore = 0.8, anchor=BOTTOM);
    }
}

// corner();
// translate([0, 40, 0]) corner();
// mirror([1, 0, 0])
// front_corner();
// translate([0, 0, top_height + 5*mount_thickness]) corner_cover();
// translate([0, 0, top_height + 5*mount_thickness]) corner_cover_w_notch();
// corner_cover_drill_guide();