include <Common.scad>;

module aluminum()
{
    cube([aluminumWidth, aluminumWidth, aluminumHeight]);
}

module stand()
{
    difference()
    {
        cube([aluminumWidth + standThickness * 2, aluminumWidth + standThickness * 2, standHeight]);
        translate([standThickness, standThickness, standHeight - aluminumHeight])
        {
            aluminum();

            translate([aluminumWidth / 2, 0, aluminumHeight / 2])
            {
                rotate([90, 0, 0])
                {
                    polyhole(d = 5, h = standThickness);
                }
            }
            translate([aluminumWidth / 2, aluminumWidth, aluminumHeight / 2])
            {
                rotate([-90, 0, 0])
                {
                    polyhole(d = 5, h = standThickness);
                }
            }
            translate([0, aluminumWidth / 2, aluminumHeight / 2])
            {
                rotate([0, -90, 0])
                {
                    polyhole(d = 5, h = standThickness);
                }
            }
            translate([aluminumWidth, aluminumWidth / 2, aluminumHeight / 2])
            {
                rotate([0, 90, 0])
                {
                    polyhole(d = 5, h = standThickness);
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