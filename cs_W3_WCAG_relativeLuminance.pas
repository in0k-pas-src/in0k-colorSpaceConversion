unit cs_W3_WCAG_relativeLuminance;
//https://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef

{$mode objfpc}{$H+}

interface

uses
  Graphics,
  math,
  cs_types;

type
   tCS_W3WCAG_relativeLuminance=t_csIntermediateCalculations;

// the relative brightness of any point in a colorspace, normalized to 0 for darkest black and 1 for lightest white
function cs_W3WCAG_relativeLuminance(const color:TColor):tCS_W3WCAG_relativeLuminance;

implementation

type tCalc=t_csIntermediateCalculations;

function cs_W3WCAG_relativeLuminance(const color:TColor):tCS_W3WCAG_relativeLuminance;
var r,g,b:tCalc;
begin   {$ifOpt D+}
        Assert(color=ColorToRGB(color),'`color` is NOT sRGB color!');
        {$endIf}
    r:=Red  (color)/$FF;
    g:=Green(color)/$FF;
    b:=Blue (color)/$FF;
    //---
    if (r<=0.03928) then r:= r/12.92 else r:= power((r+0.055)/1.055,2.4);
    if (g<=0.03928) then g:= g/12.92 else g:= power((g+0.055)/1.055,2.4);
    if (b<=0.03928) then b:= b/12.92 else b:= power((b+0.055)/1.055,2.4);
    // ФОРМУЛА
    result:=0.2126*r + 0.7152*g + 0.0722*b;
    {$ifOpt D+} // результат ДОЛЖен лежать в диапазоне [0..1]
    Assert(0<=result,'`result` is WRONG!');
    Assert(result<=1,'`result` is WRONG!');
    {$endIf}
end;

end.

