include <Common.scad>;


insideXFlange();

switchHeight = 28;
switchWidth = 48;
switchSpace = 10;
switchPanelWidth = switchSpace * 2 + switchWidth;
panelCenterX = switchPanelWidth / 2;
panelCenterZ = standHeight / 2;
switchMinZ = panelCenterZ - (switchHeight / 2);
switchMaxZ = panelCenterZ + (switchHeight / 2);

reinforcementThickness = 10;

translate([standFlangeWidth, 0, 0])
{
    difference()
    {
        cube([switchPanelWidth, standThickness, standHeight]);
        translate([switchSpace, 0, (standHeight - switchHeight) / 2])
        {
            cube([switchWidth, standThickness, switchHeight]);
        }
        translate([switchSpace + (switchWidth / 2), 0, switchMinZ - 5])
        {
            rotate([-90, 0, 0])
            {
                3mmScrew();
            }
        }
        translate([switchSpace + (switchWidth / 2), 0, switchMaxZ + 5])
        {
            rotate([-90, 0, 0])
            {
                3mmScrew();
            }
        }   
    }
    translate([switchPanelWidth, 0, 0])
    {
        insideXFlange();
    }
    topRail(width = switchPanelWidth);
    translate([0, -reinforcementThickness, 0])
    {
        cube([standThickness, reinforcementThickness, standHeight]);
        cube([switchPanelWidth, reinforcementThickness, standThickness]);
    }
    translate([switchPanelWidth - standThickness, -reinforcementThickness, 0])
    {
        cube([standThickness, reinforcementThickness, standHeight]);
    }
}