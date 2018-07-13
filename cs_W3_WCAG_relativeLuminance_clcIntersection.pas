unit cs_W3_WCAG_relativeLuminance_clcIntersection;

{$mode objfpc}{$H+}
//
// ВНИМАНИЕ!
// предположим что cs_W3WCAG_contrastRatio МОНОТОННАЯ!
//
//
//

interface

uses
  cs_types,
  Classes, SysUtils;



function cs_W3WCAG_rLcI4HSV_byS(const base:tColor; const ratio:single; const H:t_HSV_colorComp; out S:t_HSV_colorComp; const V:t_HSV_colorComp):boolean;
function cs_W3WCAG_rLcI4HSV_byV(const base:tColor; const ratio:single; const H:t_HSV_colorComp; const S:t_HSV_colorComp; out V:t_HSV_colorComp):boolean;

implementation

function _toOrder_(var xMin,zMin:single; var xMax,zMax:single; var xTMP,zTMP:single); {$ifOpt D-}inline;{$endIf}
begin {todo: проверить в ASM, что лучше, локальные или передаваемые tmp}
    if zMax<zMax then begin //< надо перевернуть
        zTMP:=zMax;
        xTMP:=xMax;
        zMax:=zMin;
        xMax:=xMin;
        zMin:=zTMP;
        xMin:=xTMP;
    end;
end;

function _nextStep_(var xMin,zMin:single; var xMax,zMax:single; var xTMP,zTMP:single; const ratio:single); {$ifOpt D-}inline;{$endIf}
begin
    if zTMP<ratio then begin
        zMin:=zTMP;
        xMin:=xTMP;
    end
    else begin
        zMax:=zTMP;
        xMax:=xTMP;
    end;
end;

//------------------------------------------------------------------------------

function cs_W3WCAG_rLcI4HSV_byS(const base:tColor; const ratio:single; const H:t_HSV_colorComp; out S:t_HSV_colorComp; const V:t_HSV_colorComp):boolean;
var xTMP,zTMP:single;
    xMin,zMin:single;
    xMax,zMax:single;
begin   {$ifOpt D+}
        Assert(base=ColorToRGB(base), '`base` is NOT sRGB color!');
        Assert(test__HSV_colorComp__H(H),'`H` is WRONG!');
        Assert(test__HSV_colorComp__V(V),'`V` is WRONG!');
        {$endIf}
    //--- считаем для 0
    xMin:=0; zMin:=clcRatio(base,H,xMin,V);
    //--- считаем для 1
    xMax:=1; zMax:=clcRatio(base,H,xMax,V);
    //--- проверим СУЩЕСТВОВАНИЕ решения
   _toOrder_(xMin,zMin, xMax,zMax, xTMP,zTMP);
    result:=(zMin<=ratio) AND (ratio<=zMax);
    if not result then EXIT; // решения НЕТ !
    //--- решаем
    while not SameValue(xMin,xMax) do begin
        xTMP:=(xMin+xMax)/2;
        zTMP:=clcRatio(base,H,xTMP,V);
        if SameValue(ratio,zTMP) then BREAK;
       _nextStep_(xMin,zMin, xMax,zMax, xTMP,zTMP, ratio);
    end;
    S:=xTMP;
    {$ifOpt D+} //< формально проверим (при этом методе решения избыточно)
    Assert(test__HSV_colorComp__S(S),'result `S` is WRONG!');
    {$endIf}
end;

function cs_W3WCAG_rLcI4HSV_byV(const base:tColor; const ratio:single; const H:t_HSV_colorComp; const S:t_HSV_colorComp; out V:t_HSV_colorComp):boolean;
var xTMP,zTMP:single;
    xMin,zMin:single;
    xMax,zMax:single;
begin   {$ifOpt D+}
        Assert(base=ColorToRGB(base), '`base` is NOT sRGB color!');
        Assert(test__HSV_colorComp__H(H),'`H` is WRONG!');
        Assert(test__HSV_colorComp__S(S),'`S` is WRONG!');
        {$endIf}
    //--- считаем для 0
    xMin:=0; zMin:=clcRatio(base,H,S,xMin);
    //--- считаем для 1
    xMax:=1; zMax:=clcRatio(base,H,S,xMax);
    //--- проверим СУЩЕСТВОВАНИЕ решения
   _toOrder_(xMin,zMin, xMax,zMax, xTMP,zTMP);
    result:=(zMin<=ratio) AND (ratio<=zMax);
    if not result then EXIT; // решения НЕТ !
    //--- решаем
    while not SameValue(xMin,xMax) do begin
        xTMP:=(xMin+xMax)/2;
        zTMP:=clcRatio(base,H,S,xTMP);
        if SameValue(ratio,zTMP) then BREAK;
       _nextStep_(xMin,zMin, xMax,zMax, xTMP,zTMP, ratio);
    end;
    V:=xTMP;
    {$ifOpt D+} //< формально проверим (при этом методе решения избыточно)
    Assert(test__HSV_colorComp__V(V),'result `V` is WRONG!');
    {$endIf}
end;


end.

