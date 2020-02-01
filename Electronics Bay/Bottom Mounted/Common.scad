include <Constants.scad>;

module polyhole(h, d)
{
    n = max(round(20 * d), 3);

    rotate([0,0,180])
    {
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
    }
}

module 3mmScrew()
{
    polyhole(h = standThickness, d = 3);
}

module 5mmScrew()
{
    polyhole(h = standThickness, d = 5);
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
