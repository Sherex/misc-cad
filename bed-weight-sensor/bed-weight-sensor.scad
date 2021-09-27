// Render bug remover in preview
rbr = $preview ? 0.01 : 0;

/* [Render] */
// Number of fragments
$fn = 250; // [1:1:500]

/* [Dimensions] */
// The width in the X direction
total_width = 34;
// The length in the Y direction
total_length = 34;
// The height in the Z direction
outer_ring_height = 2.4;
// The width in the Y (and X) direction
outer_ring_width = 2.9;
outer_ring_corner_radius = 9;

// The width in the X direction
inner_space_width = 28;
// The length in the Y direction
inner_space_length = 23.3;
inner_space_corner_radius = 5.5;

sensor_height_bottom_to_tip = 7.8;
sensor_movement_tolerance = 2;
sensor_holder_indent = sensor_height_bottom_to_tip - sensor_movement_tolerance;

/* [Bed foot dimensions] */
leg_foot_bottom_od = 59;

module curved_cube (size, radius) {
  minkowski() {
    cylinder_height = 1;
    cube(size=[size[0] - radius * 2, size[1] - radius * 2, size[2] - cylinder_height], center=true);
    cylinder(r=radius, h=cylinder_height, center=true);
  }
}

module outer_ring_shape (height) {
  curved_cube([total_width, total_length, (height ? height : outer_ring_height) - rbr], outer_ring_corner_radius);
}

module inner_space_shape_at_pos () {
  length_of_bottom_extra_metal = total_length - outer_ring_width * 2 - inner_space_length;
  translate([0, length_of_bottom_extra_metal / 2, 0])
    curved_cube([inner_space_width, inner_space_length, outer_ring_height], inner_space_corner_radius);
}

module weight_sensor_diff_shape (height) {
  outer_ring_shape(height);
  translate([0, 0, (-height - outer_ring_height) / 2 + rbr]) inner_space_shape_at_pos();
}

// difference() {
//   outer_ring_shape();
//   inner_space_shape_at_pos();
// }

module sensor_holder (height) {
  difference() {
    // The 0.05 is to set the cylinder height juuust below the top. Same as the rbr variable, but enabled in render too.
    cylinder(d=leg_foot_bottom_od, h=height - 0.05, center=true);
    translate([0, 0, (height - sensor_holder_indent) / 2]) weight_sensor_diff_shape(sensor_holder_indent);
  }
}

sensor_holder(15);