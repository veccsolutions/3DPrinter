//PETG shrinkage
shrinkage = 1.00;
frameWidth = 20;

//pi dimensions
piScrewXDistance = 58;
piScrewOffset = 3.5;
piHeight = 85;
piWidth = 56;

// plate
// side space
side = 40; //20 for the aluminum and 20 more to move it over a bit.
bottom = 40; //20 for the aluminum and 20 more to move it up a bit
width = piHeight;
height = piWidth;
plateHeight = 5;

module PolyCyl(d, h)
{
    r = (d + shrinkage)/ 2;
    fudge = 1 / cos(180 / 300);
    cylinder(h = h, r = r * fudge, $fn = 100);
}

module drawPlateScrewHole(actualX, actualY, width, height, circleX, circleY)
{
    difference()
    {
        translate([actualX, actualY, 0])
        {
            cube([width, height, plateHeight]);

            translate([circleX, circleY, 0])
            {
                cylinder(d = frameWidth / 2, h = plateHeight, $fn = 100);
            }
        }
        translate([actualX + circleX, actualY + circleY, 0])
        {
            PolyCyl(d = 5 * shrinkage, h = plateHeight);
        }
    }
}

module plateScrewHole(x = 0, y = 0)
{
    if (y != 0)
    {
        actualX = frameWidth / 4;
        actualY = y - frameWidth / 4;
        width = frameWidth - frameWidth / 4;
        height = frameWidth / 2;
        circleX = 0;
        circleY = frameWidth / 4;

        drawPlateScrewHole(actualX, actualY, width, height, circleX, circleY);
    }
    else
    {
        actualX = x - frameWidth / 4;
        actualY = frameWidth / 4;
        width = frameWidth / 2;
        height = frameWidth - frameWidth / 4;
        circleX = frameWidth / 4;
        circleY = 0;

        drawPlateScrewHole(actualX, actualY, width, height, circleX, circleY);
    }
}


module plate()
{
    translate([frameWidth, frameWidth])
    {
        // pi holes
        bottomPiHole1Y = 3.5;
        bottomPiHole2Y = height - 3.5;

        difference()
        {
            //base plate
            cube([width, height, plateHeight]); 


            translate([piScrewOffset, bottomPiHole1Y, 0])
            {
                PolyCyl(d = 3 * shrinkage, h = plateHeight);
                PolyCyl(d = 5 * shrinkage, h = 3);
            }

            translate([piScrewOffset, bottomPiHole2Y, 0])
            {
                PolyCyl(d = 3 * shrinkage, h = plateHeight);
                PolyCyl(d = 5 * shrinkage, h = 3);
            }

            translate([piScrewOffset + piScrewXDistance, bottomPiHole1Y, 0])
            {
                PolyCyl(d = 3 * shrinkage, h = plateHeight);
                PolyCyl(d = 5 * shrinkage, h = 3);
            }
            
            translate([piScrewOffset  + piScrewXDistance, bottomPiHole2Y, 0])
            {
                PolyCyl(d = 3 * shrinkage, h = plateHeight);
                PolyCyl(d = 5 * shrinkage, h = 3);
            }
        }

        translate([0, 0, plateHeight])
        {
            translate([piScrewOffset, bottomPiHole1Y, 0])
            {
                difference()
                {
                    PolyCyl(d = 5 * shrinkage, h = 3);
                    PolyCyl(d = 3 * shrinkage, h = 3);
                }            }

            translate([piScrewOffset, bottomPiHole2Y, 0])
            {
                difference()
                {
                    PolyCyl(d = 5 * shrinkage, h = 3);
                    PolyCyl(d = 3 * shrinkage, h = 3);
                }            }

            translate([piScrewOffset + piScrewXDistance, bottomPiHole1Y, 0])
            {
                difference()
                {
                    PolyCyl(d = 5 * shrinkage, h = 3);
                    PolyCyl(d = 3 * shrinkage, h = 3);
                }            }
            
            translate([piScrewOffset  + piScrewXDistance, bottomPiHole2Y, 0])
            {
                difference()
                {
                    PolyCyl(d = 5 * shrinkage, h = 3);
                    PolyCyl(d = 3 * shrinkage, h = 3);
                }
            }
        }
    }

    plateScrewHole(x = frameWidth + 10);
    plateScrewHole(x = frameWidth + width - 10);
    plateScrewHole(y = frameWidth + 10);
    plateScrewHole(y = frameWidth + height - 10);

}
plate();