include <PI Mount.scad>;

module build()
{
    panel();
    translate([standFlangeWidth, standThickness, 0])
    {
        // //left brace
        translate([0, 0, standThickness + plateHeightOffset])
        {
            piMountBraceLeft();
        }

        //bottom plate
        translate([0, 0, plateHeightOffset])
        {
            piMount();
        }

        //right brace
        translate([panelWidth, 0, standThickness + plateHeightOffset])
        {
            piMountBraceRight();
        }
    }
}

build();