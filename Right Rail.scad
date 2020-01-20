barHeight = 20;
barLength = 75;
thickness = 5;
bearingHeight = 50;
bearingDiameter = 21;
bearingCarriageLength=50;
bearingCarriageHeight = bearingHeight;

module cylinder_outer(height,radius,fn)
{
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}

module fiveMMScrew()
{
   cylinder_outer(thickness+.1, 5.1/2, 100);
}

module threeMMScrew()
{
    cylinder_outer(thickness+.1, 3.2/2, 100);
}

module carriageHoles()
{
    translate([0, bearingCarriageHeight / 4, 0]) {
        threeMMScrew();
        translate([0,0,3]) {
            cylinder_outer(thickness+.1, 6/2, 100);
        }
    }
    translate([0, bearingCarriageHeight / 4 * 2, 0]) {
        threeMMScrew();
    }
    translate([0, bearingCarriageHeight / 4 * 3, 0]) {
        threeMMScrew();
    }
}

//bar
translate([0, thickness, 0])
{
    difference() {
        cube([barLength, barHeight, thickness], false);
        translate([10, 10,0]){
            fiveMMScrew();
        }
        translate([65, 10, 0]) {
            fiveMMScrew();
        }
    }
}

//rail
cube([barLength + bearingCarriageLength, thickness, thickness * 3]);

//bearing bracket mount
translate([barLength, 0, 0]){
    difference() {
        cube([bearingCarriageLength, 50, 5], false);
        translate([thickness,0,0]){
            carriageHoles();
        }
        translate([bearingCarriageLength - thickness, 0, 0])
        {
            carriageHoles();
        }
    }
}