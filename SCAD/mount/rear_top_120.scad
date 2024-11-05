include <mount.scad>

mount(120,
      top = str("slot,d=", panel_rear_distance),
      bottom = "latch",
      add_zip_mounts = true);
