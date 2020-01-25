// NEMA 17 stepper mount for dynamometer
// Ed Nisley KE4ZNU August 2011
 
include <c:/development/mcad/units.scad>
 
//-- Layout Control
 
Layout = "Build";               // Build Show
 
//-- Extrusion parameters
 
ThreadThick = 0.33;
ThreadWT = 2.0;
ThreadWidth = ThreadThick * ThreadWT;
 
HoleWindage = 1.3;          // enlarge hole dia by this amount
WallThickness = 5;
StandHeight = 20;

function IntegerMultiple(Size,Unit) = Unit * ceil(Size / Unit);
 
//-- Useful sizes
 
Clear10_32 = 5;//0.190 * inch;
Head10_32 = 10;
 
NEMA17_PilotDia = 0.866 * inch;
NEMA17_PilotLength = 0.080 * inch;
NEMA17_BCD = 1.725 * inch;
NEMA17_BoltDia = 3.5;
NEMA17_BoltOC = 1.220 * inch;
 
//-- Mount Sizes
 
MotorWidth = IntegerMultiple(NEMA17_BCD,ThreadWidth);       // use BCD for motor clearance
MountThick = 2;              // for stiffness
 
MountBoltDia = 3.0;
 
UprightLength = MotorWidth + 2 * WallThickness;
 
StandBoltHead = IntegerMultiple(Head10_32,5);               // bolt head rounded up
StandBoltOC = IntegerMultiple(UprightLength + 2*StandBoltHead,5);
 
StandLength = StandBoltOC + 2*StandBoltHead;
 
StandBoltClear = (StandLength - UprightLength)/2;           // flat around bolt head
 
MotorRecess = StandHeight - MountThick;
 
echo(str("Stand Base: ", StandLength, " x ", StandHeight, " x ", WallThickness));
echo(str("Stand Bolt OC: ",StandBoltOC));
echo(str("Strut Thick: ", WallThickness));
 
//-- Convenience values
 
Protrusion = $preview ? 0.1 : 0;// make holes look good and joints intersect properly during preview (F5)
echo(str("Protrusion: ", Protrusion));
BuildOffset = 3 * ThreadWidth;
 
//----------------------
// Useful routines
 
module PolyCyl(Dia,Height,ForceSides=0)
{
    r = (Dia + HoleWindage)/ 2;
    fudge = 1/cos(180/300);
    cylinder(h=Height,r=r*fudge,$fn=100);
}
 
module Combined()
{
  difference()
  {
    // Initial block
    translate([WallThickness / 2,0,StandHeight / 2])
    {
      cube([(MotorWidth + WallThickness),StandLength,StandHeight],center=true);
    }

    // Motor block cutout
    translate([-Protrusion/2,0,StandHeight - (MotorRecess - Protrusion)/2])
    {
      cube([(MotorWidth + Protrusion),MotorWidth,(MotorRecess + Protrusion)],center=true);
    }

    // Pilot Hole
    translate([0,0,-Protrusion])
    {
      PolyCyl(NEMA17_PilotDia,(MountThick + 2*Protrusion));
    }

    // Motor Bolt Holes
    for (x=[-1,1])
    {
      for (y=[-1,1])
      {
        translate([x*NEMA17_BoltOC/2,y*NEMA17_BoltOC/2,-Protrusion])
        {
          PolyCyl(MountBoltDia,(MountThick + 2*Protrusion));
        }
      }
    }

    // cutouts over bolts
    for (y=[-1,1])
    {
      translate([-Protrusion/2,
                y*((StandLength - StandBoltClear)/2 + Protrusion),
                StandHeight/2])
      {
        cube([(MotorWidth + Protrusion),
             (StandBoltClear + Protrusion),
             (StandHeight + 2*Protrusion)],center=true);
      }
    }

    // stand bolt holes
    for (y=[-1,1])
    {
      translate([(MotorWidth/2 - Protrusion),y*StandBoltOC/2,StandHeight/2])
      {
        rotate([0,90,0])
        {
          PolyCyl(Clear10_32,WallThickness + 2*Protrusion,8);
        }
      }
    }
  }
 
}

Combined();