include <../config.scad>
include <BOSL2/std.scad>
include <BOSL2/screws.scad>
use <Round-Anything/polyround.scad>

// Screws [d, head]
m3 = [3.2, 5.5];
m5 = [5.2, 8.5];

// Heat inserts [d1, d2, d3, l1, l2, l, screw]
m3x3     = [4.6, 4.4, 4.0, 0.5, 2.3, 3, m3];
m3x5_7   = [4.6, 4.4, 4.0, 1.7, 4.3, 5.7, m3];

// creates a support behind the screw that fits in the groove of a 2020 v-slot
module screw_support(screw_spec = "M3") {
    points = [
      [  0,    0,    0 ],  //0
      [ 9.6,   0,    0 ],  //1
      [ 9.6, 9.6,    0 ],  //2
      [   0, 9.6,    0 ],  //3
      [ 1.2, 1.2,  1.2 ],  //4
      [ 8.4, 1.2,  1.2 ],  //5
      [ 8.4, 8.4,  1.2 ],  //6
      [ 1.2, 8.4,  1.2 ]]; //7
      
    faces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]]; // left
      
    translate([-4.8, -4.8, 0]) mirror([0, 0, 1]) 
        difference() {
            polyhedron(points, faces);
            translate([4.8, 4.8, -tiny])
                screw_hole(screw_spec, length=1.8 + 2 * tiny, anchor=BOTTOM);
        }
            
}

module mini_hinge_holes() {
    for(i=[0, mini_hinge_d, 2*mini_hinge_d]) translate([i, 0, 0]) screw_hole("M4,6", length=panel_thickness + 2*tiny, anchor=BOTTOM);
}

module super_mini_hinge_holes() {
    for(i=[0, super_mini_hinge_d, 2*super_mini_hinge_d]) translate([i, 0, 0]) screw_hole("M3,6", length=panel_thickness + 2*tiny, anchor=BOTTOM);
}

module small_handle_holes() {
      for(i=[0, small_handle_hole_d]) translate([i, 0, 0]) screw_hole("M4,6", length=panel_thickness + 2*tiny, anchor=BOTTOM);
}

module large_handle_holes() {
      for(i=[0, large_handle_hole_d]) translate([i, 0, 0]) screw_hole("M5,6", length=panel_thickness + 2*tiny, anchor=BOTTOM);
}

module heat_insert(m, below = 0) {
    union() {
        lip = 0.2;
        translate([0, 0, m[5] - lip]) cylinder(lip, m[0] / 2, m[0] / 2 + lip);
        translate([0, 0, m[5] - m[3]]) cylinder(r=m[0] / 2, h=m[3]);
        translate([0, 0, m[5] - m[4]]) cylinder(r=m[1] / 2, h=m[4]);
        cylinder(r=m[2] / 2, h=m[5]);
        if (below > 0)
            translate([0, 0, tiny - below])
                cylinder(r=m[6].x / 2, h=below);

    }
}

module standoff(h, m) {
    w = m[0] + 4;
    difference() {
        cylinder(r = w / 2, h = h);
        if (m[6]) { // heat insert
            translate([0, 0, -tiny])
                cylinder(r = m[6][0] / 2, h = h + 2 * tiny);
            translate([0, 0, h - m[5] + tiny])
                heat_insert(m);
        } else
            translate([0, 0, tiny]) cylinder(r = m[0], h = h / 2 + 2 * tiny);
    }
}

// module cut_heat_insert_holes(m, holes) {
//     difference() {
//         children();
//         for (hole = holes) {
//             translate([hole.x, hole.y, mount_thickness - m[5] + tiny])
//                 heat_insert_hole(m);
//             translate([hole.x, hole.y, -tiny])
//                 cylinder(r = m[6][0] / 2, h = mount_thickness + 2 * tiny);
//         }
//     }
// }

