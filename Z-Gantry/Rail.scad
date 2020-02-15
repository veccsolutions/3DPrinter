include <Common.scad>;

barHeight = 20;
barLength = 75;
thickness = 5;
aluminumWidth = 20;
aluminumHeight = 20;
bearingHeight = aluminumHeight + thickness + 20;
bearingDiameter = 21.15;
bearingCarriageLength=50;
bearingCarriageHeight = bearingHeight;
bearingCarriageHoleCount = 2;
bearingCarriageHoleOffset = thickness + 7;
bearingCarriageHoleDifference = (bearingCarriageHeight - bearingCarriageHoleOffset * 2) / (bearingCarriageHoleCount - 1);
footWidth = (bearingCarriageLength - bearingDiameter - thickness * 2) / 2 - 1;
clampHeight = 18;
zaxisRodDiameter = 12;

module railBar()
{
    difference()
    {
        cube([barLength, thickness, aluminumHeight + thickness]);
        translate([10, 0, (aluminumHeight / 2) + thickness])
        {
            rotate([-90, 0, 0])
            {
                fiveMMScrew();
            }
        }
        translate([barLength - 10, 0,  (aluminumHeight / 2) + thickness])
        {
            rotate([-90, 0, 0])
            {
                fiveMMScrew();
            }
        }
    }
}

module railBottom()
{
    difference()
    {
        cube([barLength + bearingCarriageLength, aluminumWidth + thickness, thickness]);
        translate([10, thickness + (aluminumWidth / 2), 0])
        {
            fiveMMScrew();
        }
        translate([barLength + bearingCarriageLength - 10, thickness + (aluminumWidth / 2), 0])
        {
            fiveMMScrew();
        }
    }
}

module railBracket()
{
    translate([barLength, 0, 0])
    {
        difference()
        {
            cube([bearingCarriageLength, thickness, bearingCarriageHeight], false);

            translate([(footWidth) / 2, 0, 0])
            {
                translate([0, 3, bearingCarriageHoleOffset])
                {
                    rotate([-90, 0, 0])
                    {
                        cylinder_outer(thickness + .1, 3, 100);
                    }
                }
                carriageHoles();
            }

            translate([bearingCarriageLength - footWidth / 2, 0, 0])
            {
                translate([0, 3, bearingCarriageHoleOffset])
                {
                    rotate([-90, 0, 0])
                    {
                        cylinder_outer(thickness + .1, 3, 100);
                    }
                }
                carriageHoles();
            }
        }
    }
}

module clampFoot()
{
    difference()
    {
        cube([footWidth, thickness, bearingHeight]);
        translate([footWidth / 2, 0, 0])
        {
            carriageHoles();
        }
    }
}

module clampFeet()
{
    clampFoot();
    
    translate([bearingCarriageLength - footWidth, 0, 0])
    {
        clampFoot();
    }
}

module clampSidewalls()
{
    translate([footWidth - 1, 0, 0])
    {
        cube([thickness, clampHeight, bearingHeight]);
    }
    translate([bearingCarriageLength - footWidth - thickness + 1, 0, 0])
    {
        cube([thickness, clampHeight, bearingHeight]);
    }
}

module clamp()
{
    x = (bearingCarriageLength / 2) -
        (bearingDiameter / 2) - 2;

    translate([x, clampHeight - thickness, 0 ])//thickness * 2 - 1, 0 ])
    {
        difference()
        {
            cube([bearingDiameter + 4, bearingDiameter / 2,  bearingHeight]);
            translate([2, 3, -2])
            {
                bearing();
            }
        }
    }
}

module rail()
{
    union()
    {
        //bar
        color([1,0,0])
        railBar();

        //bottom rail
        //rail
        color([0,1,0])
        railBottom();

        //bearing bracket mount
        color([0,0,1])
        railBracket();

        middle = (bearingCarriageLength / 2);
        offset = (bearingDiameter / 2);
        color([1, 0, 1])
        // bearing mount
        translate([barLength + middle - offset, -thickness, 0])
        {
            color([0,1,0])
            bearingSpacer();
        }
    }
}

module bearing()
{
    translate([bearingDiameter / 2, thickness - bearingDiameter / 2, 0])
    {
        //bearing case
        cylinder_outer(bearingHeight, bearingDiameter / 2, 100);

        // space around z axis rod
        translate([0, 0, -2])
        {
            cylinder_outer(bearingHeight + 4, zaxisRodDiameter / 2 * 1.3, 100);
        }

        // zaxis rod
        translate([0, 0, -20])
        {
            cylinder_outer(bearingHeight + 40, 12 / 2, 100);
        }
    }
}

module bearingSpacer()
{
    difference()
    {
        cube([bearingDiameter, thickness, bearingHeight]);
        translate([0, -1, 0])
        {
            bearing();
        }
    }
}

module bearingClamp()
{
    color([1, 0, 0])
    clampFeet();

    color([0, 1, 0])
    clampSidewalls();

    color([0, 0, 1])
    clamp();
}