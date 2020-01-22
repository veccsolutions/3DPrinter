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
    rotate([90, 0, 180])
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
}

//bar
translate([0, 0, thickness])
{
    color([0,1,0])
    difference()
    {
        cube([barLength, thickness, barHeight], false);
        
        rotate([-90, 0, 0])
        {
            translate([20, -barHeight/2, 0])
            {
                fiveMMScrew();
            }
            translate([65, -barHeight/2, 0])
            {
                fiveMMScrew();
            }
        }
    }
}

union()
{
    //rail
    color([1,0,0])
    cube([barLength + bearingCarriageLength, railWidth, thickness]);

    //bearing bracket mount
    translate([barLength, 0, 0]){
        difference() {
            cube([bearingCarriageLength, thickness, bearingHeight], false);
            translate([thickness,0,0]){
                carriageHoles();
            }
            translate([bearingCarriageLength - thickness, 0, 0])
            {
                carriageHoles();
            }
        }
    }

    middle = (bearingCarriageLength / 2);
    offset = (bearingDiameter / 2);

    // bearing mount
    rotate([90,0,0])
    {
        translate([ barLength + bearingCarriageLength -middle - offset, 0])
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