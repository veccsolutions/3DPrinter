cameraScrewSize = 2;
cameraXScrewOffset = 2;
cameraYScrewOffset = 9.5;
cameraScrewXDistance = 21;
cameraScrewYDistance = 12.5;
cameraYSize = 24;
cameraXSize = 25;
cameraMountSize = cameraXScrewOffset * 2;
mountHeight = 5;
jointBlockHeight = 5;
jointBlockWidth = 10;
jointWingWidth = 2;

module polyhole(h, d)
{
    n = max(round(20 * d), 3);

    rotate([0,0,180])
    {
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
    }
}

module CameraMountStand()
{
    difference()
    {
        cube([cameraMountSize, cameraYSize, mountHeight]);
        translate([cameraXScrewOffset, cameraYScrewOffset, 0])
        {
            polyhole(d = cameraScrewSize, h = mountHeight);
            translate([0, cameraScrewYDistance, 0])
            {
                polyhole(d = cameraScrewSize, h = mountHeight);
            }
        }
    }
}

module JointBlock()
{
    difference()
    {
        union()
        {
            translate([0, jointBlockHeight / 2, 0])
            {
                cube([jointBlockWidth, jointBlockWidth - jointBlockHeight / 2, jointBlockHeight]);
            }
            intersection()
            {
                cube([jointBlockWidth, jointBlockHeight / 2, jointBlockWidth]);
                translate([0, jointBlockHeight / 2, jointBlockHeight / 2])
                {
                    rotate([0, 90, 0])
                    {
                        polyhole(d=jointBlockHeight, h = jointBlockWidth);
                    }
                }
            }
        }
        translate([0, jointBlockHeight - 1.5, jointBlockHeight / 2])
        {
            rotate([0, 90, 0])
            {
                polyhole(d = 3, h = jointBlockWidth);
            }
        }
    }
}

module JointWing()
{
    cube([jointWingWidth, jointBlockWidth, jointBlockHeight]);
}

module JointWings()
{
    union()
    {
        JointWing();
        translate([jointBlockWidth - jointWingWidth, 0, 0])
        {
            JointWing();
        }
    }
}

module CameraMount()
{
    translate([0, jointBlockWidth, 0])
    {
        cube([cameraXSize, cameraMountSize, mountHeight]);
        CameraMountStand();
        translate([cameraXSize - cameraMountSize, 0, 0])
        {
            CameraMountStand();
        }
    }
    translate([cameraXSize / 2 - 5, 0, 0])
    {
        difference()
        {
            JointBlock();
            JointWings();
        }
    }
}

module FrameMount()
{
    color([0, 1, 0])
    {
        translate([0, jointBlockWidth, 0])
        {
            difference()
            {
                cube([cameraXSize, 20, mountHeight]);
                translate([7, 10, 0])
                {
                    polyhole(d = 5, h = mountHeight);
                }
                translate([cameraXSize - 7, 10, 0])
                {
                    polyhole(d = 5, h = mountHeight);
                }
            }
        }
        translate([cameraXSize / 2 - 5, 0, 0])
        {
            intersection()
            {
                JointBlock();
                JointWings();
            }
        }
    }
}