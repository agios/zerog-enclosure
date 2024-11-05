include <../config.scad>
include <../lib/helpers.scad>

module cover_side(){
  difference() {
    cube([top_height + panel_thickness,
          frame_depth + panel_rear_distance + panel_front_distance - 4 * mount_thickness,
          panel_thickness]);
    translate([-tiny, 2.975*mount_thickness, -tiny])
    cube([mount_thickness * 2, mount_thickness * 1.05, panel_thickness + 2 * tiny]);
    translate([-tiny, frame_depth + panel_rear_distance + panel_front_distance - 8.025 * mount_thickness, -tiny])
    cube([mount_thickness * 2, mount_thickness * 1.05, panel_thickness + 2 * tiny]);
    // handle holes
   translate([top_height + panel_thickness - large_handle_width / 2 - mount_thickness, (frame_depth + panel_rear_distance + panel_front_distance - 4 * mount_thickness - 95) / 2, -tiny])
    rotate([0, 0, 90])
      for(i=[0, 95]) translate([i, 0, 0]) screw_hole("M5,6", length=panel_thickness + 2*tiny, anchor=BOTTOM);
  }
}