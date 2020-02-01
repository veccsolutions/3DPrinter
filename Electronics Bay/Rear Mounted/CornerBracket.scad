width = 10;
height = 10;
length = 30;
holeCount = 3;
depth = 2;
holeOffset = 5;

holeLength = (length - (holeOffset * 2));
holeStep = (length - (holeOffset * 2)) / (holeCount - 1);

module wall()
{
    translate([depth, 0, 0])
    {
        difference()
        {
            cube([width, depth, length]);
            for (offset = [0: holeStep: holeLength])
            {
                echo (offset);
                translate([width / 2, 0, holeOffset + offset])
                {
                    rotate([-90, 0, 0])
                    {
                        cylinder(d = 3.5, h = depth, $fn = 100);
                    }
                }
            }
        }
    }
}

module corner()
{
    intersection()
    {
        cube([depth, depth, length]);
        translate([depth, depth, 0])
        {
            cylinder(r=depth  * 1.1, h = length, $fn = 100);
        }
    }
}

module build()
{
    union()
    {
        color([1, 0, 0])
        wall();

        color([0,1,0])
        corner();

        color([0,0,1])
        rotate([0,0,90])
        {
            translate([0, -depth, 0])
            {
                wall();
            }
        }
    }
}
build();