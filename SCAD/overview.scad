include <config.scad>
include <lib/helpers.scad>
include <top/corner.scad>
include <mount/mount.scad>
include <top/cover_front.scad> 
include <top/cover_rear.scad> 
include <top/cover_side.scad> 
include <top/cover_top.scad>
include <top/handle_corner_mount.scad>
include <bottom/door.scad>
include <door_magnet.scad>
include <bottom/handle_back_magnet.scad>

translate([frame_width / 2, frame_depth / 2, -443.5])
%color("DimGray", 0.4)
union() {
  import("lib/mercury_235_assembly.stl", convexity=20);
  translate([0, 6.85, 27.5]) 
  import("lib/Hydra_5pro.stl", convexity=20);
}

// corners
translate([-mount_thickness - panel_thickness - panel_side_distance, 
          mount_thickness - panel_front_distance, 0])
plastic() front_corner(support = false);

translate([frame_width + panel_side_distance + mount_thickness + panel_thickness,
           mount_thickness - panel_front_distance, 0])
mirror([1, 0, 0]) plastic() front_corner(support = false);

translate([-mount_thickness - panel_thickness - panel_side_distance,
           frame_depth + panel_rear_distance - mount_thickness, 0])
mirror([0, 1, 0])
plastic() corner();

translate([frame_width + panel_side_distance + mount_thickness + panel_thickness,
           frame_depth + panel_rear_distance - mount_thickness, 0])
rotate([0, 0, 180])
plastic() corner();

// top
translate([-panel_side_distance, -panel_front_distance, top_height + panel_thickness])
composite()
cover_top();

// front top
translate([0.5, -panel_front_distance - mount_thickness, top_height + panel_thickness + mount_thickness])
acrylic()
rotate([-90, 0, 0])
cover_front();

// corner covers
translate([-panel_side_distance - mount_thickness - panel_thickness,
           -mount_thickness,
           top_height + panel_thickness + mount_thickness])
plastic() front_corner_cover_w_notch();

translate([frame_width + panel_side_distance + mount_thickness + panel_thickness,
           -mount_thickness,
           top_height + panel_thickness + mount_thickness])
mirror([1, 0, 0])
plastic() front_corner_cover_w_notch();

translate([- mount_thickness,
           frame_depth + panel_rear_distance + panel_thickness + mount_thickness,
           top_height + panel_thickness + mount_thickness])
rotate([0, 0, -90])
plastic() corner_cover_w_notch();

translate([frame_width + panel_side_distance + mount_thickness + panel_thickness,
           frame_depth + panel_rear_distance - mount_thickness,
           top_height + panel_thickness + mount_thickness])
rotate([0, 0, 180])
plastic() corner_cover_w_notch();

// sides
translate([-panel_side_distance, 0, mount_thickness])
rotate([0, -90, 0])
acrylic()
cover_side();

translate([frame_width + panel_side_distance + panel_thickness, 0, mount_thickness])
rotate([0, -90, 0])
acrylic()
cover_side();

//rear
translate([frame_width + panel_side_distance - 2 * mount_thickness,
           frame_depth + panel_rear_distance + panel_thickness, mount_thickness])
rotate([0, -90, 90])
acrylic()
cover_rear();

// handles
plastic()
translate([-panel_side_distance + large_handle_width,
           (frame_depth + panel_rear_distance + panel_front_distance - 4 * mount_thickness - large_handle_length) / 2,
           top_height + panel_thickness])
rotate([0, 180, 0])
handle_corner_mount();

plastic()
// translate([frame_width - 55.4, 0, -361])
translate([(frame_width - large_handle_length) / 2, 0, large_handle_width])
rotate([180, 0, 0])
  import("lib/Handle_LARGE.stl", convexity=10);

// front mount
plastic()
translate([40, 0, -20 + mount_thickness])
rotate([90, 0, 0])
mount(330, top = "face,d=8");

// front door
translate([2 * extrusion_size + door_clearance / 2, 2 * panel_thickness, - extrusion_size + mount_thickness])
acrylic()
rotate([-90, 0, 0])
door();

plastic()
translate([frame_width - 55.4, 0, -56.6])
  import("lib/PIP super mini gear hinge v3 extended.stl", convexity=20);
plastic()
translate([frame_width - 55.4, 0, -209])
  import("lib/PIP super mini gear hinge v3 extended.stl", convexity=20);
plastic()
translate([frame_width - 55.4, 0, -361])
  import("lib/PIP super mini gear hinge v3 extended.stl", convexity=20);
plastic()
translate([61.68, panel_front_distance, -164.08])
rotate([0, 90, 180])
  import("lib/Handle_SMALL.stl", convexity=20);
plastic()
translate([48, panel_front_distance + panel_thickness + 8, -266.08])
rotate([90, 0, 0])
handle_back_magnet();
plastic()
translate([40, 7, -266.08])
rotate([90, 0, 90])
door_stop();