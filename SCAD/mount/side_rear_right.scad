include <mount.scad>

extend_rear = panel_rear_distance - corner_size - mount_thickness;
mount(70,
      top = str("slot,d=8,r+", extend_rear),
      bottom = "latch,r-15");
