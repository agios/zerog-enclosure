color("DimGray") 
union() {
  difference() {
    import("lib/mercury_235_assembly.stl", convexity=80);
    // translate([-150, -160, -20]) cube([300, 351.8, 400]);
    // translate([-150, 130, -20]) cube([300, 61.8, 470]);
  };
  translate([0, 6.85, 27.5]) 
  import("lib/Hydra_5pro.stl", convexity=20);
}
