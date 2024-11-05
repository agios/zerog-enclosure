include <mount.scad>

translate([40, -30, 2.5]) rotate([0, -90, 0])
// import("RearSplitloomArm_V1-1-0.stl");
difference() {
      mount(60,
            top = str("slot,d=", panel_rear_distance),
            bottom="latch",
            add_zip_mounts = true);
      translate([19.5, 0, -tiny]) polyRoundExtrude(
            [
                [0, -mount_thickness, mount_chamfer],
                [21, -mount_thickness, mount_chamfer],
                [21, 20 + mount_thickness, 0],
                [0, 20 + mount_thickness, 0]
            ],
            9,
            mount_chamfer,
            0
        ); 
      resize([14, 20, 10]) translate([30, 12, 11]) rotate([90, 0, 0]) cylinder(10, 7, 7);
}