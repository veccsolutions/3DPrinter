barHeight = 20;
barLength = 75;
thickness = 5;
bearingHeight = 50;
bearingDiameter = 21.15;
bearingCarriageLength=50;
bearingCarriageHeight = bearingHeight;
railWidth = 20 + thickness;

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
    cylinder_outer(thickness+.1, 3.4/2, 100);
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

union()
{
    rotate([90, 0, 0])
    {
        //bar
        color([0,1,0])
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
        color([1,0,0])
        cube([barLength + bearingCarriageLength, thickness, railWidth]);

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
    }

    middle = (bearingCarriageLength / 2);
    offset = (bearingDiameter / 2);

    // bearing mount
    translate([ barLength + bearingCarriageLength - middle + offset, 0, 0])
    {
        rotate([90,0,180])
        {
            difference()
            {
                cube([bearingDiameter, bearingHeight, bearingDiameter / 2 - 5]);
                translate([bearingDiameter / 2, 0, bearingDiameter / 2])
                {
                    rotate([-90,0,0])
                    {
                        cylinder_outer(bearingHeight, bearingDiameter / 2, 100);
                    }
                }
            }
        }
    }
}