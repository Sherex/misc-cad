/* * * * * * *
 * NOT USED
 * Can be used for putting the sensor
 * inside the leg instead of below.
 */

// Render bug remover in preview
rbr = $preview ? 0.01 : 0;

/* [Render] */
// Number of fragments
$fn = 250; // [1:1:500]

/* [Bed Leg Dimensions] */
// Only used while designing
leg_height = 22; // actual 220mm
// Wall thickness
leg_wall_thickness = 1.5;
// Outer diameter
leg_od = 60;
leg_id = leg_od - leg_wall_thickness * 2;

leg_foot_inner_wall_height = 17.3;
leg_foot_wall_thickness = 4.5;
leg_foot_od = leg_id;
leg_foot_id = leg_foot_od - leg_foot_wall_thickness * 2;

leg_foot_bottom_od = 59;
leg_foot_bottom_height = 5;

module bed_leg () {
  difference() {
    cylinder(d=leg_od, h=leg_height, center=true);
    cylinder(d=leg_id, h=leg_height + rbr, center=true);
  }
}

module bed_leg_foot () {
  difference() {
    cylinder(d=leg_foot_od, h=leg_foot_inner_wall_height, center=true);
    cylinder(d=leg_foot_id, h=leg_foot_inner_wall_height + rbr, center=true);
  }
  translate ([0, 0, -leg_foot_inner_wall_height / 2 - leg_foot_bottom_height / 2])
    cylinder(d=leg_foot_bottom_od, h=leg_foot_bottom_height, center=true);
}
