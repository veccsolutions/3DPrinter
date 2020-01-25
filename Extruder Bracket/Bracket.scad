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
 
MountWidth = IntegerMultiple(NEMA17_BCD,ThreadWidth);       // use BCD for motor clearance
MountThick = 5;              // for stiffness
 
MountBoltDia = 3.0;
 
StandThick = 5;              // baseplate
 
StrutThick = IntegerMultiple(4.0,ThreadWidth);              // sides holding motor mount
 
UprightLength = MountWidth + 2*StrutThick;
 
StandBoltHead = IntegerMultiple(Head10_32,5);               // bolt head rounded up
StandBoltOC = IntegerMultiple(UprightLength + 2*StandBoltHead,5);
 
StandLength = StandBoltOC + 2*StandBoltHead;
StandWidth = 20;
 
StandBoltClear = (StandLength - UprightLength)/2;           // flat around bolt head
 
MotorRecess = StandWidth - MountThick;
 
echo(str("Stand Base: ",StandLength," x ",StandWidth," x ",StandThick));
echo(str("Stand Bolt OC: ",StandBoltOC));
echo(str("Strut Thick: ",StrutThick));
 
//-- Convenience values
 
Protrusion = 0.1;       // make holes look good and joints intersect properly
 
BuildOffset = 3 * ThreadWidth;
 
//----------------------
// Useful routines
 
module PolyCyl(Dia,Height,ForceSides=0) {           // based on nophead's polyholes
    r = (Dia + HoleWindage)/ 2;
    fudge = 1/cos(180/300);
    cylinder(h=Height,r=r*fudge,$fn=100);
}
 
module ShowPegGrid(Space = 10.0,Size = 1.0) {
 
  Range = floor(50 / Space);
 
    for (x=[-Range:Range])
      for (y=[-Range:Range])
        translate([x*Space,y*Space,Size/2])
          %cube(Size,center=true);
 
}
 
//----------------------
// Combined stand and mounting plate
 
module Combined() {
 
  difference() {
    // Initial block
    translate([StandThick/2,0,StandWidth/2])
    {
      cube([(MountWidth + StandThick),StandLength,StandWidth],center=true);
    }

    // Motor block cutout
    translate([-Protrusion/2,0,StandWidth - (MotorRecess - Protrusion)/2])
    {
      cube([(MountWidth + Protrusion),MountWidth,(MotorRecess + Protrusion)],center=true);
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

    // //
    // for (y=[-1,1])                              // cutouts over bolts
    //   translate([-Protrusion/2,
    //             y*((StandLength - StandBoltClear)/2 + Protrusion),
    //             StandWidth/2])
    //     cube([(MountWidth + Protrusion),
    //          (StandBoltClear + Protrusion),
    //          (StandWidth + 2*Protrusion)],center=true);
    for (y=[-1,1])                              // stand bolt holes
      translate([(MountWidth/2 - Protrusion),y*StandBoltOC/2,StandWidth/2])
        rotate([0,90,0])
          PolyCyl(Clear10_32,StandThick + 2*Protrusion,8);
 
  }
 
}

Combined();