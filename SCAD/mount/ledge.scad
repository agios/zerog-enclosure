use <../lib/Round-Anything/polyround.scad>

module ledge(distance, length,
             single_lip = false, // by default we make a two lip slot for the panel
             panel_thickness = 4.3, 
             mount_thickness = 4, 
             mount_chamfer = mount_chamfer) {
    base_size = single_lip ? distance : distance + mount_thickness + panel_thickness;
    translate([0, -base_size, 0])
    union() {
        if (!single_lip) {
            // inner lip
            translate([0, mount_thickness + panel_thickness, mount_thickness - tiny]) polyRoundExtrude(
                [
                    [0, 0, 0],
                    [length, 0, 0],
                    [length, mount_thickness, 0],
                    [0, mount_thickness, 0]
                ],
                mount_thickness,
                mount_chamfer,
                0
            );
        }
        // base
        polyRoundExtrude(
            [
                [0, 0, mount_chamfer],
                [length, 0, mount_chamfer],
                [length, base_size, 0],
                [0, base_size, 0]
            ],
            mount_thickness,
            0,
            mount_chamfer
        );
        // base rear rounding
        translate([0, base_size - mount_chamfer - tiny, mount_thickness])
        rotate([-90, 0, 0])
        polyRoundExtrude(
            [
                [0, 0, 0],
                [length, 0, 0],
                [length, mount_thickness, mount_chamfer],
                [0, mount_thickness, mount_chamfer]
            ],
            mount_thickness,
            mount_chamfer,
            0
        );        
        // outer lip
        translate([0, 0, mount_thickness - tiny]) polyRoundExtrude(
            [
                [0, 0, mount_chamfer],
                [length, 0, mount_chamfer],
                [length, mount_thickness, 0],
                [0, mount_thickness, 0]
            ],
            mount_thickness,
            mount_chamfer,
            0
        );
    }
}
