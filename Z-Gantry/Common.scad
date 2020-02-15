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
    for (hole = [0 : 1 : bearingCarriageHoleCount - 1])
    {
        translate([0, 0, bearingCarriageHoleOffset + (hole * bearingCarriageHoleDifference)])
        {
            rotate([-90, 0, 0])
            {
                threeMMScrew();
            }
        }
    }
}