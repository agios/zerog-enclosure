$fa = $preview ? 9 : 1;
$fs = $preview ? 1 : 0.1;

include <../config.scad>
include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/structs.scad>
include <../lib/BOSL2/screws.scad>
use <../lib/Round-Anything/polyround.scad>
include <../lib/helpers.scad>
include <ledge.scad>

// top and bottom ledges can be:
// none, slot, latch (single that grabs panel), face (resting plate for panel)
// they can also have additional parameters to adjust left or right length, eg:
// supported params are:
// l: lengthen or shorten ledge on left side
// r: lengthen or shorten ledge on right side
// d: distance of panel, valid for slot/face
// top = "slot,l+10,r-5"
module mount(length,
             top = "none",
             bottom = "none",
             panel_thickness = panel_thickness, 
             mount_thickness = 4, 
             mount_chamfer = 1,
             add_screw_supports = true,
             counterbore = 1,
             add_zip_mounts = false) {
    top_params = ledge_params(top);
    bottom_params = ledge_params(bottom);
    top_latch = struct_val(top_params, "type") == "latch"; 
    bottom_latch = struct_val(bottom_params, "type") == "latch"; 
    base_top_offset = top_latch ? mount_thickness : 0;
    base_bottom_offset = bottom_latch ? mount_thickness : 0;
    screw_spec = (top_latch || bottom_latch) ? "M3" : "M5";
    head_space = struct_val(screw_info(screw_spec,head="socket"), "head_size") / 2;
    top_thickness = min(mount_thickness, 10 - base_top_offset - head_space);
    bottom_thickness = min(mount_thickness, 10 - base_bottom_offset - head_space);
    difference() {
        union() {
            //base
            polyRoundExtrude(
                [
                    [0, base_bottom_offset, bottom_latch ? 0 : mount_chamfer],
                    [0, 20 - base_top_offset, top_latch ? 0 : mount_chamfer],
                    [length, 20 - base_top_offset, top_latch ? 0 : mount_chamfer],
                    [length, base_bottom_offset, bottom_latch ? 0 : mount_chamfer],
                ],
                mount_thickness,
                mount_chamfer,
                0
            );
            if (struct_val(top_params, "type") != "none")
                place_ledge("top", length, top_params, base_top_offset, top_thickness, mount_chamfer, panel_thickness);
            if (struct_val(bottom_params, "type") != "none")
                place_ledge("bottom", length, bottom_params, base_bottom_offset, bottom_thickness, mount_chamfer, panel_thickness);
            if (add_screw_supports)
                screw_supports(length, screw_spec);
        }
        plate_holes(length, mount_thickness, counterbore=counterbore, screw_spec=screw_spec);
        if(add_zip_mounts) {
            zip_mounts(length, "top",  struct_val(top_params, "type"), base_top_offset, mount_thickness, top_thickness, mount_chamfer);
            zip_mounts(length, "bottom", struct_val(bottom_params, "type"), base_bottom_offset, mount_thickness, bottom_thickness, mount_chamfer);
        }
    }
}

function ledge_params(str) = 
    let (spec = str_split(str, ","))
    let (defaults = [["type", spec[0]], ["l", 0], ["r", 0]])
    struct_set(defaults, [ for (s = slice(spec, 1, -1)) each param(s) ]);

function param(str) =
    let (plus_i = str_find(str, "+"))
    let (minus_i = str_find(str, "-"))
    (!is_undef(plus_i)) ? [substr(str, 0, plus_i), parse_float(substr(str, plus_i, len(str)-plus_i))] :
    (!is_undef(minus_i)) ? [substr(str, 0, minus_i), parse_float(substr(str, minus_i, len(str)-minus_i))] :
    let (args = str_split(str, "="))
    [args[0], parse_float(args[1])];

function ledge_offset(type, offset, mount_thickness, mount_chamfer) = 
    (type == "latch") ? offset + mount_thickness :
                        offset + mount_thickness + mount_chamfer;

function ledge_y_position(position, type, offset, mount_thickness, mount_chamfer) = 
    let (ledge_offset = ledge_offset(type, offset, mount_thickness, mount_chamfer))
    (position == "top") ? 20 - ledge_offset : ledge_offset;

module place_ledge(position, length, params, offset, mount_thickness, mount_chamfer, panel_thickness) {
    type = struct_val(params, "type");
    single_lip = (type == "latch" || type == "face");
    d = (type == "latch") ? panel_thickness : struct_val(params, "d") - mount_thickness;
    l = struct_val(params, "l");
    r = struct_val(params, "r");
    total_length = length + l + r;
    translate([-l, ledge_y_position(position, type, offset, mount_thickness, mount_chamfer), mount_thickness - mount_chamfer])
    mirror([0, (position == "top") ? 0 : 1, 0])
    rotate([-90,0,0])
    ledge(d + tiny + mount_chamfer, total_length,
          single_lip = single_lip,
          panel_thickness = panel_thickness + panel_ledge_slop, 
          mount_thickness = mount_thickness,
          mount_chamfer = mount_chamfer);
}

function screw_steps(l) = [10:(l - 20) / round(l / 80):l];
function zip_steps(l) = [3:(l - 10) / (round(l / 80) + 1):l];

module plate_holes(l, mount_thickness, counterbore=1, screw_spec = "M3") {
    for(i = screw_steps(l)) {
        translate([i, 10, -tiny])
        screw_hole(screw_spec, counterbore=20, length=mount_thickness-counterbore, head="socket", anchor=BOTTOM);
    }
}

module screw_supports(l, screw_spec = "M3") {
    for(i = screw_steps(l)) {
        translate([i, 10, -tiny])
        screw_support(screw_spec);
    }
}

module zip_mounts(l, position, type, offset, base_mount_thickness, mount_thickness, mount_chamfer) {
    angle = 90;
    radius = 1.5;
    angle2 = 180;
    radius2 = 2;
    step = (l - 10) / (round(l / 80) + 1);
    hole = [1.7, 4];
    for(i = zip_steps(l))
    // for(i = [0:step:l])
        translate([i, 0, 0]) 
            zip_mount(position, type, offset, base_mount_thickness, mount_thickness, mount_chamfer);
}

module zip_mount(position, type, offset, base_mount_thickness, mount_thickness, mount_chamfer) {
    angle = 90;
    radius = 1.5;
    angle2 = 180;
    radius2 = 2;
    hole = [1.7, 4];
    y_pos = ledge_offset(type, offset, mount_thickness, mount_chamfer) +
            (mount_thickness - hole.x) / 2 - mount_thickness;
    union() {
        translate([0, (position == "top") ? 20 : 0, 0])
        mirror([0, (position == "top") ? 1 : 0, 0])
        if (type == "latch") {
            // hole from top
            translate([hole.y, y_pos, base_mount_thickness - sin(5) * (radius + hole.x) - tiny])
            rotate([0, -5, 90]) 
            linear_extrude(base_mount_thickness + mount_thickness + tiny)
            square(hole);
            // curve
            radius = (base_mount_thickness - hole.x / 2) / 2;
            translate([0, y_pos + radius + hole.x, base_mount_thickness])
            rotate([0, 90, 0])
            rotate_extrude(angle = -85) translate([radius, 0, 0]) square(hole);
            // path to halfway
            translate([hole.y, y_pos + hole.x + radius, base_mount_thickness - radius])
            rotate([-90, 90, 0]) 
            linear_extrude(10 - y_pos - radius - hole.x + tiny)
            square(hole);
        } else if (type == "slot") {
            radius = (base_mount_thickness - hole.x / 2) / 2;
            // curve
            translate([0, y_pos + radius + hole.x - sin(5), base_mount_thickness + cos(5) - tiny])
            rotate([180, 0, 0])
            rotate([0, 90, 0])
            rotate_extrude(angle = 95) translate([radius, 0, 0]) square(hole);
            // extend in ledge
            translate([hole.y, y_pos, base_mount_thickness - sin(5) * (radius + hole.x) - tiny])
            rotate([0, -5, 90]) 
            linear_extrude(1)
            square(hole);
            // curve
            translate([0, y_pos + radius + hole.x, base_mount_thickness])
            rotate([0, 90, 0])
            rotate_extrude(angle = -85) translate([radius, 0, 0]) square(hole);
            // path to halfway
            translate([hole.y, y_pos + hole.x + radius, base_mount_thickness - radius])
            rotate([-90, 90, 0]) 
            linear_extrude(10 - y_pos - radius - hole.x + tiny)
            square(hole);
        }
    }
}
