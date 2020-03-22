yDepth = 9;
zDepth = 1.6;

difference() {
    import("pi_cam_knob_v2_fixed.stl", convexity=3);
    translate([-4.5, yDepth, zDepth])
        cube([2, 3, 10]);
    translate([17.5, yDepth, zDepth])
        cube([2, 3, 10]);
}