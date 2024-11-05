include <../config.scad>

module cover_rear(){
  difference() {
    cube([top_height + panel_thickness,
          frame_width + 2 * panel_side_distance - 4 * mount_thickness,
          panel_thickness]);
    translate([-tiny, 2.975*mount_thickness, -tiny])
    cube([mount_thickness * 2, mount_thickness * 1.05, panel_thickness + 2 * tiny]);
    translate([-tiny, frame_width + 2 * panel_side_distance - 8.025 * mount_thickness, -tiny])
    cube([mount_thickness * 2, mount_thickness * 1.05, panel_thickness + 2 * tiny]);
  }
}