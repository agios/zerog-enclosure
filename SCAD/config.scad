$fa = $preview ? 9 : 1;
$fs = $preview ? 1 : 0.1;

// Strength
mount_thickness = 4;        // Overall wall thickness
mount_chamfer = 1;          // Radius of chamfers
bottom_ledge_thickness = 3; // Thickness of ledge that anchors lower panels

// Panels
panel_thickness = 4.3;    // Panel thickness + clearance, 4.3 worked well for 4mm aluminum composite panels
panel_ledge_slop = 0.4;   // Amount of overlap of clipped on panels with extrusions, mounts need to be shorter by this much 
panel_front_distance = 6; // Clearance of panel from machine front
panel_side_distance = 8;  // Clearance of panels from machine sides
panel_rear_distance = 37; // Clearance of panel from machine rear

// Top cover
corner_size = 20;         // Size of top cover corner attachement pieces 
top_height = 250;         // Height of top cover

// Frame dimensions
frame_width = 410;
frame_depth = 410;
frame_height = 440;
extrusion_size = 20;

// Door
door_clearance = 2;
door_w = frame_width - 4 * extrusion_size - door_clearance;
door_h = frame_height - 2 * extrusion_size - door_clearance;
door_handle_d = 13;

// Top handle
large_handle_length = 138;
large_handle_width = 20.7;
large_handle_hole_d = 115;

// Door handle
small_handle_length = 102;
small_handle_width = 15.3;
small_handle_hole_d = 85;

// Hinges
mini_hinge_d = 17;
super_mini_hinge_d = 13.13;

// Panel cutting calculations
// top_side = y_machine_width(410) + panel_rear_distance + panel_front_distance - 4 * mount_thickness;
//          = 436
// top_rear = x_machine_width(410) + 2 * panel_side_distance - 4 * mount_thickness;
//          = 410
// top_depth = y_machine_width(410) + panel_rear_distance + panel_front_distance;
//           = 453 / 445
// top_width = x_machine_width + 2 * panel_side_distance;
//           = 418

// Various
tiny = 0.005; // tiny value is used to stop artifacts from planes lining up perfectly

module plastic() {
  color("DarkOrange", 0.7) children();
}

module acrylic() {
  %color("LightCyan", 0.5) children();
  // %color([0.5, 0.5, 0.5, 0.5]) children();
}

module composite() {
  %color("Black", 0.8) children();
}
