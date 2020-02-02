include <Common.scad>;

module aluminum()
{
    cube([aluminumWidth, aluminumWidth, 80]);
}

module stand()
{
    union()
    {
        difference()
        {
            cube([aluminumWidth + standThickness * 2, aluminumWidth + standThickness * 2, standHeight + aluminumHeight]);
            translate([standThickness, standThickness, standHeight])
            {
                cube([aluminumWidth + standThickness, aluminumHeight + standThickness, aluminumHeight]);
            }
            translate([standThickness, standThickness, standHeight - aluminumHeight])
            {
                aluminum();

                translate([aluminumWidth / 2, 0, aluminumHeight / 2])
                {
                    rotate([90, 0, 0])
                    {
                        5mmScrew();
                    }
                }
                translate([aluminumWidth / 2, 0, aluminumHeight / 2 + aluminumHeight])
                {
                    rotate([90, 0, 0])
                    {
                        5mmScrew();
                    }
                }
                translate([aluminumWidth / 2, aluminumWidth, aluminumHeight / 2])
                {
                    rotate([-90, 0, 0])
                    {
                        5mmScrew();
                    }
                }
                translate([0, aluminumWidth / 2, aluminumHeight / 2])
                {
                    rotate([0, -90, 0])
                    {
                        5mmScrew();
                    }
                }
                translate([0, aluminumWidth / 2, aluminumHeight / 2 + aluminumHeight])
                {
                    rotate([0, -90, 0])
                    {
                        5mmScrew();
                    }
                }
                translate([aluminumWidth, aluminumWidth / 2, aluminumHeight / 2])
                {
                    rotate([0, 90, 0])
                    {
                        5mmScrew();
                    }
                }
            }
        }

        translate([aluminumWidth + standThickness * 2, 0, standHeight])
        {
            difference()
            {
                cube([standFlangeWidth, standThickness, aluminumHeight]);
                translate([standFlangeWidth / 2, 0, aluminumHeight / 2])
                {
                    rotate([-90, 0, 0])
                    {
                        5mmScrew();
                    }
                }
            }
        }

        translate([0, aluminumWidth + standThickness * 2, standHeight])
        {
            difference()
            {
                cube([standThickness, standFlangeWidth, aluminumHeight]);
                translate([0, standFlangeWidth / 2, aluminumHeight / 2])
                {
                    rotate([0, 90, 0])
                    {
                        5mmScrew();
                    }
                }
            }
        }
    }
}

module buildCornerStand()
{
    union()
    {
        color([1, 0, 0])
        stand();
 
        color([0, 1, 0])
        translate([aluminumWidth + standThickness * 2, 0, 0])
        {
            outsideXFlange();
        }

        color([0,0,1])
        translate([0, aluminumWidth + standThickness * 2, 0])
        {
            outsideYFlange();
        }
    }
}

buildCornerStand();
//testFlange();