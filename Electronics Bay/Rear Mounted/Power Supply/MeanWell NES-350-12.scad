//PETG shrinkage
shrinkage = 1.00;

//wall width
width = 5;

//powersupply dimensions
psWidth = 115 * shrinkage;
psHeight = 50 * shrinkage;
psLength = (215 + 12) * shrinkage; //main case + terminal
psTerminalLength = 12 * shrinkage;
psSideScrewDepth = 32.5 * shrinkage;
psSideScrewOffset = 10 * shrinkage;
psSideScrewDifference = 25 * shrinkage;

//switch block and wire hole dimensions
switchWidth = 40 * shrinkage;
switchHeight = 20 * shrinkage;
switchDifferenceBottom = 10 * shrinkage;
switchDifferenceTop = 10 * shrinkage;
switchBlockWidth = psWidth;
switchDifferenceLeft = switchBlockWidth - 10 - switchWidth;
switchBlockLength = switchHeight + switchDifferenceBottom + switchDifferenceTop;
switchBlockHeight = psHeight;
wireHoleX = switchBlockWidth;
wireHoleY = switchBlockLength / 2;
wireHoleZ = switchBlockHeight / 2;
wireHoleDiameter = 15;
wireHoleHeight = width;




actualSleeveHeight = psHeight + width * 2;
actualSleeveWidth = psWidth + width * 2;
actualSleeveLength = width + psSideScrewOffset + psSideScrewDepth + psTerminalLength + switchHeight;

//bottom
module powersupply()
{
    color([1, 0, 0])
    //powersupply case
    cube([psWidth, psHeight, psLength]);

    //screw holes, 4 on each side
    color([0, 1, 0])
    for (x = [0:psWidth:psWidth])
    {
        translate([x, psHeight / 2, psTerminalLength + psSideScrewDepth])
        {
            for (z=[0:150:150])
            {
                translate([0, 0, z])
                {
                    for (y=[-1:2:1])
                    {
                        translate([0, y * (psSideScrewDifference / 2), 0])
                        {
                            rotate([0,x==0?-90:90, 0])
                            {
                                cylinder(d = 5, h = width, $fn = 100);
                            }
                        }
                    }
                }
            }
        }
    }
}

module switchBlock()
{
    cube([switchBlockWidth, switchBlockHeight, switchBlockLength]);

    translate([wireHoleX, wireHoleZ, wireHoleY])
    {
        rotate([0, 90, 0])
        {
            cylinder(d = wireHoleDiameter, h = width, $fn = 100);
        }
    }

    translate([switchDifferenceLeft , -width, switchDifferenceBottom])
    {
        cube([switchWidth, width, switchHeight]);
    }
}

module buildit()
{
    difference()
    {
        //sleeve
        cube([actualSleeveWidth, actualSleeveHeight, actualSleeveLength]);

        //powersupply
        translate([width, width, width + 25])
        {
            powersupply();
        }

        //switch block
        translate([width, width, width])
        {
            switchBlock();
        }
    }
}

switchBlock();
