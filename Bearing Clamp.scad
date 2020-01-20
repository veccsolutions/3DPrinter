thickness = 5;
bearingHeight = 50;
bearingDiameter = 21;
bearingCarriageLength=50;
bearingCarriageHeight = bearingHeight;
footWidth = (bearingCarriageLength - bearingDiameter) / 2 - 1;
clampHeight = bearingDiameter - thickness - 1;

module cylinder_outer(height,radius,fn)
{
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}

module threeMMScrew()
{
    cylinder_outer(thickness+.1, 3.2/2, 100);
}

module carriageHoles()
{
    translate([0, bearingCarriageHeight / 4, 0]) {
        threeMMScrew();
    }
    translate([0, bearingCarriageHeight / 4 * 2, 0]) {
        threeMMScrew();
    }
    translate([0, bearingCarriageHeight / 4 * 3, 0]) {
        threeMMScrew();
    }
}

module feet()
{
    
    color([1,0,0])
    translate ([0, 0, 0])
    {
        difference()
        {
            cube([footWidth, bearingHeight, thickness]);
            translate([thickness,0,0]){
                carriageHoles();
            }
        }
    }
    
    color([1,0,0])
    translate([footWidth + bearingDiameter + 2, 0, 0])
    {
        difference()
        {
            cube([footWidth, bearingHeight, thickness]);
            translate([footWidth - thickness,0,0]){
                carriageHoles();
            }
        }
    }
}

module sidewalls()
{
    color([0,1,0])
    translate([footWidth - thickness, 0, thickness])
    {
        cube([thickness, bearingHeight, clampHeight]);
    }
    color([0,1,0])
        translate([footWidth + bearingDiameter + 2, 0, thickness])
    {
        cube([thickness, bearingHeight, clampHeight]);
    }
}

module bearingClamp()
{
    color([.5,1,1])
    translate([footWidth, 0, thickness*2-1])
    {
        difference()
        {
            cube([bearingDiameter+2, bearingHeight, bearingDiameter / 2 + 3]);
            translate([bearingDiameter / 2 + 1, 0, 0])
            {
                rotate([-90,0,0])
                {
                    cylinder_outer(bearingHeight, bearingDiameter / 2, 100);
                }
            }
        }
    }
}


feet();
sidewalls();
bearingClamp();