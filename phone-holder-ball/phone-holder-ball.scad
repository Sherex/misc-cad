// Render bug remover in preview
rbr = 0.01;

/* [Render] */
// Number of fragments
$fn = 250; // [1:1:500]

/* [Dimensions] */
ball_diameter = 13.8;
screw_thread_diameter = 3.8 + 0.8; // + calibration
screw_head_diameter = 6.8 + 0.9; // Hex shaped + calibration
screw_head_diameter_width_ratio = 0.5773529411764706;
screw_head_width = screw_head_diameter * screw_head_diameter_width_ratio;
screw_head_height = 8;
screw_height = ball_diameter - screw_head_height;

stem_diameter = 7;
stem_height = 5;
stem_height_from_middle = stem_height + ball_diameter / 2;

module hex_screw () {
  for (rotation_degrees=[0:120:360]) {
    rotate([0, 0, rotation_degrees]) {
      cube(size=[screw_head_diameter, screw_head_width, screw_head_height], center=true);
    }
  }
  translate([0, 0, -(screw_head_height / 2 + screw_height / 2 + stem_height / 2)]) {
    cylinder(d=screw_thread_diameter, h=screw_height + stem_height + rbr, center=true);
  }
}

difference() {
  sphere(d=ball_diameter);
  translate([0, 0, ball_diameter / 2 - screw_head_height / 2]) {
    hex_screw();
  }
}

