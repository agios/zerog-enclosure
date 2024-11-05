include <config.scad>
include <lib/helpers.scad>
// use <lib/Round-Anything/polyround.scad>

w = 44;
h = 33;
a = 14;
m = 10;
s = 3;
th = h + a;
tw = w + a;

standoffs = [
    [a / 2, a / 2],
    [a / 2, a / 2 + w],
    [a / 2 + h, a / 2],
    [a / 2 + h, a / 2 + w],
];
 
union() {
    difference() {
        screw_holes(m5, [
                [h - m / 2 + a, -m / 2],
                [h - m / 2 + a, w + a + m / 2],
            ], counterbore = 0.6) {
            polyRoundExtrude(
                [
                    [0, 0, mount_chamfer],
                    [h - m + a, 0, mount_chamfer],
                    [h - m + a, -m, mount_chamfer],
                    [h + a, -m, mount_chamfer],
                    [h + a, w + a + m, mount_chamfer],
                    [h + a - m, w + a + m, mount_chamfer],
                    [h + a - m, w + a, mount_chamfer],
                    [0, w + a, mount_chamfer],
                ],
                mount_thickness,
                mount_chamfer,
                0
            );
        }
        for (s = standoffs)
            translate([s.x, s.y, -tiny])
                cylinder(r = 2.5, h = mount_thickness + 2 * tiny);
        translate([0, 0, -tiny])polyRoundExtrude(
            [
                [s, tw / 2 + s, mount_chamfer * 2],
                [th / 2 - s, tw / 2 + s, mount_chamfer * 2],
                [th / 2 - s, tw - s, mount_chamfer * 2],
            ],
            mount_thickness + 2 * tiny,
            -mount_chamfer,
            0
        );
        translate([0, 0, -tiny])polyRoundExtrude(
            [
                [s, tw / 2 - s, mount_chamfer * 2],
                [th / 2 - s, tw / 2 - s, mount_chamfer * 2],
                [th / 2 - s, s, mount_chamfer * 2],
            ],
            mount_thickness + 2 * tiny,
            -mount_chamfer,
            0
        );
        translate([0, 0, -tiny])polyRoundExtrude(
            [
                [th - s, tw / 2 - s, mount_chamfer * 2],
                [th / 2 + s, tw / 2 - s, mount_chamfer * 2],
                [th / 2 + s, s, mount_chamfer * 2],
            ],
            mount_thickness + 2 * tiny,
            -mount_chamfer,
            0
        );
        translate([0, 0, -tiny])polyRoundExtrude(
            [
                [th - s, tw / 2 + s, mount_chamfer * 2],
                [th / 2 + s, tw / 2 + s, mount_chamfer * 2],
                [th / 2 + s, tw - s, mount_chamfer * 2],
            ],
            mount_thickness + 2 * tiny,
            -mount_chamfer,
            0
        );
    }
    for (s = standoffs)
        translate([s.x, s.y, 0])
            standoff(mount_thickness + 4, m3x3);
}
