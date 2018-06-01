unit csCalc_Delta;

{$mode objfpc}{$H+}

interface

uses
  Graphics,
  cs_types,
  csc_sRGB_2_Lab,
  cs_deltaE2000;


function delta(const C1,C2:TColor; const weightLightness,weightChroma,weightHue:t_csIntermediateCalculations):t_csIntermediateCalculations;
function delta(const C1,C2:TColor):t_csIntermediateCalculations;


implementation

function delta(const C1,C2:TColor; const weightLightness,weightChroma,weightHue:t_csIntermediateCalculations):t_csIntermediateCalculations;
var L1,a1,b1:t_Lab_colorComp;
    L2,a2,b2:t_Lab_colorComp;
begin
    sRGB_2_Lab(Red(c1),Green(c1),Blue(c1), L1,a1,b1);
    sRGB_2_Lab(Red(c2),Green(c2),Blue(c2), L2,a2,b2);
    result:=deltaE2000(L1,a1,b1, L2,a2,b2, weightLightness,weightChroma,weightHue);
end;

function delta(const C1,C2:TColor):t_csIntermediateCalculations;
begin
    result:=delta(C1,C2, 1,1,1);
end;

end.

