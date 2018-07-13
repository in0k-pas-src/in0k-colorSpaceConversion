unit cs_W3_WCAG_contrastRatio;
// https://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef

{$mode objfpc}{$H+}

interface

uses
  Graphics,
  cs_types,
  cs_W3_WCAG_relativeLuminance;


type tCS_W3WCAG_contrastRatio=t_csIntermediateCalculations;

function cs_W3WCAG_contrastRatio(const c1,c2:TColor):tCS_W3WCAG_contrastRatio;
//Note 1: Contrast ratios can range from 1 to 21 (commonly written 1:1 to 21:1).
implementation

type tCalc=t_csIntermediateCalculations;

function cs_W3WCAG_contrastRatio(const c1,c2:TColor):tCS_W3WCAG_contrastRatio;
var rl1:tCS_W3WCAG_relativeLuminance;
    rl2:tCS_W3WCAG_relativeLuminance;
begin   {$ifOpt D+}
        Assert(c1=ColorToRGB(c1),'`c1` is NOT sRGB color!');
        Assert(c2=ColorToRGB(c2),'`c2` is NOT sRGB color!');
        {$endIf}
    rl1:=cs_W3WCAG_relativeLuminance(c1);
    rl2:=cs_W3WCAG_relativeLuminance(c2);
    // сама формула
    if rl1<rl2
    then result:=(rl2+0.05)/(rl1+0.05)
    else result:=(rl1+0.05)/(rl2+0.05);
    {$ifOpt D+} // результат ДОЛЖен лежать в диапазоне [1..21]
    Assert(01<=result,'`result` is WRONG!');
    Assert(result<=21,'`result` is WRONG!');
    {$endIf}
end;

end.

