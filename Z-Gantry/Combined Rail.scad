include <Rail.scad>;
rotate([0, 0, 180])
{
    color([1,0,0])
    rail();

    middle = (bearingCarriageLength / 2);
    offset = (bearingDiameter / 2);


    // bearing mount
    translate([barLength + middle - offset, -thickness, 0])
    {
        translate([0, -1, -2])
        color([0,0,1])
        bearing();
    }
}
//bracket

color([1,1,0])
translate([-barLength - bearingCarriageLength, 2, 0])
bearingClamp();

