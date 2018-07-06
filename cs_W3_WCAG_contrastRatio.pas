unit cs_W3_WCAG_contrastRatio;
// https://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef

{$mode objfpc}{$H+}

interface

uses
  Graphics,
  math,
  cs_W3_WCAG_relativeLuminance,
  cs_types;


type tCS_W3WCAG_contrastRatio=t_csIntermediateCalculations;

function cs_W3WCAG_contrastRatio(const c1,c2:TColor):tCS_W3WCAG_contrastRatio;
//Note 1: Contrast ratios can range from 1 to 21 (commonly written 1:1 to 21:1).
implementation

type tCalc=t_csIntermediateCalculations;

function cs_W3WCAG_contrastRatio(const c1,c2:TColor):tCS_W3WCAG_contrastRatio;
var rl1:tCalc;
    rl2:tCalc;
begin
    rl1:=cs_W3WCAG_relativeLuminance(c1);
    rl2:=cs_W3WCAG_relativeLuminance(c2);
    //
    result:=(max(rl1,rl2) + 0.05) / (min(rl1,rl2) + 0.05);
end;

end.

