include <Common.scad>;

CameraMount();
mirror([0, 0, 1])
{
    translate([0, jointBlockHeight * 2 - 3, 0])
    {
        rotate([90, 0, 0])
        {
            FrameMount();
        }
    }
}