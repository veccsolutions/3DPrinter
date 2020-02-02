include <Common.scad>;

//pi dimensions
piScrewXDistance = 58;
piScrewOffset = 3.5;
piHeight = 85;
piWidth = 56;
width = piHeight;
height = piWidth;
braceSize = standThickness + 2;
piOffset = 20 + (braceSize * 2);
panelWidth = piOffset * 2 + piHeight;
plateHeightOffset = 10;

module verticalBraceHoles()
{
    screwHoleCount = 3;
    screwZLength = (standHeight - standThickness - plateHeightOffset - braceSize);
    screwZOffset = screwZLength / (screwHoleCount + 1);

    for (screwZ = [screwZOffset : screwZOffset : screwZLength - 1])
    {
        translate([0, braceSize / 2, screwZ])
        {
            rotate([0, 90, 0])
            {
                3mmScrew(height = standThickness);
            }
        }
    }
}

module verticalPanelBraceHoles()
{
    screwHoleCount = 3;
    screwZLength = (standHeight - standThickness - plateHeightOffset - braceSize);
    screwZOffset = screwZLength / (screwHoleCount + 1);

    for (screwZ = [screwZOffset : screwZOffset : screwZLength - 1])
    {
        translate([0, 0, screwZ])
        {
            rotate([-90, 0, 0])
            {
                3mmScrew(height = standThickness);
            }
        }
    }
}

module horizontalPanelBraceHoles()
{
    screwHoleCount = 3;
    screwYOffset = piWidth / (screwHoleCount + 1);

    for (screwY = [screwYOffset : screwYOffset : piWidth - 1])
    {
        translate([0, screwY, 0])
        {
            rotate([0, 90, 0])
            {
                3mmScrew(height = standThickness);
            }
        }
    }
}

module piMountBraceLeft()
{
    color([1, 0, 0])
    difference()
    {
        cube([standThickness, piWidth, standHeight - plateHeightOffset - standThickness]);
        translate([standThickness / 2, 0, 0])
        {
            cube([standThickness / 2, piWidth, braceSize]);
        }
        translate([0, 0, braceSize / 2])
        {
            horizontalPanelBraceHoles();
        }
    }
    translate([standThickness, 0, braceSize])
    {
        difference()
        {
            cube([braceSize, standThickness / 2, standHeight - plateHeightOffset - standThickness - braceSize]);
            translate([braceSize, 0, 0])
            {
                rotate([0, 0, 90])
                {
                    verticalBraceHoles();
                }
            }
        }
    }
}

module piMountBraceRight()
{
    mirror([1,0,0])
    {
        piMountBraceLeft();
    }
}

module piMount()
{
    //bottom
    difference()
    {
        cube([panelWidth, piWidth, standThickness]);
        translate([(panelWidth - piWidth) / 2, 0])
        {
            piScrewHoles(d = 5, h = 3);
            piScrewHoles(d = 3, h = standThickness);
        }
    }

    //left brace flange
    translate([standThickness / 2, 0, standThickness])
    {
        difference()
        {
            cube([standThickness / 2, piWidth, braceSize]);
            translate([0, 0, braceSize / 2])
            {
                horizontalPanelBraceHoles();
            }
        }
    }

    //right brace flange
    translate([panelWidth - standThickness, 0, standThickness])
    {
        difference()
        {
            cube([standThickness / 2, piWidth, braceSize]);
            translate([0, 0, braceSize / 2])
            {
                horizontalPanelBraceHoles();
            }
        }
    }
    
    translate([(panelWidth - piWidth) / 2, 0, standThickness])
    {
        difference()
        {
            piScrewHoles(d = 5, h = 3);
            piScrewHoles(d = 3, h = 3);
        }
    }
}

module panel()
{
    outsideXFlange();

    translate([standFlangeWidth, 0, 0])
    {
        difference()
        {
            cube([panelWidth, standThickness, standHeight]);

            translate([standThickness, 0, 0])
            {
                verticalBraceHoles();
            }
            translate([standThickness + braceSize / 2, 0, standThickness + braceSize  + plateHeightOffset])
            {
                verticalPanelBraceHoles();
            }
            translate([panelWidth - standThickness - braceSize / 2, 0, standThickness + braceSize + plateHeightOffset])
            {
                verticalPanelBraceHoles();
            }
        }
    }

    translate([standFlangeWidth + panelWidth, 0, 0])
    {
        outsideXFlange();
    }
}

module doScrew(d, h)
{
    if (d == 3)
    {
        3mmScrew(height = h);
    }
    else
    {
        5mmScrew(height = h);
    }
}

module piScrewHoles(d, h)
{
    {
        translate([piScrewOffset, piScrewOffset, 0])
        {
            difference()
            {
                doScrew(d = d, h = h);
            }
        }
        translate([piScrewOffset + piScrewXDistance, piScrewOffset, 0])
        {
            difference()
            {
                doScrew(d = d, h = h);
            }
        }
        translate([piScrewOffset, piWidth - piScrewOffset, 0])
        {
            difference()
            {
                doScrew(d = d, h = h);
            }
        }
        translate([piScrewOffset + piScrewXDistance, piWidth - piScrewOffset, 0])
        {
            difference()
            {
                doScrew(d = d, h = h);
            }
        }
    }
}


