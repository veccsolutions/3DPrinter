petgShrinkage = 1.03;

shrinkage = petgShrinkage; //done so we can do pla if desired
standHeight = 65 * shrinkage;
aluminumHeight = 20 * shrinkage;
aluminumWidth = 20 * shrinkage;
standHoleCount = 3;
standLargeScrewOffset = 10 * shrinkage;
standThickness = 5 * shrinkage;
standFlangeWidth = 15 * shrinkage;
standFlangeHoleOffset = 10 * shrinkage;
topRailHoleOffset = 10 * shrinkage;

standFlangeThickness = standThickness / 2;
standFlangeHoleLength = (standHeight - (standFlangeHoleOffset * 2));
standFlangeHoleStep = (standHeight - (standFlangeHoleOffset * 2)) / (standHoleCount - 1);
