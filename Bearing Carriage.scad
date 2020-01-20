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

// carriage mount
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

// bearing mount
middle = (bearingCarriageLength / 2);
offset = (bearingDiameter / 2);

translate([ middle - offset, 0, thickness])
{
    difference()
    {
        cube([bearingDiameter, bearingHeight, bearingDiameter / 2 - 1]);
        translate([bearingDiameter / 2, 0, bearingDiameter / 2])
        {
            rotate([-90,0,0])
            {
                cylinder_outer(bearingHeight, bearingDiameter / 2, 100);
            }
        }
    }
}
