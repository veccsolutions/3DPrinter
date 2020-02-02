include <Constants.scad>;

module polyhole(h, d)
{
    n = max(round(20 * d), 3);

    rotate([0,0,180])
    {
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
    }
}

module fanGrill(size, holeSpace, screwOffset)
{
    intersection()
    {
        translate([size / 2, 20, 0])
        {
            cylinder(d = size * shrinkage, h = standThickness, $fn = 100);
        }
        for(fanX = [0:holeSpace:size])
        {
            for(fanZ = [0:holeSpace:size])
            {
                translate([fanX, fanZ, 0])
                {
                    5mmScrew();
                }
            }
        }
    }

    translate([screwOffset, screwOffset, 0])
    {
        5mmScrew();
    }

    translate([size - screwOffset, screwOffset, 0])
    {
        5mmScrew();
    }

    translate([screwOffset, size - screwOffset, 0])
    {
        5mmScrew();
    }

    translate([size - screwOffset, size - screwOffset, 0])
    {
        5mmScrew();
    }
}

module 3mmScrew(height = standThickness)
{
    polyhole(h = height, d = 3 * shrinkage * 1.1);
}

module 5mmScrew(height = standThickness)
{
    polyhole(h = height, d = 5.1 * shrinkage * 1.1);
}

module outsideFlange()
{
    difference()
    {
        cube([standFlangeWidth, standFlangeThickness, standHeight]);
        for (offset = [0: standFlangeHoleStep: standFlangeHoleLength])
        {
            echo (offset);
            translate([standFlangeWidth / 2, 0, standFlangeHoleOffset + offset])
            {
                rotate([-90, 0, 0])
                {
                    3mmScrew();
                }
            }
        }
    }
}

module outsideXFlange()
{
    outsideFlange();
}

module outsideYFlange()
{
    rotate([0,0,90])
    {
        translate([0, -standFlangeThickness, 0])
        {
            outsideFlange();
        }
    }
}

module insideXFlange()
{
    translate([0, standFlangeThickness, 0])
    {
        outsideFlange();
    }
}

module insideYFlange()
{
    rotate([0,0,90])
    {
        translate([0, -standFlangeThickness * 2, 0])
        {
            outsideFlange();
        }
    }
}

module topRail(width)
{
    echo(width);
    assert(width >= topRailHoleOffset * 3, "Panel width is too small");
    
    topRailHoleCount = max(round(width / (topRailHoleOffset * 2)), 2);
    topRailHoleLength = (standHeight - (topRailHoleOffset * 2));
    topRailHoleStep = (standHeight - (topRailHoleOffset * 2)) / (topRailHoleCount - 1);
    echo("heha");
    echo(topRailHoleCount);

    translate([0, 0, standHeight])
    {
        difference()
        {
            cube([width, standThickness, aluminumHeight]);

            for (offset = [0: topRailHoleStep: topRailHoleLength])
            {
                echo (offset);
                translate([offset + topRailHoleOffset, 0, aluminumHeight / 2, ])
                {
                    rotate([-90, 0, 0])
                    {
                        5mmScrew();
                    }
                }
            }            
        }
    }
}

module 40mmFan()
{
    fanGrill(size = 40, holeSpace = 40 / 6, screwOffset = 3);
}