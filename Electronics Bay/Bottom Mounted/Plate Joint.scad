include <Common.scad>;

union()
{
    insideXFlange();
    translate([standFlangeWidth, 0, 0])
    {
        insideXFlange();
    }
}