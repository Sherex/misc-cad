// Render bug remover in preview
rbr = $preview ? 0.01 : 0;

/* [Render] */
// Number of fragments
$fn = 250; // [1:1:500]

/* [Nitty gritty dimensions] */
plate_thickness = 2;
plate_width = 14;
plate_in_frame_length = 15;
frame_start_to_hole = 9;
screw_diameter = 3;

body_height = 6.6;
body_width = plate_width;
body_corner_to_frame_start = 23.3;
body_radius = 31;
body_corner_offset = 24.4;
body_corner_width = 3;

module frame_plate() {
  difference() {
    cube([plate_in_frame_length, plate_width, plate_thickness]);
    translate([frame_start_to_hole, plate_width / 2, 0 - rbr / 2]) {
      cylinder(d=screw_diameter, plate_thickness + rbr);
    }
  }
}

module body() {
  cube([body_corner_to_frame_start, plate_width, body_height]);
  translate([body_corner_to_frame_start, 0, 0]) {
    frame_plate();
  }
}

module body_corner() {
  body();
  rotate([0, 90, 0]) {
    mirror([0, 0, 1]) {
      body();
    }
  }
}

rotate([90, 0, 0]) {
  // Curves body corner pieces
  intersection() {
    body_corner();
    translate([body_corner_offset, 0, -body_corner_offset]) {
      rotate([270, 0, 0]) {
        cylinder(r=body_radius, h=body_width);
      }
    }
  }

  // Corner connector
  intersection() {
    translate([-body_height, 0, -body_corner_to_frame_start]) {
      cube([body_corner_to_frame_start + body_height, body_width, body_corner_to_frame_start + body_height]);
    }
    translate([body_corner_offset, 0, -body_corner_offset]) {
      rotate([270, 0, 0]) {
        difference() {
          translate([0, 0, rbr]) cylinder(r=body_radius, h=body_width);
          cylinder(r=body_radius - body_corner_width, h=body_width + rbr);
        }
      }
    }
  }
}